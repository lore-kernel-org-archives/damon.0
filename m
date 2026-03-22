Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B2255F57;
	Sun, 22 Mar 2026 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215868; cv=none; b=HNzOfIJ0I3D1DMjeyElHPgCrO6rZRqMHpB1gmXwjON0vGkRFT2LrHkQcThN5jcJUT92CZ6nE2nDVR648taVY8pgDRuc27/XGi/Nx0tUT9kunmZK7H0XR1MNKVXtIpChcnnHUXCb18UGik17uaNWZ9ZPizRE6kPjhLW2fJhCZ0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215868; c=relaxed/simple;
	bh=22RzMTpANs3aKprCXCb35XmpMBHsIxXACgA4rqRNcMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4lNHpQRdLuc/viRnXnHVqRJDu5qP1r4afh9eoB+VGG/OhBMEShG9Z7e3HAWNPr2LSjOf0g/qJSyQx5antkHGS8rs2aG/AV1jFMLNFy3vLCj115aoOXj2tEjfJAwRv9LPLIDwcmGT+yGGKrAQIqBcFwg3XHT1jYzdqPyEfOn7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHHshZQo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHHshZQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D92C19424;
	Sun, 22 Mar 2026 21:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774215867;
	bh=22RzMTpANs3aKprCXCb35XmpMBHsIxXACgA4rqRNcMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHHshZQoqOMcpa8OyO5OiO1LbWZ5eagie6TbiHb1yFVPhcIPtleZSqsHGRQlFfbUK
	 qRsySpCNK02ERdUNrIK/abyn+VWfwN1XC9GFu7DWosG9rplJCbO1r7njwSmtTHJryx
	 ic2vXJEZRbsrJwWpC2c3bNfdxeVzTGjPtXCcY6tMH5DSgA6X5rViag4yh1QKB22Pda
	 VSdTZRCBpZ8hXQkBn8jYEEDzqYeueBofFpFdANyz5kbkmkoMVLdpwk8hD2xEVoJh+Q
	 WX/clgUBwm7tT7y+gIhYcwv+beWoH5nDs9L4ByuGofp70tnV6oTXrtQFr8e6nt2m6L
	 dv/g+x6t3/LZQ==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: optimize kdamond_apply_schemes() by inverting scheme and region loops
Date: Sun, 22 Mar 2026 14:44:18 -0700
Message-ID: <20260322214419.89419-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322184641.251966-2-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Josh,

On Sun, 22 Mar 2026 18:46:40 +0000 Josh Law <objecting@objecting.org> wrote:

> Currently, kdamond_apply_schemes() iterates over all targets, then over all
> regions, and finally calls damon_do_apply_schemes() which iterates over
> all schemes. This nested structure causes scheme-level invariants (such as
> time intervals, activation status, and quota limits) to be evaluated inside
> the innermost loop for every single region.
> 
> If a scheme is inactive, has not reached its apply interval, or has already
> fulfilled its quota (quota->charged_sz >= quota->esz), the kernel still
> needlessly iterates through thousands of regions only to repeatedly
> evaluate these same scheme-level conditions and continue.
> 
> This patch inlines damon_do_apply_schemes() into kdamond_apply_schemes()
> and inverts the loop ordering. It now iterates over schemes on the outside,
> and targets/regions on the inside.
> 
> This allows the code to evaluate scheme-level limits once per scheme.
> If a scheme's quota is met or it is inactive, we completely bypass the
> O(Targets * Regions) inner loop for that scheme. This drastically reduces
> unnecessary branching, cache thrashing, and CPU overhead in the kdamond
> hot path.

That makes sense in high level.  But, this will make a kind of behavioral
difference that could be user-visible.  I am failing at finding a clear use
case that really depends on the old behavior.  But, still it feels like not a
small change to me.

So, I'd like to be conservative to this change, unless there are good evidences
showing very clear and impactful real world benefits.  Can you share such
evidences if you have?


Thanks,
SJ

[...]

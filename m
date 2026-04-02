Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0513E21C9EA;
	Thu,  2 Apr 2026 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775092245; cv=none; b=mmDnAmoowyLdNFR2VP/46ON6N1pPd5wDjcIncSccwSFUiCcXCikR4fmzbsMUPFLWUG6o5K0WPYjAOciJnNBnl7cYn5wkHpMCggbb0TGIJ816sM7SE1FV8beP8EjpN3XVtqkVNvR1H5SNtxxjqN/TTfuJhJp5ikPT1+jhuxnHtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775092245; c=relaxed/simple;
	bh=RBpqhqYUfZvqMnoA+utE1x4KPKxI9AlOpwMFYWzsTxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXoUZJePZoocAQ20A+uv9GuApKzN21go1vGvILQoXk+MY6pMlN3quNRADJi4cM4IqO6EfX6fJRo7SdQKeELt8PKLLBpMz8xBYXjMFp/q49FE49ZkZno19KEFkcJvLlTF6SCuFSuQ5HzfTCkz16FtmHhbNISNyLB2CnLi8qbrEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meaZjrOh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meaZjrOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE64C4CEF7;
	Thu,  2 Apr 2026 01:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775092244;
	bh=RBpqhqYUfZvqMnoA+utE1x4KPKxI9AlOpwMFYWzsTxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meaZjrOhfaHbVXagdnwXKdjt8y13+v/FqQJIAbTACpaJYGd+ECjtZh2twMbsV6m3A
	 dWQvGU7v8LH8IGdYISW0u06wAPhHU8HQrmq76hq4p0sZqG6LdBDOAGAFqJeNy4FtSo
	 MYC5/u9fkCJd8LDl/XtkNOIazZgn25f9wHFjq+22i3CFyvPzZ0BGWWOdPtkU1wkvIl
	 +/9GCGQz59s0y5+I11u8gMKwodBbd/rR0dmRK3Y7zLqg6r5vxwMH0zeoK6x+wjhBD+
	 KIKNe6bo5knI8f2YAWf9TSMHySvpBZlx9b368fLGygqRM1sfyenxCArlAhJXJlqmIa
	 G4KbEh5kO8wFA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Wed,  1 Apr 2026 18:10:42 -0700
Message-ID: <20260402011043.67218-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324040722.57944-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 21:07:21 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 23 Mar 2026 18:28:00 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Forwarding Sashiko review for doing discussions via mails.
[...]
> > Additionally, when the context is paused, kdamond_fn remains in this sleep
> > loop and skips calling damos_adjust_quota(), which means quota->charged_from
> > is frozen.
> > 
> > If the pause lasts for more than LONG_MAX jiffies (e.g., about 24.8 days on
> > a 32-bit system with HZ=1000), will system jiffies wrap past the half-range
> > limit of the unsigned long type relative to the frozen timestamp?
> > 
> > If this wraparound occurs, time_after_eq(jiffies, quota->charged_from +
> > interval) would evaluate to false when unpaused. Would this cause the quota
> > window to not reset for another 24.8 days, accumulating charged_sz and
> > blocking the scheme from being applied?
> 
> That's a wild corner case, but I agree it is better to avoid the problematic
> case.  I'm still thinking about the good way for that.  Anyway, I will address
> this in the next spin.

The root cause of the issue was introduced before this patch, so I fixed it
with another hotfix [1].  So next spin of this patch will have no change.

[1] https://lore.kernel.org/20260329152306.45796-1-sj@kernel.org


Thanks,
SJ

[...]

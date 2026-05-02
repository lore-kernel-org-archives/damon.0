Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815C1B86C7
	for <damon@lists.linux.dev>; Sat,  2 May 2026 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777686763; cv=none; b=Jjs9LXChpi7AuwJsMnoduNlx7lulzPTntlGgCnb2J3VNhXSfYz0gUzAA5fLRC7JMzk5PpGxh8sKaQVBe+N1jjiV9YK9rukpxOScHOAW9g/nvNmGYUw+WWt43GCTuhgeF+PKMebrvmS7ir1E1UQEOSRl6iYCI+98TkRSFPvZZtEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777686763; c=relaxed/simple;
	bh=bgpyMW1Ap8z75ihGWc9/YMYetN9A4obE3XY677Ommvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGMvg9w6ri54az3nFdk9PV0m3QpO0ZeDpr8wCMoJmPnyHM2Ku0Zn9llR16u2vBFtoBUINaXX9xhDUjLHtUfeT4S4SPXYY84zYcP3+2skc/Ib5oT+sxocMGoDPp0Xkx1qggKgkAVee5QN3H81VnwKAmHQHQwE9I6igzIlsLDLJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsJLhfNC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsJLhfNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67ABC2BCB4;
	Sat,  2 May 2026 01:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777686763;
	bh=bgpyMW1Ap8z75ihGWc9/YMYetN9A4obE3XY677Ommvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JsJLhfNCrzhNpQBlak3df86wNUBKx97zsLMG1cIScJBGCkiuCSrzLsVxU9mtUfFOd
	 xPQZ+lbx+kydHrxTF+vsStUJYSUt/d1oCheyQFCAJcz7RsCOy7lw8ZTRdb8+haTQUm
	 YOemuhmFAXOKWnWmVJ7HW6dgojKyILaHTFz1szMOMyidwnwNOjBFYuOwx/nmzDiLhD
	 bRIZ+1X8FVHEVSYYWpJH4VgbgSplOiDeXXPNsrHCQfXR4e8hak7ZeBW2hg3JWxHYbW
	 9tphIsO+pUeVFZ0VYLSrpeAEHvhZxPLcAmOGgaqM/zdXSJ0YxE2CUOdNj25v+IgJ5f
	 yHat6WiXbR36A==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri,  1 May 2026 18:52:34 -0700
Message-ID: <20260502015235.78679-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501013750.71704-3-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  1 May 2026 09:37:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> When a user sets an invalid 'addr_unit' (e.g., 3) via DAMON_RECLAIM,
> 'min_region_sz' becomes a non-power-of-2 value. While damon_commit_ctx()
> correctly detects this and returns -EINVAL, it sets the
> 'maybe_corrupted' flag during this process.
> 
> This flag causes the running kdamond to terminate. While the termination
> is a safety measure, it is suboptimal in this case because the error is
> just a simple invalid input from the user, which shouldn't neccessitate
> stopping the kdamond.
> 
> Reproduction
> ============
> 1. Enable DAMON_RECLAIM
> 2. Set addr_unit=3
> 3. Commit inputs via 'commit_inputs'
> 4. Observe kdamond termination
> 
> Solution
> ========
> Add an early validation in damon_reclaim_apply_parameters() to check
> 'min_region_sz' before any state change occurs. If it is non-power-of-2,
> return -EINVAL immediately, preventing 'maybe_corrupted' from being set.

Looks good to me.

> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

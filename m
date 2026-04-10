Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C493C6614
	for <damon@lists.linux.dev>; Fri, 10 Apr 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829936; cv=none; b=qRTA9prSYQruyGXTV8d4HioD7UVWXWUHb04RryR6k9/P7JlDYUGJd9CeITP0f7AT55V15OARmwtB5VI70Q+ootL3TdhZZDGWDfqLedcSQM7Ob6thGYUSQQ2IEW+R9zeH33vmv3VLYcSA1geZf9PWNSGEQZ70RU6g57JD6puthaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829936; c=relaxed/simple;
	bh=vU7YhsU6mPtOO9+7OdOGJ86dQ128aE6IKS2KzhCvWA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAuIXktmrpui516uJjH8esAqpVQSKPCSLEPCQwqTS6YQRJaf8X48XioywdBxfBa/dX/fjOWVGI2V2GRhFD+AebMaWJ3JetTLHs6NEGJzp+g3mQYxTUi5mBVHJ5NkUdSVNK0pOVBiD2WXMR4FDDVL2+Q7gyCks1wvoSLAok+W5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMnTBLr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMnTBLr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1750EC19421;
	Fri, 10 Apr 2026 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775829936;
	bh=vU7YhsU6mPtOO9+7OdOGJ86dQ128aE6IKS2KzhCvWA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMnTBLr23e9TcOIjzibJX2yAThFvTjWcHruR2vn40XZzn/dQb7PmEq9jB+CyajGDR
	 y62IuCLcV+k03xjqiIeBPQRf2NuX75zuJEgT7RXcQJ7u4lpgQGPLlQwjOVCgV14FCk
	 HEiQiBslMzj5/zJYWNwa/EfO7/FvQjgCzqu8KnO4gT9BD8vzzHJgn2a8b5IH9MWTkB
	 cgHGBOjdXOtCdQl3XQjcD0FGMgNTgY81u9xT2L+ohESdvPLA9lwpB0+1T9gu8kX0aP
	 JKwRlYahD5H11hGUSiTMJyPzVXSfe500z9NEYUQRdhy5FUI80yQO6csTnLW2LwZayS
	 1mVjtY0VP74BQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 0/2] mm/damon: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 07:05:28 -0700
Message-ID: <20260410140529.82414-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410044259.95877-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Apr 2026 12:42:57 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> When a user sets an invalid 'addr_unit' (e.g., 3) via
> DAMON_LRU_SORT/DAMON_RECLAIM, 'min_region_sz' becomes a non-power-of-2
> value. This value eventually reaches damon_commit_ctx(), which does:
> 
>     dst->maybe_corrupted = true;
>     if (!is_power_of_2(src->min_region_sz))
>         return -EINVAL;
> 
> Although -EINVAL is returned, 'maybe_corrupted' is already set. The
> running kdamond observers this flag and terminates unexpectedly.
> 
> "Unexpected termination" here means the kdamond exits without any user
> request (e.g., not by writing 'N' to 'enabled').
> 
> User Impact
> ===========
> Once kdamond terminates this way, it cannot be restarted via sysfs
> because:
> 
> 1. DAMON_LRU_SORT/DAMON_RECLAIM is built into the kernel, so it cannot
>    be unloaded and reloaded at runtime.
> 2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
>    Writing 'Y' does nothing, as 'enabled' is already Y.
> 
> Solution
> ========
> Add an early validation in damon_lru_sort_apply_parameters()
> /damon_reclaim_apply_parameters() to check 'min_region_sz' before any
> state change occurs. If it is non-power-of-2, return -EINVAL immediately,
> preventing 'maybe_corrupted' from being set.
> 
> Patch 1 fixes the issue for DAMON_LRU_SORT.
> Patch 2 fixes the issue for DAMON_RECLAIM.
> 
> Changes from v3
> (https://lore.kernel.org/20260403052837.58063-1-aethernet65535@gmail.com)
> - Improve commit message: clarify "unexpected termination".
> - Add detailed User Impact with reason why kdamond cannot be restarted.

Thank you for making the change.  Looks good to me.  I gave my 'Reviewed-by:'
for the two patches as replies.

Andrew, this series is for hotfixes that deserve Cc-ing stable@.  Could you
please pick this up into mm.git?  I don't think these are super-urgent and I
have some capacities to manage this myself, though.  So if you prefer to, I can
stash this in my tree for now and repost after next rc1.


Thanks,
SJ

[...]

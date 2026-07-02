Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3376C343D86
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028675; cv=none; b=nmeV0HSk4AYP6JZpI5xj26BbUdNUQVoJMMRK3eol2i3Czy/+CtmMlLEtWA0xRK5Xozav9MS1S3xstI9r+i3/DXlIGxWQkfoxtjO69VTg/8KMPaBbIGRvWH5Se7QtISVn3CS4C10oZy3uHZsjqtkbI7O1jAcROorWnbzLGjfUE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028675; c=relaxed/simple;
	bh=oGiXSfCAQzShyuBtFN3X0Df+8ax/Zw6F53Ro6DhY6UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkShJRQAT11XElZbnrmihrs8oK1Z2fz1UsWniKkfTp1EyMLRr+MJ6n5aMmHmSn7mPpLAOdMKeusyaA6uPUaAU+Dxu39MD4p0XYLHva7mbt8v9Q9YG4GZ2+3Jcfr0m2zOOe2+0ltFKZ6k8ccc+xSfgeCw4r4lJ+PJ0YFRgyQRV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfVI6nya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfVI6nya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A4E1F000E9;
	Thu,  2 Jul 2026 21:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028674;
	bh=PM1Sx0eN2enMHjVRu+DBgXbvDxNbtJ8UW9WwvJqpyWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mfVI6nya066E4wQfPfZskHeVB16dIUDaSvDjX9tXKtEWtIwB4sDGMe2fsnw14uwCI
	 rzzNlMW6F7oT7pm2t1YLGBeozucdaYFpFA6n0WWg4mvjnobKx0T07QytnKe7A5UWJj
	 YwKSnb9b4cDqQJ0jnJ3j9Sf43g8JJRrapvc+xtUFb1DLKEp3loof0usarqYltzCx3I
	 aetsbenJKhNqc4k5AIU8pQYsJWBiDWeqc7AeQqP+7D/vv0VC3OrYs2Vx3B/28bLDO6
	 p3DFf42pbhKn8Hz6v/paw9ybIP4qm59k7PBTGmYecTbNBSphD9IYaX9N8IAH7GGdRg
	 sKu4zvEs+wlmw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 5/8] mm/damon/lru_sort: remove duplicated min_region_sz power_of_2() check
Date: Thu,  2 Jul 2026 14:44:25 -0700
Message-ID: <20260702214426.97100-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702212005.EF3901F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 02 Jul 2026 21:20:05 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the early validation of `min_region_sz` causes persistent corruption of the `monitor_region_start` and `monitor_region_end` module parameters on failure.
> --
> 
> commit 982a6b66f4f61086f3bd8de5a2da757081d4fa94
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/lru_sort: remove duplicated min_region_sz power_of_2() check
> 
> This commit removes an explicit power-of-two check on min_region_sz from
> damon_lru_sort_apply_parameters(), as the same validation is performed
> later in damon_commit_ctx().
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 32f41491b726b..2dd0cd0d26273 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -284,11 +284,6 @@ static int damon_lru_sort_apply_parameters(void)
> >  	param_ctx->addr_unit = addr_unit;
> >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> >  
> > -	if (!is_power_of_2(param_ctx->min_region_sz)) {
> > -		err = -EINVAL;
> > -		goto out;
> > -	}
> > -
> 
> [Severity: High]
> Does removing this early validation allow execution to proceed with an invalid
> addr_unit?
> 
> If the monitor_region_start and monitor_region_end parameters are 0
> (the default, triggering auto-detection), they are overwritten in-place
> with system bounds scaled by the invalid addr_unit when this function
> is called later in damon_lru_sort_apply_parameters():
> 
> 	err = damon_set_region_system_rams_default(param_target,
> 					&monitor_region_start,
> 					&monitor_region_end,
> 					param_ctx->addr_unit,
> 					param_ctx->min_region_sz);
> 
> When damon_commit_ctx() later rejects the configuration and returns -EINVAL,
> these corrupted values are not reverted.
> 
> If a user then corrects addr_unit and applies again, will the now non-zero
> parameters bypass auto-detection and get scaled again? This could cause
> DAMON to monitor an incorrect and massive physical address range, forcing
> the kdamond thread into a long pfn_valid() loop that consumes excessive CPU.
> 
> Is the same state corruption possible in mm/damon/reclaim.c:
> damon_reclaim_apply_parameters() due to a similar removal of the early
> power-of-two check?

I think the user should recheck the parameters after failures.  No blocker.


Thanks,
SJ

[...]

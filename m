Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167382;
	b=lxQhcvbrSZBKZNJhzf4QlgjO4JuC57q2Q5pwDzZJrmVsi2V6x/RQpegvnXoOQSA/fBCR
	 ODT6mGiWTWXQcIsXDNjnZ6fI5ZKzu0R+QLwpXe8/os1m+lld5NcsTIm4HKDu9EWzqaDv4
	 HM5/Xs08qVaL2zzr8I4H97KfJJ5cps4/v9OlcF8tVcAIspyZuTeCJO1edWT77QifmEDij
	 Wp6hYIgQYB/ZpfMxQRwQzHu2Jshkys5Hh95tte99PO30o5v15nXAvQbtuGkJxNs6YjDgz
	 l7UpJTs54Yizl3BxYtCwIzN9bzDP+6nphZStOE9Obkq12JQ13dFmS6m+lUvLpzoINww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167382;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=n2C/GvKXAk+pYFZ4vmrAiRb4WyuL7H3om3GAG5pFiS4=;
	b=SghITanFuVApxdHTvjw+VqmgeHwK5edzD4jSvX2rvWX6C01o30u524dCrwpJipp42Mat
	 5Xi/HzncXtirpaKKyG7l45FSWuM/vfTZM+ASnqLJrifnGCMfqc5qP/J8P9Ao6xg8qi/Kt
	 XcBYK40TskWbD/FSHJDErCEJFFXCp62VESEVjPQur75p3/5sldBy9Tb/94wdSL4BApe5N
	 PeU/KXD49rLjZqf7fpjtOR5RI4WRsjzE3WFpFITvzpOiSyrVexwbnvrI0kHIfGNxPVmMF
	 vf5PEm/TKQpePtGkUTX/llu+Z2gBkEiIw61iyByKM/UHEdCAzYBhslrWQfJ0Vloiiuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P58p1Jdp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6C606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P58p1Jdp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD83C1F0089F;
	Sun,  8 Nov 2026 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167382;
	bh=n2C/GvKXAk+pYFZ4vmrAiRb4WyuL7H3om3GAG5pFiS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P58p1Jdpmst40sGJSxTlkBW03mhyY57bZXMEomEq9m6JwA17nfaqaD0WlzTT8IPVb
	 33gLkQEBIfk9JSroVmS4GjCMePxSXk2hbYohuaHJmxT+Uy09AMVsxzcDiUQ4FHHTOw
	 hUwVK7QK31hdTL5bIZo0kVqrQ8erbbsuCKAdTuK3kOal5BdQ5bLDwV9bZ10THDJ3Po
	 frW9yPxJW556+oDWKuV8eIDUh9mIUSMsbIvET83aPhLrRsbBZb9Ds6mdCPy1Qq/GtK
	 Kklx0S1K8Rn0TIMugKLJhOdRcKpXoXMVbPqa5dEwTd3m6GMOqloTQg1TeNmASQT6Ry
	 0nm6yNER8AGbQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Brendan Higgins" <brendan.higgins@linux.dev>,
	"David Gow" <davidgow@davidgow.net>,
	"Usama Arif" <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.18.y 3/5] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
Date: Sun,  8 Nov 2026 11:49:33 -0800
Message-ID: <20261108194935.115238-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-203953@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 08 Nov 2026 19:30:36 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] mm/damon/sysfs: TOCTOU race in damos_sysfs_add_quota_score()
>   [1]
> --
> 
> commit 244e62bfada7cc56b0025da40ea03dad6d9c6420
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
> 
> This commit copies sysfs_filter->sz_range into filter->sz_range before
> validating it in damon_sysfs_add_scheme_filters() so that a concurrent
> sysfs update cannot pass an unvalidated size range to the core layer.
> 
> Link: https://lore.kernel.org/20260914142327.92510-3-sj@kernel.org
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 37e0a8bef4b1f..0f945ef043709 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -2493,12 +2493,11 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
> >  		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
> >  			filter->target_idx = sysfs_filter->target_idx;
> >  		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
> > -			if (sysfs_filter->sz_range.min >
> > -					sysfs_filter->sz_range.max) {
> > +			filter->sz_range = sysfs_filter->sz_range;
> > +			if (filter->sz_range.min > filter->sz_range.max) {
> >  				damos_destroy_filter(filter);
> >  				return -EINVAL;
> >  			}
> > -			filter->sz_range = sysfs_filter->sz_range;
> >  		}
> >  
> >  		damos_add_filter(scheme, filter);
> 
> [Severity: High]
> This problem wasn't introduced by this patch, but can
> damos_sysfs_add_quota_score() just below hit a similar double-read race on
> sysfs_goal->target_value [1]?
> 
> mm/damon/sysfs-schemes.c:damos_sysfs_add_quota_score() {
> 	...
> 		if (!sysfs_goal->target_value)
> 			continue;
> 
> 		goal = damos_new_quota_goal(sysfs_goal->metric,
> 				sysfs_goal->target_value);
> 	...
> }
> 
> target_value_store() updates sysfs_goal->target_value without holding
> damon_sysfs_lock:
> 
> CPU0                              CPU1
> damos_sysfs_add_quota_score()
>   if (!sysfs_goal->target_value)
>                                   target_value_store()
>                                     kstrtoul(..., &goal->target_value)
>   damos_new_quota_goal(...,
>       sysfs_goal->target_value)
>   ...
> damos_quota_score()
>   mult_frac(...,
>       goal->target_value)  <-- divide-by-zero
> 
> If a concurrent write sets sysfs_goal->target_value to 0 between the check
> and the second read, damos_new_quota_goal() creates a goal with a zero
> target_value, which later causes a divide-by-zero in damos_quota_score().
> sysfs_goal->metric is also read twice in damos_sysfs_add_quota_score(), so
> a concurrent metric_store() between damos_new_quota_goal() and the switch
> can leave goal->nid or goal->current_value uninitialized.

No.  damon_sysfs_valid_start_ctx() [1] avoids the divide-by-zero.

[1] https://lore.kernel.org/all/20260903010722.94244-2-sj@kernel.org/

> 
> [1] https://sashiko.dev/#/bug/linux-7f814c9a-986f-4103-a55a-ef9537dcf62b
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261108192221.114362-1-sj@kernel.org?part=3
> 


Thanks,
SJ

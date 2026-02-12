Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92321E0AD;
	Thu, 12 Feb 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915101; cv=none; b=plubk+AaVIhyKqlDxtxEBHpu5nxD32ESvhBFny9pYeLRr2FA77KaJFK2rSStRlXziSTXs6PABFwCnypezctJGZE0qRo+JSVaYzCs/XUzrJNI9/IMvNR8LlsqyFESzs8DSjlfY3w0xV5nBdQmLINkslc89iO962lalfLAJf1/ZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915101; c=relaxed/simple;
	bh=0Tmwn34HgUslYUvP6qlQX3bMzbD4sMxV/6/jElQ4/+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJkY9XA4DxJoHnyITODSvVDP3uqE4PxzGkOioMwYvOhsYx64mcsaUGB/CEd7j0+i5zjrByubE2IbNz3RVEb3/GrJumJA+47p6+kHUTUr3aClW9NzlM3lvIeHMpHEgqMI6wtxoeQNL6jMU7rcD4kWo9Wk7PyCaG2Zgud58EShqaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QecM5KFX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QecM5KFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F655C4CEF7;
	Thu, 12 Feb 2026 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770915100;
	bh=0Tmwn34HgUslYUvP6qlQX3bMzbD4sMxV/6/jElQ4/+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QecM5KFXi86YDdrbPZ0f7tNdAolbHfUbqAofTXm2hWRh66PB4515vmkKgXGyfQ4I3
	 KcNAkuDbnAzC3+XjAlYIWwwtSgXkEf5NnGKbVQ+hC9rOhj31jInqzuFsbhs0X/aV+A
	 +SDUVY5jgmd1Gl+1UQ61ak9/jijhj+yOQS300FVXjh4L3O8vt6TTJgO7VPnXEW21B/
	 yigYv3+WaefpM+QgFenKhX/ijhywsuC0bsbfgI8d64RzYN6GrZATE4xg82ZPDDoyxc
	 em6nMXgrZUO+NEa8SYs26w01KDiF52OhNbN0q3OPEW1zdFyUD5JOBWH8/fl6CtJwfX
	 TAKC6GLJsNtQQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: gutierrez.asier@huawei-partners.com,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon: remove unused code
Date: Thu, 12 Feb 2026 08:51:37 -0800
Message-ID: <20260212165138.60213-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212154157.75372-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 12 Feb 2026 07:41:56 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 12 Feb 2026 09:43:26 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
> > From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> > 
> > damon_target is not used by get_scheme_score operations, nor with
> > virtual neither with physical addresses.
> 
> Good finding, thank you for this patch, Asier!
> 
> The subject seems bit ambiguous, though.  What about "remove unused target
> param of get_scheme_score()" ?
> 
> > 
> > Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Other than the subject,
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> Also, DAMON patches are recommended to use mm-new as thier baseline [1] unless
> there are other reasons to not to do so.  But I found 'git am' of this patch on
> the mm-new fails.  It works on the master of mm.git, which is a commit of
> Linus' tree, though.  So, maybe this patch is not using mm-new as the baseline?
> Please consider using mm-new as the baseline next time, or specify why you use
> choose different tree as the baseline.
> 
> Assuming you are ok to the subject change (let me know if you are not), I'm
> attaching a new version of this patch that has changed the subject with my
> suggestion, and manually resolved the conflicts on mm-new, for Andrew's
> convenience.  I also applied that to my tree (damon/next), and I will repost it
> if Andrew miss this (as we are in the middle of merge window, maintainers could
> miss many things).
> 
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
> 
> 
> Thanks,
> SJ
> 
> [...]
> ======= >8 =======
> From e09d66bb116604c9dc5b22540641e991d977ea6b Mon Sep 17 00:00:00 2001
> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Date: Thu, 12 Feb 2026 09:43:26 +0000
> Subject: [PATCH] mm/damon/: remove unused target param of get_scheme_score()
> 
> damon_target is not used by get_scheme_score operations, nor with
> virtual neither with physical addresses.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Link: https://patch.msgid.link/20260212094326.906497-1-gutierrez.asier@huawei-partners.com

Oops, I attached an old version of the modified patch that not adjusted this
tags area.  Andrew, if you pick this up, could you please add below together:

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h |  3 +--
>  mm/damon/core.c       | 10 +++++-----
>  mm/damon/paddr.c      |  3 +--
>  mm/damon/vaddr.c      |  3 +--
>  4 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a4fea23da8576..9a88cf8d152d8 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -647,8 +647,7 @@ struct damon_operations {
>  	void (*prepare_access_checks)(struct damon_ctx *context);
>  	unsigned int (*check_accesses)(struct damon_ctx *context);
>  	int (*get_scheme_score)(struct damon_ctx *context,
> -			struct damon_target *t, struct damon_region *r,
> -			struct damos *scheme);
> +			struct damon_region *r, struct damos *scheme);
>  	unsigned long (*apply_scheme)(struct damon_ctx *context,
>  			struct damon_target *t, struct damon_region *r,
>  			struct damos *scheme, unsigned long *sz_filter_passed);
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 5e2724a4f285e..925908415a041 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1679,15 +1679,15 @@ static bool __damos_valid_target(struct damon_region *r, struct damos *s)
>  		r->age <= s->pattern.max_age_region;
>  }
>  
> -static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
> -		struct damon_region *r, struct damos *s)
> +static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
> +		struct damos *s)
>  {
>  	bool ret = __damos_valid_target(r, s);
>  
>  	if (!ret || !s->quota.esz || !c->ops.get_scheme_score)
>  		return ret;
>  
> -	return c->ops.get_scheme_score(c, t, r, s) >= s->quota.min_score;
> +	return c->ops.get_scheme_score(c, r, s) >= s->quota.min_score;
>  }
>  
>  /*
> @@ -2011,7 +2011,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
>  				s->max_nr_snapshots <= s->stat.nr_snapshots)
>  			continue;
>  
> -		if (damos_valid_target(c, t, r, s))
> +		if (damos_valid_target(c, r, s))
>  			damos_apply_scheme(c, t, r, s);
>  
>  		if (damon_is_last_region(r, t))
> @@ -2309,7 +2309,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  		damon_for_each_region(r, t) {
>  			if (!__damos_valid_target(r, s))
>  				continue;
> -			score = c->ops.get_scheme_score(c, t, r, s);
> +			score = c->ops.get_scheme_score(c, r, s);
>  			c->regions_score_histogram[score] +=
>  				damon_sz_region(r);
>  			if (score > max_score)
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 9bfe488268407..5cdcc5037cbc1 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -343,8 +343,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
>  }
>  
>  static int damon_pa_scheme_score(struct damon_ctx *context,
> -		struct damon_target *t, struct damon_region *r,
> -		struct damos *scheme)
> +		struct damon_region *r, struct damos *scheme)
>  {
>  	switch (scheme->action) {
>  	case DAMOS_PAGEOUT:
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 83ab3d8c37920..4e3430d4191d1 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -986,8 +986,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  }
>  
>  static int damon_va_scheme_score(struct damon_ctx *context,
> -		struct damon_target *t, struct damon_region *r,
> -		struct damos *scheme)
> +		struct damon_region *r, struct damos *scheme)
>  {
>  
>  	switch (scheme->action) {
> -- 
> 2.47.3

Sent using hkml (https://github.com/sjp38/hackermail)

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FBC37CD3E
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242206; cv=none; b=NwgFxC0XEDt8PJ7wp3S/6p0+z0hAuCNLHY9yNBIe3MxzaB+BfJOgk8bGN/XYl21HcMKkAPjpoQS4pGsimNZ9AIE+saDUpRr+48SjI/AavjXJvlCfwT1m5+nrZfYQZKJ5RczD0X9/8CeX/89/ySN/JjguW+qxw7qfJUqadU4koOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242206; c=relaxed/simple;
	bh=SVDF+gr6dws7gt+sx9aOPcsqtrcnTuiCe9OmPPQ6mQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttkRQvKaPoSLLAVehyHriGxOW0VEYksg8BnI9ZU4TpMm8i/8OQWTQaKUKyjejXFIRdJtEkGq59hFlS2k49t03F+0sEpimj/91qFftQ3MqIYlvbI60z3AglfMA2axaj0wF7XLw1f7cwdtcG1ETANSgZbIc6gFT/6rGDdZ476AO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGcgv0GS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGcgv0GS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F58D1F000FF;
	Sat, 12 Sep 2026 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789242205;
	bh=aJ+7jI67m2bPZ9NUb/rjQqDEwEyK3PCtV+9wlPLMl9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PGcgv0GSVYRgUXmUjoZ0K7DV4SO86B8yBDf7ypNQa0bmA9rI8lWnYhpKi0bgQ/9TO
	 qZ7qNzKJFh3GHTxbxIQ3P5hct0pn9rM8MpyC5ry9l3GxET7qERtP3TvUOhV6jeSxlw
	 7MR1aGo6utDamswe0jyiWhAxaW5WDO6pgNNrXOfHHKymD0ECaEXKYF+sJFNGGCFeEL
	 BGWqF7DNVYZFFdW5gBEEhjOLIj6XdeMNLBnrlXpHW9U33pnPrBTeZF+zPdMR8ORlHM
	 sCAYbaDY/9/Dt9qVw84+p7Wni7cGAXhgvVjNjEBKlY/aLFczKbWj/1nHiW2giQuT07
	 RIV/4sd8D1qMg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 5/8] mm/damon/sysfs-schemes: drop centralized filter range arg validations
Date: Sat, 12 Sep 2026 12:43:17 -0700
Message-ID: <20260912194318.139608-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912193003.54B061F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 12 Sep 2026 19:30:02 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the filter range argument validation in `damon_sysfs_add_scheme_filters()` relies on the core layer to perform this validation. However, the core layer's commit functions (`damos_commit_core_filters()` and `damos_commit_ops_filters()`) silently ignore the return value of `damos_commit_filter_arg()` when adding new filters. When an invalid range is provided via sysfs, `damos_commit_filter_arg()` returns `-EINVAL` and aborts before copying the arguments. Because `damos_new_filter()` uses `kmalloc_obj()` (which does not zero memory), the new filter's union arguments (e.g., `addr_range`) are left completely uninitialized. The filter is then added to the active DAMON context, resulting in the scheme acting on an unpredictable memory range derived from uninitialized heap garbage.
> --
> 
> commit a45f05608fa3c7f9050ea4eac0fd8f19b22ee509
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: drop centralized filter range arg validations
> 
> This patch drops the centralized filter range argument validations in the
> DAMON sysfs interface, relying on the core layer to perform this validation.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 8c8ab82c8facc..a4ec5d54cfbd1 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> 
> [ ... ]
> 
> > @@ -2832,27 +2832,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
> >  			}
> >  		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
> >  			filter->addr_range = sysfs_filter->addr_range;
> > -			if (filter->addr_range.end <
> > -					filter->addr_range.start) {
> > -				damos_destroy_filter(filter);
> > -				return -EINVAL;
> > -			}
> >  		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
> >  			filter->target_idx = sysfs_filter->target_idx;
> >  		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
> >  			filter->sz_range.min = sysfs_filter->range_min;
> >  			filter->sz_range.max = sysfs_filter->range_max;
> > -			if (filter->range_min > filter->range_max) {
> > -				damos_destroy_filter(filter);
> > -				return -EINVAL;
> > -			}
> 
> [Severity: High]
> Does removing this validation allow invalid ranges to bypass sysfs and reach
> the core layer logic where errors are silently ignored?
> 
> Looking at damos_commit_core_filters() in mm/damon/core.c, the return value
> of damos_commit_filter_arg() is not checked when adding new filters:
> 
> mm/damon/core.c:damos_commit_core_filters() {
>     ...
>     damos_commit_filter_arg(new_filter, src_filter);
>     damos_add_filter(dst, new_filter);
>     ...
> }
> 
> A similar pattern exists for ops filters in damos_commit_ops_filters():
> 
> mm/damon/core.c:damos_commit_ops_filters() {
>     ...
>     if (src_filter)
>         damos_commit_filter(dst_filter, src_filter);
>     ...
>     damos_commit_filter_arg(new_filter, src_filter);
>     damos_add_filter(dst, new_filter);
>     ...
> }
> 
> When an invalid range is provided via sysfs, damos_commit_filter_arg()
> returns -EINVAL and aborts before copying the arguments. Because the new
> filter is allocated without zeroing its memory, the filter's union arguments
> (like addr_range) are left completely uninitialized.
> 
> Since the error is ignored and damos_add_filter() is still called, won't
> this result in the scheme acting on an unpredictable memory range derived
> from uninitialized heap garbage?

Yes, I will fix those in the next spin.

> 
> >  		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
> >  			filter->range_min = sysfs_filter->range_min;
> >  			filter->range_max = sysfs_filter->range_max;
> > -			if (filter->range_min > filter->range_max) {
> > -				damos_destroy_filter(filter);
> > -				return -EINVAL;
> > -			}
> >  		}
> >  
> >  		damos_add_filter(scheme, filter);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260912191807.138502-1-sj@kernel.org?part=5


Thanks,
SJ

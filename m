Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC6923ABA8
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232440; cv=none; b=Qfl0uvhqa+aFeEHkc5FzqKyLB7kygQ8JtlBf16FU5S2Q7tr21oc45PjH+jsuV2aisnsDl3zQrrUS5DivEq9WxBxyge+GnPCuZdrB4fFPxRVLw49U3Hypfx9zTX9rXvt3nRuGAxzRx5DMmHkXlmYB876H56ojnKgmsYpJYLgKxpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232440; c=relaxed/simple;
	bh=yiZAer4B+Df7oT6oPMOUvuxuzVXn5cYPBlwjj/3ncjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtG3NfrKDmnp3IfxMZlLjGXMRiVy7Pewo6vU6Y4sm7reaDVfwX31rg0wfevf3lSLK2gSgZtr+qeRAS5ONDME9Da3B2tN/yw4JzJZ5JFRtZyqkNmJvOYeYIFTiCgvEc5kaf9y8LKnPttvhPC+Mut4orgcICjLZQs1H25KlNf0cqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+VDOUh4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+VDOUh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE285C2BCB0;
	Fri,  3 Apr 2026 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232440;
	bh=yiZAer4B+Df7oT6oPMOUvuxuzVXn5cYPBlwjj/3ncjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+VDOUh4MQY1aqMLAw4ONYHLzJ7fR39k7VLpOxQjQWtmfbgQ9riJlp/YBNEQseYMf
	 8Rh5N71qNsGCMIaVf5pUgOuRB6ardpJ5Xhufunf7Q3L0W+v8elf0BEH0ms4p0wObnJ
	 VQkbmM6LFT0Y8wOjWqQrRVXULcyUHc1ItTsygez08bmRfmomkmmSs8v+0ku8O8pRsC
	 PLEQGj20UJFLaYNXIcrcJmqhwg6tGEj+N8lXP1hJ/0OZXEXHmQ/mwJ7adgbaRMxTD1
	 BTn9XIu45liq53A2dXRjHzsLe5kaOJxCIiUYBa+sCSVeU/AFSsuMs1HWOQ5EbgJYMs
	 HEePceITgLhmA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v3 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 09:07:17 -0700
Message-ID: <20260403160718.64832-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403083322.5852-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dropping stable@ and Quanmin from the Cc.  Read my reply to the sashiko review
sharing for the first patch of this series to show why I do that.

And I find no blockers for this patch from below sashiko review.  Read further
if you are interested in details.

On Fri,  3 Apr 2026 16:33:22 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260403052837.58063-3-aethernet65535@gmail.com
> # start of sashiko.dev inline review
> commit 28b6de17622e17753e02ff606413650ad898f09d
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/reclaim: validate min_region_size to be power of 2
> 
> This commit adds an early check in damon_reclaim_apply_parameters() to
> validate min_region_sz and return -EINVAL if it is not a power-of-2.
> This prevents kdamond from unexpectedly terminating due to late
> validation failures.
> 
> > The damon_commit_ctx() checks if 'min_region_sz' is a power-of-2.
> > However, if an invalid input is provided via the DAMON_RECLAIM interface,
> > the validation failure occurs too late, causing kdamond to terminate
> > unexpectedly.
> 
> Is the root cause of this unexpected termination in damon_commit_ctx()
> itself?
> 
> Looking at damon_commit_ctx() in mm/damon/core.c, it sets
> dst->maybe_corrupted = true before running the is_power_of_2() check:
> 
> damon_commit_ctx()
>     dst->maybe_corrupted = true;
>     if (!is_power_of_2(src->min_region_sz))
>         return -EINVAL;
> 
> If the check fails, it correctly returns -EINVAL but incorrectly leaves the
> running context permanently marked as corrupted.  When kdamond_fn()
> observes ctx->maybe_corrupted is true, it explicitly breaks its main loop,
> terminating the thread.
> 
> Would it be safer to fix this regression by validating inputs before
> mutating the maybe_corrupted state in damon_commit_ctx(), so that other
> callers remain protected from unexpected daemon-crashing denial-of-service?
> 
> Also, does the DAMON sysfs interface bypass this min_region_sz validation,
> allowing kdamond to run with invalid alignment?
> 
> In mm/damon/sysfs.c, a user can set addr_unit to a non-power-of-2 value via
> the sysfs file. When turning DAMON on:
> 
> damon_sysfs_turn_damon_on()
>   -> damon_sysfs_build_ctx()
>     -> damon_sysfs_apply_inputs()
> 
> The code calculates ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1)
> but lacks the is_power_of_2() safeguard. It then calls damon_start() directly,
> bypassing damon_commit_ctx() entirely.
> 
> Since DAMON heavily relies on ALIGN() and ALIGN_DOWN() macros with
> min_region_sz, could a non-power-of-2 value produce corrupted mathematical
> masks, leading to overlapping bounds and memory corruption?

I answered above two questions on my reply to the sashiko review sharing mail
for the first patch of this series.  Please refer to that for details.

In short, the first behavior is intended one and we don't want to change it.
For the second finding, I will work on it.

> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da147786583..2747eef5919d1 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -204,6 +204,11 @@ static int damon_reclaim_apply_parameters(void)
> >  	param_ctx->addr_unit = addr_unit;
> >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> >  
> > +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> >  	if (!damon_reclaim_mon_attrs.aggr_interval) {
> >  		err = -EINVAL;
> >  		goto out;
> >  	}
> 
> Can concurrent modifications of damon_reclaim_mon_attrs.aggr_interval via
> sysfs cause a division by zero oops?
> 
> The global parameter is checked here, but it can be concurrently modified by
> root without subsystem-level locks.
> 
> Subsequently, the function calls damon_reclaim_new_scheme() which executes:
> 
> damon_reclaim_new_scheme()
>     .min_age_region = min_age / damon_reclaim_mon_attrs.aggr_interval;
> 
> If a concurrent sysfs write sets the interval to 0 immediately after the
> check, could this re-fetch trigger an unhandled divide error?
> 
> Further down in damon_reclaim_apply_parameters(), the code calls:
> 
>     err = damon_set_region_biggest_system_ram_default(param_target,
>                     &monitor_region_start,
>                     &monitor_region_end,
>                     ...);
> 
> Can a data race on monitor_region_start and monitor_region_end bypass
> bounds checking?
> 
> These global variables are exported as module parameters and can be
> concurrently written by userspace.
> 
> When passed to damon_set_region_biggest_system_ram_default(), the function
> validates the pointers:
> 
> damon_set_region_biggest_system_ram_default()
>     if (*start > *end)
>         return -EINVAL;
> 
> Without READ_ONCE() wrappers, could these values be modified right after
> the validation, satisfying the forbidden state where *start > *end?
> 
> If this happens, the invalid boundaries are blindly assigned to addr_range.
> When the region is later sized, damon_sz_region() calculates
> r->ar.end - r->ar.start, resulting in a massive underflowed unsigned long.
> 
> Could this cause an unbounded OOM loop inside kdamond_fn(), where the
> region split condition while (damon_sz_region(r) > max_region_sz) executes
> infinitely and constantly allocates new structures?

Again, not this patch's business.

We addressed [1] this sort of races by defining updating parameter during
commit_inputs processing as a wrong user behavior, and adding warning for
stable kernels.

Also Liew's recent patch [2] will remove the races in the mainline and new
kernels.

[1] https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org
[2] https://lore.kernel.org/20260402155733.77050-4-sj@kernel.org


> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260403052837.58063-3-aethernet65535@gmail.com


Thanks,
SJ

[...]

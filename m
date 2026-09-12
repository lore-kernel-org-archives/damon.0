Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED2384230;
	Sat, 12 Sep 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789231704; cv=none; b=YrZPr9bRXeu/yZwlCM4MJpkhNL/aGPnHInI7j3brv++oBWUxzAJr10EibvYJzOlS1o8367pogaZ0g0wSlZJgxecWpe0QRZJC2N8fRpNENi6lX3CwA5TmjfEXt/l47WqApxjaOlN0tmz1+rs7/z/Kda1oWhcD0dAoR0ET6h62WRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789231704; c=relaxed/simple;
	bh=Ix685XUceZeMBoqv3jAb597rqPGVCIgsvl6SMkKANrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4QPgLL2IFbGduUx10QBVM4OAUeyARVJLi2KZYThVuyHtZ3zcdpOytrWBbi5syOp6NqVMDxcQC5dTyNtG2JR3Z1/uTSqsr9pjm/OHVICjMquzYc1SQ3nmd6SN23X6TauQSm4gUuRonQWQqlxO4qL898NUJUjYUE5B84HAnR9GPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPZFHPQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPZFHPQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5577B1F00893;
	Sat, 12 Sep 2026 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789231702;
	bh=pJTGpq+QYVIb+Tro+6y2yguRVCq+0RN5TONlKcSTg3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPZFHPQKzNJacltdL7bXCWId11+kBuvD3FE6myUE1q6QfSAWH74K7yvtoeLNmdalt
	 x1QmbbwXTQYqaeVNgJXFYf0yHfFen5fIBlR9WqamocoNDsOskygjNiEo0feO7y6hyN
	 M7EOYlTOQ3GgmxACVyS8mn/hptMCNxv+hFN2C3T3dSwO7QrFrJPB2RSNdDkrwSsp93
	 0AqUa154/kre2iKhqIF3oFNljWHB7Y6EMiozg5gEilBLriwzliJ0J3X5/eTBxjZEGB
	 +Ps4MqUyawn8tBoRUzkhz+tYfTC7bX01C0Je8XlQuMEf4kFnLP5s9N/YowfhBLZ+rS
	 UydjYMbRqWFhw==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: add short circuit for temporal-goal schemes in damos_adjust_quota()
Date: Sat, 12 Sep 2026 09:48:14 -0700
Message-ID: <20260912164815.94400-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912124406.96535-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 12 Sep 2026 20:43:12 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> When using the temporal auto-tuning algorithm, the effective size quota
> becomes zero once the goal is [over-]achieved.
> 
> In this situation, damos_adjust_quota() still calculates
> quota->min_score for it.  However, this min_score will not be used in
> this window, because in damon_do_apply_schemes(), damos_quota_is_full()
> will always returns true, preventing the scheme from being applied to
> any region.
> 
> Therefore, add a short circuit for temporal-goal algorithm schemes to
> early return from damos_adjust_quota() before calculating min_score.

Nice catch.  Makes sense to me.

> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
> 
> I tested with virtme-ng + perf on a Proactive Memory Reclaim workload;
> within measurement noise (~3%), no measurable difference was observed.
> 
> The purpose of this patch is to reduce unnecessary operations
> (calculating min_score).  But, I'd like to know if this patch needs to
> demonstrate that it provides better performance before it's merged.

This function is supposed to be not performance critical.  I expect performance
difference would be shown only in some setups that I didn't imagine.

But the change is small and makes sense.  I wouldn't mind having no performance
measurement for this small change.

> 
> ---
>  mm/damon/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ce8c6f99106e..fdcea989f0e0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3320,6 +3320,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  
>  	if (!c->ops.get_scheme_score)
>  		return;
> +	if (quota->esz == 0)
> +		return;

Direct zero esz comparison looks redundant and incomplete.  It doesn't catch
the case that <min_region_sz remaining quota case.  Let's use
damos_quota_is_full() instead.  Also, let's do the check before the
get_scheme_score check.  If quota is already full, get_scheme_score check also
makes no sense.

>  
>  	/* Fill up the score histogram */
>  	memset(c->regions_score_histogram, 0,
> -- 
> 2.55.0


Thanks,
SJ

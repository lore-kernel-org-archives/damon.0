Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A4199E88;
	Tue, 25 Feb 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507294; cv=none; b=XoGbuMJ6yUChjtnXJwpINYwpovD9luIEFCteMO/R3dmdHrbSgHM8/opo7bkEJ5p3NW8lwoBCEqTDPa0NERoEpYzcoBthpLz6i3Wx8cYhUK5f/kbKADqGqoM6Q5OhriwUk0r7qjE/35J3F8/uaZDDVZjjnSy+4HDfpuYj/z4I7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507294; c=relaxed/simple;
	bh=//nOCamXGgyx9bCOhPoJsE2m/2aVtCeY7wDIhK+pfZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SY1YR0QBhX1XcM2wXUeZs1+F8pYHyWz4+soyySueUVIRV9M/8EaivbAo8mXrlGBTbSWuOzwWiaDJl1daqP3mo6y4lwwhN5O122Mid16G4Z9TeakTzm9dOAoGge/zryZFrfZrgLRT02RykscswLkXwCJj2e+vKQcvl3FAdN//THg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5kz60Oq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5kz60Oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66D6C4CEE8;
	Tue, 25 Feb 2025 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740507293;
	bh=//nOCamXGgyx9bCOhPoJsE2m/2aVtCeY7wDIhK+pfZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5kz60OqgePrRwVEQls5r2LtWStdAux2aZOZeCLggSe6nGNvJz+GpEZLZBV7EES9A
	 yA+BPHFeBzPhqZ60FwW9ujLk2G1MRf/+oMaxOnL+KEjK4Pp43cUIcbYTWndABkjisG
	 7HKdAHEHYNv6UbJ+JCjNkscaS3DMlByiECxoh0iZInDPZaFskL2+7LslgZAy19zxJo
	 k/eLJK3mBdCY5LTci4oy/d3BktZ0tCTck1KGtO+69BfLyWUzRXxWpYUujDcSD1bMnW
	 ugmGvGHF1nfM4wS9nNUjTAgLGvzZH8oVwnNLP5D0NjdEQi3/kW2rOcE5qsyGujFYP7
	 aj0Gef4tpEOvw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/8] mm/damon/core: implement intervals auto-tuning
Date: Tue, 25 Feb 2025 10:14:49 -0800
Message-Id: <20250225181449.3008-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250213014438.145611-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 17:44:32 -0800 SeongJae Park <sj@kernel.org> wrote:

> Implement the DAMON sampling and aggregation intervals auto-tuning
> mechanism as designed on the cover letter of this patch series.  The
> mechanism reuses the feedback loop function for DAMOS quotas
> auto-tuning.  Unlike the DAMOS quotas auto-tuning use case, limit the
> maximum decreasing amount after the adjustment to 50% of the current
> value.  This is because the intervals have no good merits at rapidly
> reducing, and it is assumed the user will set the range of tunable
> values not very wide.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 16 ++++++++++
>  mm/damon/core.c       | 68 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
[...]
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 2fad800271a4..227bdb856157 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[...]
> +static unsigned long damon_get_intervals_adaptation_bp(struct damon_ctx *c)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	unsigned long nr_regions = 0, access_samples = 0;
> +	struct damon_intervals_goal *goal = &c->attrs.intervals_goal;
> +	unsigned long max_samples, target_samples, score_bp;
> +	unsigned long adaptation_bp;
> +
> +	damon_for_each_target(t, c) {
> +		nr_regions = damon_nr_regions(t);

This should use '+=' instead of '='.

> +		damon_for_each_region(r, t)
> +			access_samples += r->nr_accesses;
> +	}
> +	max_samples = nr_regions * c->attrs.aggr_samples;
> +	target_samples = max_samples * goal->samples_bp / 10000;
> +	score_bp = access_samples * 10000 / target_samples;
> +	adaptation_bp = damon_feed_loop_next_input(100000000, score_bp) /
> +		10000;
> +	/*
> +	 * adaptaion_bp ranges from 1 to 20,000.  Avoid too rapid reduction of
> +	 * the intervals by rescaling [1,10,000] to [5000, 10,000].
> +	 */
> +	if (adaptation_bp <= 10000)
> +		adaptation_bp = 5000 + adaptation_bp / 2;
> +
> +	return adaptation_bp;
> +}
[...]
> @@ -2204,6 +2262,8 @@ static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
>  	ctx->next_aggregation_sis = ctx->attrs.aggr_interval / sample_interval;
>  	ctx->next_ops_update_sis = ctx->attrs.ops_update_interval /
>  		sample_interval;
> +	ctx->next_intervals_tune_sis = ctx->next_aggregation_sis *
> +		ctx->attrs.intervals_goal.aggrs;
>  
>  	damon_for_each_scheme(scheme, ctx) {
>  		apply_interval = scheme->apply_interval_us ?
> @@ -2290,6 +2350,14 @@ static int kdamond_fn(void *data)
>  		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
>  			ctx->next_aggregation_sis = next_aggregation_sis +
>  				ctx->attrs.aggr_interval / sample_interval;
> +			if (ctx->attrs.intervals_goal.aggrs &&
> +					ctx->passed_sample_intervals >=
> +					ctx->next_intervals_tune_sis) {
> +				ctx->next_intervals_tune_sis +=
> +					ctx->attrs.aggr_samples *
> +					ctx->attrs.intervals_goal.aggrs;
> +				kdamond_tune_intervals(ctx);
> +			}

kdamond_tune_intervals() may increase ctx->next_aggregation_sis inside
damon_set_attrs().  So it should be called before the above
ctx->next_ops_update_sis update.

>  
>  			kdamond_reset_aggregated(ctx);
>  			kdamond_split_regions(ctx);
> -- 
> 2.39.5
> 


Thanks,
SJ

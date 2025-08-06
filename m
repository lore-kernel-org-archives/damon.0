Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E501D31B9;
	Wed,  6 Aug 2025 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507354; cv=none; b=ajB3I+kAUIjwXdxcWIfE4VyXa/KNLUdiCE9c1jnmsRp++Q+P3mm6oHZzhahvMkNmRCnbrjpjnn+4H/oBVIIcyLliV4WASo+/WPnPXVtrOtP4GgQm6qdradQmDFamhnePceeYl0bKchz/5EE0c2qx45H7cu44/58S3gF9N7ryYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507354; c=relaxed/simple;
	bh=7N8Q4W4P+6iSheRgtygd3ecelGl8Z6De2VbO2stv2v0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BUPToGAPKX2Sya70il0nhI+TXhdfoWsncjpaTbiOmpRmgq1r513kSvB+Qnk1jgX1yVVJIykrAcTIRf4Cs5vIwjXn82+PuGaQtoT0ygMDl75CJvf5/mPjbYlvInNRedXcfaQr4b/5odJlgNYm+ivFhWPE7G9wp+FePdMQNh1MXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhlIJ6sW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhlIJ6sW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA30C4CEE7;
	Wed,  6 Aug 2025 19:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754507353;
	bh=7N8Q4W4P+6iSheRgtygd3ecelGl8Z6De2VbO2stv2v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhlIJ6sWU67KGuHY4kg17vJ/xHLHncT5RcqKqgfAAe4wgP59od2t0gwdpxQumJOoq
	 9FLbkdA0zzJGKjl/NSUua4bMyJ2vlRBzXGWP9iJr3FUEx7JJBzkJYgxIRV9SA2QI1G
	 I1cpET67sPVAjwOcOAKzdVYFez0zluQNS8G/x/f7MYajF8en2fyD4whBiYXse9C7Aj
	 Rs1CNnkUaqX6eJIIrBIcyYtCFTgM0bmtyYHYHQ1ugpoexU1dyGSOzbA0Mbi2UVUE4Y
	 lqECCF46lRHcG9QgxkRQ4YS6W624J7vb0CwvixlUS+Vw7Cd5lzooPLUCfpR8dHmatx
	 gFp5NnkXjDd8g==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH] mm/damon/core: skip needless update of next_{aggregation,ops_update}_sis
Date: Wed,  6 Aug 2025 12:09:10 -0700
Message-Id: <20250806190911.49728-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806164316.5728-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bijan,

On Wed,  6 Aug 2025 11:43:16 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> In damon_set_attrs(), ctx->next_{aggregation,ops_update}_sis would be
> reset, even if the sample interval, aggregation interval, or ops update
> interval were not changed. If damon_set_attrs() is called relatively
> frequently, such as by frequent "commit" operations, aggregation and ops
> update operations could be needlessly delayed.
> 
> This patch avoids this by only updating next_{aggregation,ops_update}_sis
> if the relevant intervals were changed.
> 
> Cc: Bijan Tabatabai <bijan311@gmail.com>
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
> ---
> This patch came from discussions in [1].
> 
> [1] https://lore.kernel.org/all/20250805162022.4920-1-bijan311@gmail.com/

Thank you for sending this patch as we discussed on the thread!

> ---
>  mm/damon/core.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 6a2fe1f2c952..1c3d8b92257c 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -693,6 +693,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
>  	unsigned long sample_interval = attrs->sample_interval ?
>  		attrs->sample_interval : 1;
>  	struct damos *s;
> +	bool sample_interval_changed = ctx->attrs.sample_interval !=
> +		attrs->sample_interval;
> +	bool aggr_interval_changed = ctx->attrs.aggr_interval !=
> +		attrs->aggr_interval;
> +	bool ops_update_interval_changed = ctx->attrs.ops_update_interval !=
> +		attrs->ops_update_interval;
>  	bool aggregating = ctx->passed_sample_intervals <
>  		ctx->next_aggregation_sis;
>  
> @@ -710,10 +716,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
>  	if (!attrs->aggr_samples)
>  		attrs->aggr_samples = attrs->aggr_interval / sample_interval;
>  
> -	ctx->next_aggregation_sis = ctx->passed_sample_intervals +
> -		attrs->aggr_interval / sample_interval;
> -	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
> -		attrs->ops_update_interval / sample_interval;
> +	if (sample_interval_changed || aggr_interval_changed)
> +		ctx->next_aggregation_sis = ctx->passed_sample_intervals +
> +			attrs->aggr_interval / sample_interval;
> +	if (sample_interval_changed || ops_update_interval_changed)
> +		ctx->next_ops_update_sis = ctx->passed_sample_intervals +
> +			attrs->ops_update_interval / sample_interval;
>  
>  	damon_update_monitoring_results(ctx, attrs, aggregating);
>  	ctx->attrs = *attrs;

Long story short, this (original) code is bit complicated and hence I suggest
to make this change less optimum but simpler.

damon_update_monitoring_results() assumes it is called only just after
next_{aggr,ops_update}_sis are  updated.  And the assumption is important for
the pseudo-moving-sum access frequency maintenance.  As a result, this can make
the monitoring results temporarily corrupted, and splat warning once.  Please
refer to commit 591c4c78be063 ("mm/damon/core: warn and fix nr_accesses[_bp]
corruption") or the patch thread[1] if you want more details.

Also damon_set_attrs() is called not only from commit situation.  So I think
this maybe not an ideal part to modify.

What about modifying damon_commit_ctx() to check if new and old
damon_ctx->attrs are entirely same, and skip calling damon_set_attrs() in the
case?  Doing the entire damon_attrs comparison might be suboptimum, but would
make the change simpler.  I assume the suboptimum comparison is not a real
problem for your use case, so I think that could be a good tradeoff?

Also, I realize the moving sum access frequencies maintenance and
damon_set_attrs() are not well documented and organized.  I will try to make
those better cleaned up and documented.

[1] https://lkml.kernel.org/r/20250513002715.40126-2-sj@kernel.org


Thanks,
SJ

> -- 
> 2.43.0

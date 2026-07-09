Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199E21E098
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606601; cv=none; b=mzz4ATxlGgT8YAN+FkbdYFpgCXsINYiiN0V3BMMfmSTxwmL1JPvKJEatkAGolIoH26lxkfGS4CLh8nftUPcKsZyRyKVmcZJ5fqIi13iZgUqge3jKEb31nhj/bS05ism8MSthTUGN18MZwuBoBE/ym3pdRNM/Z3bFQjPKRDCIniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606601; c=relaxed/simple;
	bh=iJbGtCmtoc0LWedTx75KJdXdgXC64CiJiYu5ZQllXU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TV1mjho4OtmCShNnSBI24vREcjlOYmWMb67ieIDCs9UEw7tEZ0kpw2uS+phI3NiGaMq4haMdNTBd9dveXQe4M0qrrSPu+V6xyT6ehEnNyKHvM+pk9oNfeJV1wRk8DF4naaDkWMw8pC7sr2oaXvYE6ZFC/aaiIrDHJhqW61TNedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToxlZtFr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToxlZtFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B71F000E9;
	Thu,  9 Jul 2026 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606600;
	bh=gY1WdIBLmRnhPimFbi9wWw6GkS/z2L9i4x7MRLZj8/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ToxlZtFr2duEbW4gc+Xo2p58JfFaJT8PvXzeRvmTy9PWWyzsnnnAJoJ5zjYY2+Khx
	 VNSHWFVVEFFD2HzbqGS8Ng8npUqe9yxsU734vYN+POvoDjRjU/vdqeick/OKuPTWgC
	 SSmqtIzxTsuL5YRhJTw5GI6ZxMmP+k6yVlZF3iL4LAw4omw22RVTEQFE4isV/AVHqW
	 DtC0ykwzgADl6/I7j9k4jm/9ZXS0hS1pMYAM867MCPvfm/O50tCOGbZsLd86Rzxddl
	 rqr4OOcV3268keg+XhGO4O1N+ivmhQfIjLU0lNIZtBWcv2beukSBYk+gFMLEtsdHYg
	 cJEnpAuA9QgvA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 04/19] mm/damon/core: ask apply_probe() to
 return max probe hits weighted sum
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260709140600.90950-5-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
 <20260709140600.90950-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:16:38 +0000
Message-Id: <20260709141640.249B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `damon_pa_apply_probes` callback unconditionally returns 0 i=
nstead of computing and returning the maximum probe hits weighted sum when =
`return_max_wsum` is true, violating the updated API contract.
--

--- Patch [4]: [RFC PATCH v1.2 04/19] mm/damon/core: ask apply_probe() to r=
eturn max probe hits weighted sum ---
commit ed82d24ec75fdb639533062e293614cb1cebe866
Author: SJ Park <sj@kernel.org>

mm/damon/core: ask apply_probe() to return max probe hits weighted sum

This commit updates the apply_probes() callback protocol in the DAMON
operations to optionally return the maximum probe hits weighted sum. This
value is intended to help the core layer adjust regions in the future.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 3c2a4d673bf62..4e1845ce83870 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -648,7 +648,9 @@ enum damon_ops_id {
>   * of its update.  The value will be used for regions adjustment thresho=
ld.
>   * @apply_probes should apply the data attribute probes to each region a=
nd
>   * accordingly update the probe hits counter of the region.  It should a=
lso
> - * &set sampling_addr of each region if ``set_samples`` is true.
> + * &set sampling_addr of each region if ``set_samples`` is true.  It sho=
uld
> + * also return maximum probe hits weighted sum of regions if
> + * ``return_max_wsum`` is true.
>   * @get_scheme_score should return the priority score of a region for a =
scheme
>   * as an integer in [0, &DAMOS_MAX_SCORE].
>   * @apply_scheme is called from @kdamond when a region for user provided

[ ... ]

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index ff4fcca949660..3eba3564a31fc 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -166,7 +166,8 @@ static bool damon_pa_filter_pass(phys_addr_t pa, stru=
ct folio *folio,
>  	return pass;
>  }
> =20
> -static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_sample=
s)
> +static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
> +		bool set_samples, bool return_max_wsum)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r;
> @@ -194,6 +195,7 @@ static void damon_pa_apply_probes(struct damon_ctx *c=
tx, bool set_samples)
>  				folio_put(folio);
>  		}
>  	}
> +	return 0;

[Severity: Medium]
The kernel-doc for apply_probes states it should return the maximum probe h=
its
weighted sum if return_max_wsum is true.

However, damon_pa_apply_probes() unconditionally returns 0 here without
computing the weighted sum.

Will this cause the core layer to receive an incorrect threshold of 0 when =
it
starts passing return_max_wsum =3D true in the future?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709140600.9095=
0-1-sj@kernel.org?part=3D4

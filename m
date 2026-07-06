Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE3434E36
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348780; cv=none; b=Kz+vNc6OFjJHJ/roE79N4PXzrl+1uQaag8sYGtKyb6uSGcP+8eLQqea06zOY4WlQPdZLT1JOBcCKyW92eHh5mmflOankztSkGsyk0xQdjCxzyAmtQSOzWsbieZV3IEI74jDMNRhn+N2vX3NgZFNP7HVPLRS3sIfefLA/gakMHZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348780; c=relaxed/simple;
	bh=hhyIyNq6RoYxw47fPhqFXy7o3WHRggInFQAYd9kV05k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SggchF0uCfYSEy6HeAAKqjN43VmxQ0fQGV6KmW5VjVM99GR7Sa2cf7mJVYl+Xt58aBhkOsnmh1UAqxQminozDkQ1ieN2c07qsYuSerBdVL1c11+BaqE1VprwD3Jz2I+58U3YMCRvbqFF3fi6l3q7IDJz14S1CA2sss/Qtq/RZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrG2J3/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrG2J3/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310BA1F000E9;
	Mon,  6 Jul 2026 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783348778;
	bh=LFRk72c+OtDwIkh1aagOZioAukQZVZRPwufneDa84lQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PrG2J3/4eurXxuezZTqmtJev8btGVOsuJ5G6irYra1IJMm9UQKBw1qFHIP02C29uB
	 J2aWhhnructkYW+i8gScHKqmHN8PPaTl5LCX2m5DSrEStoMsKR0s9xXnJ68SjWumQg
	 u+7UAnS7C4KIoQVFVvRnHOUzXGytrqBvsb7z4MF85L8G1cd+aeBSUMljkSjgD3p2+b
	 vhYUoCkLHli0jTOR9p2MQmwtHuw1Mvzxia4NfvnEjRRMSnSqRHGRSMVb6BTpbApS73
	 Da7nWre+LVcMADjYcTYp+AuMof5zXvIYPr0aocZCHQkl/ZOSnc+n6AMGH6qkRz/biP
	 rbHcHh/7iuo7g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 04/16] mm/damon/core: ask apply_probe() to
 return max probe hits weighted sum
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260706141912.88445-5-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
 <20260706141912.88445-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:39:37 +0000
Message-Id: <20260706143938.310BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Advancing physical addresses using `addr +=3D folio_size(folio)` i=
n large folio iteration paths skips memory when `addr` is not aligned to th=
e start of the folio.
- [High] Static local variables used for caching are shared across concurre=
nt kernel threads without synchronization.
--

commit 1ecdc723ec9bfdc97493a942107d11622114a694
Author: SJ Park <sj@kernel.org>

mm/damon/core: ask apply_probe() to return max probe hits weighted sum

check_accesses() DAMON ops callback returns the maximum nr_accesses of
regions.  DAMON core uses it to calculate a reasonable region merge
threshold.  The core will need to adjust regions for not nr_accesses but
probe hits weighted sum in future.  For that, the core needs to know the
maximum weighted sum of the regions.  Update the protocol for the task.

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
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the changes =
in
mm/damon/paddr.c, I noticed that __damon_pa_check_access() declares static
local variables for caching:

mm/damon/paddr.c:__damon_pa_check_access() {
	static phys_addr_t last_addr;
	static unsigned long last_folio_sz =3D PAGE_SIZE;
	static bool last_accessed;
	...
}

Because DAMON allows multiple contexts to be created and run concurrently,
each in its own kdamond thread, could these static variables be modified
concurrently without locking? Does this data race risk corrupting the cache
state and misapplying access results between different monitoring contexts?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential overshooting b=
ug
in multiple physical address iteration paths in mm/damon/paddr.c, such as in
damon_pa_pageout():

mm/damon/paddr.c:damon_pa_pageout() {
	...
	addr +=3D folio_size(folio);
	...
}

If a region start address is not aligned to the size of the folio (for
instance, starting in the middle of a 2MB THP), advancing the unaligned addr
by the full folio size will overshoot the folio boundary. Could this silent=
ly
skip valid physical memory that falls in the gap?

The same pattern appears to be used in damon_pa_de_activate(),
damon_pa_migrate(), and damon_pa_stat().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706141912.8844=
5-1-sj@kernel.org?part=3D4

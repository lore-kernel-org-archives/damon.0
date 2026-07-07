Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E623183F
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399748; cv=none; b=chZI+2jEeKFSVivWCuQv+OutKrV7ypawfcfWaQdYa/8pilDPYg9sIVZChBTW0FM/Frb0dHkoSLCSszaAE2tuHG+AuDzqYvIOaO/OKmvVS07KdyjgkblNW6KOURH8Q6UAQnyTrM2MroC/BoI/c6Stvzdxm9hJrvQoEtFVZFUDC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399748; c=relaxed/simple;
	bh=pSMmgZpRNebumNF/JHugoQB+JL2fvVk3KiaRrlDTbtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W3IZq5pifNBzb9DUe+bvIQAceQcyGaT+k5hQCHC6eRc6X6ywQFpNG28bbz9W43jqYqD/9lkkkN+auZTVOmHC2S2eBaO/iZpbLTqoQ7sDH3ymii7jtO4zPkHqqLdEs1vyUnAovG/vUemCsH9is2sD8zg8p/5caD3LbnvHWTiMZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTxmnOkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTxmnOkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF30C1F000E9;
	Tue,  7 Jul 2026 04:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399747;
	bh=YhvHvxsfcdoloq3Tf1FiHOX2OWypeI6OBjbDfWllKIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iTxmnOkGBJ2LPiy44+hYvHikcJsjJaBXnZapppPHzueF86KUmuWt4LYWKyGChhxoz
	 bKcer+oMJhztOaKngCA9Ql2FbGFFJ0GrguCpSDBPxq510ok4zHCUHJe4jwhKSOb144
	 TBj+2iS2Lfq47gMP9EyVaIM3gxN034syp2paHCdLpZiGNoS6EM7+pw/Hvpmm0NckH0
	 ISrOn/pSgFsbHfoHPPOn86DK9YNaeYtGCWMtg+8JRsOIYYvB2T9gTm2fGnspjDjQ3q
	 XcW5xq8y/xKaywxUwhipR40hLPZ7V/h7ROW9pZtm20hVzqOMgnWTPl/jo8nobJrJr7
	 V/n804upGxMOg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/6] mm/damon/core:
 s/accesses_bp_to_nr_accesses/sample_bp_to_count/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707043828.97900-3-sj@kernel.org>
References: <20260707043828.97900-1-sj@kernel.org>
 <20260707043828.97900-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 04:49:06 +0000
Message-Id: <20260707044906.CF30C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit integer overflow in conversions between basis points (bp) a=
nd sample counts due to large number of samples per aggregation interval.
--

--- Patch [2]: [RFC PATCH 2/6] mm/damon/core: s/accesses_bp_to_nr_accesses/=
sample_bp_to_count/ ---
commit 26f76c0115cf94c7177c6588b38ff64dabf63ab2
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/

This commit renames accesses_bp_to_nr_accesses() to
damon_sample_bp_to_count() to better reflect that it converts a samples rat=
io
(in basis points) to a count. It also updates the callsites and comments to
match the new name.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e710e2789085e..ca530faaa4f83 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -876,11 +876,11 @@ static unsigned int damon_age_for_new_attrs(unsigne=
d int age,
>  	return age * old_attrs->aggr_interval / new_attrs->aggr_interval;
>  }
> =20
> -/* convert access ratio in bp (per 10,000) to nr_accesses */
> -static unsigned int damon_accesses_bp_to_nr_accesses(
> -		unsigned int accesses_bp, struct damon_attrs *attrs)
> +/* convert sample ratio in bp (per 10,000) to count */
> +static unsigned int damon_sample_bp_to_count(
> +		unsigned int bp, struct damon_attrs *attrs)
>  {
> -	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
> +	return bp * damon_nr_samples_per_aggr(attrs) / 10000;

[Severity: High]
This isn't a bug introduced by this patch, but can the product of bp and
damon_nr_samples_per_aggr() overflow 32 bits?

Since both bp and the return value of damon_nr_samples_per_aggr() are 32-bit
unsigned integers, their product can exceed 32 bits if the number of samples
per aggregation interval is large (greater than ~429,496).

For example, a 1ms sample interval and a 10-minute aggregation interval wou=
ld
result in 600,000 samples. If bp is 10,000 (100%), the multiplication
10,000 * 600,000 overflows 32 bits to 1,705,032,704, resulting in a truncat=
ed
count of 170,503 instead of 600,000.

A similar overflow can occur in damon_nr_accesses_to_accesses_bp() when
evaluating (nr_accesses % nr_samples) * 10000 inside mult_frac() for large
nr_accesses values, falsely marking hot memory as cold.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707043828.9790=
0-1-sj@kernel.org?part=3D2

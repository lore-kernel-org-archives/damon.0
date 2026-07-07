Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BAA23183F
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 04:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399913; cv=none; b=EBOrODD25UyBGCun1W31/IELc5uuHCiPeCKch/v32e7wLGYA6He/bgKfhpx8IokhkK0VeXlh/18/240CFVIs3TtV3DGT1idSpJ/Sk9N54iiECcZAPqNl/zZ2DmkCxPiOJDgE1grRT3pf5mkd9fSeECmyFueE2/6IATbbWabdZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399913; c=relaxed/simple;
	bh=mu3zj9R5bQ9Ow8paby6QsYrmm8vD+EqwJNvV0kVbyAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nuk3HBnxRX+VOd2kx/27plAxi0pv4L0uVFWBnD5iZYOP/MlrJUV+3y1OSFYb3gzs81GPfPxsSRajyUnSL6LsD9Wjom5GTEKzw3COffeIh4zAyFor+/F75Ey5kQlWGiuhadEXEHdzhiKnZQB6o1Xgy/mdVa97nmg3oHEY8FRsY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReO6qUBE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReO6qUBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460C01F000E9;
	Tue,  7 Jul 2026 04:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399912;
	bh=4X5BJh2LbNA9B7gYE9LwJuBmTYqdO6UNpeqFc25lsfs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ReO6qUBE7d4/ptoPpRNnh8dWiGY5EfZUtPYKtU7CWdeKkXvmjcQtpp4htNp26aZ9w
	 khlVj+9TveEm3q8h7NoVAspVkVCJ0BtTmWO7mpWRb4cyiWJAhMBTs/5Lq2lyMbSsO3
	 Fq1RdexK6YVQkQQBX4mCXHlvGBYwXORa4DAU3VMeZbjcdOnK7+/usUzYz1uxCRF6Lb
	 YgbaZyQtTOoJ+0EARy93S/vurRGyufLlVpBYa8ajulONitX8caR7WRFce/JuYT9Np2
	 fz4pDiBzyh/90e7j+j3qu2P5GnDIwu4UDV/UEz3eR35k8cz2IMAnRvBi7FM6CMgJic
	 WbItiu0dJ4aGw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/6] mm/damon/core: update probe hits for new
 parameter commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707043828.97900-6-sj@kernel.org>
References: <20260707043828.97900-1-sj@kernel.org>
 <20260707043828.97900-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 04:51:51 +0000
Message-Id: <20260707045152.460C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit arithmetic overflow in interval scaling functions corrupts =
core metrics.
--

--- Patch [5]: [RFC PATCH 5/6] mm/damon/core: update probe hits for new par=
ameter commit ---
commit 7e26d9c01ec3d36d75d519b11f48ef36f78ec868
Author: SJ Park <sj@kernel.org>

mm/damon/core: update probe hits for new parameter commit

Users can update DAMON parameters at runtime. If the samples and/or
aggregation intervals are updated, monitoring results depending on the
intervals should also be updated. This commit ensures probe_hits are
properly updated to reflect new intervals, similar to age and nr_accesses.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index cda318806b65b..9a3ff0fe55a61 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -898,10 +898,32 @@ static unsigned int damon_nr_samples_for_new_attrs(=
unsigned int nr_accesses,
>  			new_attrs);
>  }
> =20
> +static void damon_update_probe_hits(struct damon_region *r,
> +		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
> +		bool aggregating, struct damon_ctx *ctx)
> +{
> +	struct damon_probe *p;
> +	int i =3D 0;
> +
> +	damon_for_each_probe(p, ctx) {
> +		r->last_probe_hits[i] =3D damon_nr_samples_for_new_attrs(
> +				r->last_probe_hits[i], old_attrs, new_attrs);

[Severity: High]
This is a pre-existing issue, but can the scaling logic called here
overflow and corrupt the core metrics?

Looking at the underlying functions called by
damon_nr_samples_for_new_attrs():

mm/damon/core.c:damon_sample_bp_to_count() {
    return bp * damon_nr_samples_per_aggr(attrs) / 10000;
}

and

mm/damon/core.c:damon_sample_count_to_bp() {
    return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
}

If a user configures a large aggregation to sampling interval ratio
(e.g., 1 second aggregation and 1 microsecond sampling), the ratio can
exceed 429K.=20

When damon_sample_count_to_bp() scales a count of 500,000, the internal
multiplication in mult_frac() (count * 10000) evaluates to 5,000,000,000,
which overflows the 32-bit unsigned integer maximum and yields an incorrect
value.

Similarly, damon_sample_bp_to_count() performs 32-bit multiplication
which can overflow if bp * samples exceeds the 32-bit limit.

Should these scaling calculations cast to 64-bit to prevent silent
wrap-around and wildly inaccurate statistics?

> +		if (!aggregating)
> +			r->probe_hits[i] =3D damon_nr_samples_for_new_attrs(
> +					r->probe_hits[i], old_attrs,
> +					new_attrs);
> +		else
> +			r->probe_hits[i] =3D 0;
> +		i++;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707043828.9790=
0-1-sj@kernel.org?part=3D5

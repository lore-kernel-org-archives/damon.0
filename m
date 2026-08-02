Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A443ACA71
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689467; cv=none; b=lmqSEAKdcSssC2xA7KUfWclugSfbfY4etA+HQMLa1tpSdc1aa/82ngnblrbZ+57YjY2Hr2GAxrf173JwhYKbzps1J/RWCFFp+5zuXjcXNxg8Rwn2x0zchH0JYnEQsnanXJW6UCl3cnaunV/EcJ1/5vW55myAFqFCRZmfYx+b95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689467; c=relaxed/simple;
	bh=McRnLyq7BG+RORsJMp62Y4FJywSq3RbGm0PvN/0o9o0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wi8b9M0//nU6uk20G8ss/gmximFi3Xrlg4b3NyxfzZYeKRHg8UeiqQ9HfFbInE84nNuDiGbGp8bYsrsSDHQukaKFbBaFJzSJDsYSfPkW7Fr4QDWMtySwLjXBpaDFbhd/XJ8jsAj5YMHHFeHrkW4crTX79Lv4XQKdauIANc51UqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YatXtSQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YatXtSQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947281F000E9;
	Sun,  2 Aug 2026 16:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785689465;
	bh=dZTGCVUROkzrQC6IqouxvALV0AL0s5LL2SavGv3EemE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YatXtSQf+cKQ0OzgvWKA5VBhqy82slheugDmmmBvSvxcAwyZA37CjbhC3R3xbKSl/
	 es+oy5A7rUSx0AUztOIKsUVNG7ApjajtCV2UJJvNmgqdpjgHYfXhsGxYXlEiu3I9O/
	 U+8qozBTaF4P4OEaKf9woGZ1wdSzNYBQWBELMYtQDnZ+PvIdIx2g+JlPvsB3kJL7LR
	 DBrGv6vlV0eKfmGrsTMSssnH9JubiKUCO/LKNgscVJyozNU4KdPyQl1YVSIcmPkMbR
	 v5U/+NYX2wsZ5hCBh7eUDc3Cbl+gRA/KX12a28y5jtzWLPU3BPSFQYAdcNuCI3VFgM
	 2VJ7clWXjnG7g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 9/9] mm/damon/core: handle extreme memory state
 in get_in_active_mem_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260802162631.90304-10-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
 <20260802162631.90304-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 16:51:05 +0000
Message-Id: <20260802165105.947281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit integer overflows and truncations in DAMON memory metric ca=
lculations cause wildly incorrect quota logic on 32-bit architectures.
--

--- Patch [9]: [RFC PATCH v1.1 9/9] mm/damon/core: handle extreme memory st=
ate in get_in_active_mem_bp() ---
commit e72445b8d3c8d0866c458b7707c7433d7912c2e6
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle extreme memory state in get_in_active_mem_bp()

This commit addresses a divide-by-zero issue in damos_get_in_active_mem_bp(=
).
It ensures the denominator is at least 1 when calculating the ratio of
active or inactive memory, preventing a crash if both are zero.

Link: https://lore.kernel.org/20260721034756.147011-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 67ad1f07c29a4..c79b854e1a971 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3014,7 +3014,7 @@ static unsigned int damos_get_in_active_mem_bp(bool=
 active_ratio)
>  		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
>  	inactive =3D global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
>  		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
> -	total =3D active + inactive;
> +	total =3D max(active + inactive, 1);
>  	if (active_ratio)

[Severity: High]
This is a pre-existing issue, but does this code overflow 32-bit unsigned
math on 32-bit architectures?

The mult_frac(x, n, d) macro computes (x / d) * n + (x % d) * n / d. Since
n is 10000, the multiplication x * 10000 is performed using 32-bit unsigned
arithmetic on 32-bit systems (where unsigned long is 32 bits). If active
memory exceeds 429,496 pages (~1.76 GB), the multiplication overflows
ULONG_MAX, resulting in an incorrect ratio.

Does this same overflow also affect other DAMON memory metric calculations?
For example, in damos_get_node_eligible_mem_bp():

    return mult_frac((unsigned long)node_eligible, 10000,
                     (unsigned long)total_eligible);

This explicitly casts a 64-bit phys_addr_t to unsigned long, truncating
capacities over 4GB on 32-bit systems. It also overflows mult_frac() if the
eligible memory exceeds just ~419 KB.

Similarly, in damon_get_intervals_score():

    max_access_events +=3D sz_region * c->attrs.aggr_samples;
    access_events +=3D sz_region * r->nr_accesses;

Because sz_region is in bytes, accumulating these into an unsigned long
seems to overflow for regions larger than a few tens of megabytes.

>  		return mult_frac(active, 10000, total);
>  	return mult_frac(inactive, 10000, total);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802162631.9030=
4-1-sj@kernel.org?part=3D9

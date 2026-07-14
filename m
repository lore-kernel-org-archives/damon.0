Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31434CFCF
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042286; cv=none; b=Bi940Eu2wv25IGhw5DukjKkzUpsb5xCEsHPxzoFTs6r7GT89lnPWmmSptwzw213YUm95AAFGvAphLUzAsd1cE1tF5DxnjkIc9C0DTPRd65mEa43p5OeQIJQaFXDq66182E3Ag51+x+fGysSU2Mc1HQnH3QjOtv9ns6jjssi+nbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042286; c=relaxed/simple;
	bh=TJng5mxW7x4uoKCMl3pS8vpRDCcXe8N9X0+fszp4pj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qTd3+JzTF1Om0riVZPJR22kRTys7BCcCwl4Ubk3EiLvMjPeqDYJQjJY985pvnS5iVIjWLeULzkQ0Fco0b5rGoM+GO/2FV8LJLBJvVZroMGHIz3cHGg2J+x3OMbJP4wtl+3IA6v1YlwanZn59q2ZXvdy2tJpzvDJEbqgyMlopvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH8pWqdc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH8pWqdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7D71F000E9;
	Tue, 14 Jul 2026 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784042284;
	bh=B0tQD2jZvpvORmYo23CsYPsX5jqHE6uqk8Wou79QNp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HH8pWqdceZfKR89242HjJVnCa3vLcGSvlehMyT619CeBqnpS3CXwPLhReMfWkiU+A
	 7vxIiJ27sDQUcJsAWGwx96oq2H32CfXmvmgetSIQtheh9Y58//ssRhcYP0zsV1Oe+2
	 VtyJiYPLLFeGlislBGaUbg9kuO0NPiV63onYv6rj9Kfl6c3/aRq9sbOuSu6R3rg4CI
	 BeIYAYH1t4jCz3BLNoGcgUuqIZ3gzysHiFM3/RKpIy49Fgu9QWh4bRoyHlMwzDO2DB
	 t/iJjNd37WOFv4KRrXPvclu4Wuz7tEXdktWDWSMLJwkn+j9kDsLstlUYwSW4YAUjlN
	 V3DgotNgN5/Sg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v2 3/3] Docs/mm/damon/design: Document
 hugepage_mem_bp target metric
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260714150116.382521-4-gutierrez.asier@huawei-partners.com>
References: <20260714150116.382521-1-gutierrez.asier@huawei-partners.com>
 <20260714150116.382521-4-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:18:04 +0000
Message-Id: <20260714151804.8C7D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Potential division by zero in `damos_hugepage_mem_bp()` when compu=
ting the hugepage memory ratio due to an unvalidated denominator.
- [Low] Inaccurate metric name in the commit message.

Pre-existing issues:
- [High] Potential division by zero in `damos_get_in_active_mem_bp()` when =
calculating the active/inactive memory ratio.
- [High] Potential division by zero in `damos_get_node_mem_bp()` and `damos=
_get_node_memcg_used_bp()` when a NUMA node's managed pages evaluate to 0.
--

--- Patch [3]: [RESEND PATCH v2 3/3] Docs/mm/damon/design: Document hugepag=
e_mem_bp target metric ---
commit d0083321a3dc33547522a0679c37d9ea234b4e37
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Docs/mm/damon/design: Document hugepage_mem_bp target metric

This commit documents the hugepage_mem_bp metric exposed by sysfs for
DAMON quota goals. It updates the design documentation to include the new
ratio of huge pages to total used memory.

> Docs/mm/damon/design: Document hugepage_mem_bp target metric
>=20
> Document huge_mem_bp metric exposed by sysfs.

[Severity: Low]
This isn't a bug, but is the metric name in the commit message accurate?
The code and the subject line refer to hugepage_mem_bp, but the commit
description refers to huge_mem_bp.

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b06..b001f80681b12 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2795,6 +2795,17 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);

[Severity: High]
This is a pre-existing issue, but can this divide by zero?

If the sum of active and inactive LRU pages is zero (e.g., in highly
constrained environments or due to negative per-CPU counter drift), total
evaluates to 0.

mm/damon/core.c:damos_get_in_active_mem_bp() {
    ...
    total =3D active + inactive;
    if (active_ratio)
        return mult_frac(active, 10000, total);
    return mult_frac(inactive, 10000, total);
}

Passing total to mult_frac() without validating if it is non-zero
can crash the kernel via a division by zero.

>  }
> =20
> +static unsigned int damos_hugepage_mem_bp(void)
> +{
> +	unsigned long thp, total;
> +
> +	thp =3D global_node_page_state(NR_ANON_THPS) +
> +				global_node_page_state(NR_SHMEM_THPS) +
> +				global_node_page_state(NR_FILE_THPS);
> +	total =3D totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> +	return mult_frac(thp, 10000, total);

[Severity: High]
Does this code risk a division by zero panic?

The calculation unconditionally passes total as the denominator to
mult_frac() without validating it.=20

Because global_zone_page_state() reads from atomic per-CPU counters without
strict synchronization, it can temporarily drift. If this per-CPU drift cau=
ses
NR_FREE_PAGES to equal totalram_pages(), total will evaluate exactly to 0,
crashing the kernel when the quota goal is evaluated.

> +}

[ ... ]

While reviewing the DAMON quota calculations in mm/damon/core.c, I noticed
some pre-existing regressions in related functions:

[Severity: High]
This isn't a bug introduced by this patch, but are damos_get_node_mem_bp()
and damos_get_node_memcg_used_bp() susceptible to a division by zero?

In both functions, if a NUMA node has N_MEMORY set while all its memory is
reserved (meaning zone_managed_pages is 0), si_meminfo_node() sets i.totalr=
am
to 0.

mm/damon/core.c:damos_get_node_mem_bp() {
    ...
    si_meminfo_node(&i, goal->nid);
    if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEM_USED_BP)
        numerator =3D i.totalram - i.freeram;
    else
        numerator =3D i.freeram;
    return mult_frac(numerator, 10000, i.totalram);
}

mm/damon/core.c:damos_get_node_memcg_used_bp() {
    ...
    si_meminfo_node(&i, goal->nid);
    ...
    return mult_frac(numerator, 10000, i.totalram);
}

Passing i.totalram as the denominator to mult_frac() without checking if it
is zero will trigger a division by zero panic. Users configuring DAMOS with
node-specific metrics on a node with zero managed pages can reliably trigger
this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714150116.3825=
21-1-gutierrez.asier@huawei-partners.com?part=3D3

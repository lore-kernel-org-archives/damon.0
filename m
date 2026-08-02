Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99E3ACA71
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688715; cv=none; b=ckgKY0Qkh+vFTcwy4CdxozaToY8uFxzhYJ/tBj+o+UdUHgADVuk77Buajn14A/PupQ4tyKi4/jRFHL7/MDQt47aiNUyQlQ7Wuw7cpEStvif6D3cKPCiAo39H0NYOewv03ZVF/u/xIF9gexKLSvakB3ZTVihtWpW9+xuccGWCZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688715; c=relaxed/simple;
	bh=xjQLMmf1z14zTSQEDuq2G0VzAuiZJdsBpzzZf8YwDBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gGCDkI1rPGBuqSEllvKRHAPTr2Kr6a3ksqBb5xgrFXfbY/tmyHVGp9S9m6BdbrRQfWmefhph0dnovPDjIfhEiO9y+MVvF2wu5N9cGTtjMrxLM3/SynUmuM+/qb5/035+XZIVhMdJVCSi/Z3oDzmjJ2YH247bLkl6nvgcbgqccoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDVlG+ZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDVlG+ZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C72B1F000E9;
	Sun,  2 Aug 2026 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688714;
	bh=JWEU+AzqGHxd0wTl/ZBo8zvvQj1cjejpdkV4u6hXq7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IDVlG+ZA4vp84k35ohfR4vaLVbPpzRxlPMbgTvI0B38mAn6bO5UgnlDo7e/EcqqMU
	 5XXOT07T9ram3e2fRMd4cFbYxcMay3VSiNFtu9/Iq7JOy+soWSVCLrRcQIkQI9qS3/
	 +3r/GzIWQ9Zon/m76kn3N8a/7CI0r/zRPdzsc8Lq5i0IrJvwQ1RFIlb8Lpb6b3uvs6
	 oEP5FxnSkih7rrZEgIPR66SuXWucGKZRlDsd4IU0dk1/QGyzgG6b28FoBjnkm0TQM2
	 mMU3KJHX58NI69WS7X9teZqmMTRRhEMmWXl6dCCAvnS/x5eccAEQxJdarrs3iQl3Zk
	 Z53pEZ+2nnpRg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 8/9] mm/damon/core: handle extreme memory state
 in get_node_memcg_used_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260802162631.90304-9-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
 <20260802162631.90304-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 16:38:33 +0000
Message-Id: <20260802163834.2C72B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but damos_get_node_m=
em_bp() contains a severe logic bug and underflow when free memory exceeds =
total memory (i.totalram < i.freeram).
--

--- Patch [8]: [RFC PATCH v1.1 8/9] mm/damon/core: handle extreme memory st=
ate in get_node_memcg_used_bp() ---
commit 0fb31bc202c766c30f5d776d57b867135fba4aa6
Author: SJ Park <sj@kernel.org>
mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()

This commit addresses division by zero and underflow issues in
damos_get_node_memcg_used_bp() by handling cases where total memory is zero=
 or
used memory exceeds total memory. It returns 100% and 0% for these respecti=
ve
edge cases to prevent anomalous behavior.

Link: https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e3f3ee75a3d33..67ad1f07c29a4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2862,10 +2862,16 @@ static unsigned long damos_get_node_memcg_used_bp(
>  	mem_cgroup_put(memcg);
> =20
>  	si_meminfo_node(&i, goal->nid);
> -	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> +	if (!i.totalram)
> +		return 10000;
> +	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEMCG_USED_BP) {
>  		numerator =3D used_pages;
> -	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> +	} else {
> +		/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> +		if (i.totalram < used_pages)
> +			return 0;

[Severity: High]
This isn't a bug introduced by this patch, but does the adjacent
damos_get_node_mem_bp() function contain a logic bug when free memory excee=
ds
total memory?

If i.totalram < i.freeram, it appears that for DAMOS_QUOTA_NODE_MEM_USED_BP,
i.totalram - i.freeram will unconditionally underflow, falsely throttling or
activating schemes. For DAMOS_QUOTA_NODE_MEM_FREE_BP, returning 0 means it
reports 0% free memory when the node is actually >100% free, which could ca=
use
schemes waiting for low free memory to trigger aggressively.

mm/damon/core.c:damos_get_node_mem_bp() {
	...
	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEM_USED_BP) {
		numerator =3D i.totalram - i.freeram;
	} else {
		/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
		if (i.totalram < i.freeram)
			return 0;
		numerator =3D i.freeram;
	}
	...
}

Should this pre-existing issue in damos_get_node_mem_bp() be addressed as w=
ell,
perhaps by returning 0 for USED_BP and 10000 for FREE_BP when
i.totalram < i.freeram?

>  		numerator =3D i.totalram - used_pages;
> +	}
>  	return mult_frac(numerator, 10000, i.totalram);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802162631.9030=
4-1-sj@kernel.org?part=3D8

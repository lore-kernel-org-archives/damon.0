Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25396318EE7
	for <damon@lists.linux.dev>; Fri, 22 May 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464708; cv=none; b=cysZYg4c2A36z8y6Kzgt7MMA+bB1Qi1MBXOHrcd3fvWmMjElXWTYST02wc4mcWs83zi2Pa5vTGe/rHLrsCVdWSNF7hrTmsFEq0RiB07SkiKzq0+L8mTOM9r77rl0B0+eCxzw/STD/S8Jg/uDiGC0+/mu3mEiwctyx0r3+SMRLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464708; c=relaxed/simple;
	bh=D9RgZo5GbcvTXltc63ZtQJfoCVJ35PiEKL06qr1cNys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dwNFf6NZfXyo1nkOJQcJxEARfVFwMMaPCxcNtQY4kmZolm1gLvMM3mU1u5pUbaCsvtoCvYeEJ5AeuzJ4esCgE7XNxl1j79W13i4gpn9+P5u7e1icgs/KoPLGcUjqfNSqbJ0zM8K93YxJ2dHCoEsWXuJE2GHQZDI1WgTuXUsmPnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsn4iKo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsn4iKo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834311F000E9;
	Fri, 22 May 2026 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464706;
	bh=XHQG+DBY2Yh+rExaJ1tXxjTa9GJe+A67BUtFnE0y6rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vsn4iKo2ai9N2P/LFRZlcEr+flYTi6N2UL7LYp0qUx+wnO2/wVC+D+sYr9nkMi80x
	 qO09euiNXQq/OoIV57O1gpwQML7eymy2F4kkhTSc87N74flyC7x3pOebp7o6rfaKFL
	 5EXDemdmbpZV6nklKxP+kgFAOHjG0i32h3M+5mRM9QQqIS1n/tl+4OlFvmNnlAG/bE
	 mwh8JoO+jWwzEgwa0adTtwtV6do7Gb/0cyPX6uXNTXJ9sv+ptixw4MPRapSPZXz1xt
	 3/ASozDghAZ1p2FKMSrPMHlvwS6sFcNFmcgUsld7ilz/wwU8p3o0POG/6d/lxfkA/R
	 XLFwbLi9Ik0/w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE
 auto tuning
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260522145518.158910-3-gutierrez.asier@huawei-partners.com>
References: <20260522145518.158910-3-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 15:45:05 +0000
Message-Id: <20260522154506.834311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Potential kernel panic due to division by zero in `damos_get_used_=
hugepage_mem_bp()` if `total_used` evaluates to 0.
- [Medium] The new `DAMOS_QUOTA_HUGEPAGE` metric is missing from the sysfs =
configuration interface, rendering it unconfigurable by user space.

Pre-existing issues:
- [High] Potential kernel panic due to division by zero in `damos_get_in_ac=
tive_mem_bp()` if `total` is 0.
--

commit 17f3c2a2e9debd874a0d571c22ff99586a8c2736
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning

This commit introduces a new DAMOS quota goal metric, DAMOS_QUOTA_HUGEPAGE.
It is designed to measure the ratio of anonymous huge page consumption
against total anonymous memory consumption.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -176,6 +176,7 @@ enum damos_quota_goal_metric {
>  	DAMOS_QUOTA_ACTIVE_MEM_BP,
>  	DAMOS_QUOTA_INACTIVE_MEM_BP,
>  	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> +	DAMOS_QUOTA_HUGEPAGE,

[Severity: Medium]
Does this new metric need to be exposed to user space?

It looks like the string mapping array damos_sysfs_qgoal_metric_names in
mm/damon/sysfs-schemes.c was not updated to include this new metric.
Without this mapping, will attempts to set the new metric via sysfs fail
with -EINVAL?

>  	NR_DAMOS_QUOTA_GOAL_METRICS,
>  };

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2743,6 +2743,18 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);

[Severity: High]
This isn't a bug introduced by this patch, but could the total variable in
damos_get_in_active_mem_bp() ever evaluate to zero?

If the system is in an early boot state or a highly constrained environment
where the sum of active and inactive LRU pages evaluates to zero, wouldn't
passing it as the denominator to mult_frac() trigger a divide-by-zero
exception?

>  }
> =20
> +/*
> + * Returns anon hugepage memory to total anon memory use ratio.
> + */
> +static unsigned int damos_get_used_hugepage_mem_bp(void)
> +{
> +	unsigned long used_hugepages, total_used;
> +
> +	used_hugepages =3D global_node_page_state(NR_ANON_THPS);
> +	total_used =3D global_node_page_state(NR_ANON_MAPPED);
> +	return mult_frac(used_hugepages, 10000, total_used);

[Severity: High]
Can total_used evaluate to zero here?

If the system has no mapped anonymous memory,
global_node_page_state(NR_ANON_MAPPED) could return 0. If total_used is
zero, will the division inside mult_frac() trigger a divide-by-zero
exception?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522145518.1589=
10-1-gutierrez.asier@huawei-partners.com?part=3D2

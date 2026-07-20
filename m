Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C712414DC1
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549825; cv=none; b=E+zPj+urGkNbXO+w1GWVZkSeDLx++RVwVz8qfijQD2HiucXcWKSmiHhmZRgeYc4AtvwiERjBbvC8B2BtV+ZT+byY+fNAFTq7uQVTTMxDITv/W3xVfdvKGAZE9cruJI2cCVZtZ4jxc+GcSztBqtHnl7snoSLmBUBuh4kFuNgqm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549825; c=relaxed/simple;
	bh=2zAXpSN0NdTubJcIQH/Xq5hMHvL/nTjx+2dvN4phEtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kCNMFyovQrx91AetZ393laC49qZSyJhdVC84pfQNQuq25eZcIZYRBHbRErJfP200pt1ZQO6eJGr0dQGBfK/9zZjy6F3zxV/UPyrBYRq5Usr6vOdaJ3JZudN5U/z/LOY4rTCjcqezlns1YJ2e4SUv3UjxRSHHe35cNfC5z3tWyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSz5GqZG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSz5GqZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFC01F00AC4;
	Mon, 20 Jul 2026 12:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784549818;
	bh=Y2USl01GJFzmSuP3HxXlhqa24m3BXXAGs10fispDXG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MSz5GqZGo7uQacE1QviDrhm5xWlE7VQSECifpVvDugDB5O2fTqUB3lQJltXV3p662
	 jm8DERFMVZzNAuc/SaNdDiGY1kgOdelJM0F9kAPsH7VNJhmB/+V6dR1dkqbab3OcR7
	 Xz3vMEyDDMRbXory46ioBbmaUjia7qd91jQmEfxXkVf4sOmIcQPbWZlo9qoI6iALED
	 mOgDB+t3bVOgmDdVGrvQHGm94CdxmpukVNq4opM4xpFvtyOwyEx91dr+O4AMMeJ7lA
	 7gGU0eb1bk4arERSI6HlLHTJxYmeRR3cI2TwcgFMKVlrp0XKmJPqEdNVmms6LCGIfs
	 IXd3TWRKbSCVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto
 tuning
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260720120140.881468-2-gutierrez.asier@huawei-partners.com>
References: <20260720120140.881468-1-gutierrez.asier@huawei-partners.com>
 <20260720120140.881468-2-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:16:57 +0000
Message-Id: <20260720121658.0AFC01F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unsigned underflow in `total` bypasses the division-by-zero guard,=
 causing `damos_hugepage_mem_bp` to return 0 instead of the intended safegu=
ard `INT_MAX`.
- [Medium] The new `DAMOS_QUOTA_HUGEPAGE_MEM_BP` metric is missing from the=
 sysfs parser mapping array, rendering the feature completely inaccessible =
to userspace.
- [Medium] 32-bit integer overflow in `mult_frac()` yields drastically inco=
rrect ratios when the number of huge pages exceeds ~1.7GB.

Pre-existing issues:
- [High] Preexisting division by zero in `damos_get_in_active_mem_bp` when =
LRU lists are empty.
--

--- Patch [1]: [PATCH v3 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto=
 tuning ---
commit 8d24f093924a5075fd67c8f7808eada2166af60d
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning

Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP auto tuning and add a new DAMOS
quota goal metric to measure huge page consumption. Add a guard to avoid
division by 0 when vmstat lags.

Link: https://lore.kernel.org/all/20260715151615.99767-1-sj@kernel.org/

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -167,6 +168,7 @@ enum damos_quota_goal_metric {
>  	DAMOS_QUOTA_ACTIVE_MEM_BP,
>  	DAMOS_QUOTA_INACTIVE_MEM_BP,
>  	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> +	DAMOS_QUOTA_HUGEPAGE_MEM_BP,

[Severity: Medium]
Is this feature accessible from userspace?

If a user writes hugepage_mem_bp to the target_metric sysfs file,
target_metric_store() iterates over the damos_sysfs_qgoal_metric_names
array to find a match.

Because DAMOS_QUOTA_HUGEPAGE_MEM_BP is missing from that array in
mm/damon/sysfs-schemes.c, will the kernel always reject the user's input
with -EINVAL?

>  	NR_DAMOS_QUOTA_GOAL_METRICS,
>  };
> =20
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3007,6 +3007,24 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);

[Severity: High]
This is a pre-existing issue, but can this divide by zero?

In damos_get_in_active_mem_bp(), total is used as the divisor without a zero
check. If all memory is forced onto the unevictable list (e.g. via
mlockall()), or if the system is completely idle with only kernel allocatio=
ns,
active + inactive can be zero.

If DAMOS_QUOTA_ACTIVE_MEM_BP is used in such a state, would mult_frac()
trigger a hardware divide-by-zero exception and panic the system?

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
> +
> +	/*
> +	 * vmstat may lag in idle systems and lead to free pages equaling to
> +	 * the total RAM in the system.
> +	 */
> +	if (!total)
> +		return INT_MAX;

[Severity: High]
Can total underflow here?

Because global_zone_page_state(NR_FREE_PAGES) relies on vmstat, which uses
per-CPU caching, the global NR_FREE_PAGES counter can temporarily exceed
totalram_pages() if some CPUs have flushed frees while others have pending
allocations.

If this happens, total (which is unsigned long) underflows to a value near
ULONG_MAX. Could this bypass the !total guard and pass a massive integer
to mult_frac(), which then incorrectly returns 0?

> +	return mult_frac(thp, 10000, total);

[Severity: Medium]
Will this overflow on 32-bit architectures?

mult_frac() evaluates the intermediate multiplication using the types of its
arguments. Since thp is an unsigned long, evaluating thp * 10000 uses 32-bit
arithmetic on 32-bit systems like ARM LPAE.

If the system has more than 429,496 base pages of THP (approximately 1.7GB),
will this silently wrap around and yield drastically incorrect quota goal
ratios?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720120140.8814=
68-1-gutierrez.asier@huawei-partners.com?part=3D1

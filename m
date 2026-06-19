Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD28140E5F
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881946; cv=none; b=dcI+ChiqpSa5OoX2RUGP6IHpfU7sA4b2yw2twV2WlRfK0mSzVFRTsSiG1UU9IWkNPIoy5L7UqtPr2ZJ+gI0XfjG8hZfv/BrOH3WlXOTTq6cNHia+08gmTlmo+aHpCZvh4yDoEC/9V/c/hYRAn88lQFiQJX51tdwoMsjjEHzZzh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881946; c=relaxed/simple;
	bh=0nW5ik3PNWX0orMDgDyilBs/W1+6ZeX+CSlwp1mnwMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b36KEaCliYiUMAvwdvPFas01TEz/t+5jnh3WW3pdFNYcjIg/IFLruLBUyDPs2zcQAiiM8O1Up3HyYNx8RjScme1h5b6dehXvMsgqbAKjULFnCUuf4D7uHbrB3otx4/JmWUjyXtJUE2BpBHAdDGQ/YyhJ1YmHVkAUtbpVXpQw9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/ExGExf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/ExGExf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66A31F00A3A;
	Fri, 19 Jun 2026 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781881944;
	bh=NYkDUKA/1LYbEqBLnobyJfS1Hy3fiDMwrXQLxXwPQxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/ExGExfQ8Kr5EQKklTyjIo7dHI2mKQbuwYrh4MvWQyRoW/pYd3b1U/ofSPPCLjrJ
	 vwMWJvkvyyN8F+m+tT1HHjUYduiyBnjNND5B8UmdETbp9n+GgPS+V2bINmBego4oZw
	 qUBKu7Pw8nI6GTW7QipemiDrPQgbMRPzulSVqP0rva3nr3XF19RJMQiENL48w4AV/a
	 67nv83736MSVdL13buthmg2YxGx4EJ7l6feRRSLlygHB5LZUGeKFkco4m8VHCA43+x
	 9FOs80HQEsSv7+PW3SMqbEx/mDvfKD/mOVhxOi66k77KA0e9oVgImZqbUD0WyTx6vr
	 RuzOJrmsTY8MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto
 tuning
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260619145821.2109933-2-gutierrez.asier@huawei-partners.com>
References: <20260619145821.2109933-1-gutierrez.asier@huawei-partners.com>
 <20260619145821.2109933-2-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 15:12:24 +0000
Message-Id: <20260619151224.A66A31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Missing zero check for `total` memory in `damos_hugepage_mem_bp()`=
 leads to a potential divide-by-zero kernel panic.
- [Medium] `damos_hugepage_mem_bp()` fails to account for PTE-mapped large =
folios (mTHPs), leading to inaccurate statistics.

Pre-existing issues:
- [High] Missing zero denominator check for `total` LRU memory in `damos_ge=
t_in_active_mem_bp()` causes a divide-by-zero kernel panic.
- [High] Missing zero denominator check in `damos_get_node_mem_bp()` and `d=
amos_get_node_memcg_used_bp()` can cause a divide-by-zero kernel panic.
--

commit 93cbe76d8ef461360b9dc14ac3328663e6ee8602
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning

This commit introduces DAMOS_QUOTA_HUGEPAGE_MEM_BP auto tuning. It adds
a new DAMOS quota goal metric to measure the amount of huge page
consumption to total memory consumption ratio.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b06..b001f80681b12 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2795,6 +2795,17 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);

[Severity: High]
This is a pre-existing issue, but can this lead to a divide-by-zero panic?

If a system or node has no evictable pages (for example, in constrained
environments with only kernel slab allocations or purely unevictable/mlocked
workloads), active and inactive LRU counts will both be 0.=20

Could total be evaluated as 0 here, causing mult_frac() to trigger an
unconditional divide-by-zero kernel panic?

>  }
> =20
> +static unsigned int damos_hugepage_mem_bp(void)
> +{
> +	unsigned long thp, total;
> +
> +	thp =3D global_node_page_state(NR_ANON_THPS) +
> +				global_node_page_state(NR_SHMEM_THPS) +
> +				global_node_page_state(NR_FILE_THPS);

[Severity: Medium]
Does this calculation miss PTE-mapped large folios (mTHPs)?

These vmstat counters only track PMD-mapped transparent huge pages. They
do not track PTE-mapped multi-size THPs (mTHPs), which increment separate
counters such as MTHP_STAT_NR_ANON.=20

Since modern kernels increasingly use mTHPs, will DAMON's quota
auto-tuning underestimate the actual huge page consumption here?

> +	total =3D totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> +	return mult_frac(thp, 10000, total);

[Severity: High]
Could total evaluate to zero here and cause a divide-by-zero panic?

If all managed memory on the system is free (e.g., in a specialized idle
state) or if per-CPU counter drift causes
global_zone_page_state(NR_FREE_PAGES) to momentarily equal
totalram_pages(), total will evaluate to exactly 0.=20

Since mult_frac() performs standard division without internal zero
checks, could this trigger a hardware divide-by-zero exception and crash
the kernel?

> +}

While reviewing the LRU metric above, I noticed a similar pattern in
other DAMOS metric calculations:

mm/damon/core.c:damos_get_node_mem_bp() {
    ...
    si_meminfo_node(&i, goal->nid);
    ...
    return mult_frac(numerator, 10000, i.totalram);
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code also suffer
from a missing zero denominator check?

damos_get_node_mem_bp() and damos_get_node_memcg_used_bp() filter valid
nodes via !node_state(nid, N_MEMORY), but N_MEMORY only guarantees the
presence of physical memory, not managed buddy pages.

If all physical memory on a node is reserved (such as memblock
reservations or crashkernel), managed_pages will be exactly 0, which
means i.totalram populated by si_meminfo_node() will be 0.=20

Could this result in a divide-by-zero panic when evaluated by
mult_frac()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619145821.2109=
933-1-gutierrez.asier@huawei-partners.com?part=3D1

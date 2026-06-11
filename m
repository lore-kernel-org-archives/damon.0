Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190A3FC5CA
	for <damon@lists.linux.dev>; Thu, 11 Jun 2026 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191228; cv=none; b=Ji0d4T66Qt2I/QNz5ibnJJDlOMB/qFLKwu0j3Kiz/ixaHXVQ7B39/BMiidfREDvi5VEpP0neI51/ovUS+mGYArVuakMAx+MfqYwxdoeUT23m05ErpF4gsdMJZ1JXq6WIqD+Poznx5OjAtt5qundeovhwnFzPUhpYjb5naU9jM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191228; c=relaxed/simple;
	bh=1qiqBK1G2TRfN+5W+ZJpdFya4kuCkXA1YfMlCRK4iGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uu4//trmqbeZACz1qanPbotQP0DmWC9RUSVU4ZF6IFlhIqLueTsUUbP0k03E/7KFhtzx7pApXzxS83FfNBHknVygtBdAUbAID+xx2oTGtETDnm9uk6/7u+rfgZai6sMb7T5Z3AAY+QD749bOrB8JgxnyWEuuR74WC4/P469TBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/pJ4JsF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/pJ4JsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC06F1F00893;
	Thu, 11 Jun 2026 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191226;
	bh=VdN6Fca25fmqLtZLIKp1Imod9j0HUaMN4DSURbuLiVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/pJ4JsF5/UrI0gwt6INhbg0Yk04723VR5y3flNvTHNVIk/lkJVObPbnF26VWGFNb
	 ekoRgNB9jDRqIJvqkFnp2RfUyivTiX+hg1wYqxUt42fPLAjvEJk1tn0cpH8Hej8Nt6
	 8j/Bu3Oi/40ochH/tFf1+VXxvxivP5EyZq7YLymiV7H+YHUlifwIO4tJ/aK52V1rnv
	 vd4CWz1Tn6UEh9QM/3Bf7zjffRXenPFfYztFirkCRXNA0MBGI0JGetOlAyAs5KEYOR
	 vdHzbscnIyZ2FYQdA3Dp/C0oEpohAVtP/Re1ySGCk7IQmRJ2HUZ4srBy7WQxNPffpz
	 6VM2eVnmJVnjQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 1/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE
 auto tuning
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260611150244.3454699-2-gutierrez.asier@huawei-partners.com>
References: <20260611150244.3454699-2-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:20:26 +0000
Message-Id: <20260611152026.CC06F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Incomplete Metric Implementation (mTHP & PTE-mapped THP omitted)
- [High] 32-bit Integer Overflow in Hugepage Metric

Pre-existing issues:
- [High] Pre-existing 32-bit Integer Overflows in DAMON metrics
- [High] Pre-existing Division by Zero in damos_get_in_active_mem_bp
--

commit 7873411ecddc79aa5afd0d6d56dfa25345f98454
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning

This commit introduces a new DAMOS quota goal metric to measure the amount
of huge page consumption to total memory consumption ratio. It adds the
DAMOS_QUOTA_HUGEPAGE_MEM_BP metric and its corresponding calculation logic
for scheme auto-tuning.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b06..b001f80681b12 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2795,6 +2795,17 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the use of mult_frac()
in damos_get_in_active_mem_bp() risk a division by zero?

If a system has no active or inactive pages (which is structurally possible
if user processes are non-existent, completely swapped out, or if all pages
are mlocked into the UNEVICTABLE LRU), the total evaluates to 0:

mm/damon/core.c:damos_get_in_active_mem_bp() {
    ...
    total =3D active + inactive;
    if (active_ratio)
        return mult_frac(active, 10000, total);
    ...
}

Since mult_frac() divides by the denominator, could this trigger a
division-by-zero kernel panic?

[Severity: High]
This is a pre-existing issue, but can the mult_frac() calculation overflow
on 32-bit architectures?

In both damos_get_in_active_mem_bp() and damos_get_node_mem_bp(), the metri=
cs
evaluate macros like:

    mult_frac(active, 10000, total);
    mult_frac(i.totalram - i.freeram, 10000, i.totalram);

The mult_frac() macro performs an intermediate multiplication of
(x % d) * 10000.

On 32-bit architectures with more than ~1.76 GB of memory, can this
intermediate multiplication exceed UINT_MAX and silently wrap around,
corrupting the memory ratios?

> =20
> +static unsigned int damos_hugepage_mem_bp(void)
> +{
> +	unsigned long thp, total;
> +
> +	thp =3D global_node_page_state(NR_ANON_THPS) +
> +				global_node_page_state(NR_SHMEM_THPS) +
> +				global_node_page_state(NR_FILE_THPS);

[Severity: High]
Are multi-size THPs (mTHPs) and PTE-mapped THPs omitted from this calculati=
on?

The NR_ANON_THPS counter strictly tracks the number of base pages in
PMD-mapped anonymous THPs. It appears to ignore THPs that are mapped via
PTEs (e.g., due to VMA boundary crossing).

Furthermore, modern setups heavily rely on multi-size THPs (such as 64KB
or 128KB), which are tracked separately via per-order mthp_stats.

Will ignoring these lead to an incorrectly reported near-zero huge page
consumption on modern mTHP setups, breaking the auto-tuning behavior?

> +	total =3D totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> +	return mult_frac(thp, 10000, total);

[Severity: High]
Will this new metric also be impacted by the 32-bit integer overflow issue
mentioned above?

On 32-bit architectures, thp and total are 32-bit unsigned longs.

The intermediate multiplication in the mult_frac() macro evaluates to
(thp % total) * 10000.

If the system has more than UINT_MAX / 10000 memory pages (about 429,496
pages, or ~1.76 GB of RAM), could this intermediate result exceed UINT_MAX
and silently wrap around, leading to an incorrectly low hugepage ratio?

> +}
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611150244.3454=
699-1-gutierrez.asier@huawei-partners.com?part=3D1

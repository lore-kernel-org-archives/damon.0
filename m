Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C92D1916
	for <damon@lists.linux.dev>; Thu, 11 Jun 2026 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191460; cv=none; b=sn5eKOHULWepcrxws0yHQZoTJUyW5ZqgF+4DMOh2SQHIODFuW5MdJEN6GxHVx6SvZ5+yoCreatyTbAJzRBiUW3U5KVf4E3NAiUq+uk/JOmn9mMIRcHSoIJD/mK9IHJDE4RLrZYV32ZP1nLFWWbYj4ywSJUF/PVbosPMkwDG4cTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191460; c=relaxed/simple;
	bh=FO15N8OUdBs2/ldhHDl3Jz15YdSS1z+whQk5lCoToQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pFehH3qpkI7UeNrs7dFM7JIffy1/YFDc8x0azzo8UDdavKREArqtusNlz4cNE2awsngBMMXtdv8FKgKc0tO62qgSUp4wox5xFXeAqYjq1Bt+5NFebhWOM484xnl4lPKEFlpj/a5TVV9LVxuRj/GNvK5xgSqBf86EZ4G+b5ThoWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9EZDt9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9EZDt9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C3D1F00893;
	Thu, 11 Jun 2026 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191459;
	bh=bIFxX1tsG47yh2g6OIVMscHAVLZeV0c/IOu0BHSw930=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c9EZDt9PKP0wxqiWLTG6oLJFWinjtuBrhTIenS7WwahW4rdoUCIRrSAZpHtuAkCQL
	 h7XXw6U/nFQb1b2q3eh03ZYvKKoeiydsjQnlA7uuPTyBTWw6L2MYSeROHvJhkDXWeK
	 Y/7RDqL38Eu7vDfabGloVcLyExieJOIvffILtVAPCj9u/iG1VcMotv//KRbGCWUfph
	 v8yD1uADpBYKo5DdQisQSe1G8ic6++ZB1Jsonk0SkKe+jT2WzAQa75aMSAtnThxL/G
	 Hmyp3YabqvYpZu8lqxbFe2hB/M6RPdARAdAUjq7+ew87gJn1d6/4QFMW9Uag0HVfY5
	 k9l+e8jMcPrFA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 3/4] mm/damon/sysfs: support hugepage_mem_bp
 quota goal metric
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260611150244.3454699-4-gutierrez.asier@huawei-partners.com>
References: <20260611150244.3454699-4-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:24:18 +0000
Message-Id: <20260611152418.E4C3D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Missing zero check for total memory before calling `mult_frac()` c=
an cause a division by zero kernel panic.
- [Medium] Calculation of hugepage basis points in `damos_hugepage_mem_bp()=
` can overflow on 32-bit architectures.
- [Low] The metric `DAMOS_QUOTA_HUGEPAGE_MEM_BP` erroneously copies its `cu=
rrent_value` from sysfs, resulting in a dead store and misleading initializ=
ation.
- [Low] `samples/damon/hugepage.c` fails to compile on configs without `TRA=
NSPARENT_HUGEPAGE` due to `HPAGE_PMD_SIZE`.
--

commit 6648426483c20398b6f6fd9f51731549de51d36d
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon/sysfs: support hugepage_mem_bp quota goal metric

Add the "hugepage_mem_bp" to the sysfs-schemes interface. Also handle
DAMOS_QUOTA_HUGEPAGE_MEM_BP when constructing quota goals.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2795,6 +2795,17 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);
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

[Severity: High]
Can total be zero here, leading to a division by zero exception?

The total variable is calculated as totalram_pages() -
global_zone_page_state(NR_FREE_PAGES). On a newly booted system or due to
vm_stat per-CPU counter drift, NR_FREE_PAGES could temporarily equal
totalram_pages(), making total exactly 0.

If total is 0, passing it to mult_frac() will trigger a division by zero
exception and panic the kernel, since mult_frac(x, n, d) evaluates x / d.

Could a safeguard like if (!total) return 0; be added to prevent this?

> +	return mult_frac(thp, 10000, total);

[Severity: Medium]
Will this calculation overflow on 32-bit architectures?

The macro mult_frac(x, n, d) executes (x % d) * n / d, which evaluates to
thp * 10000 / total. Since thp and 10000 are unsigned long, this
multiplication occurs in 32-bit arithmetic on 32-bit architectures.

NR_ANON_THPS stores the number of base pages that are PMD-mapped. If the
system has more than 429,496 THP pages (approx 1.63 GB of memory, which is
possible on 32-bit architectures like ARM with LPAE), the multiplication
thp * 10000 overflows unsigned long.

This wrap-around results in an incorrect, artificially small value being fed
to the DAMON quota tuner, leading to erratic auto-tuning behavior.

> +}
> +

[ ... ]

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[ ... ]
> @@ -2877,6 +2881,9 @@ static int damos_sysfs_add_quota_score(
>  		case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
>  			goal->nid =3D sysfs_goal->nid;
>  			break;
> +		case DAMOS_QUOTA_HUGEPAGE_MEM_BP:
> +			goal->current_value =3D sysfs_goal->current_value;

[Severity: Low]
Does this erroneously copy the current value from sysfs?

Because DAMOS_QUOTA_HUGEPAGE_MEM_BP is an auto-calculated system metric
rather than a user-provided one, the DAMON core unconditionally overwrites
goal->current_value during the first evaluation interval in
damos_set_quota_goal_current_value().

This assignment appears to be dead code that breaks the pattern of other
system metrics which correctly fall through to the default case.

> +			break;
>  		default:
>  			break;
>  		}

[ ... ]

> diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
> --- a/samples/damon/Kconfig
> +++ b/samples/damon/Kconfig
> @@ -40,4 +40,16 @@ config SAMPLE_DAMON_MTIER
> =20
>  	  If unsure, say N.
> =20
> +config SAMPLE_DAMON_HUGEPAGE
> +	bool "Build DAMON-based collapse of hot regions (SAMPLE_DAMON_HUGEPAGE)"
> +	depends on DAMON && DAMON_VADDR

[Severity: Low]
Will this cause build failures on configurations without huge page support?

The Kconfig option SAMPLE_DAMON_HUGEPAGE does not depend on
TRANSPARENT_HUGEPAGE. When CONFIG_PGTABLE_HAS_HUGE_LEAVES is not set (which
happens when huge page support is disabled), HPAGE_PMD_SIZE resolves to
(1UL) << ({ BUILD_BUG(); 0; }).

This could lead to compile errors in samples/damon/hugepage.c since it uses
HPAGE_PMD_SIZE to calculate huge page counts.

> +	help
> +	  This module monitors a certain PID provided by the user through

[ ... ]

> diff --git a/samples/damon/hugepage.c b/samples/damon/hugepage.c
> new file mode 100644
> --- /dev/null
> +++ b/samples/damon/hugepage.c
[ ... ]
> +static int damon_sample_hugepage_damon_call_fn(void *data)
> +{
> +	struct damon_ctx *c =3D data;
> +	struct damon_target *t;
> +
> +	damon_for_each_target(t, c) {
> +		struct damon_region *r;
> +		unsigned long hugepages =3D 0;
> +
> +		damon_for_each_region(r, t) {
> +			if (r->nr_accesses > 0)
> +				hugepages +=3D r->ar.end - r->ar.start;
> +		}
> +		hugepages =3D hugepages / HPAGE_PMD_SIZE;

[Severity: Low]
Does this use HPAGE_PMD_SIZE without verifying huge page support is availab=
le?

As mentioned above, if TRANSPARENT_HUGEPAGE is not enabled, this macro will
trigger a BUILD_BUG() and break the compilation.

> +		pr_info("hugepage: %lu\n", hugepages);
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611150244.3454=
699-1-gutierrez.asier@huawei-partners.com?part=3D3

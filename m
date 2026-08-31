Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4A4457D5
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201360; cv=none; b=N1ut9ipJr8v5R1g9iiH8QQRFpVBaBnlxf/dP86WVt6DV/O2SOXMBlpA6p6IVAIjYw4235J/4RTp/RuxkrRmQ6Yh5PrUssLz/VXmwUMNtRq7ARyYObe6T862IdJu4DfUGGQDZiEBdYKlOyTTLkr98/DQlILcGD5/96OhvcSmFOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201360; c=relaxed/simple;
	bh=ZEvwigpzeMkv/mMnQvV86WEm/lHhsT0sdckr9hcaY6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G9BjmPNr6UHtAFcbdwl75OeTIALzEPeI0VoxhoBW+6FHCQXZadV2I93mVXcAFzJpYUleQt8N2KGBHrKn0SNc/+d+iR+KA8JiuNfYP5zswSpVjE2cg58V3TXGwwvU8L7vCrQ4CKmYsCjl7daaENAJPS6J0Hr+IUuBjWlJYEBOmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwKv/oee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwKv/oee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B4D1F000E9;
	Mon, 31 Aug 2026 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201359;
	bh=qmYgBPW2GZsGTmndTusSYSkguXgRIlez+sjGGPz+lh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PwKv/oeeenwpyDBZjL/coMGcQVf4zNEsTtHg9N6XuiDIHyWL2/tgg64NCEWfEixJj
	 ZE89Mb4RQWl892iv5r4XPeM7pufuMrR4gPIf2MW5BFqFTtjZwj7V/4yn1gentrZo/j
	 t551LRSflRz7wT0zGQ1QAl8nU9aorLJzPy4xFzkwl0B6f0ZXILSpPJ19ryAZ2odkVv
	 X0y8QtpUJ84IIbzdti8j60x2ImwxVCM29KQGqJhMYZsi3w+OCH5ScpiJ7/l7gLQVhx
	 WMZubNYYfRlZ0dcMtHHY+OxLzuY9r3kXulSC+ROjd43OpRISMXtiOA76CQABxwhFwq
	 UkWrDKx01ycLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] Docs/mm/damon/design: Document hugepage_mem_bp
 target metric
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831144732.80910-4-sj@kernel.org>
References: <20260831144732.80910-1-sj@kernel.org>
 <20260831144732.80910-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:35:58 +0000
Message-Id: <20260831183558.F0B4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Integer overflow in `mult_frac` on 32-bit systems for memory excee=
ding ~1.75 GB of huge pages, resulting in incorrect DAMOS quota auto-tuning.
- [Medium] The newly introduced DAMOS quota goal metric 'hugepage_mem_bp' i=
s not tested in the DAMON sysfs selftests.
--

commit 59f2c739bce03363ce501965d6708d807908af18
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning

Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP auto tuning. Add a new DAMOS quota
goal metric to measure the amount of huge page consumption to total
memory consumption ratio.

Link: https://lore.kernel.org/all/20260715151615.99767-1-sj@kernel.org/

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..9c0e42a1d2cfc 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3007,6 +3007,22 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);
>  }
> =20
> +static unsigned int damos_hugepage_mem_bp(void)
> +{
> +	unsigned long thp, total_pages, free_pages;
> +
> +	total_pages =3D totalram_pages();
> +	free_pages =3D global_zone_page_state(NR_FREE_PAGES);
> +
> +	if (total_pages <=3D free_pages)
> +		return 10000;
> +
> +	thp =3D global_node_page_state(NR_ANON_THPS) +
> +				global_node_page_state(NR_SHMEM_THPS) +
> +				global_node_page_state(NR_FILE_THPS);
> +	return mult_frac(thp, 10000, total_pages - free_pages);

[Severity: High]
Does this calculation overflow on 32-bit systems?

Since thp is an unsigned long, on a 32-bit architecture it is a 32-bit
integer. If the system has more than ~1.75 GB of huge pages (about 429,496
pages), the internal multiplication thp * 10000 will exceed 4,294,967,295
and wrap around.

This leads to an incorrect value being returned from mult_frac() and results
in incorrect DAMOS auto-tuning.

commit a2c5ad81dadcc820e74efd9d73c1f576bbe76457
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon/sysfs: support hugepage_mem_bp quota goal metric

DAMOS has a new autotune policy metric: DAMOS_QUOTA_HUGEPAGE_MEM_BP.
This patch exposes DAMOS_QUOTA_HUGEPAGE_MEM_BP through sysfs.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 32f495a96b17a..d9b81d7b5910e 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[ ... ]
> @@ -1269,6 +1269,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_q=
goal_metric_names[] =3D {
>  		.metric =3D DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
>  		.name =3D "node_eligible_mem_bp",
>  	},
> +	{
> +		.metric =3D DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> +		.name =3D "hugepage_mem_bp",
> +	},
>  };

[Severity: Medium]
Should there be an accompanying update to the selftests for this new sysfs
metric?

Currently, the hugepage_mem_bp metric is missing from the tests. For
example, in tools/testing/selftests/damon/sysfs.sh:test_goal(), the new
metric is not verified:

tools/testing/selftests/damon/sysfs.sh:test_goal() {
    ...
    ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
    ensure_write_fail "$fpath" "foo" "invalid input"
    ...
}

Running the sysfs.sh selftest will silently skip testing the new metric
because it wasn't added to the hardcoded list of valid inputs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144732.8091=
0-1-sj@kernel.org?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0E433120E
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586374; cv=none; b=GC/tO13rKWoCLKT0+dU1yk1RwRayNoih8BD2CZdbZULM2X+qQrEzzTVKVpzIW/9AsopKVA37kNbk2qLDKdBsV5qbunPrMX7QivzpyCcQQQTP1CzWgNyVmWiW04KG5nrzKJvu7gR/fa3T5YEFyewpbc4t+wAtBjna5qBPOBYE4M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586374; c=relaxed/simple;
	bh=erD6aZo/guU8tSOt7xC1KTyBQ2w86PNv0Ucu5HGNXPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U3EzGJ7mkjt9L9seMGvGs07CnVWiRH2ch3QFDrWSj464jYEby9otnsdZnDHBJHN/iI/UaZZJiou5kcWL5QSwjgjrMyo4cvtPCdM5QsebP6YBCN7i36cPw33LhaNSYmw62DupjIjFr9Bk9Vt/v8zE7Q/zAySxveesKyb5QBHIhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L09gPnQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L09gPnQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C431F00893;
	Thu,  4 Jun 2026 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780586372;
	bh=kcYaPGfZcJbqGTckhPXOSc/ANtL2+KfyhJIq6x3WlkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L09gPnQhg4SwRySsoJDKWO/ZTryyT/OcRmnWQVg+23Hn8jGdHPzQ2c4r20LGZHsBp
	 2n5ZTmC7B/TKVjD9DOQpeD17CQ3wkNKr5zAC1VWVC4vnOyXviRwYwszXnSuVy2H0JB
	 5wZuTEYf+xOQXUXIFPOorbh4kN/6NQkM1NrFtKtvSGAoAYDUvPbY6GoJVjHHUDicrV
	 IslRw3R5+YEj0ky62hHfTZjXcbm55Nob5HB1l0XgLSMdWF7hBbNj/aXYuQ4tUFgbQ3
	 Eu0BRUY98OkrwfejfVp1Roe1dOAq0W1v/WRxff+luLp+uWB7q6atOf5z3Hfc14oDwx
	 4/vb2zF7Pj6Yw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE
 auto tuning
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260604150338.501128-2-gutierrez.asier@huawei-partners.com>
References: <20260604150338.501128-2-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:19:31 +0000
Message-Id: <20260604151932.93C431F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] A potential division by zero in damos_hugepage_mem_bp() can cause =
a kernel panic if the total non-free RAM pages evaluate to 0.
- [Medium] The new DAMOS_QUOTA_HUGEPAGE metric is inaccessible from userspa=
ce because it was not added to the sysfs mapping array damos_sysfs_qgoal_me=
tric_names.
- [Medium] The implementation calculates the ratio of all THP memory to tot=
al used memory, directly contradicting the commit message's claim that it m=
easures huge page consumption relative to total anonymous memory.
- [Medium] The calculation in mult_frac() can silently overflow a 32-bit un=
signed long, resulting in arbitrarily small, incorrect quota targets.

Pre-existing issues:
- [High] The pre-existing DAMOS_QUOTA_ACTIVE_MEM_BP and INACTIVE_MEM_BP met=
ric computation can trigger a kernel panic via division by zero.
--

commit 1f37bbf7381e392f999f133e0444c2faad754df9
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning

This commit introduces a new DAMOS quota goal metric, DAMOS_QUOTA_HUGEPAGE,
which is intended to measure the ratio of huge page consumption against
total anonymous memory.

> Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a
> new DAMOS quota goal metric to measure the amount of huge
> page consumption to total anonymous memory consumption
> ratio.

[Severity: Medium]
Does this description match the implementation?

The commit message states this measures huge page consumption against total
anonymous memory, but the code in damos_hugepage_mem_bp() calculates the sum
of all transparent huge pages relative to total used memory.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6f7edb3590ef9..d840b0bc0b953 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -176,6 +176,7 @@ enum damos_quota_goal_metric {
>  	DAMOS_QUOTA_ACTIVE_MEM_BP,
>  	DAMOS_QUOTA_INACTIVE_MEM_BP,
>  	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> +	DAMOS_QUOTA_HUGEPAGE,

[Severity: Medium]
Does this new metric need to be added to damos_sysfs_qgoal_metric_names[]
in mm/damon/sysfs-schemes.c?

Without adding it to the string mapping array, it appears this metric cannot
be configured from userspace via sysfs.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 265d51ade25bf..71c8699bdd476 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2756,6 +2756,17 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);
>  }

[Severity: High]
This is a pre-existing issue, but can this cause a divide by zero kernel
panic?

If there are no active or inactive pages, or if per-CPU vmstat counter drift
evaluates total to 0, mult_frac() will divide by zero.

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
Can mult_frac() divide by zero here?

If the system is highly idle or due to per-CPU vmstat counter drift, total
could evaluate to exactly 0.

[Severity: Medium]
Is there a risk of a 32-bit overflow in this calculation?

On 32-bit architectures, mult_frac() preserves types, and computing
thp * 10000 could exceed the maximum unsigned long value if there are
more than ~1.7 GB of THPs, producing an arbitrarily small quota target.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150338.5011=
28-1-gutierrez.asier@huawei-partners.com?part=3D1

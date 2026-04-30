Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59CF429817
	for <damon@lists.linux.dev>; Thu, 30 Apr 2026 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563819; cv=none; b=UoBO1+moG9IizfwSWmbchFgNpHR+3OB63jGXQQJy2ldzMmLdJ1JKS6l79C/AcrnqG4M8xb44E5l9uyvciA/b4h6mDepOy/iqBze5KZCladiV9p5gR+rSstkvv61T6Uadar7t4xzq0XoN4MkeDyb5dDjzzINfC7h2/1iPos5xw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563819; c=relaxed/simple;
	bh=OAy9rmsQ9nEcYj5uK27fnoEfy9dpDPbx99HsH+6ZyQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EIGogNzdGGxGoaABnBvbPbwxrGWkzURo3127LCio9rnZOZvqiRV2e1W1Wz3dX+dNfmTefQfagBFrywJ/dHjWmXj/cW250WoY/zsAynhQMDAH9lPm3KzfFrWVaHN8/itdcH/9Dk9X0crdVE2672/eXipAMBijAR8WvZIS/dtO/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH/MIOzs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH/MIOzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22E6C2BCB3;
	Thu, 30 Apr 2026 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777563819;
	bh=OAy9rmsQ9nEcYj5uK27fnoEfy9dpDPbx99HsH+6ZyQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GH/MIOzs0f2rr0vMDEI2oSxmpWAAwEqVPo5DlOmAT8V+8Mpckoqr9jm0ZUJa239to
	 Tpo0xzjWlqr+gpcGyN4kYDM5eCRFQpmIqHlhnOf9UdAiP2/gQpGHy3+R0yG1sKA/O6
	 gTeXm6ItU4pj4iIBl4UWfUT1RDEJEJIS+Y4o599andVQPQvlJAyAeFmfpVMwF5TSF/
	 9TppGCb3sXCpsJoL3ndtPjdEG44t12s9AeBLGOBh5KUnzGnBMhlptTzL2SnDi5w3D9
	 HUoLNrUv9BbC4LHVTEbiRtZRJWbdJseYK7JMnQIHhGKtUBkoF9caz4pqJrA7sff6V7
	 WiO85A4gSulGg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 3/4] mm/damon: introduce DAMON_HUGEPAGE for hot
 region hugepage collapsing
Reply-To: sashiko@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260430134139.2446417-4-gutierrez.asier@huawei-partners.com>
References: <20260430134139.2446417-4-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 15:43:38 +0000
Message-Id: <20260430154338.E22E6C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Silent failure and invalid state when target PID is not found.
- [High] TOCTOU race condition on `aggr_interval` leading to divide-by-zero=
 kernel panic.
- [Medium] Memory leak of DAMON context upon module initialization failure.
--

commit 982630eef231c8c59229da1208ed3240bf24f081
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing

This patch introduces a new DAMON module (DAMON_HUGEPAGE)
which collapses hot regions into huge pages.

> diff --git a/mm/damon/hugepage.c b/mm/damon/hugepage.c
> new file mode 100644
> index 0000000000000..02729736dc560
> --- /dev/null
> +++ b/mm/damon/hugepage.c

[ ... ]

> +static struct damos *damon_hugepage_new_scheme(void)
> +{
> +	struct damos_access_pattern pattern =3D {
> +		/* Find regions having PMD_SIZE or larger size */
> +		.min_sz_region =3D PMD_SIZE,
> +		.max_sz_region =3D ULONG_MAX,
> +		.min_nr_accesses =3D 0,
> +		.max_nr_accesses =3D UINT_MAX,
> +		.min_age_region =3D min_age /
> +			damon_hugepage_mon_attrs.aggr_interval,

Is there a race condition here? Since damon_hugepage_mon_attrs is exposed
as a module parameter, aggr_interval could be modified locklessly. If it is
set to 0 concurrently between the check in damon_hugepage_apply_parameters()
and this division, could it trigger a divide-by-zero kernel panic?

> +		.max_age_region =3D UINT_MAX,
> +	};
> +
> +	return damon_new_scheme(
> +		&pattern,
> +		/* synchrounous partial collapse as soon as found */
> +		DAMOS_HUGEPAGE, 0,
> +		/* under the quota. */
> +		&damon_hugepage_quota,
> +		&(struct damos_watermarks){}, NUMA_NO_NODE);
> +}
> +
> +static int damon_hugepage_apply_parameters(void)
> +{
> +	struct damon_ctx *param_ctx;
> +	struct damon_target *param_target;
> +	struct damos *scheme;
> +	struct damos_quota_goal *goal;
> +	struct pid *spid;
> +	int err;
> +
> +	err =3D damon_modules_new_vaddr_ctx_target(&param_ctx, &param_target);
> +	if (err)
> +		return err;
> +
> +	param_ctx->addr_unit =3D addr_unit;
> +	param_ctx->min_region_sz =3D max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> +
> +	spid =3D find_get_pid(monitored_pid);
> +	if (!spid)
> +		goto out;

Does this silently return success when the monitored PID is not found?

Because err is 0 from the successful context creation above, jumping
to the out label returns 0.

This would cause DAMON to start with an empty context without informing
the user that their configuration failed.

> +
> +	param_target->pid =3D spid;
> +
> +	if (!damon_hugepage_mon_attrs.aggr_interval) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}

[ ... ]

> +static int __init damon_hugepage_init(void)
> +{
> +	int err;
> +
> +	if (!damon_initialized()) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> +	err =3D damon_modules_new_vaddr_ctx_target(&ctx, &target);
> +	if (err)
> +		goto out;
> +
> +	call_control.data =3D ctx;
> +
> +	/* 'enabled' has set before this function, probably via command line */
> +	if (enabled)
> +		err =3D damon_hugepage_turn(true);
> +
> +out:
> +	if (err && enabled)
> +		enabled =3D false;
> +	return err;
> +}

Does this code leak the allocated ctx and target if damon_hugepage_turn()
fails?

Because module initialization failure prevents the module exit routine
from running, it seems damon_destroy_ctx() should be called in the error
path to avoid a memory leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430134139.2446=
417-1-gutierrez.asier@huawei-partners.com?part=3D3

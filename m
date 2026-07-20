Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08CA136358
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549746; cv=none; b=oMWvoxmQai8Adkm6mx+SEMPnHYgL5WptBjpMdL+e8kBsudcNYoL3tPvN8CgrjY3zugO8mw02l3ZTdKDmEVLx9WK5TOSCBzUimIW+LIQvY6Kn4RXtbEjNbjNIF5kTs6r+/FzXI4Gz+bRTCelrAG3eTp468OhszkAjFUFJB3uCVEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549746; c=relaxed/simple;
	bh=flBKkacy3t++z6Rfl18HEKflKxaow+gG5/vq/4DdkP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sEU3xBmdNXGo1orCfOwMiB5wNBzUgiXXK21uJYKxNYQkLyzN3NRbLzLQwva5web0IIWoad7J0g5iG4c414G+gDwUuhf3IYtjuHMVhGK9CgYO9SZwa9aTE2SYoNaz85wfvQ0Uv3vaWMxNbMl2hDmo0CE8bGuG66fZe3j2vD5Nd2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOPUUALA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOPUUALA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1381F00ADF;
	Mon, 20 Jul 2026 12:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784549738;
	bh=lrRr0MPvvtjltzCIFbPmxcNoXoJORWXzH31ALsRBQ9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hOPUUALAdvCP618RdBqx5lHyxADcpqv1iS3yic+aIYhIjTBRJ10J5hc1jsCOApDwh
	 Q1NnkyZpFt4YhNPw71eRPBR63pmdPxh/0JfP9GotVzK+zWlJKRHquVzfIXJpnYYlKU
	 tvdNzvlwfjxsnfIJgPOrmhSi0Hhs2mYZgeUw05d7EzkWOSTtDbXqVxJnfqcnhuc2Sr
	 JudH1WPAupkIMjLzDWLHHP8ohDzGGiTiL6KGYPcVZnh4HHlBad/dINNpLOFG5866jN
	 Klmi1Ym7wSFJPBwIl3bt25J+vegcoM1xj+l41emLKV3VayYvVke2ZrzfmANL8A4hfS
	 R1F01aka3q05g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] mm/damon/sysfs: support hugepage_mem_bp quota
 goal metric
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260720120140.881468-3-gutierrez.asier@huawei-partners.com>
References: <20260720120140.881468-1-gutierrez.asier@huawei-partners.com>
 <20260720120140.881468-3-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:15:38 +0000
Message-Id: <20260720121538.9C1381F00ADF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Integer underflow when computing 'total' in `damos_hugepage_mem_bp=
` causes DAMON to become maximally aggressive on highly idle systems.
- [Medium] The new `hugepage_mem_bp` sysfs metric is missing from the DAMON=
 sysfs selftest script.
- [Low] Missing documentation for the `hugepage_mem_bp` metric in the DAMON=
 design guide.
--

--- Patch [2]: [PATCH v3 2/3] mm/damon/sysfs: support hugepage_mem_bp quota=
 goal metric ---
commit 304fd61bee6da0356569e9c8297451d15a43e10f
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon/sysfs: support hugepage_mem_bp quota goal metric

This commit exposes the new DAMOS_QUOTA_HUGEPAGE_MEM_BP autotune policy
metric through the DAMON sysfs interface. It adds "hugepage_mem_bp" to
the sysfs-schemes interface.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 32f495a96b17a..d9b81d7b5910e 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
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

[Severity: High]
While this patch exposes the new metric, is there a potential integer
underflow in the underlying implementation of damos_hugepage_mem_bp() in
mm/damon/core.c?

Due to per-CPU vmstat counter drift, pending positive deltas from freed
memory can cause the global NR_FREE_PAGES count to temporarily exceed the
fixed totalram_pages(). In damos_hugepage_mem_bp(), total is computed as:

    total =3D totalram_pages() - global_zone_page_state(NR_FREE_PAGES);

On a highly idle system, this could cause the unsigned subtraction to
underflow, resulting in a value near ULONG_MAX. The subsequent !total check
would fail, and mult_frac(thp, 10000, total) would evaluate to 0 due to the
enormous denominator.

Would this score of 0 lead damon_feed_loop_next_input() to perceive a maxim=
al
divergence from the goal, forcing the scheme to maximize its quota
aggressiveness instead of minimizing it?

[Severity: Medium]
Should tools/testing/selftests/damon/sysfs.sh be updated to include the new
metric?

The test_goal() function validates writes to target_metric for all existing
metrics:

    ensure_write_succ "$fpath" "active_mem_bp" "valid input"
    ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
    ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"

Could hugepage_mem_bp be added to this sequence to ensure the sysfs interfa=
ce
is regression tested?

[Severity: Low]
Does this new metric need to be documented in
Documentation/mm/damon/design.rst?

The documentation lists all available target_metric values, such as
inactive_mem_bp and node_eligible_mem_bp, but it appears hugepage_mem_bp
is missing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720120140.8814=
68-1-gutierrez.asier@huawei-partners.com?part=3D2

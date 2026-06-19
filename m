Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACD03B19A9
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881982; cv=none; b=VE3mJoW0s8NevIHGOKSZidJnBh3I7NZz/eWuykccEiFY5WHHh7yPI8/uRIMaxD7vgk/EV0b/7w9XTbEOjjaKlVfDUlQXqIlfF4JKJ+JcTTqSwOwa79nSZmJPySRwFYldAr7gY5637uC4zPa4ACbKJ5I6qsHLEB/yTIkWEl641Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881982; c=relaxed/simple;
	bh=ZABqEJ8I0razCCqR700JiMpk2XylaoV4Gr9++SOHDZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m6IoR1uKCWrKRYHkDI8pKgYmAFdU2UFMoOAvD2Q70pDOtT0JdS5oFN1N/8YngcIcHBsibxH0UKjcl1K7FOdsbjYuB9ckEzMo7aRotdRAo0BuO8YaeYr19z6oDVnjmNylltCqjzLnNCjVeb8TyphHYObpPsSzdBV/GU1lCEFR0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByxgOR9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByxgOR9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB971F000E9;
	Fri, 19 Jun 2026 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781881980;
	bh=vpQJDXjPERyqg17WutW72MRvTGg0HOw5GsPjotLYzeE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ByxgOR9HDLYcXqEH1pUP45f0wNNHTKCaArm1uGyEa77qD615FgAu7H1SPPIp0ETa7
	 i2K6y6I98G1EyexUT12V8mPIEtD7EechA8YJaHdC42XqWZ5PtE3JWD+uHbcBELJ8+j
	 1lE61n9oYabMY4fh48huoGd5AIzxrvEaVapSsTUHcBXbamocvUzr0cfFfnJAPfLjDg
	 ur7JbUVI1iiJWm+QFkHAJuCorscIBr9y2sw355Lv3Jn4s8JV2XUXScd97vOD1U9Db9
	 DC6036x7ZWg2k6PfVFbFaWvxcZT53jEwpeFmnW8/0py90j8k2hE+sDrUycpY+E4FiQ
	 /OPncxKUcfsdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] mm/damon/sysfs: support hugepage_mem_bp quota
 goal metric
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260619145821.2109933-3-gutierrez.asier@huawei-partners.com>
References: <20260619145821.2109933-1-gutierrez.asier@huawei-partners.com>
 <20260619145821.2109933-3-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 15:13:00 +0000
Message-Id: <20260619151300.BDB971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel panic if user sets DAMOS quota goal target_value to 0 via s=
ysfs.
- [High] Potential kernel panic in `damos_hugepage_mem_bp()` if system memo=
ry usage drops to 0.
- [High] Potential kernel panic in `damos_get_in_active_mem_bp()` if LRU li=
sts are empty.
--

commit 2cad27ab47cb3fdb7470dc5639b19615c6ec257b
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Subject: mm/damon/sysfs: support hugepage_mem_bp quota goal metric

This commit adds the DAMOS_QUOTA_HUGEPAGE_MEM_BP metric to the sysfs
interface, allowing users to configure the hugepage_mem_bp quota goal
metric for DAMOS autotune policies.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 329cfd0bbe9f3..4b5429a5b4158 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1267,6 +1267,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_q=
goal_metric_names[] =3D {
>  		.metric =3D DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
>  		.name =3D "node_eligible_mem_bp",
>  	},
> +	{
> +		.metric =3D DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> +		.name =3D "hugepage_mem_bp",
> +	},

[Severity: High]
This isn't a bug introduced by this patch, but exposing this metric makes a
pre-existing divide-by-zero pathway reachable. Can this cause a kernel panic
if system memory usage drops to 0?

Looking at damos_hugepage_mem_bp() in mm/damon/core.c, it calculates total
without verifying it is greater than zero:

mm/damon/core.c:damos_hugepage_mem_bp() {
    ...
    total =3D totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
    return mult_frac(thp, 10000, total);
}

If the number of free pages equals totalram_pages() (which is possible on
mostly empty systems, in tightly constrained VMs, or due to vmstat per-CPU
drift), total becomes 0. Could this cause a divide-by-zero panic during
quota adjustment?

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this sysfs
exposure, I noticed another pre-existing divide-by-zero risk if LRU lists
are empty. Does this code safely handle zero total active/inactive memory?

mm/damon/core.c:damos_get_in_active_mem_bp() {
    ...
    total =3D active + inactive;
    if (active_ratio)
        return mult_frac(active, 10000, total);
    return mult_frac(inactive, 10000, total);
}

If there are no pages on the active and inactive LRU lists (e.g., in systems
relying solely on Hugetlbfs, unevictable memory, or during early
initialization), total evaluates to 0. Does this need a check to avoid a
divide-by-zero panic?

[Severity: High]
This isn't a bug introduced by this patch, but since we are looking at quota
goals, is there a risk of a kernel panic if a user sets target_value to 0
via sysfs?

Looking at target_value_store() in mm/damon/sysfs-schemes.c, user input is
directly accepted:

mm/damon/sysfs-schemes.c:target_value_store() {
    ...
    int err =3D kstrtoul(buf, 0, &goal->target_value);
    ...
}

Then in damos_quota_score() in mm/damon/core.c, this target_value is used as
a denominator:

mm/damon/core.c:damos_quota_score() {
    ...
    highest_score =3D max(highest_score,
                mult_frac(goal->current_value, 10000,
                    goal->target_value));
    ...
}

Since kdamond will trigger a divide-by-zero if target_value is 0, should
there be validation in target_value_store() to reject a value of 0?

>  };
> =20
>  static ssize_t target_metric_show(struct kobject *kobj,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619145821.2109=
933-1-gutierrez.asier@huawei-partners.com?part=3D2

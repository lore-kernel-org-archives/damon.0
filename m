Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAA3B47D2
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688996; cv=none; b=MTr0sVByJWcPGYGuE/G6IceEInxJB11oePV1jXwpeRS+toLjgUnVWKdbw0eDpoc42Gzi7h+i/0zS2IQWVEpL9Ipjrbt7OhTeuEjqlKjsVthp/tiXEduSq0Y5iig5FEiA2tic9ouP6QOTvQEodsjVCfjJAPEYNAqR/iCa4Sh9ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688996; c=relaxed/simple;
	bh=XErA0izaehxRYKEQnUAyb/U11YugNJp6FTafLkqGrCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zi1rt4L3gHuBa1EzbnhNCcneAgbBVJ0YUYexTYYZATzG7dINT/PEHjHRIq/1j4ZXH8zK/A+hchxaey00BJRP++VOij/gYqGhpSUzNd6WcvOTr16uvT6EyVmBehLV8DSlMZfkG99x0fMnlmwbFE2kWDbbMTJNEwfo4U4GI0IQfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzzIFEwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzzIFEwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A571F000E9;
	Sun,  2 Aug 2026 16:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688994;
	bh=+uHObLo5Z1VKMDHSgFQbVmPMFmbIBuooawNq64UnVbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzzIFEwMSufu4IBaj0E2PI938LYsetn7k7vie4lk3S1UfpXByo/hE3L3QPjBCqPPm
	 +ygZDM5TCg/lzesVgJVEFfuT4KvC2ZLoUvDIpiOgpVBC6/NebfH8g/uQwP4f2kqzEF
	 HGn0IVQ/d2SOWG60eDjRYxk6ICYzsly94KHD3iO6okvE57NHTL6Cpr/XLbidluSFXM
	 qtyP//oPomIX6xuQ+V1ILRWeEj7tYzIbPaBvWxaJWhow7gzPCL1CV1ZVb8/cW0Or0m
	 gORVq0wNu93JgMyVKTLDP85TEO62xXoi3/QHYCkgPVzW17ptAqjSkYlCOb3Cg/xe0C
	 hGstzfogReXSQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 2/9] mm/damon/core: initialize
 damos_quota_goal->last_psi_total
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260802162631.90304-3-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
 <20260802162631.90304-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 16:43:14 +0000
Message-Id: <20260802164314.73A571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch incompletely fixes the uninitialized `last_psi_total` =
variable usage. While it initializes `last_psi_total` when the `kdamond` th=
read starts, it fails to initialize it for schemes or quota goals added dyn=
amically at runtime via sysfs.
--

--- Patch [2]: [RFC PATCH v1.1 2/9] mm/damon/core: initialize damos_quota_g=
oal->last_psi_total ---
commit ca3c4694fe111f676d0de56148cf986c02532428
Author: SJ Park <sj@kernel.org>

mm/damon/core: initialize damos_quota_goal->last_psi_total

When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
delta for the feedback loop is calculated using
damos_quota_goal->last_psi_total. It is not initialized at the beginning.
This commit initializes the value at the beginning of kdamond.

Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e2900d0c984c9..3bdbf4fbf7147 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3744,6 +3755,7 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
>  	damon_for_each_scheme(scheme, ctx) {
>  		damos_set_next_apply_sis(scheme, ctx);
>  		damos_set_filters_default_reject(scheme);
> +		damos_init_quota_goal_last_psi(scheme);

[Severity: Medium]
This is a pre-existing issue, but does this completely fix the uninitialized
variable usage?

While this initializes last_psi_total when the kdamond thread starts, it
appears goals added dynamically at runtime via sysfs will still be
uninitialized.

When a goal is parsed from sysfs, memory is allocated without zeroing the
structure, leaving last_psi_total filled with slab garbage:

mm/damon/sysfs-schemes.c:damos_sysfs_add_quota_score() {
    ...
    goal =3D damos_new_quota_goal(sysfs_goal->metric,
            sysfs_goal->target_value);
    ...
}

During the context commit phase, the goal is dynamically allocated but
last_psi_total is intentionally bypassed:

mm/damon/core.c:damos_commit_quota_goals() {
    ...
    new_goal =3D damos_new_quota_goal(
            src_goal->metric, src_goal->target_value);
    ...
}

When the feedback loop executes, this uninitialized memory is consumed:

mm/damon/core.c:damos_set_quota_goal_current_value() {
    ...
    goal->current_value =3D now_psi_total - goal->last_psi_total;
    ...
}

Will this cause a random, extremely large or small initial quota adjustment
when a user adds a new DAMON scheme or quota goal with the
DAMOS_QUOTA_SOME_MEM_PSI_US metric to a running context via sysfs?

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802162631.9030=
4-1-sj@kernel.org?part=3D2

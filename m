Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE7B23392A
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784249541; cv=none; b=f1QwnSmxTYRFXNEPyiYEw4BL4jJD0MstUb9QXVKYvaGsFWypICpgAflldx1aXPpjDpxvo7W+wuAgkSExu0CxxBTLseR8u06xwUDgKkFGX+karTA9n8rH9ssqST91Quvgaddq7PflCoW0oun8HXemUnPSv2yman94HfFLiQYeB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784249541; c=relaxed/simple;
	bh=FbJBuz/SgzjoS8UBYRy0mDVKsqqckqif0oUjCFzKMtI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uLwPCClY8saFt8wOel6gCGNJt4S5MLRRGOzL8+LeHrisWGMkl+NXyx8DS22Pm7GTXyvG6eR+NVRMj9AU1SO5QvpRIxL0CnSNzq6B0mpxr9FDBwyAhFPfzjwAuBThhBEAxk08e8WtrSl4pJAh+vx/eFNFX1UfdtidC2tcD8+xxhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsibzDlH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsibzDlH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB001F000E9;
	Fri, 17 Jul 2026 00:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784249540;
	bh=6hy3sgNdwWz1uFNbF3itEyJ5w643l7yev/2gyqhZSqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LsibzDlH/SSQK45PwHKm2sf2N1cj6bNWx1lSZaeGAXGuwh8mxBFhTc5amk1gVXa7B
	 BCCoAoiSRjc2iFLYCPKbBPf0y3bzcWnJmiAI3N2q3ovducjtnYV0qpZWGCBXMRvlFO
	 GHVAlqmhpWNA+wjJ2TUFH71u+qtL8n2yYjiXCGtpzHYsD7/TCq8lGMtsu+HYryk6y+
	 cwQAuNKP2dUmnksqol00XpyWwnYy0hk+q+nLsXE1FbqQe66IQCIxga4p4BQMwr9uzw
	 c8OoMpjFDdyYsnsdhwoPeq25iP4+f+mNq30s+Fke0h8Y2h2pJTpvAD5Q/B8tHW7LQl
	 f3S2kXrzgpfkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] mm/damon/core: initialize damos->last_applied
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260717003022.119437-2-sj@kernel.org>
References: <20260717003022.119437-1-sj@kernel.org>
 <20260717003022.119437-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 00:52:19 +0000
Message-Id: <20260717005220.7CB001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect PTE advancement for large folios in vaddr stat scanning =
and migration.
- [High] Commit of DAMON parameters corrupts the active scheme's quota stat=
e by zeroing dynamic fields in-place.
- [High] Failure in `damos_commit_dests` leaves the active scheme in an inc=
onsistent state, leading to a NULL pointer dereference.
--

--- Patch [1]: [PATCH 1/7] mm/damon/core: initialize damos->last_applied ---
commit 90344a381581ba5ad7a7c87826b18bf948659516
Author: SJ Park <sj@kernel.org>

mm/damon/core: initialize damos->last_applied

This commit fixes an issue where the damos->last_applied field was being us=
ed
without initialization, leading to DAMON unexpectedly skipping the applicat=
ion
of DAMOS actions for a folio the first time per scheme. It addresses this by
initializing the field in damon_new_scheme().

Link: https://lore.kernel.org/20260714055436.120034-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 603b102ff80f9..20d267c615faf 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -705,6 +705,7 @@ struct damos *damon_new_scheme(struct damos_access_pa=
ttern *pattern,
>  	INIT_LIST_HEAD(&scheme->ops_filters);
>  	scheme->stat =3D (struct damos_stat){};
>  	scheme->max_nr_snapshots =3D 0;
> +	scheme->last_applied =3D NULL;
>  	INIT_LIST_HEAD(&scheme->list);
> =20
>  	scheme->quota =3D *(damos_quota_init(quota));
                        ^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but does this in-place zeroing
corrupt the active scheme's quota state?

Looking at damon_new_scheme(), it passes the provided quota pointer to
damos_quota_init(), which zeros out dynamic fields directly:

mm/damon/core.c:damos_quota_init() {
    ...
    quota->esz =3D 0;
    quota->total_charged_sz =3D 0;
    ...
}

When damon_commit_ctx() applies new parameters to an active context, it cop=
ies
schemes by calling damon_new_scheme() with a pointer to the running context=
's
scheme quota.

Could this wipe out the current quota charge window progress and reset the
goal tuner's feedback loop (esz_bp) on every parameter commit, causing
inconsistent tuning pressure?


[Severity: High]
This is a pre-existing issue, but can the failure path in damos_commit_dest=
s()
lead to a NULL pointer dereference?

In mm/damon/core.c:damos_commit_dests(), if memory allocation fails for
dst->node_id_arr or dst->weight_arr, the function returns -ENOMEM:

mm/damon/core.c:damos_commit_dests() {
    ...
    dst->node_id_arr =3D kmalloc_array(src->nr_dests,
        sizeof(*dst->node_id_arr), GFP_KERNEL);
    if (!dst->node_id_arr) {
        dst->weight_arr =3D NULL;
        return -ENOMEM;
    }
    ...
}

However, dst->nr_dests is updated later. If the allocation fails while
updating an active context during __damon_commit_ctx(), could the active
scheme be left with weight_arr =3D=3D NULL but a non-zero nr_dests?

If so, would this cause a kernel panic when kdamond resumes and calls
damos_va_migrate_dests_add(), which iterates up to dests->nr_dests and
unconditionally dereferences dests->weight_arr[i]?


[Severity: High]
This is a pre-existing issue, but does the PTE iteration in
damos_va_stat_pmd_entry() and damos_va_migrate_pmd_entry() overshoot large
folios?

In both functions, when a valid folio is found, the loop increment is set to
the total number of pages in the folio:

mm/damon/vaddr.c:damos_va_stat_pmd_entry() {
    ...
    if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
        *sz_filter_passed +=3D folio_size(folio);
    nr =3D folio_nr_pages(folio);
    s->last_applied =3D folio;
    ...
}

If the current PTE maps a tail page of a large folio (for example, if the V=
MA
starts in the middle of a large folio), wouldn't advancing pte +=3D nr and
addr +=3D nr * PAGE_SIZE overshoot the end of the large folio?

Could this cause DAMON to skip subsequent PTEs in the mapped page table that
might belong to entirely different folios, missing stats and migration acti=
ons
for them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717003022.1194=
37-1-sj@kernel.org?part=3D1

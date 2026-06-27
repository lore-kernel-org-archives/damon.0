Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C71A5B9E
	for <damon@lists.linux.dev>; Sat, 27 Jun 2026 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782580752; cv=none; b=fwkn/rnffthZ+2osaHzCQmJkvgzmMv6QmaNP5ILvdpUypAN1R0BFqFDo7+pKeFMvzh6sj8AvoaBrZDmbTeEmW1zhDbGWXFxjsdSMYixjy8wcp9IV99p1QevNG+laE8rT63ZoR8lb4K0LNK66Xr4yyjyOFdgPOPPkb03wN4A/LKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782580752; c=relaxed/simple;
	bh=4xJ7obycK6Qm86wMoTiWi+gvMzrrRn4BBxQF3rqBPzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kwu4T2z+Y3f60h+WfxOlrvBSdFr47maASPv+XmbC7FU9fqHwlNhEeCCMmIWv+BK/9dsYUQ4IcDAH6e0AO/W7ToEKULFFf2sQrUMl1FUhnXjGOzVndCNAbHOdX18ZR8eitPHdvjxT2x2zt/0H76vtCrXCxPrTY+LtpWLZ3Y0YLks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2WBDOJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2WBDOJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7181F000E9;
	Sat, 27 Jun 2026 17:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782580751;
	bh=AUjVaU+N8asBe6EhcZJUatMtEuZVZJALtXyRFEHTfho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J2WBDOJhxyl91eDVTqR8qaVHrN+Q/UhA6kjmflGD0i/qiP+XHABy9NFGR3eBT65DH
	 wcKtCiHN5NMVkxtXfAgt3y8Emi1N1KKvQWZpNUZvm8/pooo73RvTS6DEnAmrmQ3QHW
	 W4iVXiXcx+HypE+3b7ZNx9NT+/R7ELqvA7qj38dUr1LjbrHs9tthLSgU8p2oS7TcIH
	 CdE1zOHczEHeipjsErV00iSqhZUGtK7j9vE/J3ReY+2+0i5O3cHiHQQsr7UuSLwWXL
	 sq5vShL8qkCBlV5JIckWuA5UUyj7WasTFKYIQjHwpEURHJfb/JEddqWCzH2GAInLNU
	 lQpXly4yMXUhQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: validate ranges in
 damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260627170057.1867-1-sj@kernel.org>
References: <20260627170057.1867-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 17:19:10 +0000
Message-Id: <20260627171911.1A7181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The validation check to prevent empty regions is bypassed due to i=
nteger overflow in ALIGN(), leaving the divide-by-zero vulnerability unpatc=
hed.
- [High] Memory allocation failure during region updates leaves the running=
 DAMON context with a corrupted, partially updated region list.
--

commit e67b2388e5d46f77944a06f1bd1d3d550638fade
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: validate ranges in damon_set_regions()

This patch updates damon_set_regions() to validate ranges and reject
inputs where the start address is greater than or equal to the end
address. This aims to prevent zero-length regions which can cause
divide-by-zero errors in damon_merge_two_regions().

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b06..b3100d7fa5596 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -358,6 +358,11 @@ int damon_set_regions(struct damon_target *t, struct=
 damon_addr_range *ranges,
>  	unsigned int i;
>  	int err;
> =20
> +	for (i =3D 0; i < nr_ranges; i++) {
> +		if (ranges[i].start >=3D ranges[i].end)
> +			return -EINVAL;
> +	}
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this validation check=20
sufficiently protect against overflow when the regions are aligned later?

If a user supplies a region where the end address is ULONG_MAX,
ALIGN(ULONG_MAX, min_region_sz) will wrap around to 0.

Since this validation check uses unaligned inputs, ULONG_MAX passes
the check here. Later, during allocation:

damon_set_regions() {
    ...
    r =3D damon_new_region(
            ALIGN_DOWN(ranges[i].start, min_region_sz),
            ALIGN(ranges[i].end, min_region_sz));
    ...
}

This creates a region with a wrapped and inverted size. If the adjacent
regions sum to a size of 0, for example 4096 + (ULONG_MAX - 4095),
can this lead to a divide-by-zero crash in damon_merge_two_regions()
when the sizes are added together?

damon_merge_two_regions() {
    ...
    l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
            (sz_l + sz_r);
    ...
}

[Severity: High]
This is also a pre-existing issue, but what happens to the region list if
memory allocation fails after existing regions are destroyed?

In damon_set_regions(), existing regions not in the new ranges are
destroyed. If a subsequent damon_new_region() fails and returns -ENOMEM:

damon_set_regions() {
    ...
    if (!r)
        return -ENOMEM;
    damon_add_region(r, t);
    ...
}

The error rollback path in damon_revert_target_commits() does not restore
the regions_list state:

damon_revert_target_commits() {
    ...
    damon_for_each_target(target, dst) {
        if (target =3D=3D failed)
            return;
        put_pid(target->pid);
    }
}

Will this transient allocation failure permanently leave the running damon
context with a corrupted or partially updated region list, silencing
reclamation daemons?

>  	/* Remove regions which are not in the new ranges */
>  	damon_for_each_region_safe(r, next, t) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627170057.1867=
-1-sj@kernel.org?part=3D1

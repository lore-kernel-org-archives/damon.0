Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D37E0FF
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692656; cv=none; b=iISj9I7Dky36gZL/LHDECrWfrC4n5JVMTs1E7Kvoq4+ZavcNpY2RAuVMiZ9e3WRjC7ReaNdhQb+IReFS79P8cdN1A/Pn0YM70MJOEXMGTh31E+Ybrq/LlosGf4MNA+Kpx5Ds3fqEbLUr8xZr+MWr7a5zIKEyP+Eq1MykjVdCvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692656; c=relaxed/simple;
	bh=fGD5gr7QAgkx7tFPtSV+gWec/9fiRy884osK3JqHvWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q28bUg7MxjznUdHQEsaoq3WGYWNIDBjscnB6rDztIKkp0cUO47fnn9KKB/yQCrCinMbq5obBkr7Q8IfL+2AA6WpskX9eNX9kiZRErtCM7YE8MlhIOjrX0UbToQ4WEc/sCwv8LXlYdkdHKsuJCuhN/APlQHLTXHp9kAaLu5sdEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHpNNtrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHpNNtrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B90E1F000E9;
	Fri, 10 Jul 2026 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692655;
	bh=9ZV6BEtSxP4K3Iid6fTMWFQdeuRWV5IQMTvfLAZ+F3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHpNNtrdA6bvHf/pNfNPklx1BEx3kBJzfErqz9GoOcO5ReBM897aWXCYO/2skXRJj
	 iDR9HuvIYK6/Wc/SE4KpkFpc+LABEPpK7dxVycakVOrK/JSEty4R9mzrg5vIvGeoy3
	 gLEKD6y/gPV2cl2WSXTkxc+IL+iWJmOxpYIn/McdSKtTQwDMzSq2SAe27QcxBuxZ44
	 nhgHLVuVaUz4AuhKc6g+O3MW7+vnAKyjHjxuycxVrbLMekSvuQ1WqfGtLloHwLU5of
	 C7227nhptVtx0uAAhxTzbvEsocZ366yxR21s7QfxP3hQCan04hCnnDqqAZGprRvB+3
	 dno/jJ7HOcEHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/19] mm/damon/core: use abs_diff() instead of abs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710134651.18084-8-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
 <20260710134651.18084-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 14:10:54 +0000
Message-Id: <20260710141055.0B90E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unchecked memory allocation failure in `damon_apply_min_nr_reg=
ions()` leads to heap corruption and infinite loops
--

--- Patch [7]: [PATCH 07/19] mm/damon/core: use abs_diff() instead of abs()=
 ---
commit 168e2738a1f4077551ffee47ed4ecb0a582831f3
Author: SJ Park <sj@kernel.org>

mm/damon/core: use abs_diff() instead of abs()

Replaces abs() with abs_diff() in damon_merge_regions_of() to prevent
silent integer overflow when casting unsigned int to signed int.

Link: https://lore.kernel.org/20260705213817.100841-1-sj@kernel.org/

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index fea97399b5754..4c7e8a12a9b67 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3269,7 +3269,7 @@ static void damon_merge_regions_of(struct damon_tar=
get *t, unsigned int thres,
>  			r->age++;
> =20
>  		if (prev && prev->ar.end =3D=3D r->ar.start &&
> -		    abs(prev->nr_accesses - r->nr_accesses) <=3D thres &&
> +		    abs_diff(prev->nr_accesses, r->nr_accesses) <=3D thres &&
>  		    damon_sz_region(prev) + damon_sz_region(r) <=3D sz_limit)
>  			damon_merge_two_regions(t, prev, r);
>  		else

[Severity: Critical]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but I noticed a potential memory corruption issue in
damon_apply_min_nr_regions() when a memory allocation fails.

If damon_split_region_at() fails to allocate memory, it aborts silently and
leaves r->ar.end unchanged.

The loop then unconditionally advances r:

mm/damon/core.c:damon_apply_min_nr_regions() {
	damon_for_each_target(t, ctx) {
		damon_for_each_region_safe(r, next, t) {
			while (damon_sz_region(r) > max_region_sz) {
				damon_split_region_at(t, r, max_region_sz);
				r =3D damon_next_region(r);
			}
		}
	}
}

Can this corrupt memory or cause infinite loops if the allocation fails on
the last region in the list?

If this occurs on the last region in the target's list,
r =3D damon_next_region(r) resolves to the list head (&t->regions_list).

Because the list head is embedded inside struct damon_target, container_of()
returns a bogus struct damon_region pointer pointing before the damon_target
object.

The next iteration of the while loop would read r->ar.start and r->ar.end
from this invalid memory. If the computed difference exceeds max_region_sz,
it enters the loop again. A successful damon_split_region_at() could then
write the new region's start address to r->ar.end, corrupting memory before
the damon_target structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710134651.1808=
4-1-sj@kernel.org?part=3D7

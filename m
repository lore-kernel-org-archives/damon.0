Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBD1991D4
	for <damon@lists.linux.dev>; Wed, 13 May 2026 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778646115; cv=none; b=Emed33DMR3WBMmQe9/cMskQEDk3gSllM5g5nYyACdQ7mqgXPGHBIj+h0Apby0oh/rG8dyi4P2ahvq0x47Biy3Dh2UwnipWa9jVpe1prql21RKam+A9+dG3mImGBxYrQ0lQ1W25rKtVdXeaNkCHu8tJc/fCxYCe4DcpLeg9AlY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778646115; c=relaxed/simple;
	bh=rsMC4+0UIJxi5oe16Q7TeYZBrtpGFVW7LzFqFb3Rz7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ob0izkSLKO6Lvf0sL9r+OILGSvJEJk46lJIJGYBfKJ0254wNbFk+YtF9/8HvitMUIOlv82hBYZUR9ZyMkCNjfdA/AgZTTalsVxpMcWUgxdckT+wu1t+lt+sR5VWMx6Bo0kgoNjTRwn8pqRiGViU+MPzZ9I8H8BIIC87LMLEEcwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbFbYNe+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbFbYNe+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E09C2BCB7;
	Wed, 13 May 2026 04:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778646114;
	bh=rsMC4+0UIJxi5oe16Q7TeYZBrtpGFVW7LzFqFb3Rz7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EbFbYNe+Ns4TOhuRtbphKagI4rhqyTnDor1X4hzBtCwbX0pVBADSaluUMvoYLLZoP
	 rEIxkrSCVxH+0cV8NpwHzyIQBe+Z5Gt6t4DR70+qTDmeQ+9Mj6G1GcTJtMGTE1YH9m
	 ZbDyZ7GOUK8RZInwx83va3DphuMBDCDMqlgq/FgnIQYOW5PlSFgXBhliQ3GPcGaD+W
	 vmfK3eGLyiFli+VUHmPiJ2K5EvsIwnDD64+Uf1kSSXaDV5Ih5cuSnp32KXLwKpZlEJ
	 YlKu4mRbkPvVwdXwpgVR3UhaCl9yfzGU2SWiA/FmADyqTxflDZaNJmYMhmrvB4tgB+
	 UpwJHPeKpgHEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: fix double increment of
 nr_regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Agarwal" <agarwal.vineet2006@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260512041157.109845-1-agarwal.vineet2006@gmail.com>
References: <20260512041157.109845-1-agarwal.vineet2006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 04:21:54 +0000
Message-Id: <20260513042154.73E09C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incomplete fix leaves nr_regions counter permanently leaking on th=
e error path.
- [High] List corruption and Double Free due to lockless list manipulation =
in kobject release.
- [Medium] Region directory naming preserves an unintended 1-based indexing=
 regression.
--

commit 8f7ffd21263a0409418cf4d88e9b7e2d7a90117e
Author: Vineet Agarwal <agarwal.vineet2006@gmail.com>

mm/damon/sysfs-schemes: fix double increment of nr_regions

This commit attempts to fix a double increment of nr_regions when populating
region directories. It removes the post-increment from the
kobject_init_and_add call, relying instead on the earlier increment of
sysfs_regions->nr_regions.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 622c3799db87b..5d966ac864193 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2998,7 +2998,7 @@ void damos_sysfs_populate_region_dir(struct damon_s=
ysfs_schemes *sysfs_schemes,
>  	if (kobject_init_and_add(&region->kobj,
>  				&damon_sysfs_scheme_region_ktype,
>  				&sysfs_regions->kobj, "%d",
> -				sysfs_regions->nr_regions++)) {
> +				sysfs_regions->nr_regions)) {
>  		kobject_put(&region->kobj);
>  	}
>  }

Does this error path leak the counter?

If kobject_init_and_add() fails, kobject_put() triggers
damon_sysfs_scheme_region_release() to delete the region from the list and
free it. However, sysfs_regions->nr_regions has already been incremented
prior to this call and is never decremented on this error path. Because the
cleanup function damon_sysfs_scheme_regions_rm_dirs() only decrements the
counter for items remaining in the list, the counter permanently leaks. Aft=
er
an error, subsequent directory names will skip numbers and drift indefinite=
ly.

Also, does this preserve an unintended 1-based indexing regression?

Prior to commit 66178e4ec30a, region directories were 0-indexed. By passing
the already-incremented sysfs_regions->nr_regions to kobject_init_and_add(),
the first region directory is named 1. This violates standard DAMON sysfs
array conventions where targets, schemes, and filters all start at 0,
potentially breaking user space tools.

Should the code pass the unincremented sysfs_regions->nr_regions to
kobject_init_and_add() and only increment it on the success path?

Finally, this isn't a bug in this patch, but does the kobject release path
have a lockless list manipulation issue that can cause a double-free?

The function damon_sysfs_scheme_region_release() calls list_del(&region->li=
st)
without holding damon_sysfs_lock. If kobject_release() is delayed (for
example, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled), the region remains
linked in sysfs_regions->regions_list after
damon_sysfs_scheme_regions_rm_dirs() has called kobject_put() on it.

If a subsequent command like update_schemes_tried_regions executes while the
region is awaiting delayed release, damon_sysfs_scheme_regions_rm_dirs() wi=
ll
traverse the list and call kobject_put() a second time on the same
zero-refcount object. Furthermore, when the delayed release finally execute=
s,
list_del() will run concurrently with other list operations without locks,
resulting in list corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512041157.1098=
45-1-agarwal.vineet2006@gmail.com?part=3D1

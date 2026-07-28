Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A693A5E93
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268887; cv=none; b=jWTQe0Kvo8Bcf82744SzpMNRhbpSWPfHbqWmRy8j1zNIMaV4hMvjUvLdJwLfDteUu0gYIFC6DTW5Oyb5J97xp0sNHUDWVQUSPquzazjoq1K8V1qIwSJerGK9wTftgxKtwOdbXHnQKKE/EWju5PIC9MPowRtflmyw4/+GkgpsEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268887; c=relaxed/simple;
	bh=ni1Y3PXWdpJBLue4GQLXD2CMQnncyB/WpqHzv8M8NoY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o9EBN0TzevTaQPCiq9rX39Sz+j73biq8HLP8JtfWum0v02TcA7BAATl7DgYFo65Vhj+Pw8vLS5nVieDZdwLGnzIa86cbeiFihPtZrkvp2c2ZkkLBVZkQX9ThWLdSbWCnDUv134XkqV3ZqRIimADUXTwUi6vgDQra+DC+r9KGiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNsDcPPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNsDcPPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965471F000E9;
	Tue, 28 Jul 2026 20:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785268885;
	bh=yENKdlKcOyD/2q83o+upsXG2O4+y34ym1qBK2i9PUd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNsDcPPVcxg4FUpQDjPl3XKj8uNUXo19/2DzzB6mdKKkWfkY6dmgdUa1Ap3JTWxiy
	 8sIwIBQGXpuBJ6UPybJfmvL+MH5/1yu0CqCSNsoth2R+MAr74TZmN/YUs3Tg6NOjEI
	 Z/syuVTbiSYqMdJEQMz4dec21jyrWl27TBK/eNzz5uAAChgZjD8/GMWMQixOs5Syxq
	 I3D6XC0bUg3aoTogpFU0OvfsGLu8XHjGf5JtsYh0Dx29GIftHctqzJkNUrNQjSfVSb
	 4I43iGaCTzPcELEqoT55lhdMv4gRAYl0DqVRQVQDWJQTfMbXQUbSEJaHbsUTFwCRJr
	 UK64c0SOmrSlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] mm/huge_memory: skip zone device folios in
 madvise_free_huge_pmd()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20260728194714.3713735-3-gourry@gourry.net>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-3-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 20:01:25 +0000
Message-Id: <20260728200125.965471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] madvise_cold_or_pageout_pte_range() fails to filter out zone d=
evice PMDs, risking invalid operations on device memory.
- [High] madvise_cold_or_pageout_pte_range() triggers a refcount livelock b=
y elevating the folio refcount before acquiring the folio lock on the PMD p=
ath.
--

--- Patch [2]: [PATCH 2/4] mm/huge_memory: skip zone device folios in madvi=
se_free_huge_pmd() ---
commit 624f2a18069c771c887a2d3f875451eb3bd7e41d
Author: Gregory Price <gourry@gourry.net>
Subject: mm/huge_memory: skip zone device folios in madvise_free_huge_pmd()

This commit addresses an issue in madvise_free_huge_pmd() where zone device
folios were being marked as lazyfree without proper checks. It adds a bailo=
ut
condition to skip the operation if the folio is a zone device folio.

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 73522f296cee2..0b48112574882 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2338,6 +2338,10 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb,=
 struct vm_area_struct *vma,
>  	}
> =20
>  	folio =3D pmd_folio(orig_pmd);
> +
> +	if (folio_is_zone_device(folio))
> +		goto out;
> +
>  	/*
>  	 * If other processes are mapping this folio, we couldn't discard

While reviewing the zone device filtering added here, I noticed a couple of
pre-existing issues in the related PMD handling path in mm/madvise.c.

mm/madvise.c:madvise_cold_or_pageout_pte_range() {
[ ... ]
		folio =3D pmd_folio(orig_pmd);

		/* Do not interfere with other mappings of this folio */
		if (folio_maybe_mapped_shared(folio))
			goto huge_unlock;

[Severity: Critical]
This is a pre-existing issue, but is it possible for a zone device PMD to be
processed here?

The folio is resolved from the PMD but lacks the folio_is_zone_device(folio)
filter (unlike the PTE path). If a DAX or device coherent THP is partially
advised, the split path could leave the pgmap pointer uninitialized on the
split folios, potentially causing a kernel panic when accessed. Could we ad=
d a
similar bailout here?


mm/madvise.c:madvise_cold_or_pageout_pte_range() {
[ ... ]
		if (next - addr !=3D HPAGE_PMD_SIZE) {
			int err;

			folio_get(folio);
			spin_unlock(ptl);
			folio_lock(folio);
			err =3D split_folio(folio);

[Severity: High]
This isn't a bug introduced by this patch, but could this locking order cre=
ate
a refcount livelock?

Calling folio_get() before blocking on folio_lock() elevates the folio's
refcount. When split_folio() later checks the expected refcount against
folio_ref_count(), wouldn't it fail with -EAGAIN if other tasks are also
blocked trying to lock the folio? Should the refcount be elevated only after
acquiring the folio lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728194714.3713=
735-1-gourry@gourry.net?part=3D2

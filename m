Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179C2EEE93
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268627; cv=none; b=lGMeezt0WX1g1z8S1R051nRGxd83xDMocbrlMzBGryleeh9UDdybIPVvSUeYJ7fnh18obslkHGzi+GtmUXa4veMOcstVU80UZLhiI+k6fut0xUG6M/mBQXKLTP0oX/nWgWBUyvFPdgC8MgqpDjBDgwj0LfUaNYOT0pQu9LDSPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268627; c=relaxed/simple;
	bh=CitnH4Nqjir9L2Uiq9McDsqzkwWUKvVZkjzx+Rqrs5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VMYHBL2ekmo27UlE9dfsGWqGZ1BUO2RNJKINzD3XfKXUKRxu5d5Ju4xduDwMrKvBHsJhA+TD0qWWDbbMmn21JFCKWQB883VCw8+XNbITYer9iqeAPYgzruhhHObAh6sr82E5vw9ACAXjYQiCc9vbrXnpA+R3qfIbFZVYfNMHbz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqO+GNSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqO+GNSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F851F000E9;
	Tue, 28 Jul 2026 19:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785268625;
	bh=HQPAs+/hLx9X5V2tQtCYiaH+Bh/KYsAsUhQoxyY9yA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YqO+GNSZAkMuaNkPLadVeseSPnbyt2dpXU+vKgAD/peyf6fwMe4dtJIRwphxsxKYZ
	 QCfvl7eg4y+GzCqUtYQbFZkHysD8p4ZrrdRrNj3h8iFX9gG/p3qrvIkwNMhRzxQcOd
	 2MxOJQxxlAif/VBRR9h4ekJR7Z61KY5awv5PfJYmdZExIywaQdM1udJ5UdswV/DmG7
	 NZJsdUpeLKMz2ose6hSHFla65yJXvY7XPoyCBGQVmlDr42+2d8+vrZouG5IaHe7xa0
	 rfWRnyWuG3/GJXtKN1qdgde4a9qzSygDxK61E64g1O12IBGv+p/2mfMXKJnA+B08jG
	 vA0fpTnSxsrIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in
 damon_get_folio()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20260728194714.3713735-2-gourry@gourry.net>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-2-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 19:57:04 +0000
Message-Id: <20260728195705.53F851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The explicit `folio_is_zone_device()` check added by the patch i=
s dead code and fails to achieve its stated intent.

Pre-existing issues:
- [High] Early return in damon_ptep_mkold and damon_pmdp_mkold skips MMU no=
tifier aging for device-exclusive swap PTEs.
- [High] The scheme's `last_applied` pointer caches a freed folio pointer, =
leading to a dangling pointer comparison.
--

--- Patch [1]: [PATCH 1/4] mm/damon: defensively skip zone device folios in=
 damon_get_folio() ---
commit 8181b2e77c1b49bcb808528f343f72fdbf9d168c
Author: Gregory Price <gourry@gourry.net>

mm/damon: defensively skip zone device folios in damon_get_folio()

All DAMON physical- and virtual-address operations obtain their folios
through damon_get_folio(). That helper already excludes ZONE_DEVICE
memory implicitly via pfn_to_online_page() and folio_test_lru(), but
this is inconsistent with other callers in mm/ which test explicitly.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 0981a5e3af172..0db1383de5d01 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -32,7 +32,8 @@ struct folio *damon_get_folio(unsigned long pfn)
>  	folio =3D page_folio(page);
>  	if (!folio_try_get(folio))
>  		return NULL;
> -	if (unlikely(page_folio(page) !=3D folio) || !folio_test_lru(folio)) {
> +	if (unlikely(page_folio(page) !=3D folio) || !folio_test_lru(folio) ||
> +	    folio_is_zone_device(folio)) {

[Severity: Medium]
Since ZONE_DEVICE folios do not have the LRU flag set, won't the
!folio_test_lru(folio) check always evaluate to true for them?

Additionally, earlier in damon_get_folio(), pfn_to_online_page(pfn) is
called, which strictly returns NULL for ZONE_DEVICE memory. Doesn't this
mean ZONE_DEVICE memory will never reach this new folio_is_zone_device()
check at all, making it dead code?

>  		folio_put(folio);
>  		folio =3D NULL;
>  	}

[Severity: High]
This is a pre-existing issue, but I have a question about how
damon_get_folio() returning NULL interacts with device-exclusive memory.

When DAMON encounters a device-exclusive PFN swap PTE in damon_ptep_mkold()
or damon_pmdp_mkold(), damon_get_folio() returns NULL because
pfn_to_online_page() rejects it. Both of these callers then immediately
early-return on !folio:

mm/damon/ops-common.c:damon_ptep_mkold() {
    ...
    folio =3D damon_get_folio(pfn);
    if (!folio)
        return;
    ...
}

Doesn't this early return silently bypass the mmu_notifier_clear_young()
call completely, breaking DAMON's ability to monitor device accesses
(which relies on the MMU notifier for device-exclusive PTEs)?

[Severity: High]
This isn't a bug introduced by this patch, but looking at how DAMOS
physical address apply functions interact with folios, I noticed
something about the last_applied pointer:

In mm/damon/paddr.c:damon_pa_pageout(), a reference is dropped:

mm/damon/paddr.c:damon_pa_pageout() {
    ...
    folio_put(folio);
    ...
    s->last_applied =3D folio;
}

Since folio_put() drops the reference, could this store a dangling
pointer across DAMON region processing boundaries?

If that physical memory is subsequently reallocated for a new folio,
it will reside at the exact same address. When this pointer is later
checked in damon_pa_invalid_damos_folio():

mm/damon/paddr.c:damon_pa_invalid_damos_folio() {
    ...
    if (folio =3D=3D s->last_applied) {
        folio_put(folio);
        return true;
    }
    ...
}

Could this falsely match the dangling pointer and erroneously skip a
valid, newly allocated folio from DAMOS actions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728194714.3713=
735-1-gourry@gourry.net?part=3D1

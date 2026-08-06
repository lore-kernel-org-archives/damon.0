Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120303EE1E5;
	Thu,  6 Aug 2026 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006847; cv=none; b=j+xhp563+3X8DZruvsLxtcd9aK7MA1ePFZrooGesIMCFzHm+u6T1W/xlVKrHStmTgN4pMe76p6OSVoDN8cXjhnOIw2eh2eaa3Tp/9+RsCeT0G+FvInuZ9107SFFWwdlBC7FNvSW29mKvD0kwEcO6Ra6sztfaXxD2BpyE4dc6jaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006847; c=relaxed/simple;
	bh=IXosy3m+BAms28vhI8cA5HSHPycKiF6bAta4JwvlU0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cfuJF4BEFFYplOAeW8h26kM0q9LlEs6xrrDkb0aAeEvDK5Q/z6YzupHI7FuotAFgnKyOpGGVouEN8wslJ+Vpq/bqLZK2nhcFWD2Y48qt4yHCc5qj9MzxDyVxZ2hQlvaOL1Go+nNqYsZvNFIxMpyEmfxywjoqRLv6ESkaU7uouok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFAdCt3O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFAdCt3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9031F000E9;
	Thu,  6 Aug 2026 09:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786006845;
	bh=76KutQ140xLoGJiHxtF05UpSwJ3YofiDfwlWKcagWBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFAdCt3OHLMPBCo/UPP8xCDtFsWr08moBBuIFtsD9shG+cWOFp0mwNWiCsQqK1AVO
	 JrGlLnKRtiZkmo/ql65ghpk9mtAe89B7SCoAMuKVieZ3lBKDv0qOMdeizCwGWMT8nf
	 /uCqw+5Hfgimeq9aHU00PFD6QR7WX9vll0TTGIc8w2JcCpwjmYUOv9/NG7T0n+VDpd
	 Cg+iRqWlhuwZmMh/Rv+zIkBAmN0BHPovZ+dmaA126sRQcX8Mpv8yb3fFIL+IXq51gA
	 2xeluD4HBXtgDJpfWovhR7AhE2LaKskv7DkCDV1ufygzQp6UbgAIErhDdCosMCC0uf
	 lcIG67KBiKoxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] mm: use hw_pte_t for generic PTE table storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: dri-devel@lists.freedesktop.org, damon@lists.linux.dev, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260806083926.1807279-5-usama.anjum@arm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-5-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 09:00:43 +0000
Message-Id: <20260806090044.CB9031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] copy_present_ptes batches PTEs in shared mappings without FPB_=
RESPECT_WRITE, granting the child process unintended write access to read-o=
nly pages and bypassing filesystem write notification.
- [High] Page walk callbacks wp_pte() and clean_record_pte() access hardwar=
e bits on potentially non-present PTEs, risking metadata corruption.
--

--- Patch [4]: [PATCH 4/9] mm: use hw_pte_t for generic PTE table storage -=
--
commit 9f475c080b8384027672c2a2cfdb3246a47fd906
Author: Muhammad Usama Anjum <usama.anjum@arm.com>
Subject: mm: use hw_pte_t for generic PTE table storage

This commit converts generic page-table interfaces to use hw_pte_t pointers=
 for
table storage instead of pte_t pointers. It retains pte_t for logical PTE
values, changing the vocabulary without altering representation or behavior.

> diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
> --- a/mm/mapping_dirty_helpers.c
> +++ b/mm/mapping_dirty_helpers.c
> @@ -31,7 +31,7 @@ struct wp_walk {
>   * The function write-protects a pte and records the range in
>   * virtual address space of touched ptes for efficient range TLB flushes.
>   */
> -static int wp_pte(pte_t *pte, unsigned long addr, unsigned long end,
> +static int wp_pte(hw_pte_t *pte, unsigned long addr, unsigned long end,
>  		  struct mm_walk *walk)
>  {
>  	struct wp_walk *wpwalk =3D walk->private;
>  	pte_t ptent =3D ptep_get(pte);
> =20
>  	if (pte_write(ptent)) {

[Severity: High]
This isn't a bug introduced by this patch, but does this code modify hardwa=
re
bits on non-present PTEs?

The page walk callback wp_pte() processes all PTEs within a mapping range,
including non-present entries like migration or swap entries. It checks
pte_write() directly without verifying pte_present() first.

If a swap or migration entry overlaps with hardware writable bits, this che=
ck
might pass, causing pte_wrprotect() to be called. This can silently corrupt
swap or migration metadata, leading to memory corruption when the entry is
later resolved.

[ ... ]

> @@ -86,7 +86,7 @@ struct clean_walk {
>   * in the address_space, as well as the first and last of the bits
>   * touched.
>   */
> -static int clean_record_pte(pte_t *pte, unsigned long addr,
> +static int clean_record_pte(hw_pte_t *pte, unsigned long addr,
>  			    unsigned long end, struct mm_walk *walk)
>  {
>  	struct wp_walk *wpwalk =3D walk->private;
>  	struct clean_walk *cwalk =3D to_clean_walk(wpwalk);
>  	pte_t ptent =3D ptep_get(pte);
> =20
>  	if (pte_dirty(ptent)) {

[Severity: High]
This is a pre-existing issue, but can this inadvertently corrupt non-present
PTEs?

Similar to wp_pte() above, clean_record_pte() evaluates pte_dirty() on the
entry without checking if the PTE is actually present. Calling present-PTE
accessors on non-present entries produces undefined results. If this evalua=
tes
to true for a swap or migration entry, calling pte_mkclean() will overwrite
and corrupt the swap metadata.

[ ... ]

> diff --git a/mm/memory.c b/mm/memory.c
> --- a/mm/memory.c
> +++ b/mm/memory.c
[ ... ]
> @@ -1205,7 +1205,7 @@ static __always_inline void __copy_present_ptes(str=
uct vm_area_struct *dst_vma,
>   */
>  static inline int
>  copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct =
*src_vma,
> -		 pte_t *dst_pte, pte_t *src_pte, pte_t pte, unsigned long addr,
> +		 hw_pte_t *dst_pte, hw_pte_t *src_pte, pte_t pte, unsigned long addr,
>  		 int max_nr, int *rss, struct folio **prealloc)
>  {
>  	fpb_t flags =3D FPB_MERGE_WRITE;
>  	struct page *page;
>  	struct folio *folio;
>  	int err, nr;
> =20
>  	page =3D vm_normal_page(src_vma, addr, pte);
>  	if (unlikely(!page))
>  		goto copy_pte;
> =20
>  	folio =3D page_folio(page);
> =20
>  	if (unlikely(!*prealloc && folio_test_large(folio) && max_nr !=3D 1)) {
>  		if (!(src_vma->vm_flags & VM_SHARED))
>  			flags |=3D FPB_RESPECT_DIRTY;
>  		if (vma_soft_dirty_enabled(src_vma))
>  			flags |=3D FPB_RESPECT_SOFT_DIRTY;
> =20
>  		nr =3D folio_pte_batch_flags(folio, src_vma, src_pte, &pte, max_nr, fl=
ags);

[Severity: Critical]
This is a pre-existing issue, but does this code allow read-only PTEs to be=
come
writable in the child process?

In copy_present_ptes(), when batching PTEs for a shared mapping, the flags
variable includes FPB_MERGE_WRITE but the FPB_RESPECT_WRITE flag is missing.
This causes folio_pte_batch_flags() to group PTEs with differing write
permissions.

If a batch contains both writable and read-only PTEs (for example, a 4K page
was made writable via page_mkwrite() while the rest of the THP remains
read-only), FPB_MERGE_WRITE ensures the batched output PTE is marked writab=
le.

For shared mappings, __copy_present_ptes() calls pte_mkclean() but does not
write-protect the PTE. Consequently, set_ptes() installs this clean but
writable PTE across the entire batched range in the child process.

When the child writes to these newly writable pages, the hardware sets the
dirty bit without a page fault. This bypasses the filesystem write
notifications, which can allow writes to unallocated blocks in sparse files
and silently drop data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806083926.1807=
279-1-usama.anjum@arm.com?part=3D4

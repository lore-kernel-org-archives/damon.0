Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3106E379C5C
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860230; cv=none; b=tGUXAGio03KRZLNKAQyRSFNR9oGzkTG6vaK7kaWxEejSuTwOnNI/BSkTv5VEll76dKPLZFwRrKiqD6SoiISm6nJlJ3ac2kYnFd7XIUdx9eBaoN2mn/M3qcQbZQVS2+8jxapyjWoOijD+0oAzkVRZT8eNXK4ppZ9V4beVSjmJUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860230; c=relaxed/simple;
	bh=qfEf0pqy20XeJMyOTNZnCus0vrDQFTi/reCwBUK6OQY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WudB3GRbrwR1Dss6klCaaQznkg/SCz6uZ6Q3pDSJEdMlkC6zforwqKocMTWU3O1nOp8ciA12lralYdF9ljF8LMMQyxPjP6VAzSK47KT2q0Z6Lzz2APeNquIHZD+6If6ZUXvVE1gmi374hPjfUl+xRcW8MVctgmZ1g1JK7HEQJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDHjzYay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDHjzYay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6DE1F000E9;
	Thu, 27 Aug 2026 19:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787860226;
	bh=3SFVq6qeA/Snfgbt5F979m54IEqtSyQJCWW1It4EAc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TDHjzYayAIH+jT5IoNwJfKa3Xe2+QsZm8cysjVX7iZeyQNaRbcVsYQuVLcj+q5ein
	 SuKxMp13vs5BgeigRCgxb/syYBUXdgyhXtw9lP5YmTzp81LYrdgcrn/Sk+XJGq84wO
	 esyKNA9bK3HH92PlsJaeCRJmIE/INNPEsqtbuBGwqDQTleTqyvLzD19qCmSXtAmXQP
	 2cmo2V73Mx9yld9j+EavXpar7xFY3maUW38JEuOXZSUN75EjwxnAxCPLgCxzZGnjNR
	 Vlyqk64R1EmG5SNaRRThKCeMFfcZ+1vcL0zzY+2VSEoCfGqp9ZMEuBSPVfBcAJHAcX
	 jq/P5j4cM2mUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon: use a page-aligned sampling address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Gao" <zcgao@amazon.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260827193821.46115-1-zcgao@amazon.com>
References: <20260827193821.46115-1-zcgao@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:50:25 +0000
Message-Id: <20260827195026.5B6DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unaligned address passed to `mmu_notifier_clear_young()` in THP an=
d HugeTLB paths causes out-of-bounds young bit clearing.
- [High] damos_va_migrate_pmd_entry() and damos_va_stat_pmd_entry() incorre=
ctly advance the PTE loop by folio_nr_pages(), skipping unrelated PTEs.
--

commit aa3021f597712046c0814751d5b225db6dfc5b6c
Author: Nathan Gao <zcgao@amazon.com>
Subject: mm/damon: use a page-aligned sampling address

This patch modifies the DAMON virtual address access check to page-align
the randomly chosen sampling address. This prevents issues on architectures
like arm64 where an unaligned address could lead to walking past block
boundaries and causing page table corruption.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 0648400b2d65b..8856a9131971d 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -361,7 +361,8 @@ static void __damon_va_prepare_access_check(struct mm=
_struct *mm,
>  					struct damon_region *r,
>  					struct damon_ctx *ctx)
>  {
> -	r->sampling_addr =3D damon_rand(ctx, r->ar.start, r->ar.end);
> +	r->sampling_addr =3D PAGE_ALIGN_DOWN(damon_rand(ctx, r->ar.start,
> +						      r->ar.end));

[Severity: High]
This isn't a bug introduced by this patch, but while this patch page-aligns
the sampling address, can this still cause out-of-bounds young bit clearing
for huge pages?

When DAMON samples a region, the address is passed down to THP and HugeTLB
handlers. If the sampled address retains a sub-huge-page offset, the range
passed to the MMU notifier spans two contiguous huge pages:

mm/damon/ops-common.c:damon_pmdp_mkold() {
    ...
    young |=3D mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_=
SIZE);
    ...
}

mm/damon/vaddr.c:damon_hugetlb_mkold() {
    ...
    if (mmu_notifier_clear_young(mm, addr, addr + huge_page_size(hstate_vma=
(vma))))
    ...
}

Secondary MMUs like KVM check for GFNs overlapping this range. Because the
adjacent huge page overlaps with this range, KVM could incorrectly clear its
young/accessed bit, altering the access history of an unrelated huge page.


[Severity: High]
This is also a pre-existing issue not introduced by this patch, but do the
PTE walk loops in damos_va_migrate_pmd_entry() and damos_va_stat_pmd_entry()
skip unrelated PTEs?

mm/damon/vaddr.c:damos_va_migrate_pmd_entry() {
	for (; addr < next; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
		nr =3D 1;
		ptent =3D ptep_get(pte);
...
		folio =3D vm_normal_folio(walk->vma, addr, ptent);
...
		nr =3D folio_nr_pages(folio);
	}
}

In the PTE walk loops, the step size nr is set to folio_nr_pages(folio).
However, folio_nr_pages() simply returns the total size of the large folio.
If the large folio is only partially mapped within the VMA, or if the
iteration starts at an offset into the folio, blindly advancing pte +=3D nr
and addr +=3D nr * PAGE_SIZE will overshoot the folio's boundaries. Could t=
his
skip valid PTEs that map entirely different folios, causing DAMON to silent=
ly
ignore those pages?

> =20
>  	damon_va_mkold(mm, r->sampling_addr);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827193821.4611=
5-1-zcgao@amazon.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57DF427F97;
	Mon, 27 Jul 2026 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172157; cv=none; b=E6P8mtgZOdYdyUyINHfOxEGU6Rf+Eq4OW3RQji2eLLFfMbxcvpOai32QpLTGW1HmDwovDqj64cfP0HTYmZebV6ck69OCqIDJtnspzREVyyl3iWyX9kqL6DQsaEr9i5LvxREV1xj6yTtEx04VfQvAgiGJo/OUlo4MkgdwXrZ9sW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172157; c=relaxed/simple;
	bh=0Jh/HQSKQu5d89MOXnalBDXnDq+NzvYdVc2b7TbAzX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RIjBrv0nnYcKynA1atYyLkea0SkZALuvnjO27xwqpPiwXRhqKHF0cvAGIoAbf3nYCdxqqzPxvVIzJWWSnK+w1h9DpfWPOP9J1CCRoi00AZiTiQC4oklmyDN6yLyiKX9CsnKjhyLeNIyr12QGtongqkZjLu3qvaoNDtPBpy8+J18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2zsRbrn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2zsRbrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464F11F000E9;
	Mon, 27 Jul 2026 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172155;
	bh=R5RIhjlhVNK2x7Y1fqqGI/R1pQZMseReL4BIJn/zNrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C2zsRbrngaP3oTDgOSU3g6rJG02D43gQgvKoiJUZVfmI8h0iYH3vsZjVD0/5fjtpL
	 Tk21pTEFdOzZKjOd3Gps6+D9TrZ/8qy4GcV1kjWtOhb+ADc3ma1LAeQ7Ur0hlP4UIC
	 Epvm1sYvah+nxf5f+bNqcP1h0KbjdhQwaRTtL1AsvuLe9I0FTh7micGAsre26r89ep
	 Vd0PAW2ZEJE+2Wzbp7CPcaaWKhBQOXgg5yAJ1NUE8uhRtsteql8PxerVro8Ohz0e6F
	 Wm2a0npzM/pUniYEKcRVamLy/NscRf3riUOmAJlkf4qPZo+T3ItQ1mnX7NRG7+boiE
	 RX7dycUJMZa+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/11] misc/sgi-gru: use ptep_get() for page-table
 reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20260727164715.2866609-10-usama.anjum@arm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-10-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:09:14 +0000
Message-Id: <20260727170915.464F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lockless page table walk in `atomic_pte_lookup` reads page tab=
le entries multiple times, causing TOCTOU vulnerabilities (UAF, Wild Read, =
Privilege Escalation).
- [Critical] atomic_pte_lookup maps the base of an anonymous THP instead of=
 the requested offset, causing silent data corruption.
--

--- Patch [9]: [PATCH RFC 09/11] misc/sgi-gru: use ptep_get() for page-tabl=
e reads ---
commit 24fd6151a0088920cebe4cf33a4840e02a2f4e62
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

misc/sgi-gru: use ptep_get() for page-table reads

A leaf PMD is being read through ptep_get() by treating the PMD address
as PTE-sized table storage. ptep_get() now accepts hw_pte_t *, so update
the cast accordingly.

> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufa=
ult.c
> index 3557d78ee47a2..ff89d34ad2aa4 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -228,10 +228,10 @@ static int atomic_pte_lookup(struct vm_area_struct =
*vma, unsigned long vaddr,
>  		goto err;
>  #ifdef CONFIG_X86_64
>  	if (unlikely(pmd_leaf(*pmdp)))
> -		pte =3D ptep_get((pte_t *)pmdp);
> +		pte =3D ptep_get((hw_pte_t *)pmdp);
>  	else
>  #endif
> -		pte =3D *pte_offset_kernel(pmdp, vaddr);
> +		pte =3D ptep_get(pte_offset_kernel(pmdp, vaddr));

[Severity: Critical]
This is a pre-existing issue, but does this lockless page table walk
have time-of-check to time-of-use vulnerabilities?

When atomic_pte_lookup() evaluates pmd_leaf(*pmdp) and then rereads *pmdp
via ptep_get(), if a THP split occurs concurrently (which only takes the
PMD lock and can run concurrently with mmap_read_lock()), the second read
could see a PMD pointing to a PTE table. The function would then treat this
non-leaf PMD as a leaf PTE, extracting the PFN of the PTE table itself.
Could this cause the GRU hardware TLB to be programmed to grant user-space
read/write access to its own kernel page tables?

Similarly, if a concurrent MADV_DONTNEED (which runs under mmap_read_lock())
clears the PMD between pmd_none() and pte_offset_kernel(), could
pte_offset_kernel() compute a direct-map address of PFN 0 (PAGE_OFFSET),
resulting in a wild read of physical memory to use as a PTE?

[Severity: Critical]
This is another pre-existing issue, but does atomic_pte_lookup() map the
base of an anonymous THP instead of the requested offset, potentially causi=
ng
silent data corruption?

Further down in this function, the code does:

	*paddr =3D pte_pfn(pte) << PAGE_SHIFT;
#ifdef CONFIG_HUGETLB_PAGE
	*pageshift =3D is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
#else
	*pageshift =3D PAGE_SHIFT;
#endif

When processing a TLB miss for a virtual address mapped by an anonymous THP,
pmd_leaf(*pmdp) is true. The function extracts the base PFN of the 2MB page
from the PMD. However, because is_vm_hugetlb_page(vma) evaluates to false
for anonymous THPs (it only checks for hugetlbfs VMAs), *pageshift is set
to PAGE_SHIFT (4KB).=20

Because the base PFN of the THP is extracted without adding the offset for
vaddr, and a 4KB page size is used, does this cause reads and writes to any
4KB chunk within an anonymous THP to incorrectly access the first 4KB chunk
of that THP?

> =20
>  	if (unlikely(!pte_present(pte) ||
>  		     (write && (!pte_write(pte) || !pte_dirty(pte)))))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727164715.2866=
609-1-usama.anjum@arm.com?part=3D9

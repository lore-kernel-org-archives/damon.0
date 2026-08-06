Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B943E49F4;
	Thu,  6 Aug 2026 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006883; cv=none; b=cfNgF+gwy9avQxYjgLGDwUWO3YpEUHkpAk9mP1ftzNK5NiUBgZyZYOh7iEo9x+5hi8/NJMNhfPmlwGibx8x9JXnPiEATwFZ21lv5j1MKonHlmab1WSh2/Ky4qoxIe1dwBxPZ5hV4sxTEOTg0qpCM4ELwT50+RgFiJsBYtP25zZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006883; c=relaxed/simple;
	bh=gN64CbbVMioCnULy/XAxWfPJLYEo011W1ngSIOkw56g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CXKMDl9/Qz48zr6hNjrnIyX8vIdf5hcU9wNobSzREUcSbtRbopFMbOpmqWtwN++1yyfC7ddob0C6y+/cTaH9jUyDpbySqapggcLA0iXI8eR5w3WNoWWWKYpYguaOn9WuN+MCpk4iEty+piST97MRQTRkK6nKihN4pYHQWyZ+a4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBASob7v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBASob7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C013F1F000E9;
	Thu,  6 Aug 2026 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786006882;
	bh=gtt+zplP1NQteJybU0xLiv3wJ4KT/lOlzhGGTNIRcm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KBASob7vFaOgGODbTeQS5Tc3BJ4ei5vr6UYD/v90sbOI6u7NpgGPN9mH4bjsetee0
	 ZwgsDwJSHOk8QKJIfkj2bQVa3kmh8DsSl8hpR4IKOZeqpk5SvYpzrcvhN4eeoyhLXY
	 RUnxBhvbG7m+EU5FF6wMBG5TEDtHY2oDfQ7dcWXsHFcLjwCkKR/KEp/2TCBNSoU7LF
	 SLnC8uER56a7KHo58rq6AmQrJjLnH7c/9IT62pe11m1luTQBF5exzbXG6UN0NaFDJ3
	 v3WTWjYZO342LT55cAOIa01OzOU7nrZPLR5Gq1Is7OdUjROr7rkj6NMY5ttqJjeifw
	 xEFuNdqNCscAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] mm/kasan: use hw_pte_t for the early shadow PTE
 table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260806083926.1807279-8-usama.anjum@arm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-8-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 09:01:21 +0000
Message-Id: <20260806090121.C013F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Invalid non-present page table entry conversion in ptdump callback=
s.
--

--- Patch [7]: [PATCH 7/9] mm/kasan: use hw_pte_t for the early shadow PTE =
table ---
commit 3ee38376d3d7f9e85666863e4080641fcf9b048b
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

mm/kasan: use hw_pte_t for the early shadow PTE table

kasan_early_shadow_pte is a complete PTE table rather than a standalone
PTE value. Declare and define its elements as hw_pte_t so the object uses
the PTE table storage type.

[ ... ]

> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index 376880071ca2a..8f19f20be3c44 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -19,7 +19,7 @@ static inline int note_kasan_page_table(struct mm_walk =
*walk,
>  {
>  	struct ptdump_state *st =3D walk->private;
> =20
> -	st->note_page_pte(st, addr, kasan_early_shadow_pte[0]);
> +	st->note_page_pte(st, addr, ptep_get(kasan_early_shadow_pte));

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying the K=
ASAN
shadow table handling in ptdump, are the page extraction checks that lead h=
ere
safe for non-present entries?

In mm/ptdump.c, callbacks like ptdump_pmd_entry() and ptdump_pud_entry()
unconditionally call pmd_page() and pud_page() before checking if the entry
is present:

mm/ptdump.c:ptdump_pmd_entry() {
    ...
	pmd_t val =3D pmdp_get(pmd);

#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
	if (pmd_page(val) =3D=3D virt_to_page(lm_alias(kasan_early_shadow_pte)))
		return note_kasan_page_table(walk, addr);
#endif
    ...
}

User page tables can contain non-present swap or migration entries at the P=
MD
level. If pmd_page() (and equivalents like pud_page(), p4d_page(), pgd_page=
())
extracts a bogus PFN from a non-present entry, could this lead to an
out-of-bounds array access and a NULL pointer dereference in the sparsemem
arrays when pfn_to_page() is evaluated?

Since ptdump can be invoked on user page tables via debugfs by users with r=
ead
access, could this trigger a kernel panic? Should these callbacks verify the
entry is present before calling the page conversion functions?

> =20
>  	walk->action =3D ACTION_CONTINUE;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806083926.1807=
279-1-usama.anjum@arm.com?part=3D7

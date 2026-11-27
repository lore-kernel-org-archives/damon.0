Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818954;
	b=03V2Suk75JZlbOL/HkptPp6SipY3vg7JXcuJzeJyDsSKKt69DY+btVmfn/Qhmaqciiy+
	 Yx1bBuPLs2hfcvEaX7Qwd/1GqGEGPxrOZNq2B5crS3vJ7opiQiQk1I0oFfojXlXwwoqTM
	 vUJuhm0+lLr47wV19cq+ZMmOnlPHqXrCkRskyL0jwW/yADRaul5R+X3wVRL2fdwZyfksj
	 JeWfciRwqI0QB5zbIMNq2ea66ZUOrilSxdvxWbiKnbq6jLf7krgrVvSKlYFSh+KIuWusH
	 QfSqNQC4PLF2ze9c9x/eu1PVBz88pEWUlxWTuZl76EFuDxb007FnRgUX1mKvLnDR4Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818954;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dzF317K6KqDBv+rHBv9bV3+7O0cBP4sxEFIupvQMWVA=;
	b=DzUSOR7WwnC42wePaFNQA8q3z2ZBrxvOsGXYZw5r7OlimLTgJdVyOe0szflCHLtPhq3u
	 91t7Kq0dVn2gzVH7+6s1K+zMBKe2BVQvtkyslno1sFI4MtoiF2Y9YWVoxfo+QYTuD6+up
	 WW05xNDARKNnoiu1s+CM73F6I2/DYd6Br6HOUBq7g9RxN6EBsqCruYD5BWeg+t/vFk++u
	 A1UHRqbd9tZdS+R/GzovobCfbcE50PtI8qXWPvxy5iuqdL1mCJ/BxzRFMOsnFWSk6q4rp
	 jE3z4TvMPwXqZQI8SX2j4YjmUIWIMpryMkuUKS/8LpjY92DvW0eOUVW6WzS1aK9gVOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N97Ok2bp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5896606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N97Ok2bp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563EA1F000C1;
	Fri, 27 Nov 2026 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795818954;
	bh=dzF317K6KqDBv+rHBv9bV3+7O0cBP4sxEFIupvQMWVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N97Ok2bpSbtbpvw8SFOg8pmPmUYycOcIkyqzhFPD9FnA4BQ/FrNBQYgVuziSteeNH
	 /9zRQF3nsTNx2bAFiGakWnyixf8X3884ZaY4Xc5L4tkwvcgOCXKjO4RkxEmEooWMj5
	 wKOu4bRbdBOZU2WATujGqJw/eGHXnfG98kC8f3hqKjUWjV9DXBinpHXUCnkiL2H1XZ
	 tQKGektu9F1BJlf4KzPtn6bhF8covbfwMsPhlMFInKLrpcanbTra7rEPgeHS39WO6x
	 GBb5DfI9rye+KgWc8LGtCcj0+uWSt1SygCdXQvdGxBeFLMcHxeRFASf5qHawLf85RR
	 f1cDs+OkN61oQ==
Message-ID: <sashiko-outbox-238334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/7] mm/damon/vaddr: implement sz_filter_passed
 for migrate_{hot,cold} action
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261127222719.105510-4-sj@kernel.org>
References: <20261127222719.105510-1-sj@kernel.org>
 <20261127222719.105510-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 22:35:53 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] mm/damon/vaddr: NULL folio dereference in
  damos_va_migrate_pmd_entry()
--

commit 446fe1a8fb2f01d2025ab8ed2dd156f643ec9800
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action

This commit threads sz_filter_passed through damos_va_migrate() and
damos_va_migrate_pmd_entry() to accumulate the size of folios that pass
DAMOS ops filters during migrate_{hot,cold} actions.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index c8f93a19c840e..721a23856ee16 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
[ ... ]
> @@ -895,6 +898,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, uns=
igned long addr,
>  		s->last_applied =3D folio;
>  		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
>  			continue;
> +		*sz_filter_passed +=3D folio_size(folio);
>  		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
>  				migration_lists);
>  	}

[Severity: High]
Can the PTE loop in damos_va_migrate_pmd_entry() dereference a NULL folio
when vm_normal_folio() returns NULL (for example, on the shared zero page
or a special mapping)?

Earlier in this series, commit "mm/damon/vaddr: use damos->last_applied
for migrate action" placed damos_va_invalid_folio() (which checks !folio)
after folio_page_idx() and folio_nr_pages():

mm/damon/vaddr.c:damos_va_migrate_pmd_entry() {
	...
		folio =3D vm_normal_folio(walk->vma, addr, ptent);
		page_idx =3D folio_page_idx(folio, pte_page(ptent));
		nr =3D folio_nr_pages(folio) - page_idx;
		if (damos_va_invalid_folio(folio, s))
			continue;
	...
}

When folio is NULL, folio_nr_pages() dereferences NULL while holding the
page table lock.  Checking !folio (or calling damos_va_invalid_folio() or
checking !folio before computing page_idx and nr, as in
damos_va_stat_pmd_entry()) avoids the NULL pointer dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127222719.1055=
10-1-sj@kernel.org?part=3D3

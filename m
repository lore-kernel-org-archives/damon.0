Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9A2C0F81
	for <damon@lists.linux.dev>; Sat, 16 May 2026 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778974588; cv=none; b=WYiCp7WGm+fdUfRnwUpyRakE068pqayEeiGE7CKWSC1t0oXTeihhPMXaRGJrzh9J3TW/PNU04D4bS19v3ms4iGfUvfDgbaOR/ErQ4ott7JUWS5poYJDvhE9umhE9+SRLqJbYgXJyKqzUfXL3Fp7+8TqSgjjKA2sov3qBOjIhtpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778974588; c=relaxed/simple;
	bh=vqviVsSE4yqHnbaMHjx+C7PJSm81b815OSdqrYBQFbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uy/lvc3k2haGSCmLcsMzl65NpKMIn6T44CTyv3yea3kEynr4UfrhqDGnBOk4wD2E8W6rvc3hfAJg4CgM4h6Hv/fbisGbF6ZZA4j7vkZjiW2T4p9V3a7wFZxXHHDtYsUBcP8GhETDZjczkbVPXvy3IcwQIxgaPBLsvjadqDHKI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fnmpfc7U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fnmpfc7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E2AC19425;
	Sat, 16 May 2026 23:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778974588;
	bh=vqviVsSE4yqHnbaMHjx+C7PJSm81b815OSdqrYBQFbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Fnmpfc7Ubp3+4cN/cnZEir76YwIbVvFSenpNz82JA9axFgPh2TH08el/qYgGZXJeL
	 BrYDBJ2jixZEUBe5oUeqvaZyhBlw5rJtHPsMeWpaIJTmBOEfvk34wKAvVmctnyTXMF
	 lfCraZt7kGC7gJR3U2hftxRV1j2oYDBHLrvl7mNoKTFQSEGMIuuZJrtD5ZHgJQZhVW
	 Wog02XnWOuVEBqmuHjsIiFvhneVTbGvFNENMfPZjpSC62DbzWUZg6DlyhPZBZMg0Gp
	 OSwfJxQB/Mn9ZWgzkz3LwAjz8irl3FCpFB0vHk4rl0fniB2e/7AKbCzC1Th1CiA0v2
	 scDHXCjc0FEtA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/5] mm/damon/paddr: skip free pageblocks in
 migration walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260516210357.2247-5-ravis.opensrc@gmail.com>
References: <20260516210357.2247-5-ravis.opensrc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 23:36:27 +0000
Message-Id: <20260516233628.54E2AC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Calling `PageBuddy()` on a tail page triggers a kernel panic.
- [High] Unsafe address advancement skips valid memory when starting from a=
n unaligned offset within a folio.
- [High] Speculative access of folio flags on an unreferenced folio risks `=
VM_BUG_ON_FOLIO`.
- [Medium] The optimization fails to skip buddy blocks larger than `pageblo=
ck_order` efficiently.
- [Medium] Skipping an entire pageblock when `pfn_to_online_page()` returns=
 NULL misses valid memory.
--

commit 66e620b27c62d5fcd72a28187d8b381c33d31172
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: mm/damon/paddr: skip free pageblocks in migration walk

This patch optimizes DAMON physical memory walks on sparse address spaces
by checking if a pageblock is entirely free or offline, skipping the entire
block to reduce kdamond tick time.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index c4738cd5e221e..e844c990987b9 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -258,13 +258,32 @@ static unsigned long damon_pa_migrate(struct damon_=
region *r,
>  		unsigned long addr_unit, struct damos *s,
>  		unsigned long *sz_filter_passed)
>  {
> -	phys_addr_t addr, applied;
> +	phys_addr_t addr, end, applied;
>  	LIST_HEAD(folio_list);
>  	struct folio *folio =3D NULL;
> +	unsigned long pfn;
> =20
>  	addr =3D damon_pa_phys_addr(r->ar.start, addr_unit);
> -	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
> -		folio =3D damon_get_folio(PHYS_PFN(addr));
> +	end =3D damon_pa_phys_addr(r->ar.end, addr_unit);
> +	while (addr < end) {
> +		pfn =3D PHYS_PFN(addr);
> +
> +		/* Skip pageblocks that are entirely free. */
> +		if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
> +			struct page *page =3D pfn_to_online_page(pfn);
> +
> +			if (!page) {
> +				addr +=3D pageblock_nr_pages * PAGE_SIZE;
> +				continue;
> +			}

If a memory hole is smaller than a pageblock, can skipping the entire
pageblock miss valid, online pages in the remainder of the block?

> +			if (PageBuddy(page) &&
> +			    buddy_order_unsafe(page) >=3D pageblock_order) {
> +				addr +=3D pageblock_nr_pages * PAGE_SIZE;
> +				continue;
> +			}

Does this code risk a kernel panic when calling PageBuddy() on a tail page?

If a pageblock-aligned PFN points to a tail page of a larger compound page
(such as a 1GB HugeTLB page), PageBuddy() would trigger a VM_BUG_ON_PGFLAGS
due to the PF_NO_TAIL policy.

Also, if a free buddy block is larger than pageblock_order, does the
optimization fall back to stepping by PAGE_SIZE?

The first pageblock is skipped, but on the next iteration, pfn points to the
start of the second pageblock, which is a tail page of the large buddy bloc=
k.
Because the PG_buddy flag is only set on the head page, PageBuddy(page) will
evaluate to false.

> +		}
> +
> +		folio =3D damon_get_folio(pfn);

This isn't a bug introduced by this patch, but does damon_get_folio()
speculatively access folio flags before acquiring a reference?

mm/damon/ops-common.c:damon_get_folio() {
    ...
    if (!folio_test_lru(folio) || !folio_try_get(folio))
        return NULL;
    ...
}

If the page is concurrently freed and reallocated as a tail page of a new
compound page, calling folio_test_lru() before folio_try_get() risks a
VM_BUG_ON_FOLIO.

Additionally, this wasn't introduced by this patch, but can the physical
address advancement skip valid memory when starting from an unaligned offse=
t?

If damon_pa_migrate() starts at an unaligned offset within a large folio, p=
fn
points to a tail page, and damon_get_folio() resolves this to the head foli=
o.
The loop then unconditionally advances by the full folio size:

    put_folio:
        addr +=3D folio_size(folio);
        folio_put(folio);

Adding the total folio size to an unaligned starting offset would push addr
past the actual end of the folio, skipping pages in the subsequent memory
region.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516210357.2247=
-1-ravis.opensrc@gmail.com?part=3D4

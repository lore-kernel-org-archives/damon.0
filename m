Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A53AE18A
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688592; cv=none; b=dsp7TSCTApT6xL3MnL8KBalR2Ok8rb580yylMBQ1ifh/JUaXCn15IEWPXVi2eupQ9+eRTtPkmBE1Vhe6UCTLKgd7s6kCJwSmIx72RHgOjHhmP9rcc4ddj1wXfk2JMzyjFfszMVEVFzh4+KL7qmBuKvyJvrxXD/gzEguV0H91Jew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688592; c=relaxed/simple;
	bh=+dIyll+xClUb7ec8Nz1+rTwzxb4MDH7vDE9qsTwvfVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=haWA5F23Di2IvsFJyoH60+d79kEmFsZakJFHvnWmYFY+dFZu7q/0Yqa/GcFpvXfzOB3iLOHpkh2NYjAzRwbu1a+/GVQH7cfW/kfCXmKa1Sxe5z3oKJ6VCyGnXlUA4vwYAeyX+pdIIGsnwDLPbBOp02caR85YUZlwiYbLhtzxnv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/ByFmnb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/ByFmnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F561F000E9;
	Sun,  2 Aug 2026 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688591;
	bh=T6XlcdRgM3dQw/pWbDrTtbl3E7Kfl+8mWSBXPq7y2r8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C/ByFmnbDdLYjQrz73rdEJKxv+ZILD+9jbRX+RfDN5VU2V6tP7CSpECeoM7Bxnonl
	 SunKUBhAOE5vdWiXMjtkhThzYjEmSAxYCZMwA4EaSD76t6xv1v6hboIYIrwDbhibdY
	 smcttyBHZcqXQvKLohLzgdmjwQi6yK8zL55+DRXKtwfJsG2FslLXveHZ7f02kBagO1
	 dbh0dAkTcmzNLC4C7KNkIA6PP9EIAINh7Y7Aa6/QFI8sln6M9IUK/kpEV/y2lYV1jj
	 1dVF0IQYsbV7yTHz6EMrgnTRWqimplJ7c9B1jGpkZTebvsEq+nHOhyvhHkmbfhEVSv
	 K92Z8mVHP0nAQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 5/9] mm/damon/vaddr: respect folio end for
 DAMOS_STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260802162631.90304-6-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
 <20260802162631.90304-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 16:36:30 +0000
Message-Id: <20260802163631.33F561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe blind PTE batching skips intermediate mappings and misses p=
er-PTE Accessed/Young bits for large folios.
--

--- Patch [5]: [RFC PATCH v1.1 5/9] mm/damon/vaddr: respect folio end for D=
AMOS_STAT ---
commit d6ffeea9e85e0fc3aa2c2575b8113904f9da4123
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: respect folio end for DAMOS_STAT

This commit fixes an issue in DAMOS_STAT page-level monitoring where the
address advancement could incorrectly skip folios if a region starts in the
middle of a large folio. It ensures the address is advanced exactly to the
start of the next folio by calculating the correct page index.

[1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 0648400b2d65b..4b0b5edf67952 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
[ ... ]
> @@ -844,7 +846,8 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsign=
ed long addr,
> =20
>  		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
>  			*sz_filter_passed +=3D folio_size(folio);
> -		nr =3D folio_nr_pages(folio);
> +		page_idx =3D folio_page_idx(folio, pte_page(ptent));
> +		nr =3D folio_nr_pages(folio) - page_idx;

[Severity: High]
This is a pre-existing issue, but does this blind PTE batching skip
intermediate mappings and miss per-PTE Accessed/Young bits for large folios?

When damos_va_filter_out() tests the young filter, it only checks the
accessed bit of the first pte. By unconditionally advancing pte +=3D nr wit=
hout
aggregating the accessed bits of the remaining subpages, could this miss
hardware accesses on PTE-mapped large folios (like mTHP) and cause DAMON to
falsely classify actively used memory as cold?

Additionally, if userspace partially unmaps or remaps portions of this large
folio (for example, via MADV_DONTNEED or mmap), the page table might contain
different folios or empty entries in the skipped range. By blindly advancing
the PTE walker based purely on the first folio's size, does this ignore tho=
se
mixed mappings and fail to monitor the substituted folios?

>  		s->last_applied =3D folio;
>  	}
>  	pte_unmap_unlock(start_pte, ptl);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802162631.9030=
4-1-sj@kernel.org?part=3D5

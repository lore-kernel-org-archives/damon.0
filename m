Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747813793B4
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935084; cv=none; b=GZ08Yy7zYSpF5TqDUJ3tULY+67iiMdOFC8y8CiHXEs2D2aqsTBZemQNEKgXDzrkVwNggkdGiUyCmM9AbBp5kwPmBe+Q/HMfysk2U7Q/oja3+Sr+wGAOBf5obPKaBBMm01qj+dvY4IPUGSMFEmmz0ChTJyMWN+z8eSSMagBpOCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935084; c=relaxed/simple;
	bh=3EFv5lP2OsyndLwAZLZ5r38va7nqKzSmvQV+O4/J5rg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jw4nJsC3I3l6hFHwF5fKJdVI/UIkuM6MAPnUt9Sv3AiI4/CZ7V1QQMp+9Lhgx6fJgjR6oWk3gIjzSEIfsmumpdpay6t2UhjdVUH5xnfKqt7l7jGAbKMZFuKxO5A7VSdYMa5bEBkvaX+2ejXdT/ciyo5Cxizw9j00iurQWkGlw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3x40k9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3x40k9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1AF1F00A3A;
	Wed,  9 Sep 2026 06:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935083;
	bh=z4BHE2lelVEt+IqddrSfibN15Kab/dT8CWpQPsG2BME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M3x40k9jO30QCtbapDPJH7ZiG16UMM2M6sltDkyjrsE9q/qNH4twoZf4Ki54ya9R7
	 rZVutefWSpBZdy8TaIrHrpQFYC37in5wx1fEfdePFEWDT7MM5eYO8qlI9KzQJ1KmcE
	 iia5ZAtgNKkyN6SIDI8+/g80vpvWebFVu9jxsj5mhCbc/I5mavqHmR2Xa9kXR9rT9t
	 Q0wrsjI7DKgKpKZHJmClEy/DpJxWSQkNj/CuA0sUBa4m4GWHsH7Ua9i/na7zRrUpyT
	 qY+J4IZyGDCq2DYK4sLwMQd/6lc4ApARmEhu1HfA4AT4dEOuHdL60VcD1kaRjAQCE0
	 u/y4nM678Ik7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/vaddr: drop last same folio access check
 optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909061152.278678-1-sj@kernel.org>
References: <2026090858-legislate-monogamy-2299@gregkh>
 <20260909061152.278678-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:24:42 +0000
Message-Id: <20260909062442.DB1AF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The PMD is read directly via `*pmd` outside a lock, which can caus=
e torn reads on architectures where PMD size is larger than the word size (=
e.g., 32-bit PAE).
--

commit 3ab3595f2bebbbf09add4e61c160f37ee6aa2807
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: drop last same folio access check optimization

This commit removes the same-folio access check optimization from DAMON's
virtual address monitoring. The optimization was found to race when multiple
kdamonds are running, and its impact was deemed doubtful.

Link: https://lore.kernel.org/20260715031002.108504-4-sj@kernel.org
Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 708f281c1b6b4..4aa89347d754d 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
[ ... ]
> @@ -453,10 +452,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigne=
d long addr,
>  			goto huge_out;
>  		if (pmd_young(*pmd) || !page_is_idle(page) ||
>  					mmu_notifier_test_young(walk->mm,
> -						addr)) {
> -			*priv->page_sz =3D HPAGE_PMD_SIZE;
> +						addr))
>  			priv->young =3D true;

[Severity: High]
This is a pre-existing issue, but does reading the PMD directly via *pmd
outside a lock risk torn reads on architectures where the PMD size is larger
than the word size (like 32-bit PAE)?

Earlier in damon_young_pmd_entry(), the code does:

if (pmd_trans_huge(*pmd)) {
        ptl =3D pmd_lock(walk->mm, pmd);

Since damon_young_pmd_entry() runs during DAMON's page table walk under
mmap_read_lock(), concurrent THP modifications aren't prevented. If a torn
read occurs on the lockless *pmd evaluation during a concurrent THP split or
collapse, it could bypass both the pmd_trans_huge() and pmd_bad() checks.

If it falls through to the regular page path, pte_offset_map_lock() might
map a bogus physical address from the torn value, allowing arbitrary memory
to be treated as PTEs.

A similar lockless check appears to exist in damon_mkold_pmd_entry() as
well. Could these paths use pmd_read_atomic() or pmdp_get_lockless() to
safely evaluate the PMD?

> -		}
>  		put_page(page);
>  huge_out:
>  		spin_unlock(ptl);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909061152.2786=
78-1-sj@kernel.org?part=3D1

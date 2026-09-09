Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FBC35F162
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933803; cv=none; b=IMgYF0ecbe/6JUOmMLTM9DEiRbHTQahcEegwzYLMXNCCcEIREAF0fRaLiNnBRQcOJRiHKEX5zYE38VrYqyFRhWZiA1erHdK+XLPziprvJJeVVnQDH5M2uAAJ0ChfaM63WsSr5d45RSe4wCqIbQHtL9vrQWnaE+ibMN6y3x3ofc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933803; c=relaxed/simple;
	bh=C2HpbGcjbr1iWehRGzAutXKrwUTnHYo/ByGZG5my3Xk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oFSMY7FwM6ZxHIM5GxG3Oj4MLZUXlZ0TjLLi9ZE6WZlkvKT20/vWV0Vn5qxzPsLgx1ZTMKwgrsS3LnJj4U8r53hVpD0CuiWQhvqUMPl7G2t9x3y/xx5w2OEns13XIClGUKJqDF6p4kvysyCemOHHj46/nZI0/ADN/qcjpwx0Fco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeTbAw12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeTbAw12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B47E1F00A3D;
	Wed,  9 Sep 2026 06:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788933802;
	bh=nQ0545lBSwbl5qgxMAqcnIVPwTRKt2YbweaOuZZU30U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FeTbAw12FXrsNqwa3OcC1wTRZDRg/+E4Pkvi4P5QtOLq2hVHwye3pdVWEhPDc+oyX
	 nME7xbfURgYTbCjE27bn8FD+723P8xhBmfRlE+29PHbXljX4Gcbj2YqEkF+edgx1uP
	 W8mxtyKCqbEbGLasvvOPIuowT6fRPjlbKt5hh65SuBLSE8jduu6Ut3Iq9SCG8EYjh/
	 2Bm2vy0PIaNkXAp3vWJjLFlKRsFj/4qztTSl9d46aXqVl2qqtelX3HDYihztZCQLau
	 brvhc7y6vpfRZ2/gTAYf9OHSNbsp1N9EpajGDcdqXC5IWf9owGPhDkD4Pw4Zs5l2sE
	 FyWOiuC7isPUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.2.y] mm/damon/vaddr: drop last same folio access check
 optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909055319.263738-1-sj@kernel.org>
References: <2026090857-turtle-delirious-bcbc@gregkh>
 <20260909055319.263738-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:03:21 +0000
Message-Id: <20260909060322.3B47E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] DAMOS PTE-level PMD iteration incorrectly advances past unrelated =
memory when encountering large folio tail pages.
--

commit d786b1179a857b410a9db73cdc4ee0d7bdcbede5
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: drop last same folio access check optimization
   =20
This commit drops the last same folio access check optimization in DAMON.
The optimization can race when multiple kdamonds are running, and its
impact is doubtful.

Link: https://lore.kernel.org/20260715031002.108504-4-sj@kernel.org
Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 2c1c1952c008d..404785128ffd7 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
[ ... ]

[Severity: High]
This is a pre-existing issue, but does this code incorrectly advance past
unrelated memory when encountering large folio tail pages?

Looking at damos_va_migrate_pmd_entry() and damos_va_stat_pmd_entry() in
mm/damon/vaddr.c, the PTE iterator unconditionally advances by the full fol=
io
size:

mm/damon/vaddr.c:damos_va_migrate_pmd_entry() {
    ...
	for (; addr < next; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
		nr =3D 1;
		ptent =3D ptep_get(pte);

		if (pte_none(ptent) || !pte_present(ptent))
			continue;
		folio =3D vm_normal_folio(walk->vma, addr, ptent);
    ...
		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
				migration_lists);
		nr =3D folio_nr_pages(folio);
	}
    ...
}

If the loop encounters a PTE pointing to a tail page of a large folio,
folio_nr_pages(folio) returns the size of the entire large folio. Because t=
he
current PTE does not point to the head of the folio, advancing pte and
addr by the full folio size will overshoot into unrelated page table
entries, skipping memory regions during migration and stats scanning.

Could this lead to incorrect functional behavior where unrelated memory
regions are silently skipped by DAMOS actions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909055319.2637=
38-1-sj@kernel.org?part=3D1

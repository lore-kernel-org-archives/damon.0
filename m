Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F381AA8
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785031236; cv=none; b=U4MUuyIK+ly8jaHU/jM5ATtBu1x2PLEFr4/9LAnCJ1SI6OfcpLEPcGrx1naS8Jzs1zgGPyA7ATWB3dZ/Gs7ohuqjn78x/2xoB/6jb4GtZa69kRVWGzJVdHoqfCEjXGazyDITSdhWIrVoNuyhmF6F1lBX+ZNw+r3BleYtS3ebtFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785031236; c=relaxed/simple;
	bh=HHeEZM4/MnZjM+zhl9QqnDd+c7j5eqGZ6F6UNkzTlVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O0Nsn3Pj52+dhOZJLOQcFj2LBHdBeyhB5OpDpSRHWph91yA98/6X/qLd0rB3QAdRkcG8vMbgJk2FRBMeU9i1rzv0qaa4/JKM8LmN3mHQsqakHsLFP+2J/epOrNi61b6JglFZL/ECAzc9JQqHVz9uKmLfsfTof2Hfpf9Ec6JcLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoaXXSCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoaXXSCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D041F000E9;
	Sun, 26 Jul 2026 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785031234;
	bh=Joxju0a3ldeO8zkwLN0i2ecsCRwd5XcABYEPejhtOR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eoaXXSCPB2uGOYalyq/hqQMlTMy33hzdWSfdO3diFLNWsZhEpzsqMGGaghY3FDvFe
	 D1Hs3Tx8g+AQnt/L0WoI9IsOy+F0FpXwZ2MX4ax+2A10/elsQIVMefeOV+arrljozd
	 yPlywYIXfQKWxtW5aYyl1iOXQdcUEOzzzf7MBPjazVsIeEvEIdWktjUIA6UHs/LEq/
	 B0Te3TcqdP6nKuf5Obm2lqkkiyQ+pP6pVTiTuxjthw+F5OrS0+e1NXj8Nl0bWvFdjF
	 rn2GhpRc4QmDS+l+nrMp+u4HbZp0FzGnlY9fmVhRtQaBrqfnavZzFbwEARX7x0izst
	 ijtXB9fWwfgWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mm/damon/ops-common: putback folios on invalid
 migrate nid
Reply-To: sashiko-reviews@lists.linux.dev
To: dayou5941@163.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260726014815.1280757-1-dayou5941@163.com>
References: <20260726014815.1280757-1-dayou5941@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 02:00:34 +0000
Message-Id: <20260726020034.93D041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Invalid address and PTE advancement after page-to-folio conversion=
 for large folios in DAMON scanning loops.
- [High] DAMON migration causes NR_ISOLATED_ANON and NR_ISOLATED_FILE count=
er underflow.
--

--- Patch [1]: [PATCH v3] mm/damon/ops-common: putback folios on invalid mi=
grate nid ---
commit 1f243815b710aba6f1b966b6f98b83cb7c51edeb
Author: liyouhong <liyouhong@kylinos.cn>

mm/damon/ops-common: putback folios on invalid migrate nid

damon_pa_migrate() and damos_va_migrate() isolate folios into a local list
and then call damon_migrate_pages().  When target_nid is invalid (including
the scheme default NUMA_NO_NODE / -1), damon_migrate_pages() returns early
without putting the folios back to the LRU.

Callers then discard the list head while those folios remain isolated with
an extra reference taken by folio_isolate_lru().  The pages stay off the
LRU for as long as the mapping exists (anon active+inactive counts drop
while RSS does not), and the leftover references can pin the pages after
the mapping is gone.

Put the folios back on the invalid-nid path so ignored migration requests
still return them to the LRU.

Fixes: 7e6c3130690a ("mm/damon/ops-common: ignore migration request to inva=
lid nodes")
Cc: <stable@vger.kernel.org>
Assisted-by: Cursor:grok-4.5
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index e59f77eca83b2..0981a5e3af172 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
[ ... ]

While reviewing this migration fix, I noticed a couple of pre-existing issu=
es
in the DAMON migration code:

mm/damon/vaddr.c:damos_va_migrate_pmd_entry() {
[ ... ]
	for (; addr < next; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
		nr =3D 1;
		ptent =3D ptep_get(pte);

		if (pte_none(ptent) || !pte_present(ptent))
			continue;
		folio =3D vm_normal_folio(walk->vma, addr, ptent);
		if (!folio)
			continue;
		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
			continue;
		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
				migration_lists);
		nr =3D folio_nr_pages(folio);
	}
[ ... ]
}

[Severity: High]
This isn't a bug introduced by this patch, but does this iteration overshoot
the end of large folios?

If the current PTE corresponds to a tail page (meaning we are at an offset
into the folio), adding the full folio_nr_pages() to both pte and addr seems
like it will advance past the end of the folio, skipping subsequent, unrela=
ted
memory.

This same pattern appears in damos_va_stat_pmd_entry(), damon_pa_migrate(),
and damon_pa_stat().


mm/damon/vaddr.c:damos_va_migrate_dests_add() {
[ ... ]
isolate:
	if (!folio_isolate_lru(folio))
		return;

	list_add(&folio->lru, &migration_lists[i]);
}

[Severity: High]
This is a pre-existing issue, but does this isolation miss incrementing the
isolated VM stats?

Folios are isolated here and added to the migration list, but I don't see
NR_ISOLATED_ANON or NR_ISOLATED_FILE being updated.

Later, when the core migrate_pages() code processes these folios via
damon_migrate_pages():

mm/migrate.c:migrate_folio_done() {
[ ... ]
	if (likely(!page_has_movable_ops(&src->page)) && reason !=3D MR_DEMOTION)
		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
				    folio_is_file_lru(src), -folio_nr_pages(src));
[ ... ]
}

Will this decrement cause the node page state counters to underflow?

Since the counters weren't incremented originally during DAMON's isolation,=
 it
looks like a successful migration will drop the isolated stat and wrap it
around. This could hang memory reclaim since too_many_isolated() might
perpetually return true.

This also seems to apply to damon_pa_migrate().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726014815.1280=
757-1-dayou5941@163.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320723939C2
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988873; cv=none; b=dV32YzPJR3MVwqY19+5tSF2zkXeGDFBtsUjNc2Boeoa33ZAr9tXcYHPYvFmbmHvJePEcZ7FarUp3LkkTmTcxOo3m5WuwODuSE/J7LlUMBP2ClfEN3uFHiTruqRi8EHNBZxbGX9tEG4NnZbbLJgvrQv+eywXFLuGf3tzDDXkOwOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988873; c=relaxed/simple;
	bh=jDQoIXsbwOvjrCng4gu/qIcBGVt0XAmT1jLY6FGFHPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GFs4T6/dIjvPYpC30wI3fjfYKolydJ+gNXeiVYMmYFr0OAMzmwhP6tr+aTZBd0Dgcc7OLpXjqSNk4SrjGAv87G6TS8nKO8Ooq1Q8l1PGTSHe9emD1476+k1+heegK2aa1dzsg0pUF+dAtzk05SIiVg873ffWTcmpSH6YPBlYHAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLqneaHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLqneaHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FEB1F000E9;
	Thu,  2 Jul 2026 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782988871;
	bh=jDQoIXsbwOvjrCng4gu/qIcBGVt0XAmT1jLY6FGFHPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CLqneaHUQnfDsr8Ros6ioah1sLim3db0vkWifcflB5354Eeje4M7fdzy6bZv/RukZ
	 QRCkHBLd+5rtL10JPB81E4jq1wHpwcCX4jD8AK4/A5EChUiFUKiCqwRX/Ahyc+i/7u
	 zC/gnEnxjt8aqvlhso0+9e92Oi9dGJQFD7L1lPMAjAyt0Su+jbEza4uQdWXu4u0eD9
	 cQUeJgPkpjnXd5pEiz7W7nwo460+bkvbIj8GU5ez6LrWRVBdSoUy9EERJfHLFjhAtu
	 +cpga9gqpmlXmC0PBFNgr72a/AUvNi7ozd1M71jp2DsroZ8KV00lsCqoAwmEkf3xV8
	 6gk8FoJjljzdw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND RFC PATCH v2 4/5] mm/damon: introduce DAMOS_SPLIT
 action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lian Wang" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702094633.75658-5-lianux.mm@gmail.com>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
 <20260702094633.75658-5-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:41:11 +0000
Message-Id: <20260702104111.A1FEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] `damos_va_collapse` and `damos_va_split` redundantly process memor=
y and corrupt accounting quotas, while `split` skips memory chunks.
- [Medium] `damos_va_collapse` and `damos_va_split` silently ignore DAMON o=
perations layer filters.
- [Low] Unconditional use of `HPAGE_PMD_ORDER` breaks the build on architec=
tures without huge page support.
- [Low] Implicit default target_order for DAMOS_SPLIT triggers a kernel war=
ning on scheme creation.
--

Note: This report is provided as a free-form summary due to recitation
restrictions preventing the inline quotation of the original patch code.

Commit: bad86cd869e24f6ecf3b06b8afd727d7561ea5eb
Author: Lian Wang <lianux.mm@gmail.com>
Subject: mm/damon: introduce DAMOS_SPLIT action

This commit adds a new DAMOS_SPLIT action to the DAMON operations layer.
It allows splitting large folios into smaller mTHP-order folios based on a
target_order provided via the sysfs interface.

[Severity: Low]
Could the unconditional use of HPAGE_PMD_ORDER in damos_va_collapse and
damos_va_split in mm/damon/vaddr.c break the build on architectures without
huge page support? On architectures where CONFIG_PGTABLE_HAS_HUGE_LEAVES is
not defined, HPAGE_PMD_ORDER evaluates to a macro containing a BUILD_BUG,
which might cause a compilation failure since vaddr.c does not depend on
CONFIG_TRANSPARENT_HUGEPAGE.

[Severity: High]
Does damos_va_collapse redundantly process memory and inflate the accounting
statistics? It uses a local variable last_chunk to prevent duplicate
processing, but because the function is called per-region, last_chunk is
reinitialized to ULONG_MAX each time, causing it to repeatedly process the
same chunks.

Additionally, in damos_va_split, if a small folio is encountered or the
address is unmapped, does the address iterator incorrectly skip memory?
It appears to increment the address by the full chunk_sz (2MB) instead of
the folio size or PAGE_SIZE, which would skip the remaining folios in the
PMD block.

[Severity: Medium]
Do damos_va_collapse and damos_va_split ignore DAMON operations layer
filters? Unlike other actions that evaluate damos_va_filter_out on each
folio, these functions appear to unconditionally increment the
sz_filter_passed statistic. This might falsely report to the DAMON core
that the memory passed user-configured filters like anon/file or age filter=
s.

[Severity: Low]
Will creating a sysfs DAMON scheme for the split action trigger unnecessary
kernel log spam if the target_order is left at its default? In
damon_sysfs_mk_scheme in mm/damon/sysfs-schemes.c, the target_order is
zero-initialized. The validation logic treats 0 as invalid for DAMOS_SPLIT,
defaults it to 2, and emits a pr_warn, which might generate a warning every
time such a scheme is committed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702094633.7565=
8-1-lianux.mm@gmail.com?part=3D4

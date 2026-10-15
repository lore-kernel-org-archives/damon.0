Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42651411A18
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089330; cv=none; b=goUTKRzUfTBNmRCbfSdulQbp/a5qPLzl3nIR85XON78QucuT1GentfsnMrT413hiCRR9ZcSPYbuzJ6eJVDAr7cCBJtro9TmD7wJ9jzVH7g3knEr6iFUG8NI4wxQV8Eo8924uuI318WCWTF66S6k1GtUGhWO6T4DmvVzSLG8k+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089330; c=relaxed/simple;
	bh=VYdPySX+3h17NuXNf+00eU/6k0VT7mW+25WsBPymJyk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KXG6x/wqiXBpJl462zLDGlVBNpacrOVGMfYwscjnOkpIPPGxzwEPIQYXiOi0dsh1W8k5Bu+tKdxns3KZcglIswiBrQrlePfXP1qTbdn3SI1kLkw4uq1ilLmO2OP9CGIXc3kQJB+HptotG/WLnJIHASjnhpuLHe9/ccCS3aqCOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfqo343l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfqo343l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9039B1F000C4;
	Thu, 15 Oct 2026 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792089324;
	bh=8N1uJL1uc6YyRzsUibIgSdF8D1XSRj4fYGrBBAGA81U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cfqo343lYXl7vv//JHDl78MwPkllPZbH9HOp6hiUYm8QtqKpDONWw8pG+Ow2XZRu7
	 OdzoQwpkLZsagwBKRDy5C423oQA5ILzxLk3gapfN2vFyxaQgTq2sVYwraLInUbLls2
	 dc/ugRwosIahKyixwdgJvsVyU53IjeXsO3ikUfnBksDXFCGxqO0PmKwpyVndlJqe4O
	 4v7ft09vlul3caWQU1ibVqrBXPhpVhUZLrPPhqBivaK73iT/O0N6RHdIbG343wNEQF
	 EcQSgmi0M2htNg/ze7fO273YzywlZzQTp6uOt3EBBSPrz3Ls2CciHKCOjULUV0GlJo
	 +bz4nkRG8g2Sw==
Message-ID: <sashiko-outbox-173307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/17] mm/mglru: make folio_test_workingset() work
 based on folio LRU refs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-16-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-16-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:35:24 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> folio_test_workingset() currently tests the PG_workingset bit, which
> is only the second lowest access bit of the folio LRU refs count now.
> Folios with a higher refs count carry it in the LRU_REFS_MASK field
> and no longer have PG_workingset set, so the bit test misses them.
>=20
> folio_set_workingset() currently sets the PG_workingset bit with a
> plain set_bit(), which also over-promotes folios at a higher refs
> count: e.g. a folio at refs 4 is bumped to refs 6, advancing it
> toward LRU_REFS_MAX and an unintended generation promotion on the
> next access.
>=20
> Move the test into mm_inline.h as an inline helper based on
> folio_lru_refs(), checking refs >=3D LRU_REFS_WORKINGSET.  The set
> stays a plain PG_workingset bit operation reserved for the
> classical LRU: under MGLRU the refs count is maintained by
> folio_inc_lru_refs(), and now triggers a debug WARN when called
> while MGLRU is fully on (the switching window is exempt, as the
> classical paths legitimately run alongside MGLRU then).  The one
> PageWorkingset() user in erofs is converted to the folio helper.
>=20
> Under the classical LRU the refs count is not maintained, so the
> test falls back to the PG_workingset bit test, which is the old
> behavior.
>=20
> Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D16


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C23BCD05
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200095; cv=none; b=OSXlm+oZqQMOhIFc/qVKSwPvck94E8RGn/Wn0m1fUhKBx5DVhDZk0KXb8IMFqTSfa7WcfwMtoNhgB65DnKD14vALOr/qPNYR5Ao2n+yhv0axF2LGp40qWiAX7XvU82knyF8DP+J5F351QfQGR5jDqJPbLnYLVWbHj5227rlPPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200095; c=relaxed/simple;
	bh=iGmuc4CmScGA/6tEZdkv5Vq3245P2N5tMmR5FUWNofk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bsIfESH1/q+BtYN6pNT1Mr91GXpfKspR3Lm8nMgUD1CE+LnVX+6GpVuK529yzyv04yCzkTs0kJ8Orz4GF30XE628dE0Gp1I5/9tFL7Q7w+7cEkX+NCGgBis9yx0BwhUSvYB2MdpIRUgi68GPXpTfFJcXy/w7RAIOHrYXeoNWB8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFJPdscs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFJPdscs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E934C1F000E9;
	Mon, 31 Aug 2026 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200094;
	bh=MkOo+fFeNfSE30V9qLuyaGgIjZ+S1tHg29XYJAHdOtc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFJPdscspiCd2M03jc2/uOlFOXgiqvD/E6couDfOPFupCsIQFKperha3PYXCHYH45
	 U7+ub8ZQT6WYmM4PHVyoplk4V2PWlNHiReSWaPxeBLMyAGpQUjC36obT10SEyzPEgr
	 JCwMtpxAeDjICjH62T3Y9co3mUMl2mObQ9DdT0hbxx6AXt/o2qCi9tjLt5/gUgKMXh
	 2wbBov0ZAq2/P1DDG+KXyMVGt7WKeoQQfzzFJmGQvm8P0cYdO0HXcXImhbKNwAwJeB
	 n0jr2TT1oc/WsDGnxI0IYFmx0Eyo3wDlVcoFVdLOrUSxQDtSWNrpLLvKZJaGvRx+qq
	 hoisEkfHl2z/g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 4/8] mm/damon/vaddr: respect folio end for
 DAMOS_STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831140254.72004-5-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
 <20260831140254.72004-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:14:53 +0000
Message-Id: <20260831181453.E934C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> For applying DAMOS_STAT action to a region, DAMON virtual address space
> operation set (vaddr) calls walk_page_range[_vma]() for the region.  The
> pmd walk entry function, namely damon_va_stat_pmd_entry(), applies DAMOS
> filters to folios of addresses of the region in the pmd.  It starts from
> the walking address and advances the address by the size of the folio of
> the address until it goes out of the pmd or the region.
>=20
> Let's suppose it is for the first pmd of the region, and the region
> start address is in the middle of a large folio.  Also, the next folios
> are small.  Then, some of the next folios could be skipped.  Fix the
> issue by advancing the address to exactly the start address of the next
> folio.
>=20
> The user impact is that the DAMOS_STAT-based page level monitoring
> results become inaccurate.  Since the page level monitoring is supposed
> to provide relatively high precision, this is definitely a problem.  It
> is arguably not critical since it is only monitoring quality
> degradation.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org
>=20
> Fixes: 63f39737d1e3 ("mm/damon/vaddr: support stat-purpose DAMOS filters")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831140254.7200=
4-1-sj@kernel.org?part=3D4


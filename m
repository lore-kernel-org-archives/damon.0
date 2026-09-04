Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AB1BC2A
	for <damon@lists.linux.dev>; Fri,  4 Sep 2026 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482312; cv=none; b=sdSKUS69+fvgvoyXGO0sO/WkvWsYdo5GOA5leElSXOZj/KxUsQsypIcZ4kVPV++xQe/oARZCIJ0TxoExKW5JlF3sjYsoobqKzTrypAvyrJXy1x1t51j4SJwoZhL1G5KcKhj4cXm4MUpJQgT5/kGsuo1Xqw8/2+PgqPRJyqU8kRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482312; c=relaxed/simple;
	bh=Dhr1581kj0ATcWVGxID2pQTyl+8rL/G0+J0WZW2/gzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hCUFMphZPwOS/vuFdqUu6/Wz5waEuN29NCoPu31xgGp3icOoqPiHORWJksUmSmlojvODAMY98grs+BXfIb/AVBitLoQLFK9AQpMNyh/XzN9iUGsiJH41xmGbHIoHKgv7c4INwdQ49Fd5oV0Ey8K9fKy4lfkYSeQ5H3jB9s+Thts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3pKw0qy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3pKw0qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174C41F000E9;
	Fri,  4 Sep 2026 00:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788482311;
	bh=z1sBaHPwUZuXDolQC5u/ZlSfhiFSBSslEeAnzWi3B1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I3pKw0qyS3fWDmk3kssqJ3ZJhJJRI6ceMwd7+AvVgB/uAaicKo1TZxlr+6+nfIjGM
	 /yQDLYxN+tKudauqsv5WuXb82nN6EiMjGTZrKcYVIyf06r+hDG2k7GUEqYbuWJmC8I
	 I3pkLS2stpcvdW2uRfgp+b3imd9gJn9xRTqBg16pzTAr7xf/BQhZ6H3r9a7+0r1W3K
	 sWqCMMyhcj8qqNpsSsEglo1uHMBzxl0muRRl75UAmTcsa58bVW6Ya7t8IrRafAWi1Z
	 g8ZT6Vq7SKCRr04G/f492QzolPs040BIHeEX+EybYR1S6sXNxCm3f9knWoGU8KBtt7
	 CG3dbxJJLXVHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] mm/damon/ops-common: use a page-aligned address in
 damon_ptep_mkold()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260904002829.116381-1-sj@kernel.org>
References: <20260904002829.116381-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 00:38:30 +0000
Message-Id: <20260904003831.174C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Nathan Gao <zcgao@amazon.com>
>=20
> __damon_va_prepare_access_check() picks a random byte address within the
> region and stores it in r->sampling_addr. damon_va_mkold() passes it into
> a page table walk, which hands it to damon_ptep_mkold() as the address of
> the page to sample:
>=20
>   damon_va_mkold(mm, r->sampling_addr)
>     damon_va_walk_page_range(mm, addr, addr + 1)
>       damon_mkold_pmd_entry()
>         damon_ptep_mkold(pte, vma, addr)
>           ptep_test_and_clear_young(vma, addr, pte)
>           mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)
>=20
> For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
> [ ... ]
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Gao <zcgao@amazon.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904002829.1163=
81-1-sj@kernel.org?part=3D1


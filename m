Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C593905F0
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199601; cv=none; b=bYcI/gzYCqro+xr13B1Ep1JbBFCKjJOuRphhnv4YED5YGCEqgIA42V2tv4coSeDoftCVyYuHG4x3GyYno+d3LZ5p9HnNoSGtqyPLfACFSbQvo2NAk+hTe3bWwpXByI06Db8QzelbsEkXdtJ3riaUcmG1lSGzUUNc/nM1mGWFNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199601; c=relaxed/simple;
	bh=m7LK2HJR9ZZEGD3uPm6vL/9b0VBERaZM0+KM+Q1phyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G4GgVBBK4gzN2GadfEan5vm/ehKMG+ioNDn3+AUl4QPjGjqlZhi1l6lyfAaCqEFMtMsog7fo6VshaxzOdEHZGv1xl7Gu3o9bhNYCY0hF/ZVAxk5orgaDNu36uQfn4Ix/3qR6k/bwF0w5gaX2Tp8N9NnH940PCxcTcScCjGS24Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImB5HHGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImB5HHGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F3E1F000E9;
	Mon, 31 Aug 2026 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199600;
	bh=vD6b/XP1+caitxF9xEXCDHoqHRzcFU0ockdXFUpolQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ImB5HHGgmPhU8cUYjxzuU8YR8OFbJ2aIQ1wVd1tfB3EdD2ZS+WjJ0x7DIsR+9p22j
	 KLjp9mBQGaM0dGhJjqA7VplNI1TrmHI6vx2J/oR7ScdoS/nKSdkCAVlkzIyyBsI49L
	 V70TkkVpTtihu+dCaa8ZDzy4Fd0nzyWaRD+TdwV1CeMYfIUscl69JLiPPw1Cc7X4zw
	 RZA1RrCaBGaaYLEJTpWpKxLnUhcy8NW7VhEMnJ6Qv3ye4hNbwgLMJphtMcnxJdgK7B
	 s2AlDtBFYpm5fKH8WhOf1GdL/lAKvIG4IOB4/s2DGhy8y6uj7iw21Cu9KUaGy5lsJd
	 t+kNAyYPP4ypA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 3/8] mm/damon/paddr: respect folio end for
 DAMOS actions except STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831140254.72004-4-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
 <20260831140254.72004-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:06:39 +0000
Message-Id: <20260831180639.C9F3E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> A few functions for applying DAMOS actions including pageout,
> lru_[de]prio and migrate_{hot,cold} in DAMON physical address space
> operation set (paddr) collect folios of the given region by getting the
> folios of region-internal addresses.  Then, those functions apply the
> action to the collected folios at once.  The collection starts from the
> region start address and advances the address by the size of the folio
> of the address until it goes out of the region.  If the start address is
> in the middle of a large folio, and if the next folios are small, some
> of the next folios could be skipped.  Fix the issue by advancing the
> address to exactly the start address of the next folio.
>=20
> The user impact is that DAMOS action is applied to less than expected
> amount of memory.  Given the best effort nature of DAMON, it is no big
> problem, but it is clearly a bug that is better to be fixed.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org
>=20
> Fixes: 3a06696305e7 ("mm/damon/ops: have damon_get_folio return folio eve=
n for tail pages")
> Cc: <stable@vger.kernel.org> # 6.15.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831140254.7200=
4-1-sj@kernel.org?part=3D3


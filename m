Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02C429CF3
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268976; cv=none; b=UM2YvHMM36wnosiSdIe9wmwqfAH7vV4wzuJ6h4eKB9DDr96+YIbMdtrEpjeMOn9hhnPOPGO3QnKJnlrqacJP+jybEsZkQl1iYF9SOP7xjyhC8ldQ4Lo46fey7hMnnJNPAL5NcDqztk6/e1l+1k+ZH5zH120PEnzFDH1H2kZZCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268976; c=relaxed/simple;
	bh=1MFxyuAjpVL3sNFMFEwRIWII1I+sZ8yXsfXdedMLKRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IE4wnqIf18Du8lyjLCY+T0jmV3dwy0nFTB4e+k04AGXsdZ5Aml1W84OEOdVIgTH3VGzH2w+LjiYqzav5JBr8tHP8Yg8deNxNA8fUWz1IsKQg3kxJOxa7QXAYk50599ZjQWHCr4Eu920uKa/3MWZyIX6i6SenqgaxmySYOrZdaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrjSCbWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrjSCbWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E035F1F000E9;
	Tue,  1 Sep 2026 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268975;
	bh=doCI1UdbAfcs08xR5gttgoa5/XnSdVYPacpyXIRXgnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PrjSCbWzXL23/jqeVaSYwlmkeuEAivRdma7MQHU/IxcKtoYhU+CtgCg41Wt1w2iNI
	 TJ2yb1sn/zuaRZrcnENYqFJCL5e+rAZ2KxGIgcBSww/N5xgAmWWpI1QIQ2w5LkZ99z
	 k/x6s3dBfT34KoO5o3p+n1k+i776A6DH0FwbpHpgwwe6evtEMhViAQLN6v0qw2vG+q
	 cWnCb8KyLW7I6WjPLcrDItz7Owbd0CWusYcKqsNzVigO/hG2s+S2X/ZxnbHEIzt6bl
	 jU3kRPoFP1ls0W3nyL5bSoA2HlyL8tVQoj5VQ0MfcVl2YfvJQM51Q+Fmkito+GWLsV
	 fpwLqqTjfmE8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] mm/damon/paddr: respect folio end for DAMOS actions
 except STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131326.97615-3-sj@kernel.org>
References: <20260901131326.97615-1-sj@kernel.org>
 <20260901131326.97615-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:22:54 +0000
Message-Id: <20260901132254.E035F1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131326.9761=
5-1-sj@kernel.org?part=3D2


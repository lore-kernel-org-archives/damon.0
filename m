Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACDF35CB95
	for <damon@lists.linux.dev>; Tue,  6 Oct 2026 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269925; cv=none; b=pa/VaAIzK5toxR4gx1eZHjzSI1UCQJf4XzJ5gr+kIAm4Cgeo8YQnL8Mew9EOOb1uEJtlptnxxc97z3kM5y7nJLnlkOAgd9Pr4PiLnO488/cO9eqk6ZdgyXcLOoLDIuDmIY0QScLF8YvYfeN0eySyxCDUEyXV1xQN/iafKUeVecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269925; c=relaxed/simple;
	bh=CNBmojB3IYfPTE2TDoSWqOdRlm15mn2JaOvwF77Vtr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G96KaljlyZnVgRELZJXyvkdU0nP+j2Tk+nc2I3+3xnHm6LOKCKZaBw+hdpcBBKsUtloElsqAau0vtIFoeLvikjFB8lpob+EgrGyYX4wqMQokXcED2A9Q9buJS5Hh8NHAfLAH63dfrNCl+kEpWt9euxrpZQneopLOn3pVVg7KoUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGjv2rjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGjv2rjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB521F000FF;
	Tue,  6 Oct 2026 06:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791269924;
	bh=afI6c6/Vc5cbh3hcR8zxBoDClUXmAqkWQJ1QdBx2IwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EGjv2rjQQah2uJQ0FNMqqW5vwbsFHEkjdReOitZDZnXhfYvRrixWCTFv2RILLyYMB
	 VXr1idKGr4idnDMC4/R9Yvj0mghRgLgC/a+jLobaTyt5Hu01zONuVs6pDyuxcqAZ2Y
	 QilpynFoFd9lVL6uuwSdYA4uthpcWgySmcv+QF/1uRYV81/KDn41EqvqbrXRySLiyL
	 gLpwO25oZ4A3U6JZt0qJxh0eLjH0oSwQgdWoOXwVD7e5wbPX5zMlQYypraC2LVcenw
	 4zCSfy/yMNE9cDgThWmRdt/KGMLQBbriwxvUMyHk5METY/BhS0Cb3nTLlltkPJsrMC
	 Hej2VlTcfMiDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] mm/damon: use damon_get_monitor_folio() for hugetlb
 entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261006065209.41507-3-sj@kernel.org>
References: <20261006065209.41507-1-sj@kernel.org>
 <20261006065209.41507-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 06:58:43 +0000
Message-Id: <20261006065843.DBB521F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Gregory Price <gourry@gourry.net>
>=20
> Hugetlb folio acquisition is open-coded in three places:
>   - damon_hugetlb_mkold()
>   - damon_young_hugetlb_entry()
>   - damon_va_probe_hugetlb_entry()
>=20
> DAMON already has damon_get_monitor_folio(), which paddr uses to
> get monitored LRU and hugetlb folios and to filter them through
> damon_folio_acceptable().  These paths bypass that check.
>=20
> Use that helper in these paths too, so that DAMON acquires hugetlb
> folios and applies its acceptance policy in one place.
>=20
> No functional change intended. All callers reach these paths with a
> present hugetlb PTE under the page table lock, so the folio is always
> a mapped hugetlb folio and the helper always returns it.
>=20
> Cc: Gregory Price <gourry@gourry.net>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006065209.4150=
7-1-sj@kernel.org?part=3D2


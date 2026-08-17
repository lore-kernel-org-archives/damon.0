Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A832B989
	for <damon@lists.linux.dev>; Mon, 17 Aug 2026 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948878; cv=none; b=rIUeo41tslN00JOQAy+QciEDHaw/hGmkTTrvBLpyxEtnlgWQ2/+04wpqKLHWKT7yx8nVO0LvnSzQsizohTTQqxcMe0PRJI4VghzTfD0QOV/08ZMVsPUSw7plABUM7L/qAOjGeiyeLLUoPBHRkcULOABAgQqvpj9o6GjJtkPL4aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948878; c=relaxed/simple;
	bh=9+QGpIiM/bqc+qOn22GKy+iHO0ZRG3eOAwuAeuzditA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i5Pz8RzO4VekP6Ug1M0rzO2IREi5d2mzfCj3jmwAnu3pbfjiWHT6ejNQEs+j6e17SblnRar8FZhJFGITqgIrwgxDuqCQ4s4Ly2DsHbczQA/pCJYpaoUO0wBwXVO2KBYiTIPrXPmKaRms8axi1niz6zriaMQRpeTnQP+H3eyvXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLCTzEPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLCTzEPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3581D1F000E9;
	Mon, 17 Aug 2026 06:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786948877;
	bh=YEL9T2YaWdU+bIoPoU2FRvfoFZQrxaDcXtS/QDkQ8zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dLCTzEPNDC4SrajtqOioQIaer1qxxLZ4oQTwY0kBmeDrh/IINAaGN/NqoFJ4e0O1u
	 7+hkcmqt6dAaB5GqOglWtScgCk0C4bh7zvDXisPCJwYheKSJOcIt7TCGeR2gy0a7VN
	 PzrIzgJfjXrerHf6dhocC/qP5NQM1zie9S6Y/2ae5ipiLieuQoqoiohSnpfGHcKQ3M
	 k7XGvDPSFZfSLUPsEEIJHlj3kOwiH2Ne36qDfV6ItEGbx2DXqumNF+AqqXn9tX0XXB
	 XScALcIks9RBFeyaT+tv2NnOKXqKbQf0YAJoJK/kO7AAA+mQHEsM/UdDgssdxK1nph
	 x6KFLWs6MImWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/ops-common: factor out
 damon_putback_folio_list()
Reply-To: sashiko-reviews@lists.linux.dev
To: dayou5941@163.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260817063458.351063-1-dayou5941@163.com>
References: <20260817063458.351063-1-dayou5941@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 06:41:16 +0000
Message-Id: <20260817064117.3581D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removal of `struct folio *folio;` declaration causes a compilation =
failure in `damon_migrate_folio_list()`.
--

--- Patch [1]: [PATCH] mm/damon/ops-common: factor out damon_putback_folio_=
list() ---
commit b95b21fa4d0d8990d47609474f8cee2aa7d640e1
Author: Li Youhong <liyouhong@kylinos.cn>

mm/damon/ops-common: factor out damon_putback_folio_list()

This commit factors out the duplicated putback loop in
damon_migrate_folio_list() and damon_migrate_pages() into a new
damon_putback_folio_list() helper. The commit notes state this removes
the need for the local folio variable.

Link: https://lore.kernel.org/all/20260724060707.CE1F81F000E9@smtp.kernel.o=
rg/

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index fbda70d8ea4d0..f9cfd35bee722 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
[ ... ]
>  static unsigned int damon_migrate_folio_list(struct list_head *folio_lis=
t,
>  						struct pglist_data *pgdat,
>  						int target_nid)
>  {
>  	unsigned int nr_migrated =3D 0;
> -	struct folio *folio;
>  	LIST_HEAD(ret_folios);
>  	LIST_HEAD(migrate_folios);

[Severity: Low]
The commit message notes that removing the folio variable here won't cause
a build failure. However, does damon_migrate_folio_list() still use the
folio variable in its first while-loop?

Looking at the remaining code in damon_migrate_folio_list():

	while (!list_empty(folio_list)) {
		cond_resched();

		folio =3D lru_to_folio(folio_list);
		list_del(&folio->lru);

		if (!folio_trylock(folio))
			goto keep;

Will this cause an undeclared identifier compilation error since the variab=
le
was removed from the function scope but not re-declared locally inside this
loop block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817063458.3510=
63-1-dayou5941@163.com?part=3D1

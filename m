Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B43815F9
	for <damon@lists.linux.dev>; Fri, 24 Jul 2026 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784873231; cv=none; b=a6XHsJw/Szxb7ppTzIOdW8K4toNsuMxi8SUZAas4l6hxDk0pA2uydm3LSQoDsoIbJMkWdr1mNFdtY4aRu5MS0/cPD+eV+EGQwTMS4KxA9nsMzJjjEGUJjjffw86fUmZRU53wCS5ZVgUtGIcJZIYmAFkygBghXW+aeYdVZSAU7vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784873231; c=relaxed/simple;
	bh=MDSiIP4mUxRJ+QSX3xTIYwcO6ZMXBKaYhMJiqn/k620=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gripHq5Muj7cBYM/mslo/KxrI3uLDkGaimEtxeJANzi4sqDDImsN+uYMtC9D+fVpfourl4lWivjysaWzAvNSN8A7svuSE7mPwBi00mFH031/3jvBdXJRwmIt1iw2vIGoASzVtMc12o/gZgfZM3ntfAMCTJa78fBU82mtHN/XbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0sZS2Cy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0sZS2Cy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1F81F000E9;
	Fri, 24 Jul 2026 06:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784873228;
	bh=TxfZBQ8ZpE5nPXYs5bIi4bV+smIy+gk8t+H/aAFxG2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L0sZS2Cyn4jC6owK4VPvVgl22k3DzEbIoxZxk2ZeN8oG0LBcpEpvp8q8dezlBYAx0
	 7gE/nkGf6AOGo5B4HXXmYlbxztbgMqbmLgZ996fuBaq3ADMUVJviTy4x6HtCV3WoTa
	 1RkcQrjY1YB15p4xXQsHSssofCtcL7NeC+j2D3nP/dPX3iqGJGx8VF7Bltblx7r7pq
	 7NDAqgxj4dS6/0retpQBXZS6Kxpq9yZBqicTzw93fY02055HZGIO4pP2Rw3vf0ybYF
	 nJAOm7+UGRJgU7gIHqdiNdAslS53W1yumtZrF9NLhpxiWoratlq7qZ3+4+By8syF3R
	 xtv73LOmSsB5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/ops-common: factor out
 damon_putback_folio_list()
Reply-To: sashiko-reviews@lists.linux.dev
To: dayou5941@163.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260724060135.3014676-2-dayou5941@163.com>
References: <20260724060135.3014676-1-dayou5941@163.com>
 <20260724060135.3014676-2-dayou5941@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 06:07:07 +0000
Message-Id: <20260724060707.CE1F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removal of the `struct folio *folio;` local variable declaration ca=
uses a build failure.
--

--- Patch [2]: [PATCH v2 2/2] mm/damon/ops-common: factor out damon_putback=
_folio_list() ---
commit 44363c3cc00338e3c3445bc5730a2655a4c0fded
Author: liyouhong <liyouhong@kylinos.cn>
mm/damon/ops-common: factor out damon_putback_folio_list()

This patch factors out the duplicated folio putback loop from
damon_migrate_folio_list() and damon_migrate_pages() into a new helper
function, damon_putback_folio_list().

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 0981a5e3af172..4b99c31122d6d 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
[ ... ]
> @@ -330,12 +330,22 @@ static unsigned int __damon_migrate_folio_list(
[ ... ]
>  static unsigned int damon_migrate_folio_list(struct list_head *folio_lis=
t,
>  						struct pglist_data *pgdat,
>  						int target_nid)
>  {
>  	unsigned int nr_migrated =3D 0;
> -	struct folio *folio;

[Severity: Low]
Does removing this declaration result in a build failure? The folio variable
appears to still be used in damon_migrate_folio_list() during the initial
loop over folio_list:

	while (!list_empty(folio_list)) {
		cond_resched();

		folio =3D lru_to_folio(folio_list);
		list_del(&folio->lru);
        ...

>  	LIST_HEAD(ret_folios);
>  	LIST_HEAD(migrate_folios);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724060135.3014=
676-1-dayou5941@163.com?part=3D2

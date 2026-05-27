Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F403FDBF3
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882199; cv=none; b=kG1D3ihX1zjmzg4sHrSdUkJY/bzNThQ/5ykLK1eaZm2m5PwlcSnFxr/OtGr05j2TEt1AyOn7LbAX+ThChB9CeH97PdtNPMD2QAPeuJHNPGVrrX/IubWQ7I7FheouCKtcb0o1YXzy5jkaHqxUQb5sxOCH6r0f6kYYSsP6vM9IQhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882199; c=relaxed/simple;
	bh=PWw7wEc5hBK9ZpOe9sMBNpz1nnOvTFIoyHCcu4mVzKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WnhiZjy7lXlqGvCfEreB/1ESpmbZV3nIiMa4aw01odhBYgjGFqy1blnXZdIDgiDjlMuS7zO5ohslaOAM86rITSTEXEAtMLgOjZD3h5P/Fa7fK4Zgo6f3QddoDFuqwlgx16mZPiExYvL6gMFCUoi40hpye25GhxpkVdIUlhe613s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkLUD7of; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkLUD7of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A50A1F000E9;
	Wed, 27 May 2026 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882196;
	bh=UwCRVxgUThr2PO25wOcBO3cybf9azgkbCrv/oJlM4PY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YkLUD7of2TrWz3OArDX1X68S8z6taJKB8LpdgzQwigJ0+9WYm8cTzF3EWlGA46L4T
	 ouno5lBetCx1/lLLGUU+D8qYREvcRjlLaSjOHcJ8j5PvnjZRbE+Z6twxChZdNizFAr
	 waCoEys41x9YyqnpmeVbz5xc25TqmLD61o3BfaZcWqEzLgSTrhCPI57JygW8zmqeAf
	 vlVVgKas4VxakU8tX4ff7J6TwWSrgPcvOLY09AjB1WyazNw2WsJk5P+GCx01LonuLj
	 QUHGwFuf3Wh6EOcegE7fD/DBM+ePlBxXpaP/t9GkBXindrjqcRr7qCGlKiaSiQuVZA
	 CR7i4PqnEieLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] mm: replace direct FOLIO_MAPPING_ANON usage with
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-8-tao.wangtao@honor.com>
References: <20260527110147.17815-8-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 11:43:15 +0000
Message-Id: <20260527114316.1A50A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Incomplete tagged pointer filtering in `gup_fast_folio_allowed=
()` allows non-anonymous tagged pointers to fall through and be dereference=
d, causing a kernel panic.
- [High] Calling `PageAnonNotKsm(page)` in `stable_page_flags()` bypasses t=
he page snapshot, causing speculative folio access in a PFN-scanning loop.
- [High] `PageAnonNotKsm()` incorrectly returns true for file-backed pages =
under `CONFIG_ANON_VMA_LAZY`.
--

commit 31e536094ea4838e96a754bf6847c942608b9162
Author: tao <tao.wangtao@honor.com>

mm: replace direct FOLIO_MAPPING_ANON usage with helpers

This patch replaces direct uses of FOLIO_MAPPING_ANON in external modules
with helper functions in preparation for ANON_VMA_LAZY.

> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index f9b2c2c906cd7..93ddfda9fa1d2 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -163,8 +162,7 @@ u64 stable_page_flags(const struct page *page)
>  	folio =3D &ps.folio_snapshot;
> =20
>  	k =3D folio->flags.f;
> -	mapping =3D (unsigned long)folio->mapping;
> -	is_anon =3D mapping & FOLIO_MAPPING_ANON;
> +	is_anon =3D folio_test_anon(folio);
> =20
>  	/*
>  	 * pseudo flags for the well known (anonymous) memory mapped pages
> @@ -173,7 +171,7 @@ u64 stable_page_flags(const struct page *page)
>  		u |=3D 1 << KPF_MMAP;
>  	if (is_anon) {
>  		u |=3D 1 << KPF_ANON;
> -		if (mapping & FOLIO_MAPPING_KSM)
> +		if (!PageAnonNotKsm(page))

[Severity: High]
Does this code reintroduce speculative folio access on the unreferenced pag=
e?

The stable_page_flags() function is a PFN walker. Because the pages being
scanned are unreferenced, the code safely snapshots the page and its folio
state before accessing it.

The original code read the mapping from the stabilized snapshot. But
PageAnonNotKsm(page) internally invokes page_folio(page)->mapping on the
live, unreferenced page.

As documented in the MM subsystem guidelines, accessing folio state without
stabilization in a PFN walker can cause a VM_BUG_ON or garbage reads if the
compound page structure changes concurrently.

>  			u |=3D 1 << KPF_KSM;
>  	}
> =20

[ ... ]

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 5c10bf5db26fc..e2332aefa48f7 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -738,7 +743,11 @@ static __always_inline bool PageAnonNotKsm(const str=
uct page *page)
>  {
>  	unsigned long flags =3D (unsigned long)page_folio(page)->mapping;
> =20
> +#ifdef CONFIG_ANON_VMA_LAZY
> +	return (flags & FOLIO_MAPPING_FLAGS) !=3D FOLIO_MAPPING_KSM;

[Severity: High]
Will this macro return true for standard file-backed pages when
CONFIG_ANON_VMA_LAZY is enabled?

For a standard file-backed page, the mapping pointer is word-aligned, meani=
ng
the lower bits are clear and flags & FOLIO_MAPPING_FLAGS evaluates to 0.

Since 0 !=3D FOLIO_MAPPING_KSM evaluates to true, the macro seems to
incorrectly evaluate to true for file-backed pages. The previous
implementation correctly returned false for file pages since 0 =3D=3D 1 is
false.

> +#else
>  	return (flags & FOLIO_MAPPING_FLAGS) =3D=3D FOLIO_MAPPING_ANON;
> +#endif
>  }

[ ... ]

> diff --git a/mm/gup.c b/mm/gup.c
> index ad9ded39609cb..69dda325b082f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2792,9 +2791,8 @@ static bool gup_fast_folio_allowed(struct folio *fo=
lio, unsigned int flags)
>  		return false;
> =20
>  	/* Anonymous folios pose no problem. */
> -	mapping_flags =3D (unsigned long)mapping & FOLIO_MAPPING_FLAGS;
> -	if (mapping_flags)
> -		return mapping_flags & FOLIO_MAPPING_ANON;
> +	if (mapping_is_anon((unsigned long)mapping))
> +		return true;

[Severity: Critical]
Could this allow non-anonymous tagged pointers to fall through and be
dereferenced?

The original code safely captured all tagged mapping pointers by checking
mapping_flags =3D mapping & FOLIO_MAPPING_FLAGS. If the pointer was tagged =
but
not anonymous (e.g., PAGE_MAPPING_MOVABLE which uses bit 1), it returned
false, avoiding further processing.

With the new code, if mapping is a non-anonymous tagged pointer,
mapping_is_anon() evaluates to false, and the function falls through. The
subsequent code explicitly assumes the pointer is a valid
struct address_space * and dereferences it (e.g., in
secretmem_mapping(mapping)). Dereferencing a tagged pointer directly causes
a misaligned memory access, leading to a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D7

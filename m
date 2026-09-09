Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F82D0629
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932915; cv=none; b=a+CjjNsLiGAmMIctonqp9tcZ1fE19/GrMWU50tFdJuXqbxcyUU/vkZOIl9hfNYRt5UXlt3uFSM6DIthLKEe4lPc2MBftnM6LzHfEv3rDSfB62dmn5J5v6n/NLd4zuBHiau5UNsSRECUiqvkpt0/EbE6G4W99rh1o6w4YbGZueUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932915; c=relaxed/simple;
	bh=A0B+kwC9WVX1NupvJkgEuGTxsdh7aSfCUALhNWtkos8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LW0D2ULj1BtHQK/SNzU3xMdMFFoJN6TIxROQILKgB9CXBZEK+qrzbqbSH+0+t7EHewQQkbAaOOW7Qde4VxE0dmVslNJ1AC2Z0UWMT5rUTik2vlrKR8V8N2N4rpBZQ42irvcx+3DsaFySRKa1by05uaSfBSODRnK3SSKL3IgDMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXKGqz57; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXKGqz57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A262E1F00A3A;
	Wed,  9 Sep 2026 05:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932913;
	bh=uSdWkkZAOC7733gc3u53sxHy3ZZAIerAk5twWpbBGps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gXKGqz57mP8gTEKVK0F2ewnK/HsaMaGNRNESENrNjTVOZMwKNEM6u6AmqaeYzhdnV
	 gwK1NCndZU6pMQ6bTBFw8Z38DXaby7hH1tP3t1jixlGrAV4sySpOTXUKwALUdvU8DX
	 70e7wh2BJ9F7ETrvQNL0nahYG2jF+SESPlARQ2aWKPGiQigWCl7ASe6g7oQ/7UzjRW
	 F05ioXV5bRxEnGxCdv5yDL371CsJbZ2dgbLkVZNOLA0yMcbEUkUG4ZhhSDpum3HeIQ
	 iz/mzxQ5WvebLloKWUWvQSyUy3Li1BXZ6r2v6a9ahsqXmONrBwlAc862IKQrDQyAsv
	 IyH6KlIIH/6pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/paddr: drop last same folio access
 check reuse optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909053646.245843-1-sj@kernel.org>
References: <2026090852-morally-preview-efa5@gregkh>
 <20260909053646.245843-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:48:33 +0000
Message-Id: <20260909054833.A262E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a pre-exis=
ting TOCTOU race in `damon_folio_young` where an anonymous folio can be con=
verted to a KSM folio after lockless checks, leading to `rmap_walk_ksm` bei=
ng called without the folio lock.
--

commit fca283b4eb28ba2daec6fc0d0f8aed873b1ec9ca
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: drop last same folio access check reuse optimization

This commit removes a race-prone optimization in damon's physical address
monitoring that attempted to reuse access check results for the same folio.
The optimization provided doubtful benefits while introducing potential rac=
es
when multiple kdamonds run.

Link: https://lore.kernel.org/20260715031002.108504-5-sj@kernel.org
Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index d4a4d51750f5f..a6b1de97b1e8a 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c

[ ... ]

> @@ -157,7 +157,6 @@ static bool damon_pa_young(unsigned long paddr, unsig=
ned long *folio_sz)
>  		return false;
> =20
>  	accessed =3D damon_folio_young(folio);

[Severity: High]
This is a pre-existing issue, but is there a time-of-check to time-of-use
race in damon_folio_young() when handling anonymous folios?

When damon_pa_check_access() calls damon_pa_young(), it takes a speculative
reference to the folio and calls damon_folio_young(). Inside
damon_folio_young(), the need for a lock is determined locklessly:

damon_folio_young() {
        need_lock =3D !folio_test_anon(folio) || folio_test_ksm(folio);
        if (need_lock && !folio_trylock(folio))
                return false;
       =20
        rmap_walk(folio, &rwc);
}

If the ksm daemon is concurrently processing an anonymous folio, could the
lockless check evaluate to false just before the ksm daemon updates
the folio with the ksm flag?

If that sequence occurs, damon_folio_young() would skip acquiring the
folio lock and call rmap_walk(). The rmap_walk() function would then
re-evaluate the ksm flag, see it is set, and call rmap_walk_ksm() without
holding the required folio lock.

Could this lead to a panic or data corruption when walking the ksm stable
tree locklessly?

> -	*folio_sz =3D folio_size(folio);
>  	folio_put(folio);
>  	return accessed;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909053646.2458=
43-1-sj@kernel.org?part=3D1

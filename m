Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC935E93E
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933374; cv=none; b=Aj5t5/RcDmTlkS83kJtCAABYoZcJPsMQ9bZRFWM6iE/QO4hJ4WJY+HiZP7af9y1z0Q0b5GLQGEc6ngJh78T0H3vc2wM1e7Xh/qWEGrr5RZ7KiGJIXmK3qVol8KsdSfDP0oIyOG2trmysxamZSfyuh8TCpm0Z5AkjhQpBSmLI4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933374; c=relaxed/simple;
	bh=SgnfopaEl3XME4MAu7aYCWExP2mDH4XsV//2te4WB7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b8UFKUG8IOqugEBHPflSPSdXvzs4LTtLCxxNvd/6PijrkSJklX5O+vio50LjzuEarVopqC7U+a/YZWqKqjjXeNFDDGS/3MjAEnQljsljNNEzJ7ItvkUAPPdmVxJuvnkr1A8FBP94p27rTuKJCyWEuWPNCcplxBT+qLPXeEJYTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvYnaB3a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvYnaB3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31801F00A3D;
	Wed,  9 Sep 2026 05:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788933373;
	bh=AFQ1xylIOQoEVCskyy2BlJ3nkK0lQWURhAqsPquKutw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FvYnaB3afDw/fkUO3uxbkn+YHZr4AAInMQTSY/xA/wFGkuzAwWQoCdJE90oHAjZmw
	 JuINNgz13CX/sT+aoAkm6lKAspf8LVMwyecdxVOExDl+3xMrKE6AVJsgxpWkOimzjp
	 VPkyz8Mt5GsJDk4w8mk0d8cV9Z2xK2KQNItdXopPEIwthDOz4nvX9O0ZcOhYlxqD8o
	 PmpTUrLKpn2WPHzOYVZdm71u+Pw/7WXTJ4A5keEt2oWzclswQV8TFhWeKATOV7dSli
	 ro04ja9iFj4qYkJjq/3i/oXlzkIOQ5k/rLnq8dw3cQxECyca52C5pE2bDF+7m4n7GP
	 u7XKKi8j5YUSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/paddr: drop last same folio access check
 reuse optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909054545.256743-1-sj@kernel.org>
References: <2026090853-disparity-bazooka-4747@gregkh>
 <20260909054545.256743-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:56:12 +0000
Message-Id: <20260909055612.D31801F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Physical address sampling and PFN iterations fail for large folios=
 because `damon_get_folio` explicitly rejects tail pages.
--

commit cb37cb361a4cb244731d8cba3a6b765eff4dcbaf
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: drop last same folio access check reuse optimization

This commit drops the optimization that reuses the previous physical address
access check if the region falls within the last checked folio. The author
removes it in favor of code simplicity, noting it can race when multiple
kdamonds are used.

Link: https://lore.kernel.org/20260715031002.108504-5-sj@kernel.org
Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 909db25efb35e..fe481ae64f37e 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
[ ... ]
> @@ -111,7 +111,7 @@ static bool __damon_pa_young(struct folio *folio, str=
uct vm_area_struct *vma,
>  	return *accessed =3D=3D false;
>  }
> =20
> -static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
> +static bool damon_pa_young(unsigned long paddr)
>  {
>  	struct folio *folio =3D damon_get_folio(PHYS_PFN(paddr));
>  	bool accessed =3D false;

[Severity: High]
This isn't a bug introduced by this patch, but does physical address sampli=
ng
fail for large folios because damon_get_folio() rejects tail pages?

In damon_pa_young(), the sampled physical address is passed to
damon_get_folio() via PHYS_PFN(paddr). For large folios, this randomly
sampled address is extremely likely to fall on a tail page. Since
damon_get_folio() explicitly returns NULL for tail pages:

mm/damon/ops-common.c:damon_get_folio() {
    ...
    if (!page || PageTail(page))
        return NULL;
    ...
}

Does this mean DAMON silently ignores large folios for physical address
monitoring? This same tail page rejection seems to cause the unconditional
PAGE_SIZE stepping in damon_pa_pageout() and
damon_pa_mark_accessed_or_deactivate() to skip entire large folios if the
region boundaries start on a tail page.

While this wasn't introduced by this patch, dropping the last-folio-size
cache here removes the only mechanism that might have partially masked this
flaw for randomly sampled addresses that happened to hit a head page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909054545.2567=
43-1-sj@kernel.org?part=3D1

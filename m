Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D923515FE
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933137; cv=none; b=DVnGyOsxsrdofY6Sh/VXJnw3mfsxbFp5KYzCQn3Nsg8s/5mkYzzf+xKdFjK7CL/6KUkQSpSWqmsboNLCf924zraP3WivIhxHMcZbS4IG0d/BCUBtxtITShJ1IhfGHzyLBONdZAEEpR2tes5z6NhHp9w2/KGXmfyUMjpOrgZWUfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933137; c=relaxed/simple;
	bh=0jjcSgzaI+B15K5LekBIdxBUdOjL2igQvIUTKZFi264=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KNFwPntRxfGBjX+pTT9yyHyN4++ixrKaXisR6typ1XYEiBT7zpmvQbxiiPj1sKQIBJY0N6UQarjfRjth0war9ZZFzx5s1spd+DOWga1bF1vSO+XR3PGNGy1/4im5uSrOtrAEGJ2fGACFPhuqx0UQK0NEAMFYevms+Lde0Qdkts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx5EzzCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx5EzzCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A781F00A3A;
	Wed,  9 Sep 2026 05:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788933136;
	bh=n919cd2z8aoF6dDUoMb798w6ru3ir+vnd7fDq1iddcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bx5EzzCJeTgWv98rI4lyCi8u4b7fG+RVZgc8negVATevtqK0ut1NieMZBpokO+jRE
	 L4eyv+u8vV3RFR6xUvUeYzn4t5vJ92xToCV7i5FVcyqSZkWy0ieOU+IhGIh8IfonSx
	 g1AitJ+y2hxJLSpiOv8G2KYu4sZRov3sT9HVdh3NRnud84yusXRW/mRa4CT/V2ZEZt
	 Eu6xCRra9RQ3wGQpWloeeRIo1Pk04CnAlBYJCAoFnlBUaY1KmAfm3GyQTb+38yQUtg
	 Nqyz533gwFOnXKIVyb4rp7SD9X30VvRQUUv2uNuIEtwlIp732XhVPJqiU7Z1lIXFSX
	 9d9HRdubUOv0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/paddr: drop last same folio access check
 reuse optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909054255.253652-1-sj@kernel.org>
References: <2026090853-handoff-bootlace-9e07@gregkh>
 <20260909054255.253652-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:52:15 +0000
Message-Id: <20260909055216.13A781F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused field `page_sz` left in `struct damon_pa_access_chk_result` =
after dropping the optimization.
--

commit 9b0877a60d53720420f674776094bf4134b4f6d7
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: drop last same folio access check reuse optimization

This commit drops the optimization that reuses the last access check result
if the region is in the same page. This removes the race condition when
multiple kdamonds are used and favors code simplicity.

Link: https://lore.kernel.org/20260715031002.108504-5-sj@kernel.org
Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 7bc8d79c7fa07..d1d047f494aed 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c

[ ... ]

> @@ -161,29 +161,16 @@ static bool damon_pa_young(unsigned long paddr, uns=
igned long *page_sz)
>  	folio_put(folio);
> =20
>  out:
> -	*page_sz =3D result.page_sz;

[Severity: Low]
Since the optimization was removed and page_sz is no longer returned, is it
necessary to keep the page_sz field in struct damon_pa_access_chk_result?

It looks like result.page_sz is still being assigned in __damon_pa_young()
and initialized in damon_pa_young(), but the value is never used by any
caller after this patch. Can the field and its assignments be removed
entirely to clean up the remaining dead stores?

>  	return result.accessed;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909054255.2536=
52-1-sj@kernel.org?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884DE23AB88
	for <damon@lists.linux.dev>; Mon, 13 Jul 2026 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951616; cv=none; b=H3+oo/dQnlxabld7AszmwFlwOGHp5e1pF2+hgZnRE4T9j4wb6x64N71dvIPzOJoqKOJBR1b5KRnEK29+Egq8j9mL3m0Y9CmCuetmLnvEGIq28KPfvL4oJ1tHQJgvTan7tl3nnAzvuOMTsOHtRRue4FnypjRMu3htzj2iH+uCBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951616; c=relaxed/simple;
	bh=Rcbpx/F4TSSbY/aPo6eRbkUDD0H8AAKcAZCIVg2rwGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gw5ZU4I8Yarwg4F4VEc9idjaJf7ib1Oy+Pt4T+Vw34lJrtjPYOhxvN8O+XOwqT3SH1wKftPrqUsfngsQEmM6ikN1HvUTVArLlAWrnDanAHkxIvumT4ALdd78PFt+CpNJPSQByTRCAREgUm8Nd89hHydZBbZRl/jYyEakZqjY89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njwjc9FT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njwjc9FT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81971F000E9;
	Mon, 13 Jul 2026 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951614;
	bh=Pk8cigop19FcF9jWmvU1gB9qS+mKvIwC9x2Mp3vksXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=njwjc9FTML8y3ZTMz+brxswoUuvU1A0Roqx7SGngDoGe3UT6Hq5DH3Ad/YcWhMuJe
	 qwnLv90m9eJ7ldNCJfLYerFUcutfVLerj4/ACsSN1ldfbwzkUWuh079qjOI9iGf10J
	 HjO85UGYoKtujPQP3R3+OIAoTnb4MyZYTjVzpFI2ZoL9tKp4bTNhoXG7C9LzDE1Dqi
	 TuI3Uzg4N1L4+ukJWYnvcbw4dMki7/Vp9V+gw3XZn/a8rW1eHYMt9JqaqL08uy46Dw
	 tMZX4hEERnGiZZtWwrL+UNmA45tFMo5ZYw7UxQpzzFdhZnd0EbfsWwkNzYF9KVT0Zz
	 57SdKqljTRj9A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 3/5] mm/damon/vaddr: drop last same folio
 access check optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260713135838.32730-4-sj@kernel.org>
References: <20260713135838.32730-1-sj@kernel.org>
 <20260713135838.32730-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 14:06:53 +0000
Message-Id: <20260713140653.E81971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: identical data race in `mm/damon/paddr.c` causes a=
ccess statistics corruption
--

--- Patch [3]: [RFC PATCH v1.2 3/5] mm/damon/vaddr: drop last same folio ac=
cess check optimization ---
commit d42bea4a157d94e45112b2190d4aba2a5eeffaa2
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: drop last same folio access check optimization

This patch removes the "last same folio access check" optimization in
vaddr.c to fix a data race when multiple kdamonds are running.

Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index d10b8042adb5b..d487b7a4a1042 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c

[ ... ]

> @@ -494,28 +487,17 @@ static bool damon_va_young(struct mm_struct *mm, un=
signed long addr,
>   * r	the region to be checked
>   */
>  static void __damon_va_check_access(struct mm_struct *mm,
> -				struct damon_region *r, bool same_target)
> +				struct damon_region *r)
>  {
> -	static unsigned long last_addr;
> -	static unsigned long last_folio_sz =3D PAGE_SIZE;
> -	static bool last_accessed;

[Severity: High]
This isn't a bug introduced by this patch, but does the same data race still
exist in mm/damon/paddr.c?

Looking at __damon_pa_check_access() in mm/damon/paddr.c, it seems to have =
the
exact same caching optimization using static variables:

	static phys_addr_t last_addr;
	static unsigned long last_folio_sz =3D PAGE_SIZE;
	static bool last_accessed;

Since these static variables aren't protected by any locks, could concurrent
kdamond threads using DAMON_OPS_PADDR clobber each other's state in the exa=
ct
same way?

For example, if Thread A processes a 2MB huge page and updates last_folio_sz
to 2MB, could Thread B evaluate its next sampling_addr using Thread A's 2MB
last_folio_sz?

This would cause ALIGN_DOWN(last_addr, 2MB) =3D=3D ALIGN_DOWN(sampling_addr=
, 2MB)
to incorrectly evaluate to true for up to 512 consecutive 4KB pages, assign=
ing
them all the last_accessed value without actually checking them. Should this
identical optimization be removed from paddr.c as well to completely resolve
the data race?

> +	bool accessed;
> =20
>  	if (!mm) {
>  		damon_update_region_access_rate(r, false);
>  		return;
>  	}
> =20
> -	/* If the region is in the last checked page, reuse the result */
> -	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) =3D=3D
> -				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
> -		damon_update_region_access_rate(r, last_accessed);
> -		return;
> -	}
> -
> -	last_accessed =3D damon_va_young(mm, r->sampling_addr, &last_folio_sz);
> -	damon_update_region_access_rate(r, last_accessed);
> -
> -	last_addr =3D r->sampling_addr;
> +	accessed =3D damon_va_young(mm, r->sampling_addr);
> +	damon_update_region_access_rate(r, accessed);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713135838.3273=
0-1-sj@kernel.org?part=3D3

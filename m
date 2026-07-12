Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128423393B
	for <damon@lists.linux.dev>; Sun, 12 Jul 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783876211; cv=none; b=DaOoP0Z/MUI5MdGZjCu/oK4Y+/QLYudB1oU3Dhyuq51snYurSwwyHxiqGx7rESAbGnF46zDdP7nGNkQ7d4d9qsQNGwMd+RlJzYJCj5ucmenZQ5nE0GmlY5wMY7ID7Z8ngQTbqK0x7lOybzuiFh1y/GTcfWIrUjlib8Jxxwc/xzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783876211; c=relaxed/simple;
	bh=FP9uTopaNfkF3/OrWaMJR/tKYxB7Vrb02MCUoXmg1qY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u9q0xcDJGpW+1tPJdRGgJjoICRMIgUb1tVX4tMH4bsLGmVspojGFDo3JPO9O/Hp1EBTwVC44uqM+883F8nWuCO3nVbvwm38GYCByOFga9872X7Cws9d7fPStMY2HVWnCDEvVtoajnL7xDC9hKnBdMKkoOnDk6CH3ev3+A651KOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKB2wcBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKB2wcBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F295E1F000E9;
	Sun, 12 Jul 2026 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783876210;
	bh=PvmBA5ltCLsM96Oh3TzjJEB7/hUBnBXu0JR6xqSgGMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKB2wcBmCkiay7/Aff4I+2CsahGhN8KJZxVHL22SRzi7MtmFgBk4lfGJyBGLcEsps
	 qV5MvM0Q+4gGAHKNbFysEJssPAr+yziOQcLJl7GqedpmesVvohTdnhDJ7/OhiGEn1S
	 1zOmQqx9W3Sl6J2r1m8jNPzBeKID29OvB+MjDsGWPunF8ecNB0NPOGQKTfmO6iZfei
	 8ozpdNe04LDRlPOpKazwJKUAYlhRRvh6RHzdpoiAvCb9I3tEs63SupEAm4tY9f357V
	 EoR3X37IVHPFTVZvrzyENPihwZhcOs9mTXVl8YP7FVc/r+3eA9M+4IFB+kdduDcYTb
	 MksQAitbtFUaQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 3/5] mm/damon/vaddr: drop last same folio
 access check optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260712170328.91144-4-sj@kernel.org>
References: <20260712170328.91144-1-sj@kernel.org>
 <20260712170328.91144-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 17:10:09 +0000
Message-Id: <20260712171009.F295E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused parameter and dead code tracking logic left behind after rem=
oving optimization.
--

--- Patch [3]: [RFC PATCH v1.1 3/5] mm/damon/vaddr: drop last same folio ac=
cess check optimization ---
commit 40e12defdea3b013644cc026283aa34cdd3ae2fb
Author: SJ Park <sj@kernel.org>
mm/damon/vaddr: drop last same folio access check optimization

This commit removes the last same folio access check optimization from DAMO=
N's
virtual address space primitives. The optimization was found to cause race
conditions when multiple kdamonds are running.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index d10b8042adb5b..16fe210d2042a 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c

[ ... ]

> @@ -496,26 +489,15 @@ static bool damon_va_young(struct mm_struct *mm, un=
signed long addr,
>  static void __damon_va_check_access(struct mm_struct *mm,
>  				struct damon_region *r, bool same_target)
>  {

[Severity: Low]
Does this code still need the same_target parameter?

With the optimization removed below, the parameter is no longer used in
__damon_va_check_access().

The caller, damon_va_check_accesses(), also still computes and tracks the l=
ocal
same_target variable on every iteration just to pass it here:

	damon_for_each_target(t, ctx) {
		mm =3D damon_get_mm(t);
		same_target =3D false;
		damon_for_each_region(r, t) {
			__damon_va_check_access(mm, r, same_target);
			max_nr_accesses =3D max(r->nr_accesses, max_nr_accesses);
			same_target =3D true;
		}
		if (mm)
			mmput(mm);
	}

Could we remove the parameter and the dead tracking code in the caller as w=
ell?

> -	static unsigned long last_addr;
> -	static unsigned long last_folio_sz =3D PAGE_SIZE;
> -	static bool last_accessed;
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
> =20
>  static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712170328.9114=
4-1-sj@kernel.org?part=3D3

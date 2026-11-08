Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794170179;
	b=ACuPWnE4IP1LYwX445nm3YbGGNOcs36iJAi494U21EhiZLkuHcGB0R4815lR6bbAFPbz
	 e3v3z3wz/V0nN+hnBcBZ4oBw4wRpXN5NW2SoaeXSCInnLLpaY0pbRBOo/fnWmiWcruKQM
	 gw3Po/oK807MtV5+NZWsRQMIB/CDZEDwI6Vo8pBy3D8EmoYX5/pup4xqcVRiJrTipSd7L
	 qQHX1U3ZQvqsoott/k/txRRoQIgfmARsB414tib4okqpl9kpxJcDGS0L89Gv55N2hkGRv
	 yDncpnPYfwOWYNxh9p9hluTEALQJnHCLLCSNSffUDScvUlQEbWjMwilemQ94AgHzD+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794170179;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v8azARso06dhqTAeLMc7skppXLvcYQdPyeFCseSu9tM=;
	b=g7Ld1FhXqgwxmjC5hDtc110He7s7Rh1j/m1bZFsr+utaV3YF7KQ9GB9USvdPB0rGKNhC
	 AKGauEliU1/gEDbevcdpeIWZnaf6uCheJYGEA5EAcHqOW11TGSAdHK+QnGOKJemCoaTN3
	 eEaHfXbid8nhBj2LtNYlqjB2detzWWHLzrPvLOhgsCT7z9Zb1Vo55KGKzZaXKNLnc8g9D
	 da9qkVbLJRW25kEdckSNnNH58Sot1BRSQQ444TuhNxVZc/vYQO6frsa54DSdc/N75h4mw
	 HTBJBQW4HJvkZqqzTk8KOh0R6OYIU4sJ7TNuXhX8Q9F5CLfGcGqIjefFdC/JAu443LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A56ATWUD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17285606A33C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A56ATWUD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6B61F00922;
	Sun,  8 Nov 2026 20:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794170178;
	bh=v8azARso06dhqTAeLMc7skppXLvcYQdPyeFCseSu9tM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A56ATWUD2D90WHekZBP0BIe/F6dic9aEjtoOn6sJPFtFP3mwM0xtLwIVElLK0lNCP
	 45ldKrwytJ/zbX8oPPWrnu85UUuHexiURgehqfGEdTjBXs0Qs5nIt40E+a0iCOgvmu
	 vzlYx5HiifGa4nygHuRtaSuhQCWqu+Xkw/CuiBNE3S8Oruqq4bxJko6cXo3grOcS/X
	 WwZT2cH3JqBHFsis3o+WJ/2ACN9yPIJ8jjkEv1Y631UbcW81mL7puYvHnsDHWyMGI5
	 plFVg9Ol5A7+06AHhA1Fvswu7LaG9u6tqqtW2pVGvhVPW4hBDbwR/E8llOWafozPD+
	 SJIFP0OLRcjIA==
Message-ID: <sashiko-outbox-204020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y 1/2] mm/damon/core: skip applying scheme if region
 split for quota fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Usama Arif" <usamaarif642@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261108202759.117377-2-sj@kernel.org>
References: <20261108202759.117377-1-sj@kernel.org>
 <20261108202759.117377-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:36:18 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mm/damon: inflated tried stats in damon_do_apply_schemes() on
  split failure
--

commit 3b087258b4341cba87012b7cb96ed676fd164c12
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip applying scheme if region split for quota fails

This commit updates damon_split_region_at() to return an error code on
allocation failure and skips applying the DAMOS scheme in
damon_do_apply_schemes() when splitting a region to fit the quota fails.

Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f0da5cb2b88a0..9206737d05ae7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -810,7 +810,8 @@ static void damon_do_apply_schemes(struct damon_ctx *=
c,
>  						DAMON_MIN_REGION);
>  				if (!sz)
>  					goto update_stat;
> -				damon_split_region_at(t, r, sz);
> +				if (damon_split_region_at(t, r, sz))
> +					goto update_stat;
>  			}
>  			ktime_get_coarse_ts64(&begin);
>  			sz_applied =3D c->ops.apply_scheme(c, t, r, s);

[Severity: Low]
Does jumping to update_stat on damon_split_region_at() failure inflate
s->stat.nr_tried and s->stat.sz_tried?

When damon_split_region_at() fails, sz is the non-zero remaining quota
size, c->ops.apply_scheme() is skipped, and quota->charged_sz is not
advanced:

mm/damon/core.c:damon_do_apply_schemes() {
	...
update_stat:
		s->stat.nr_tried++;
		s->stat.sz_tried +=3D sz;
	...
}

Because quota->charged_sz remains unchanged, subsequent matching regions
can repeatedly add sz to s->stat.sz_tried if allocation continues to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108202759.1173=
77-1-sj@kernel.org?part=3D1

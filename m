Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169418;
	b=RsQE5x9dZbKEIxMTonmY+jG04oBXJFB3otoPS4dNnm3XpKmylwSEwMe73XrVJLwRODD5
	 nJthI2k10S1XvAodu0BhObUsAkC/CynIFfXxEpVJNBAQJJLs45m5Kz+mnbdPT/dG5SRlI
	 KdXCe76mRdUeCkP19pl5PNxDwJzNsX/O2Y6vjvlo0mVXfIbxKW0X6GLg3tx/hMzEIhNtU
	 dlzF+sT73X8lxRWNhFTc1YjLJcBgklzYJbFmmj/+kFmJ4alyqfRozLmOGCOT60klLKTW1
	 D7wqisM3iCIQr3mllDfrchQcNPZAlabLJTzRSa+FbrLqyHJyUl0phUUM+QHcrXj5eMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RLSNq312cKLDEo3U4exWhRNTp6plA4woo3CVLNEmLks=;
	b=r7u8xzC877o7zJzj1f3r8YK35KOdc6/0LzbZGHSmeG+sD+SVWbxNI4pyoZAE2yHMO2RT
	 hh81qFiFS4HXsNzKigWxn292gd5VZNneU3XgmeY0iyMrRlj2UuZWIfiSpYywyry1s35s6
	 D7+k+ZdtkLjC6vHO+S8a20jFQGxL5QdA/Hb98UrDvYlWIIGXgqs+S+UcoKT+vhS631PeE
	 PsG2X6mhPLiRpNoNRs8uomJtJpRigOGaLVI+AaYbsXkCoz3GFktOUwl/7lZ43bQRFNTJI
	 PTUF0SCHiE5pzXTNhV8quWKXvbsCyzx4+buNinx18ZIENN8uGlMY7ThV3UAQnRdcBdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evCJOY+g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724F60729A8
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evCJOY+g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2DC1F008A5;
	Sun,  8 Nov 2026 20:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169417;
	bh=RLSNq312cKLDEo3U4exWhRNTp6plA4woo3CVLNEmLks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=evCJOY+gVUzp1DzjbiFmkH/UuXhVATwMh845mwI4vVAh+Aa/q0GFq0cVn8tFnIO9A
	 5TCvjXUI75bQz0elpEuxKCFYvuScWi2cHh6OeupP6bAtMpQiik+Hp+f+K3Z6PgSdBZ
	 YjNFeyiiuUJLlGAgQgp9aEXbdrv3E5Bd0KYIUuMIjJw2V5AWmDjw8fqRqIBtymfj/D
	 N3fr0iIppXQ5GKTAJTZ6An87iDVqgbhPyvHPRbosKi13NgqPe7ued6w3ES30fbwyPt
	 xIOjqFJfoio2T6CBZgpsb/oLNKUncrosAxykc7yQTqxEvLIyuEo64V9R63sIcv7MGE
	 fkPCTTYMs6Cig==
Message-ID: <sashiko-outbox-204013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 1/3] mm/damon/core: skip applying scheme if region
 split for quota fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Usama Arif" <usamaarif642@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261108201456.116824-2-sj@kernel.org>
References: <20261108201456.116824-1-sj@kernel.org>
 <20261108201456.116824-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:23:37 +0000
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
- [Medium] mm/damon: false tried stats on split failure in
  damos_apply_scheme()
--

commit 17459070b1916b2d77f607f0fb7f0f9158e6224f
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip applying scheme if region split for quota fails

This commit updates damon_split_region_at() to return an error code on
allocation failure and skips applying the DAMOS scheme in
damos_apply_scheme() if splitting a region to fit within the size quota
fails.

Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b5b6d00d7a3b5..9d4a78deaa06a 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1004,7 +1004,8 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  					DAMON_MIN_REGION);
>  			if (!sz)
>  				goto update_stat;
> -			damon_split_region_at(t, r, sz);
> +			if (damon_split_region_at(t, r, sz))
> +				goto update_stat;

[Severity: Medium]
Does jumping to update_stat here falsely inflate s->stat.nr_tried and
s->stat.sz_tried when damon_split_region_at() fails?

At this point sz is the non-zero remaining quota size, and
damos_update_stat(s, sz, sz_applied) unconditionally increments
s->stat.nr_tried and adds sz to s->stat.sz_tried even though
damos_filter_out() and c->ops.apply_scheme() were skipped.  Because
quota->charged_sz is not updated on split failure, every subsequent
matching region in the walk that exceeds the remaining quota and fails to
split will also add sz to s->stat.sz_tried again.  Returning early here, as
damos_filter_out() does just below, would avoid counting skipped regions as
tried.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108201456.1168=
24-1-sj@kernel.org?part=3D1

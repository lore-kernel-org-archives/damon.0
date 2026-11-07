Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090819;
	b=NKjGtMYlrW9hqqEfGy7MsJl7YISJewkM4RDTQod5ONW5mbHi0wQonUfEqJJdMipHAevc
	 fZKFGyEDKylq7AQi64/zx/sxXia0FBq+6kfaRzU4UkkicWOtJAR9n4RUEDYLVmE7E5cee
	 1nzrvcYDVWm3IeNZr8FJzq0Fo19K1tA/gPW1aLyOK+SfokOm9oh7WzAPLhLG3usSp/oG6
	 h3Gcyvvt39rV1nY+OC4M+EJr5AOLRgLeukVm1f+EEKe9bH4R4PVuVioAJKvuuYEXvrpMT
	 FXbXMitBx46LPtFhmqKpJ1Jn8z/Owm/b8nwmPTO71wl6S3JaU7XBk8JwyUVrPeP9SPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090819;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MODwKQRYO4GDp3rYpGZwVLoSBR2IsHfImNwOzMkTcjM=;
	b=mcy2+dz4hK1xoj6lBydPHdbnQrnVdnXoY85Q1FsFM8eG8KyOLbndDNsZWIMTnVYPDhBM
	 tyzXcnH74cPxj2h4hFJ7Rq202eSldtd0Z/fYmjeGZzNAXfbBYsaN9rnB4O+TXh7Hiww82
	 l6C6UT/1X4Ki3HuZw3DHMmAJAr37WFbZ0PD3WHAZDIP/5p7sAAGkVtigRuFToHfVHAunP
	 JKo4r/D04VRA0uz+hp1UEtkYHtRWiFt/umACUP/LRjL786ByNxUpUqfXXneqWzapWN2yd
	 bxDTY1n0hzyUpyA6yiQqe+XbKr9diNdtEBr1KWbLFRHPexeCG4SLzgSzv+dJquJkw0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gB3PONk8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27086606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gB3PONk8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F931F0089F;
	Sat,  7 Nov 2026 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090819;
	bh=MODwKQRYO4GDp3rYpGZwVLoSBR2IsHfImNwOzMkTcjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gB3PONk8CA+MS2j6v8aMS9L8RPUu7WZYUV9OXr2DD1tEpaguD5JgV9oRmUqgvCqGd
	 E5a/66brYdG3hNqxHdJ5pt9j+KTCK6caX8FsNkEEOfvbWBpeTyjC2pVJ7OMxg6WgJA
	 oOJx/MuPF2ir7fzrGt0HL41H4fxtFkyaI/bPNON/El4sXEJmx+YvyWJz9lgbnCE5uP
	 9CP4DiaO/wGIHOf0rcglW/+OlSGJyJzt5o0mWk6r1rcJqAWWkDCeiT4R4yhNDVNuFk
	 ChtBvv/eWpzh7R5ZYIJzuxbypn3LwwzCCjhe0KRMkgg8g8zfpLssjHO1OulCRUeeCE
	 qpswuTMqSZiHA==
Message-ID: <sashiko-outbox-203366@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.6.y 1/3] mm/damon/core: skip applying scheme if
 region split for quota fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Usama Arif" <usamaarif642@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261107222202.331476-2-sj@kernel.org>
References: <20261107222202.331476-1-sj@kernel.org>
 <20261107222202.331476-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 22:33:38 +0000
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

commit ae5a2312a946a6108ba6414ca8a1f6fb984dd078
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip applying scheme if region split for quota fails

This commit updates damon_split_region_at() to return an error code on
allocation failure and skips applying the DAMOS scheme in
damos_apply_scheme() when splitting a region to fit within the remaining
size quota fails.

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
>  		}
>  		if (damos_filter_out(c, t, r, s))
>  			return;

[Severity: Medium]
Does jumping to update_stat when damon_split_region_at() fails inflate
s->stat.nr_tried and s->stat.sz_tried?

At this point sz is non-zero, so damos_update_stat(s, sz, sz_applied)
increments s->stat.nr_tried and adds the remaining quota size sz to
s->stat.sz_tried even though scheme application was skipped before
damos_filter_out() or c->ops.apply_scheme() ran.  Because quota->charged_sz
is not updated either, every subsequent matching region in the same walk
that fails to split will add sz to s->stat.sz_tried again.  Returning
directly instead of jumping to update_stat would avoid accounting the
skipped region as tried.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107222202.3314=
76-1-sj@kernel.org?part=3D1

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082714;
	b=2dttHicU3BWQzoFtwoMY/EIoLUemSKbFdKVrAK3IeaYg3MkR4LsVQmI2lT0NZ+fiLxsJ
	 EQsI6rUofZfWbROiZdJ56SxuWTilH54UgrNc9klDbFOBkXPkv4b0DVKZiiqZ6n0aAdi4+
	 cHR/6pwmNV3B/g+rEC0++NOmKFe/AYqIenfywkIklXKnF9+zvKMRj+fnlVRbXAemfm9aq
	 mbYTAZ0fabAPALFwRUCILwO7L+7CCYXvxrSO6Qgyp04eu2kOPEFq0zLL9eho0oWhT7NEL
	 hdFAA53Uq79shfQwC/Q1YYaCHJkfE4mApEOcSaxraCSyP1dtPO3IyR2+ZGCO+VwQrDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082714;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0QctvfANf8m71klIHep/iiL0jBDeYa3bUuHZCrSLd+U=;
	b=ZhTvDor3gVW4HkcWMjSLQWzFrBokT53C8SXGT4NWmCvhSxCIrqaVkx6ZERtHPte1KM6e
	 l1tfS5kMkmFwD+TTAxrbLzRHeGvZFKlSBTZvnLFgcHLKqwcZyCKfIQ83wd7GIlxu/uYIz
	 Cc5p79Zr0QkBSnCsPr5T4YSRifUydv3tudWWgO/CaFogJPf3kCdVxXsJR0f+KTU0cr8ON
	 OggmmqpYSEAYfIm4XpBnOa0T+YwnSdgjcgPx44HrP3dyBXTUW4PgHneyxgSQ9Bg47noQ+
	 uWxIjKNhLjUsD87NYw6jVmlv1crQVw76N47+hJABI99UwP1LEQVHSX/DiffOIC5nkwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZTnlbIG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C8606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZTnlbIG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287EB1F0089F;
	Sat,  7 Nov 2026 20:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082714;
	bh=0QctvfANf8m71klIHep/iiL0jBDeYa3bUuHZCrSLd+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MZTnlbIGEU8Tx9q1gI7QEoRw7flNo9r6oLAYyy08vDomrC10Petl80l0htRdYK1ba
	 UeA3yQ+Ux1LOtDmRaEGO2Ra42g24KnLL8Hd6Y6J4s85s92APX9M9twQXG7K5ghMGHD
	 l1qbPgeU+qp4A/Jx/ZPoNVDk9IHn97T/vzjZk70/63U8WlBSIq1dSIcFaAnM9tO2e0
	 PQ/+UTN1pv2DIUT9jXWNgkRuT/Wg9ESXcj/muPVJ8TcqIo/sAGbCi1H/+dmnOIqIbk
	 B7hstRTfxJCK5xx9rI92QMB7lOLFOPRjhjdTvGMidWnlC5XaqhTwwYc9CbBBSM485P
	 YXTuoy9jRXj5g==
Message-ID: <sashiko-outbox-203262@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.18.y 1/5] mm/damon/core: skip applying scheme if
 region split for quota fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Usama Arif" <usamaarif642@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261107201001.206120-2-sj@kernel.org>
References: <20261107201001.206120-1-sj@kernel.org>
 <20261107201001.206120-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 20:18:33 +0000
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
- [Low] mm/damon: damos_apply_scheme() inflates stats on region split
  failure
--

commit dd2b638af6fec217ed7123ab31fe119102f17f78
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip applying scheme if region split for quota fails

This commit updates damon_split_region_at() to return an error code on
allocation failure and skips applying the DAMOS scheme in
damos_apply_scheme() when splitting a region to fit within the size quota
fails.

Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 8fa788b0d709c..4c536a9b958e4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -2000,7 +2000,8 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  					c->min_sz_region);
>  			if (!sz)
>  				goto update_stat;
> -			damon_split_region_at(t, r, sz);
> +			if (damon_split_region_at(t, r, sz))
> +				goto update_stat;
>  		}
>  		if (damos_filter_out(c, t, r, s))
>  			return;

[Severity: Low]
Does jumping to update_stat when damon_split_region_at() fails inflate
s->stat.nr_tried and s->stat.sz_tried?

At this point sz holds the non-zero aligned quota remainder, so
damos_update_stat() increments s->stat.nr_tried and adds sz to
s->stat.sz_tried even though damos_filter_out() and c->ops.apply_scheme()
were skipped.  Because quota->charged_sz is not updated on this failure
path, subsequent oversized matching regions in the walk will repeatedly add
sz to s->stat.sz_tried while allocation keeps failing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107201001.2061=
20-1-sj@kernel.org?part=3D1

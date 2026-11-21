Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295507;
	b=U3V0Mp8H1EwAIq0n2Csrv7O4sHQH/9wCS2HniJ2Pv/yItD/wO95treI+oRrW81xXSOkC
	 kEnZWraksNhLWejVlisiFSykri9qjUL/eVFlTjeD92EPrZ3wt4DOKHOZRsx4GDIUdgD0G
	 kdqGmRQLaO/zxwGSFLcLZOhfr1gSx1EBVNaPpvXqgBb3OlyKjRG9twJU1j5cMuYlBywHM
	 qYo6e0fkn/s5lcs//LEBO9son3x1GK6FJEvxM5LjFo2fcLPx92zhtSFJcjpUHz0tv7RbF
	 3AryRDG6nf94A7KzonsvdZFRzOHmt+x9ij35wgoKf5YPZNPBtCcCNOSzqOndLbbEZsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295507;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L8ZevwdJGMQHEXIo4r3jD0w0C3WV9dYZLnb659zW1N8=;
	b=oA5FooFFMlVt4/zEIkeuBwqlOD8Z7Q6YrLq3GZiqQFqWN07B0IOXH/EvdPFlTw21m/ak
	 ENlGyNakn3WR+B7HkUV5dRHSEe44luQKwfs+5qV5uN6C5XuxVEbuRe73XRncIwmRFvRZw
	 5DN3V6PwJzn3MvM6XO21/6xi0YSxh6Duul0Iw/uKML+Ne+tjwGr+SBWmg82azb1a//6DU
	 Ht0na9R5ozb2tf54q0LdoZiBJ7cViJ1qbXtYATvPkkHU1NxDC2awqZeJ+9g/A1+YUvFAB
	 YyhNUHaaq5fS2FVfV2pux+rjpIZulG7yOmtCAP/AExvV/NUIVBftMpZkPMZdDCJibWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d39iIEEj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B75606A320
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d39iIEEj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804A31F000CA;
	Sat, 21 Nov 2026 21:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295506;
	bh=L8ZevwdJGMQHEXIo4r3jD0w0C3WV9dYZLnb659zW1N8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d39iIEEjpKdFEcI4uJMGV50pzV1E0hbs7NqlQUiCgzW1gVYRkLOt/FM/VaNVa7ulG
	 adWSuJXs9Ldg69vcLm8Y8nfNTbbnbyBUcC8zDVJpFs2Ga2TMhWf+9Qaz4Mv1FB0roF
	 2nA0md1kzj5DtGbUn7u/gtr3meHI0jm3LtLk/f3rO4UTCPDQvj71sITuQyxx2gl/Uv
	 XAWlU7JhTdW2fPSvBUCvHAjiYmpgaNIu964S5vJYoLGANdIeycIcJnDjwaRTSVzaJd
	 PXBS4UPRWLnQ/SL+KRflx6d+rTcAZAvzieGtctAPx/3TDgHrC8LAWHHLvqrokSt8WO
	 g/UGVTjXccgqA==
Message-ID: <sashiko-outbox-227387@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-15-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 21:11:46 +0000
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
- [Medium] mm/damon/paddr: 64-bit phys_addr_t truncation in
  damon_pa_filter_match()
--

commit 28e4b56e5a2332a155374f4f6e67e8b3da9ffb34
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: support REPORT_MADE type probe filter

This commit adds DAMON_FILTER_TYPE_REPORT_MADE probe filter support to the
physical address space operation set by querying damon_report_exist() over
the last sampling interval.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index e89cb14ee17be..4003ae914f1a2 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -140,9 +140,10 @@ static void damon_pa_prep_probes(struct damon_ctx *c=
tx, bool set_samples)
>  }
> =20
>  static bool damon_pa_filter_match(struct damon_filter *filter,
> -		struct folio *folio)
> +		struct folio *folio, phys_addr_t pa, struct damon_ctx *ctx)
>  {
>  	bool matched =3D false;
> +	struct damon_addr_range addr_range;
> =20
>  	switch (filter->type) {
>  	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
> @@ -157,19 +158,27 @@ static bool damon_pa_filter_match(struct damon_filt=
er *filter,
>  		else
>  			matched =3D damon_folio_young(folio) =3D=3D false;
>  		break;
> +	case DAMON_FILTER_TYPE_REPORT_MADE:
> +		addr_range.start =3D pa;
> +		addr_range.end =3D pa + 1;
> +		matched =3D damon_report_exist(filter->report_type, &addr_range,
> +				jiffies -
> +				usecs_to_jiffies(ctx->attrs.sample_interval));
> +		break;

[Severity: Medium]
Can assigning pa into addr_range.start and addr_range.end truncate 64-bit
physical addresses on 32-bit CONFIG_PHYS_ADDR_T_64BIT kernels?

struct damon_addr_range uses unsigned long for start and end.  When
monitoring physical addresses at or above 4 GiB with ctx->addr_unit scaling
on a 32-bit PAE/LPAE system, the upper 32 bits of pa are dropped (and
addr_range.end wraps to 0 when the lower 32 bits of pa are 0xffffffff), so
damon_report_exist() matches against the wrong address range.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121210013.1303=
97-1-sj@kernel.org?part=3D14

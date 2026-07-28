Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B918A6CF
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216765; cv=none; b=ggHRs1G09YxU6nv3JoenKZYL+U4y+490hxTnyDmmbJej0CnYH6qJhK5HmTOduwKWqQVBMiSeF5UUnUmzx/BU0kg0avf8NgJxLDaoY3//VrQxW8h4vaZv8+dRB7oFPXp+V0UO+39NXFIOmjqRONRPFNNR45MkZd21SglQJJBG9IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216765; c=relaxed/simple;
	bh=GrLJ58jmrFpz+rYJZPdzzOnFFXNbUSryhvJnb7a1neU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JP1ZzvmKbNWYL9226WTu5orjK0XGazuSh8cScU3Vfd008YoLuJQvBquerpgEAAugG1bby+1LOcaHSvpk6JovSsxEkrXmaX+Uc8UVFvP8DnmU/Abw0ixBEFbZNTTEhZrP0+Cg0gKtYdyI9K02jW/X31sAAIT0+GGPU1E9OOuVe3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz+yTWhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz+yTWhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66471F000E9;
	Tue, 28 Jul 2026 05:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216763;
	bh=wO2EwZy7qcPpCjI/E3FjJ8ZcllHD5LCF7GNz/B5Pe+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pz+yTWhixKcU1PZHrLWHRJQ4p9ilBCvYXAYXMcHGRrNsuW/95woPzqPKHhNYA9RCY
	 Yjxtsm679podCvA0JAGJqe6yH1Ofwtr919wAOVDFdZiPddY9fYESRvoSvwLf2RTNSm
	 Rbu8Qs5G26YTHUzFMJ/xt1ImblQtlc3pKayFWNLQRxLrRDJYe8UJ8MEZXCN/jyLaON
	 zAGnGeiRGyPPi4u6zPn2kd9CF1plBPjvF3Rk2mq5t8VPZkQ4N0crcskzdjxRhACgz7
	 E2N78sUVj9E0t86xbIkmP3A7bFCHnW5V4w6B0WhIkcK5toLLeQ9zBcD5uF4Yo5Pc+8
	 mxKH19JYnXg9A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/10] mm/damon/vaddr: remove a debug message
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260728052811.192712-4-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
 <20260728052811.192712-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:32:43 +0000
Message-Id: <20260728053243.B66471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The 'ctx' parameter in '__damon_va_init_regions()' is now completel=
y unused and should be removed.
--

--- Patch [3]: [RFC PATCH 03/10] mm/damon/vaddr: remove a debug message ---
commit 6f7aa725872ec3ac7c5da1213c336d706d99ebb1
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: remove a debug message

This commit removes an old debug message in the DAMON virtual address
space operation set that hasn't been used meaningfully for the last
few years.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 4976775fe2762..5ccf70dc8a30b 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -192,19 +192,10 @@ static int damon_va_three_regions(struct damon_targ=
et *t,
>  static void __damon_va_init_regions(struct damon_ctx *ctx,
>  				     struct damon_target *t)

[Severity: Low]
Since the removal of the debug message also removes the only usage of ctx
in __damon_va_init_regions(), should we also remove the ctx parameter from
this static function's signature and update its caller to avoid unused
parameter warnings?

>  {
> -	struct damon_target *ti;
>  	struct damon_addr_range regions[3];
> -	int tidx =3D 0;
> =20
> -	if (damon_va_three_regions(t, regions)) {
> -		damon_for_each_target(ti, ctx) {
> -			if (ti =3D=3D t)
> -				break;
> -			tidx++;
> -		}
> -		pr_debug("Failed to get three regions of %dth target\n", tidx);
> +	if (damon_va_three_regions(t, regions))
>  		return;
> -	}
> =20
>  	damon_set_regions(t, regions, 3, DAMON_MIN_REGION_SZ);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728052811.1927=
12-1-sj@kernel.org?part=3D3

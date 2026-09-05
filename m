Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAF449992
	for <damon@lists.linux.dev>; Sat,  5 Sep 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613107; cv=none; b=AOfkqmtADSNXasXjeSCn7r1ANVbiDMsG4iG5HHBAf+B3R/LZ95WemtQdmrYj8WUDN48XxzBWlQrG6BhfDbwLca9jW4wgG0KWjBXp3IHZJHiqr28XD5mW2HnbMKdAk7atxS9sEW4YFyfMNG0Ju/w9HEMauN8gmB/erHy7vW9QYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613107; c=relaxed/simple;
	bh=Crq44gmsRykxHARkZg9ggATUxczLtMVlQqoOMiwK9e4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xk9nTp5zEN8BuxWjIRHFbip//UFj3oWJSRTb4/WWY+snoOJSz2KEAsrh+BWNk0KVgiFInA6COT1r1XBfxy1dzQUDOpBtI+tLgQhnnkS4Rm6F9VTzy2g3ptMYa9ChsC/5eYZvCulOefjC5s2N8QYrCru8t1qvbKbLMG7MHBJSh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2oygyf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2oygyf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5D51F00A3D;
	Sat,  5 Sep 2026 12:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788613105;
	bh=b2YRtZLpTN2yJHxssLOzWzDXXFH/dFWmdmUjkiGfjks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I2oygyf62lQJsvwdSab2KDBcz33fSQfqtzbpCyH+RL+Y82MX7IRXHmZyrXXX80fhr
	 dmOLtVsn5hVnIbjT5OV3dj7ElIlEhjBqCopHy+zW5KsEEsQOfm8oerdnvyAB+VY1C5
	 ZfNZc6fLeEhqjAON5YyZ28a3irPnR0i9hpCN54fzliJr6uZVLnnCCBgyoDNzagkl1S
	 0N7bkWbHV61v5NS6m2dQpihxdXYNIwlBEbVy9s3A3OWlelu7mcjsT1DM3Mcc3RJoiS
	 V/eMXl0vjg0Y57mR/G8fLKSBRd/DH5TpkpPhsz5ltFFZdjUYH4ZSUuw5xloNUW+L01
	 l5RpaU78JQLOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mm/damon/core: allow esz to be set to zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260905124706.3398-1-aethernet65535@gmail.com>
References: <20260905124706.3398-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 12:58:25 +0000
Message-Id: <20260905125825.BD5D51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit integer overflows in time quota and throughput calculations=
 lead to severe miscalculations on 32-bit architectures.
--

commit dc1c35769ce920ee1796367097f9876b2f24a643
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: allow esz to be set to zero

This commit modifies damos_set_effective_quota() to allow the effective
size to be set to zero when the goal has been achieved. It changes the
order of max and min calculations when quota->ms is set to ensure
that a zero esz_bp results in a minimal effective size instead of being
clamped to min_region_sz.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ce8c6f99106ed..3e9c9b6385d4e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3259,8 +3260,8 @@ static void damos_set_effective_quota(struct damon_=
ctx *ctx, struct damos *s)
>  					1000000, quota->total_charged_ns);

[Severity: High]
This is a pre-existing issue, but does mult_frac() silently overflow on
32-bit architectures here in damos_set_effective_quota()?

Since quota->total_charged_ns is represented as an unsigned long, it native=
ly
overflows after 4.29 seconds on 32-bit systems. Furthermore, when
calculating throughput via mult_frac(), the remainder calculation
(sz % ns) * 1000000 can silently overflow a 32-bit unsigned long, which
causes throughput estimation to be completely incorrect and often near zero.

>  		else
>  			throughput =3D PAGE_SIZE * 1024;
> -		esz =3D min(throughput * quota->ms, esz);
> -		esz =3D max(ctx->min_region_sz, esz);
> +		esz_time =3D max(throughput * quota->ms, ctx->min_region_sz);

[Severity: High]
This is also a pre-existing issue, but can throughput * quota->ms overflow =
32
bits for quotas over a few seconds here in damos_set_effective_quota()?

If this wraps around on 32-bit architectures, it improperly clamps the
effective size to ctx->min_region_sz, nullifying the time quota feature.

> +		esz =3D min(esz_time, esz);
>  	}
> =20
>  	if (quota->sz && quota->sz < esz)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905124706.3398=
-1-aethernet65535@gmail.com?part=3D1

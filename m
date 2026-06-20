Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A24299A82
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976872; cv=none; b=Ry8onP2DkGk/s7Ili/21satIlkjqE4NULvVIyPQ7KjvscGWE6UQvwiLv2HSjTbJLeG56c8Nv3LYD9q8mz9Sbq/LekR96KjWWQI/+Iufwpj0glircL2tU0+h5zFrp9SNPk/fUluEJLTvjuKPVhZ11MfgvC1r7Bnm3XcP5ahVz8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976872; c=relaxed/simple;
	bh=ihQMuUzlG8ks5PFhEE/HSSGSPHCTmHvf22z65LkfOsA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cOYJTLsIrh41iaV8C3gaC37j/rnEVlRETCwR6IxJToLEfBSPxdMkIQ7laeZMDXn2ANkTm8vScCH5B/hCdPecpibW7zbyAM6o0DdXqg83m24hXe9/yRVaprWoT/NKp/dmNEr2X/sR3tGH9AYgH5gbq83IwqLP5ND+atmwThFznQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXHxsbAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXHxsbAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F911F000E9;
	Sat, 20 Jun 2026 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976871;
	bh=XejjbnSBhrLNiizvOsUCDC2KQbRyyApO4m5oJMplz+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BXHxsbAY43RgKF17yqWHu5u5c9DcN9FJ35Hms45ZsYxYJLXnjZs/UDwxSTijVfgbo
	 BCpUaK89QQY7Gh6O0qOBmArZUr9u9lon2qze+1R+SUQgtc/GWzfwqLUHYwKajWEiwo
	 e1/BPUNJ+7/5LfRF00avH5c9wHAxRrZtXvytixG610INMmwyudAVrDYNirClyyXomN
	 b70aFEY2I/FdwbFFo2DNUf1XAMKI34rbG0wGqOt8h8aS/4e74cjZItMKk4SJryCYwS
	 Ft2ED8W32p7Cu6J4iWtjyEoAlacUxHs1iBo3UD5Vo23uW9OYKASuAwMXs/+r+luptK
	 lJqh6TgAboG8A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 11/13] mm/damon/core: remove nr_accesses_bp
 setups and updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260620172244.90953-12-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
 <20260620172244.90953-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:34:30 +0000
Message-Id: <20260620173431.09F911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `attrs` parameter in `damon_update_region_access_rate()` is com=
pletely unused after this patch.
--

commit ecb338097e9822ecdcbfa5f88676102211ac76ca
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: remove nr_accesses_bp setups and updates

This commit removes the setups and updates of the nr_accesses_bp field
in the DAMON core. The field is no longer used for any real purpose and
has been replaced by a simpler function.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 53568a3c3ad9b..a41b66b26a472 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3779,18 +3774,6 @@ static unsigned int damon_moving_sum(unsigned int =
mvsum, unsigned int nomvsum,
>  void damon_update_region_access_rate(struct damon_region *r, bool access=
ed,
>  		struct damon_attrs *attrs)
>  {
> -	unsigned int len_window =3D 1;
> -
> -	/*
> -	 * sample_interval can be zero, but cannot be larger than
> -	 * aggr_interval, owing to validation of damon_set_attrs().
> -	 */
> -	if (attrs->sample_interval)
> -		len_window =3D damon_max_nr_accesses(attrs);
> -	r->nr_accesses_bp =3D damon_moving_sum(r->nr_accesses_bp,
> -			r->last_nr_accesses * 10000, len_window,
> -			accessed ? 10000 : 0);
> -
>  	if (accessed)
>  		r->nr_accesses++;
>  }

[Severity: Low]
Does this leave the attrs parameter completely unused in
damon_update_region_access_rate()?=20

Since the removal of the damon_moving_sum() logic removes the only use of
attrs inside this function, could we also drop the struct damon_attrs *attrs
parameter from the signature and its callers to fully clean up the API?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620172244.9095=
3-1-sj@kernel.org?part=3D11

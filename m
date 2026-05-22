Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF453537E5
	for <damon@lists.linux.dev>; Fri, 22 May 2026 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472516; cv=none; b=Nl+F3ZzSvbx/tcBXbl3ObS2+pjRbKNuHec//TuIvew2vp78eDjESZvqIFyxEKW00Nqtx5/wDcsblcQG2uCduGehtgP7RsCOT4YioYXOkHUhyKxKCJ8fh3TxvxmiNjJ9jOHHk8kKO/ljnbTfaPgtBxf+Q29aGr8ct/QhXE4tSiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472516; c=relaxed/simple;
	bh=u/Bfbqk0thoIhIl9vxvrabHm9uNmNK4GPAGx/FpTkxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B+X3pMoGDp+MV+20fPq+yTtbEJrfT1McnSHEnvaux6agLDkuLzZ9wiZHoM2+0Gpybpk4VirBhr794rAw9kCkrD20tMcOGMvHgOuUUvkJwV4TXONgMupJTDZX/0V5UNvtk0gv6+M0GFeyvMFMEcgDfsNVt/zwoWfYgsPdAVcDjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtJ7Pspp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtJ7Pspp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CADA1F000E9;
	Fri, 22 May 2026 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779472515;
	bh=FEolMyepUWooNzwpflwBq4+X8fANuUH0fptDoQGWgjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KtJ7PsppvklRb2zLHwuOSGmQz2lIu/h2pEECjB/E1J/cz1yp7b3t3oK7WyerdmnSQ
	 0Z0PPQgDAsHM0wj6wNkIt0HnLmSoKbv7WKiIaT8jxWH2aUUMHW4PHgvpB/LGhPJ6w7
	 NGP6UOg/oTp6PYs0MZnQjiT3ET243YUue6B54bcg6cJ/lySZUG4MADA/76Fdhkw1sy
	 QngDP6+Vyd+q8XDm1Uh1s01LHFrfWsp89VKpGkMJrgrUU29cvtMgwrNO59FPgC0LtO
	 K+moZLXVc1rik2RzaflRePc74/9tJRGaBIcZW37yWAyZoBn0zPKZGIhHXPJuqPOeGZ
	 zcLgrtqabxomA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/14] mm/damon/core: add kdamond_call() debug_sanity
 check
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260522154026.80546-9-sj@kernel.org>
References: <20260522154026.80546-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 17:55:14 +0000
Message-Id: <20260522175515.0CADA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Calling damon_nr_regions() instead of accessing t->nr_regions direc=
tly causes completely redundant O(N) list traversals and duplicate warnings.
--

commit 97b7c0b9ade3ed697ef1eba39c981f58994bd0bd
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: add kdamond_call() debug_sanity check

This commit introduces a new debugging check, damon_verify_ctx(), which
runs under CONFIG_DAMON_DEBUG_SANITY. It is called from kdamond_call() to
ensure the DAMON context state is valid before proceeding.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d816679dd7020..00e2997524ece 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3329,6 +3329,37 @@ static void kdamond_usleep(unsigned long usecs)
>  		usleep_range_idle(usecs, usecs + 1);
>  }
> =20
> +#ifdef CONFIG_DAMON_DEBUG_SANITY
> +static void damon_verify_ctx(struct damon_ctx *c)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r;
> +
> +	damon_for_each_target(t, c) {
> +		struct damon_region *prev_r =3D NULL;
> +		unsigned int nr_regions =3D 0;
> +
> +		damon_for_each_region(r, t) {
> +			WARN_ONCE(r->ar.start >=3D r->ar.end,
> +					"region start (%lu) >=3D end (%lu)\n",
> +					r->ar.start, r->ar.end);
> +			WARN_ONCE(prev_r && prev_r->ar.end > r->ar.start,
> +					"region overlap (%lu > %lu)\n",
> +					prev_r->ar.end, r->ar.start);
> +			prev_r =3D r;
> +			nr_regions++;
> +		}
> +		WARN_ONCE(damon_nr_regions(t) !=3D nr_regions,
> +				"nr_regions mismatch: %u !=3D %u\n",
> +				damon_nr_regions(t), nr_regions);

[Severity: Low]
Does this code perform unnecessary list traversals and cause duplicate warn=
ings?

Since damon_nr_regions() internally calls damon_verify_nr_regions() which
performs its own O(N) list traversal and issues its own WARN_ONCE on mismat=
ch,
using it here results in traversing the list multiple times.

It also causes multiple warnings for the exact same mismatch.

Would it be better to compare against t->nr_regions directly to avoid the
redundant traversals and duplicate warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522154026.8054=
6-1-sj@kernel.org?part=3D8

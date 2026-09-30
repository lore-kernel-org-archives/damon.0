Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5E345EB5
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762084; cv=none; b=V5/ld7L/xq+Ix01+ifFuCTJur+BvQzppKrQh98SXPL3yKC0aDBv+o6bWXXyTaIN/qwqBoO5k86x+OwRy2Da4v7+/mLH50fNOPWwT3sXIqp5VrzoSeiva47OPIP5oiRsn7iTuwv5Vl349xgGNTOeJUj2ALYeQ1t/9o23pskWXwBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762084; c=relaxed/simple;
	bh=3iTGzwZSfiAn4JDIELvL9WArJpu/aYbL1ufa+pVjPSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kuOWwk5dy8ZitIz5arOzySKjFOBM64nZ9QzPrtlDwnkeG7LzGHppd9keoQeZraVaVriEy843iLoIt7E8lGhkSB8nxxyMEq+NOeD7+6tRqNSwlpwU+JR8Pn5wfoPKT02M80p9c+L1rfRMl7z3XUjvfpzQ3Y7NLPDnrUIHoUC/QdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt0Fjs1/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt0Fjs1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264EF1F00893;
	Wed, 30 Sep 2026 09:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762082;
	bh=7dqHLZnhNdY8I3EMdSYi/29xYRaWqv8u+A+wN5KiaQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wt0Fjs1/QSqCb48W8z9zc1QntD4M2tBKiaxw9gX7Kj+MVIPf0DK0dqLcR2otb276n
	 IQ+cBSutOeGxTVgPEyT3Hv7WELFB35PkIYFMLDvrEU1N7DJRYw0nrWFyRoInVLjSMQ
	 Ft55OXK1zDpQpi1CdIYk6vbwBJ+cYiO9d4gLwFFFlR9v79PHIEXWC2a+QD8gA+MMvo
	 02kQQ6iMuPuUUKT0zZPa9T5Ql+a1m+OZo/9kYLOMt337Na/Ezp9XVo1/B6W83HP5lX
	 Kz+4RVM5BZFePDoJG1DZA6A8m16t2QeAo1mf8syBtSKCs6ZsorY5jGQo7b1EqlTHPT
	 rCm6/fMqqjZRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/core: fix unconditionally skip last
 region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260930093707.48739-1-sj@kernel.org>
References: <2026092948-moonrise-persecute-3597@gregkh>
 <20260930093707.48739-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 09:54:41 +0000
Message-Id: <20260930095442.264EF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: invalid list head dereference if damon_split_region_at() fails
- [Medium] mm: scheme state leak due to early return for small last region
--

commit ae1e4dc8429f6a152575d9c64a1876f9dfb3b7ad
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix unconditionally skip last region

This commit modifies damos_skip_charged_region() to only reset the charge
state when the last region is reached. It ensures the last region is skipped
only when it is applied or cannot be split.

Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0713fda22682c..5ede1733369f5 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

>  		if (quota->charge_addr_from && r->ar.start <
>  				quota->charge_addr_from) {
>  			sz_to_skip =3D ALIGN_DOWN(quota->charge_addr_from -
>  					r->ar.start, DAMON_MIN_REGION);
>  			if (!sz_to_skip) {
>  				if (damon_sz_region(r) <=3D DAMON_MIN_REGION)
>  					return true;

[Severity: Medium]
Does this early return for a small last region bypass the state clearing at
the relocated out label?

If damos_skip_charged_region() processes the last region in a target and it
is smaller than DAMON_MIN_REGION, the code executes return true early. This
bypasses the out block that clears quota->charge_target_from.

In the subsequent window, the scheme could again skip all targets until the
saved target, evaluate its last region, and hit the same early return,
potentially skipping targets endlessly across windows.

>  				sz_to_skip =3D DAMON_MIN_REGION;
>  			}
>  			damon_split_region_at(t, r, sz_to_skip);
>  			r =3D damon_next_region(r);
>  			*rp =3D r;

[Severity: High]
Can unconditionally advancing the region pointer after a potentially failed
split on the last element cause list head type confusion?

When damos_skip_charged_region() processes the last region of a target and
attempts to split it, it calls damon_split_region_at(). If the split fails
due to a memory allocation failure, the region is not split and remains the
last element in the list.

The subsequent call:
r =3D damon_next_region(r);

will dereference r->list.next, which points to the list head
(&t->regions_list), returning a type-confused pointer.

Passing this bogus pointer back via *rp =3D r means that subsequent calls to
damos_valid_target() and damos_apply_scheme() will dereference it, which
could lead to a heap out-of-bounds access.

> +			skip =3D false;
>  		}
> +	}
> +out:
> +	if (r =3D=3D damon_last_region(t)) {
>  		quota->charge_target_from =3D NULL;
>  		quota->charge_addr_from =3D 0;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930093707.4873=
9-1-sj@kernel.org?part=3D1

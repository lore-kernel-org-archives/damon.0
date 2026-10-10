Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E741A4EF
	for <damon@lists.linux.dev>; Sat, 10 Oct 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614522; cv=none; b=T5BemN64pURW2q8CCDZ904W+LR4SKPTFT6rTAyOuBw14LwVjDNAdtGY7V71QggBp5CmQ0YfnPdVd68gGd1SZTU137P/yExcBA0Xou5IfQr/cBScmQqXDEjuBE4ZHKGSkkhLpxPkhLdl55w5VZx+6VrwlcQSFJXBJxTnsGkUa5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614522; c=relaxed/simple;
	bh=nT+ucQk4zn9uZ8Tx0oumhjSIlolRcj6l/XFnAH2v3Hs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a+slhqBlZUai2cVaZYZkd5etNogn8Z50rt8gqya4VKKdoCA+09oxa/f54xVCJiF/r6qjT8nED27nqOC/cBbw7gcMW+Y+bjfwN3LKjq2kf4/ftrqspuWFTtWvrzVMOn8sQ8lqRtsyBeoMApA8v/+GyIki+66HIEaeoITNdU85quM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mc13FAPI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mc13FAPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8401F000FF;
	Sat, 10 Oct 2026 06:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791614517;
	bh=VmlmnRzQ08rmXkr/Rcx/gVGDgv28QLuNyd6JeQCkpWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mc13FAPITBDTdt/O0wY0HZgeIWZlucFwSqV9STNeU4Jl+F3oQRvoZuOmumvVTFJaU
	 z/fceoZBcuSIFozG831Dj4V+mlIodpGQaVMkIlC9E5g9x3vk/4Qu0MnLQKUzM66obL
	 K0DxfyOZkyGDEP1iayHvORXdmZDju3PE8XbjulJHmNNSJvIivJN4hEoigXOu25zvt2
	 X2OBk64zNDvqw6HTAeFJvjK+gqHwZRUqj5M5OdpH6+MeYV8T2iWgfnjo2Jocez5Q92
	 M6bF9yG3wwoB7U5gDD/m9p/yS26ndvB7HbdGihAvJYvZObw4yyevxvIj/VdGG6nvTq
	 g/97S60zhDE4A==
Message-ID: <sashiko-outbox-166283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y v3 1/2] mm/damon/core: do non-safe region walk on
 kdamond_apply_schemes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261010063042.8611-2-sj@kernel.org>
References: <2026092949-surpass-thimble-02a8@gregkh>
 <20261010063042.8611-1-sj@kernel.org> <20261010063042.8611-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 06:41:56 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/damon: double-application of earlier schemes to newly split reg=
ions
--

commit 01d768c4d318527360ef5913771d20f22a99984a
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

kdamond_apply_schemes() is using damon_for_each_region_safe(), which is
safe for deallocation of the region inside the loop. However, the loop
internal logic does not deallocate regions. Hence it is only wasting the
next pointer.

Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7afbc20833ea4..b5c85e6488596 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -912,7 +911,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  	}
> =20
>  	damon_for_each_target(t, c) {
> -		damon_for_each_region_safe(r, next_r, t)
> +		damon_for_each_region(r, t)
>  			damon_do_apply_schemes(c, t, r);

[Severity: High]
Does this code cause earlier schemes to be applied twice to newly split
regions?

If multiple schemes are configured, an earlier scheme (e.g. Scheme 0) might
apply its action to a full, un-split region. If a later scheme (e.g.
Scheme 1) then decides to split the region, damon_split_region_at() inserts
the newly split part into the list immediately after the current region.

Because this loop in kdamond_apply_schemes() now uses
damon_for_each_region() instead of the safe variant, the outer loop will
advance to this newly split region and call damon_do_apply_schemes() on it
again.

Will this cause damon_do_apply_schemes() to evaluate the new region from
the beginning of the scheme list, resulting in Scheme 0 executing its
memory management actions (like madvise) and counting statistics a second
time on the same memory range?

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010063042.8611=
-1-sj@kernel.org?part=3D1

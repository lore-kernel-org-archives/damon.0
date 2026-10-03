Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FB3A5E89
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050185; cv=none; b=WbhIgLN8nzgV4jEsSuBI304qJZ31MeeNnQ1eBYx6il1nm/dGwCwBL7dFdttuJBPVMzPlEZyMHCBidBATWLaI8JH/cLrAopMRKGatZBSnS6vRDrKXsmNw0QDecH4tre7snNWNT94A14C8Pmg/WOuDKlEyev2eV5DL1bPrkhR38Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050185; c=relaxed/simple;
	bh=NUTBPAABBhXvQUYkXfNhHe4QRlhLXcMx0Gn4O7S2GUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PGb2PdKJV2APtvIOJtJdak9xWwWtjfOH2wtIwNEInRvLyMBFvk313VQXPEfUt2v1iGcm5p1ni6RD5EovsYR0KhhFvBDAG6tAasSHK6PHtD2dCKW7TQ5Kl7YrQrT7HJd1Fw2a/X0IySrVEan1PI8Mh7CpsjEMqaTclRcIQFpt8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7NYAMD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7NYAMD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2081F0089B;
	Sat,  3 Oct 2026 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050183;
	bh=05shZExPXkVqzvolueM4AhkN7Ba3osJHr2wJ4SsF8cc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7NYAMD/TzmeK61ZgPYwCzW3d71plS8Lrd2/w/ts95XYIGJGHjIyrryItFrte+1xv
	 YdtdM5pb8AEIg3o6U5bWrRu75ubxNGxHERfeLFVPOOFKdDbhHWgchSwn74Oi/7drz2
	 dSswNzT1l8F6Q28S44veDHPVwJxGnZZ5mlWR1FxuKIbW7+nR4wiZ8ldxjB7qSqgnzC
	 wH13eUuzHpaYCnNiEC3DMhicbntjo9FP1QTnG4PeWtNA+lnksYBCISo3CuuJkmaBpy
	 0fllBIjujkhaaw69r2qpvlw6xdr2Lc0KJ+HAcSLJtbVchRZRV9dkjGVxqO/CLz0PqF
	 QYn1+ece5deDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/core: do non-safe region walk on
 kdamond_apply_schemes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003163101.32739-1-sj@kernel.org>
References: <20261003163101.32739-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:23 +0000
Message-Id: <20261003175623.7F2081F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: damon: state leak in damos_skip_charged_region() on split fail=
ure
- [High] mm: damon: double processing of regions due to dynamic iteration
--

commit 21f2d44a9b003b2e8d2502cbeb64ca223ff26e08
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

The commit replaces the safe region iterator damon_for_each_region_safe()
with damon_for_each_region() in kdamond_apply_schemes(). It updates
damos_skip_charged_region() to return true when a region is split, allowing
the new fragment to be processed in the next iteration.

Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c0dcb190b06e3..8217815de8982 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1770,9 +1772,7 @@ static bool damos_skip_charged_region(struct damon_=
target *t,
>  				sz_to_skip =3D min_sz_region;
>  			}
>  			damon_split_region_at(t, r, sz_to_skip);
> -			r =3D damon_next_region(r);
> -			*rp =3D r;
> -			skip =3D false;
> +			return true;
>  		}
>  	}
>  out:

[Severity: High]
Does this early return bypass the cleanup block at the out label?

If damon_split_region_at() fails on the final region due to memory
pressure, returning true here skips the out block that clears
quota->charge_target_from.

Could this leaked cursor cause the scheme to permanently skip all
subsequent memory targets in this and future evaluation intervals until
an allocation succeeds?

[ ... ]

> @@ -2329,7 +2329,7 @@ static void kdamond_apply_schemes(struct damon_ctx =
*c)
> =20
>  	mutex_lock(&c->walk_control_lock);
>  	damon_for_each_target(t, c) {
> -		damon_for_each_region_safe(r, next_r, t)
> +		damon_for_each_region(r, t)
>  			damon_do_apply_schemes(c, t, r);
>  	}
> =20

[Severity: High]
Can changing this to a dynamic list iterator lead to regions being
processed multiple times?

If a DAMON configuration has multiple schemes, and a later scheme splits
a region, the newly inserted right-hand fragment will be visited by this
outer loop in the next iteration.

Since damon_do_apply_schemes() evaluates all schemes sequentially,
wouldn't schemes that already processed the original uncut region
process the new fragment again, leading to duplicate memory operations
and double-counting in quota tracking?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003163101.3273=
9-1-sj@kernel.org?part=3D1

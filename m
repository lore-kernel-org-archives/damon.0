Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478987;
	b=wQklXX47L/pr9bV6VWTOEFwQTrkOdhEt67n8uz6FJ44/pxgEN0usB9KALB0+gRgPoAjW
	 KL7niiIksKvuf2Uo5727paOurfM9nduxQEjyYratld5OwVnROxsd3waR4WoI+TtsSXPhI
	 i2qOKOo33hx669UZMOSRJXii8bwKxK/3zVDAGflZR+rW3gs9HMmE/6QCDdJ9BzKMRZAIW
	 hBu9E27s9VpnzQfUCUQQQLjZN6lScMgOoyxzJFyDjBxh5FLIBFpp885d3qnArnUO6vDyv
	 ijauVC9rTM6fojt64BLRMYHLup//qc0tDUU3PN6c+KsZaBS0G5eYGgSUH7MoFfQoLjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q2ru2S13CIhq9NBkMO/MyjWR+bJSGBvY/6OTd8m0ekc=;
	b=iVVtR4IrOgFVJGa+/JagdtehXTlzABDrcl8wFoBRvR3Bk+zYYc1kVPFNM+drNN76XNeB
	 0XZvJAUM+N69pZQScTuKHDvJSgYB7FlWqzuajwxTrTZh1R/M+j68dXxP+YYD4za25Xx5G
	 sTqppt5ewT0HaMynjI7HDcsJoyPRhMGf9gME397WENH62JbmSqcxiCgTS5Sa6TrOZ7ELe
	 NyMvgWBYWPT8tQxhZ8nGH9Oz8wgFl5jgFSqWRFw+GEmgyTHaxRGg00ngC2XFarokfAki6
	 LZJ3Og0QBle6mT72f38s3q5ISguD22AoKxQ1QxAu9TCNx8K+/33FlD8HsLvbiQX4eAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdG3vwND;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F5606A31A
	for <damon@lists.linux.dev>; Sat, 31 Oct 2026 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdG3vwND
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D641F000C1;
	Sat, 31 Oct 2026 20:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478986;
	bh=Q2ru2S13CIhq9NBkMO/MyjWR+bJSGBvY/6OTd8m0ekc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MdG3vwNDiZqBbXbRaR7aLigmxsmYICLskNTiOc8ayqUhIVn2z+jB7T0SyI50RPytM
	 YkBd6Zeypm/gz3nEdxMbSgDrHJl0hEyaUp0SnEPtWvhSE6Vbeg2PCA1i5DyS08AkAd
	 gjnb5S+sWwmQNUwicq/YibUu8GCQHvGRtuP4oZShjR4mpj+Vx4PR4p/SLuN340qJUt
	 GYVGsiNB7pLYWUPqFdVNxh9DLsGM1y4wM43/a9S4qyL815Wgun7GQi1eHBk0GB8+gj
	 wR87c6vYk+BAgTrnMhqok9u+XPPRh9k0TtwtR1OoED5xOLbKyVdz9L0mC/nsrc1xGK
	 xuVedDGGGZLHw==
Message-ID: <sashiko-outbox-192118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/6] mm/damon/core: handle invalid target in
 damos_fix_stale_charge_pointers()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261031202614.96036-2-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
 <20261031202614.96036-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 20:36:25 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/damon/core: stale charge_target_from and skip regression on i=
nvalid target
--

commit 3b1cac25b68197d5c2819d4a16dbde02446b2d07
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle invalid target in damos_fix_stale_charge_pointers()

This commit moves the DAMOS quota charge pointer fixup for invalid targets
from kdamond_apply_schemes() into damos_fix_stale_charge_pointers().

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 73b571b429cb3..ce75db510a9d3 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3394,7 +3394,11 @@ static void damos_fix_stale_charge_pointers(struct=
 damon_ctx *c,
>  		return;
>  	damon_for_each_target(t, c) {
>  		if (t =3D=3D quota->charge_target_from) {
> -			if (damon_nr_regions(t) > 0)
> +			bool valid_target =3D true;
> +
> +			if (c->ops.target_valid && !c->ops.target_valid(t))
> +				valid_target =3D false;
> +			if (valid_target && damon_nr_regions(t) > 0)
>  				return;
>  			break;
>  		}
> @@ -3513,15 +3517,8 @@ static noinline_for_stack void kdamond_apply_schem=
es(struct damon_ctx *c)
>  	max_region_sz =3D damon_region_sz_limit(c);
>  	mutex_lock(&c->walk_control_lock);
>  	damon_for_each_target(t, c) {
> -		if (c->ops.target_valid && c->ops.target_valid(t) =3D=3D false) {
> -			damon_for_each_scheme(s, c) {
> -				if (s->quota.charge_target_from !=3D t)
> -					continue;
> -				s->quota.charge_target_from =3D NULL;
> -				s->quota.charge_addr_from =3D 0;
> -			}
> +		if (c->ops.target_valid && c->ops.target_valid(t) =3D=3D false)
>  			continue;
> -		}

[Severity: Medium]
Can moving the invalid-target reset from kdamond_apply_schemes() into
damos_fix_stale_charge_pointers() cause stale quota->charge_target_from
pointers and alter round-robin target skipping across multiple targets?

First, in kdamond_apply_schemes(), damos_adjust_quota() (which calls
damos_fix_stale_charge_pointers()) runs for all schemes before the
damon_for_each_target() application loop.  For virtual address space
monitoring, c->ops.target_valid(t) is damon_va_target_valid(), which
checks whether the target PID still has a live task_struct.

If the target referenced by s->quota.charge_target_from is valid when
damos_fix_stale_charge_pointers() checks it, but the process exits while
damos_adjust_quota() builds the score histogram or while
damos_apply_target() applies schemes to earlier targets, the target loop
in kdamond_apply_schemes() will see c->ops.target_valid(t) =3D=3D false and
skip t without clearing s->quota.charge_target_from.  For all remaining
targets after t in c->adaptive_targets, damon_do_apply_schemes() calls
damos_skip_charged_region():

mm/damon/core.c:damos_skip_charged_region() {
	if (quota->charge_target_from) {
		if (t !=3D quota->charge_target_from)
			return true;
...
}

which will skip every subsequent target for that apply interval.

Second, damos_adjust_quota() returns early before calling
damos_fix_stale_charge_pointers() whenever damos_quota_is_set(quota) is
false:

mm/damon/core.c:damos_adjust_quota() {
	if (!damos_quota_is_set(quota))
		return;
	...
	damos_fix_stale_charge_pointers(c, s);
}

whereas damon_do_apply_schemes() calls damos_skip_charged_region()
unconditionally.  If damos_quota_is_set(quota) becomes false while
quota->charge_target_from is still set to a target t (for example, when a
quota is disabled or its goal is removed via online commit in
damos_commit_quota(), which preserves quota->charge_target_from, and
quota->esz becomes 0), and t exits before kdamond_apply_schemes() reaches
t, neither damos_adjust_quota() nor kdamond_apply_schemes() will ever
clear quota->charge_target_from, causing damos_skip_charged_region() to
skip all other targets permanently.

Finally, when monitoring multiple targets [t0, t1, t2] where the previous
quota window stopped at charge_target_from =3D t1 and t1 has since exited,
kdamond_apply_schemes() previously skipped t0 via
damos_skip_charged_region(), cleared charge_target_from upon reaching t1,
and resumed applying the scheme at t2.  With charge_target_from cleared
upfront in damos_fix_stale_charge_pointers() before the target loop
starts, won't kdamond_apply_schemes() restart charging from t0 instead of
advancing to t2?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031202614.9603=
6-1-sj@kernel.org?part=3D1

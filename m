Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C0F4DAF86
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554555; cv=none; b=RFaVWSqYwMteYTh3onR8vZWNw+ADLyCa2etXUwXiXJEN2mot13L7IN8y3WpZ7o38iODiNG7sWypVJ7P2LE0+gK5ZUS75/oMgkk8N+Tc2BoPEg4hGqRA7+3zWMEB8UOR+5bms5r2aB0clvTUF1eV0n1EbKI2yfFcalo61q/fyuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554555; c=relaxed/simple;
	bh=boOtwdMkZ+4zg/pwkipUsdm3YpTeNwLaYKuG8D/aKZw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oDNZxSEXRYw1oodnvmDVcNLg43neUul5AlXo6AWIb4W4uocmjGsZPBWhQL0K5W2x7D9aR5R2so9/HLo4LYrJHmI/ACh+0QxIrdL5DzLXYI7Dhz3QsQ7xusf2s+wUxINQDVaNRXrIQLYR3ZU24x53RHhNVjsPCRub9ySNoqTtrXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZVDdPwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZVDdPwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9B11F000FF;
	Fri,  9 Oct 2026 14:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554553;
	bh=7cv6P0atzvoA8NyDclvv0+XPKn3m/uY8fu9PvpHAdsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SZVDdPwM8QBXgP6pftLhf8lEsSg3IKiJkuP/fRAUY2qacxhmDhzcLwFVzlkIyVxaf
	 FOEYbR0uk2+3a1Aogw21iQOZnhJOiebhJO25Kb2YJzmK+r0V9SgwtXlWyeSChDmOS5
	 IPWiDSuPKAAt8hFBFM32vlLvw/6IRyREQ4VASx3LSJyxiNVltB8WqygWO4PBGJQ6Yf
	 SwUikFpIUxCcgfDnVzAdWQ5Yk+pfrLIABiJhFFIjQ+zpSXGTlw1MWC4CfRUTZxaRNf
	 m24e3bXYgWfAVpUphPr7z96uttJjQVGXHWjeaB+yI8xDwAcygTNEyIM0n0KiJbR0V3
	 sx+MdlsDG+ukg==
Message-ID: <sashiko-outbox-165685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y v3 1/2] mm/damon/core: do non-safe region walk on
 kdamond_apply_schemes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261009134949.11507-2-sj@kernel.org>
References: <2026092948-moonrise-persecute-3597@gregkh>
 <20261009134949.11507-1-sj@kernel.org>
 <20261009134949.11507-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 14:02:33 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: damon: double processing of split regions by earlier schemes
--

commit de615e5101d6a41f308fef487cc464f7d25abb6e
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

This commit replaces the safe region iterator with damon_for_each_region()
in kdamond_apply_schemes() to ensure newly split regions are not ignored
during iteration. It also simplifies damos_skip_charged_region() by
removing a workaround that updated the region pointer directly.

Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index fe91b296f4c66..c86cac855b9b0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1134,7 +1134,7 @@ static void damos_adjust_quota(struct damon_ctx *c,=
 struct damos *s)
>  static void kdamond_apply_schemes(struct damon_ctx *c)
>  {
>  	struct damon_target *t;
> -	struct damon_region *r, *next_r;
> +	struct damon_region *r;
>  	struct damos *s;
>  	unsigned long sample_interval =3D c->attrs.sample_interval ?
>  		c->attrs.sample_interval : 1;
> @@ -1156,7 +1156,7 @@ static void kdamond_apply_schemes(struct damon_ctx =
*c)
>  		return;
> =20
>  	damon_for_each_target(t, c) {
> -		damon_for_each_region_safe(r, next_r, t)
> +		damon_for_each_region(r, t)
>  			damon_do_apply_schemes(c, t, r);

[Severity: Medium]
Will this change cause earlier schemes to re-process newly split regions?

When damon_do_apply_schemes() evaluates a region, it sequentially iterates
through all schemes. If an earlier scheme processes the region, it applies
its action and updates its quota.

If a later scheme then hits an address filter or quota while evaluating the
same region, it splits the region, shrinking it and inserting a new remaind=
er
region immediately after it in the target list.

Because the outer loop now dynamically fetches the next region via
damon_for_each_region(), this newly inserted remainder region is evaluated
in the very next iteration.

When damon_do_apply_schemes() processes this remainder region, it starts ov=
er
from the first scheme. Won't this cause the earlier scheme to re-evaluate
and apply its action a second time, potentially artificially double-charging
its quota and redundantly applying physical memory operations?

>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134949.1150=
7-1-sj@kernel.org?part=3D1

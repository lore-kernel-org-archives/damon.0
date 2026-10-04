Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245753B8D79
	for <damon@lists.linux.dev>; Sun,  4 Oct 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127739; cv=none; b=b3ELNhabQfrb7iXfr93YUlZmIcAAZpmREBEWw3zuQeR9OvKmM+zYv7IgPWTfOzGSlEIcTOO2bwO9P77iqDyDJ6Pc7ZvIAPjO3L4KviYpVk47RUODC0y15LJ5I/GuNBjLFhW+7JaobraEiBKqVn5n1DKiVu63L2JIHkcNQVxSwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127739; c=relaxed/simple;
	bh=CbteSrzfJufXyhzbdgGKv/LT29SFvIFhCExIlff9+AU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=po2Xa3B3KWzO93T8JT9f6qw7h1EpnbQmhH3ILKNBldqxeQjnu3UGGri+Qni4AUpTDpJGaGZ1J7CyrZO15uxIlai0PGSgW3Smg1TEBF1BNQz9bSW79Vp7TKUPvgK6dUms3N2GA2BBH938YXR+3MCpMJhWMQQkIbsqxmnpIZM6bWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBKJxQb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBKJxQb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6454F1F000FF;
	Sun,  4 Oct 2026 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791127737;
	bh=m5TmTUKHM+3x2QbDClekO8xvx7X7sMn0d53CLCbDg/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WBKJxQb4VE10Vz6CPnz+QoISl7YHlMx1h5NcVeHsUbjPzCLlQFY81YelvFv9kxbpl
	 hSZLnwK/JtHBEffd7bFbEn1Bn8qlbFwkI5JyyVfA9PIQCzzMNUGiL4pdqtLrMayRtB
	 4c/fLf9iH+1Y3A33TZaxTWBoBNGhPDqJFA21vrSF3KzY7pyOOpa5sroMCRAEu7Uw9W
	 ueNnloPZxFsi7V/xO9MdsYFSOM5jEvt9DB8csqbWaCRfMvw/EdblMBSiUTxpuEa8QA
	 I1LjGWTc0CwPCon1m8frpTpl6O/9LV6WcBXDanftlxTa2sPEjR5vyGQ3sL7VpBqfFM
	 JGxcnc5Dsyr/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y v2] mm/damon/core: do non-safe region walk on
 kdamond_apply_schemes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261004151730.4700-1-sj@kernel.org>
References: <20261004151730.4700-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 15:28:56 +0000
Message-Id: <20261004152857.6454F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/damon: double application of schemes due to non-safe region walk
--

commit 5f2353c7bc7cba2be5c7364e80d79941a4bb1709
Author: SeongJae Park <sj@kernel.org>
Date:   Sun Oct 4 15:17:30 2026 +0000

mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

This commit replaces damon_for_each_region_safe() with damon_for_each_regio=
n()
in kdamond_apply_schemes() so that regions dynamically split by scheme addr=
ess
filters are not skipped. It also removes the workaround in
damos_skip_charged_region() that adjusted the region pointer, as the new
iteration logic will naturally visit the newly split regions.

Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c0dcb190b06e3..02cc99aa6d3eb 100644
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
> +			skip =3D true;

[Severity: High]
When damon_split_region_at() splits this region, the remainder is inserted
directly after 'r'. Will this cause earlier schemes to process the remainder
a second time?

Because kdamond_apply_schemes() now uses damon_for_each_region(), the loop
will step into the newly split remainder region next. However,
damon_do_apply_schemes() iterates all schemes from the beginning for each
region. If Scheme 0 already processed the full region before Scheme 1 split
it here, Scheme 0 will now evaluate and charge the remainder portion a
second time.

[ ... ]

> @@ -2329,7 +2329,7 @@ static void kdamond_apply_schemes(struct damon_ctx =
*c)
> =20
>  	mutex_lock(&c->walk_control_lock);
>  	damon_for_each_target(t, c) {
> -		damon_for_each_region_safe(r, next_r, t)
> +		damon_for_each_region(r, t)
>  			damon_do_apply_schemes(c, t, r);

[Severity: High]
Does this non-safe iteration lead to double-charging quotas across schemes?

If a later scheme in damon_do_apply_schemes() splits the region (either due
to skip boundaries in damos_skip_charged_region() or quota limits in
damos_apply_scheme()), the new right-hand region is immediately visited on
the next iteration of this outer loop.=20

Since damon_do_apply_schemes() always begins its scheme evaluation from the
first scheme, any schemes evaluated before the split will process the newly
split right-hand region again, incorrectly double-applying physical actions
and double-charging their quotas.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004151730.4700=
-1-sj@kernel.org?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063993C9897
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785088623; cv=none; b=LmI4Yp0MMg54+SaEqXpbkyXenynCkJfEVHo/37/bPkepN/g8c3zRQwlXpE5fsQopquktrJ7tckTZTcUGEClz2x/u21WSBR8uKSFoE3ri1E4M3+qtfJJ4bSOmQ78fl/4tIr94J005XF8Uz0K8ySHRv1zg9/NfqEvOcPP2EsvGp1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785088623; c=relaxed/simple;
	bh=ymIH/AtTaXmPke1dvJpLk7PtsqjBLkLHdO5rvZ5hvyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k7AinrQPV7w/T0QOlPY1rfCpmEPF+utHCqt7XqVRubN0MVDw74kPAhwyhIkHHZ0PPX8FIg4DmOZriJ/jYlvYOsAwalG/VJjXNis7U6aKXN0+hFUcnCS2URw0kFhBik17oU/aOtsmiWK/zxrVmON8qZgV+YyU95eGEYJVsGH5Gtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHMBJgtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHMBJgtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E4D1F000E9;
	Sun, 26 Jul 2026 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785088621;
	bh=WuSuVd892DiK2WKxrVbqhutKvCeAX6SlpMJMGNLIwPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHMBJgtQ0ZHGM+64SA2wv/wznvhr7KkpwU4ddDyYTmQm8m3x9Dx/H65UxJ/SJ/Drz
	 cXVP7H/UWcalh4YcrmFSq0P97Uookhyn5beJFlmVf7VvbsRZcSAMCxI+5FQXt0sdxm
	 B/7syE65cPkCxM6LBOYLw46T4GG5PK3avlGjYJu8kIGzx7KvC61NGn4vbLkMAqS9Kq
	 uPrs/4Sw+ijkgae2FyL3fdW0jRr57S8DrOdfawl04R9vUK1dvrePLrwZd1IAW7L+PD
	 5B9wGBLS8XFcY+iuc5PFDqJ7wEQAOA2OvHBi/DJ/9QfYa/zDOwY3nZBnkN9OS2O6ns
	 2zJnVfeGqLhug==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/17] mm/damon/core: introduce
 damon_operations->prep_probes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260726173935.94046-8-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
 <20260726173935.94046-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:57:00 +0000
Message-Id: <20260726175701.89E4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] TOCTOU race in `kdamond_fn` across blocking wait leads to NULL poi=
nter dereference of `ctx->ops.prep_probes`.
- [Medium] Silent bypass of preparation actions when unsupported by operati=
ons set.
- [Low] API Contract Omission: `prep_probes` documentation fails to specify=
 the requirement to set `sampling_addr`.
--

--- Patch [7]: [RFC PATCH v2 07/17] mm/damon/core: introduce damon_operatio=
ns->prep_probes() ---
commit f3f60f13684ba2645da0754240dfe010fa41b859
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damon_operations->prep_probes()

damon_prep needs to be executed by the underlying DAMON operation set.
Extend the operation set callback list for the execution of damon_prep
actions. If the underlying operation set implements the callback, DAMON
core executes it in the monitoring preparation time.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 24b362fcf53b1..fe2c6b56d1d53 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -654,6 +655,8 @@ enum damon_ops_id {
>   * last preparation and update the number of observed accesses of each r=
egion.
>   * It should also return max number of observed accesses that made as a =
result
>   * of its update.  The value will be used for regions adjustment thresho=
ld.
> + * @prep_probes should execute required &struct damon_prep for next &str=
uct
> + * damon_probe applications to each region.

[Severity: Low]
Does this documentation need to specify that @prep_probes is responsible
for setting the sampling_addr?

Looking at kdamond_fn(), when do_prep and access_check_disabled are both
true, apply_probes() receives false for its set_samples parameter:

kdamond_fn() {
...
        if (do_prep)
                ctx->ops.prep_probes(ctx, access_check_disabled);
...
                max_wsum =3D ctx->ops.apply_probes(ctx,
                                access_check_disabled && !do_prep,
                                get_max_wsum);
...
}

This seems to leave prep_probes as the only callback receiving true for
set_samples, making it solely responsible for setting sampling_addr.

>   * @apply_probes should apply the data attribute probes to each region a=
nd
>   * accordingly update the probe hits counter of the region.  It should a=
lso
>   * set &damon_region->sampling_addr of each region if ``set_samples`` is=
 true.
[ ... ]
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 127d3a7c27280..7ea42983d1276 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3878,6 +3891,8 @@ static int kdamond_fn(void *data)
> =20
>  		if (!access_check_disabled && ctx->ops.prepare_access_checks)
>  			ctx->ops.prepare_access_checks(ctx);

[Severity: High]
Could the context's operations set change during kdamond_wait_activation()
(called just before this), resulting in a NULL pointer dereference here?

The do_prep flag is cached before calling kdamond_wait_activation().

If the wait blocks, a user could update the context's operations to one that
does not implement prep_probes (via kdamond_call() from a sysfs commit),
making ctx->ops.prep_probes NULL.

When execution resumes, it would use the stale do_prep =3D true value and
attempt to call the now-NULL ctx->ops.prep_probes(...).

[Severity: Medium]
Also, does this silently ignore user-configured preparation actions?

If a user configures a probe with preparation actions, but the current
operations set doesn't implement prep_probes, do_prep evaluates to false.

It appears the preparation actions are silently bypassed during execution
without returning an error during context commit, such as in
__damon_commit_ctx().

This could leave the user unaware that their configured actions are not
being applied.

> +		if (do_prep)
> +			ctx->ops.prep_probes(ctx, access_check_disabled);
> =20
>  		kdamond_usleep(sample_interval);
>  		ctx->passed_sample_intervals++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726173935.9404=
6-1-sj@kernel.org?part=3D7

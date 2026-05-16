Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1E35E1C8
	for <damon@lists.linux.dev>; Sat, 16 May 2026 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778972129; cv=none; b=JJNkVwqm4bZsd5PN1i7HU8Gr70Vb+yHQytcxn1804wQGvOBOb7T6azimcQtNcBJ0qTh2JCpQlWDX7fdU15CBeNIt/Ug+WM2kbmVonq22Fa9TcvjpWv8M9INDlVT6BmcolBLF/N55x6bke4Wcg05YK974twXQ9ob2UcRmVuwkh7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778972129; c=relaxed/simple;
	bh=e6rm8sxGCYiKlEuMZa/Q7yEW1gr+v1psSaxxlSj5aRQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IKh44ul67/giUfXMSc40MKBuq03YeYrd9wvIU2FcUXINVrG48tS4rB25yENRzM3k1lu39TFTVg0R/3rNcd6UPuyNOmWM71RDs1zRUuY1Iye5UjRbS6ARZXyv7wZp36BQpju73HE4fZ7JQHm3q4xwoBFA1fMZA2dIkYWOFwaV5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFJFergS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFJFergS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF04C19425;
	Sat, 16 May 2026 22:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778972128;
	bh=e6rm8sxGCYiKlEuMZa/Q7yEW1gr+v1psSaxxlSj5aRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AFJFergSPqFY7wnAJ7a7Goi72S+IQXlfzsU9s1f2XHUxe4bx4osEm0PjnnGCgSLNj
	 9JdtXmTXlElgQFcrpQlmxbmVJWJU0GNj8eTmjBbCSx43sFMuoSDhZl0xS98sSmq/03
	 dkfnxNyekwhPIEVTcyWn3Ij5dW5mN/AjjPbMTsP4thRABw5gBsQra20umrfv78ibur
	 mXFA9W5P+HI6S/FvcxQLYfwq+4lp0iy+Mb02kL2FGEEcGZvGqRYn1XRUtZwfESImvs
	 Tq4BiJDhYBuxZCgpYBmb5D8cPZBFgjFH2Hbau///Ad8rgXLoEsv8SvcNu/d0gjqRBr
	 5+AjzD3T0FNRw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/5] mm/damon/core: cap effective quota size to
 total monitored memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260516210357.2247-3-ravis.opensrc@gmail.com>
References: <20260516210357.2247-3-ravis.opensrc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 22:55:28 +0000
Message-Id: <20260516225528.BAF04C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The safety cap limits the effective quota output (`esz`), but fail=
s to cap the tuner's internal state (`quota->esz_bp`), leading to severe in=
tegral windup.
- [High] Accumulating the total monitored size into an `unsigned long` over=
flows on 32-bit architectures, permanently crippling the scheme quota.
- [High] Applying the safety cap can forcefully reduce the effective quota =
below `min_region_sz`, resulting in permanent scheme starvation for small t=
argets.
- [Medium] The safety cap is completely bypassed for statically sized quota=
s due to an early return, causing inconsistent API behavior.
--

commit afc20f6b1154f371b12a0f1f9ad37023b5bba0ef
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: mm/damon/core: cap effective quota size to total monitored memory

This commit introduces a safety cap on the effective quota size computed by
the DAMOS quota goal tuner to prevent it from exceeding the total monitored
memory.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2614,6 +2614,19 @@ static void damos_goal_tune_esz_bp_temporal(struct=
 damon_ctx *c,
>  		quota->esz_bp =3D ULONG_MAX;
>  }
> =20
> +/* Sum of all monitored region sizes across all targets in @ctx. */
> +static unsigned long damon_ctx_total_monitored_sz(struct damon_ctx *ctx)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	unsigned long total =3D 0;
> +
> +	damon_for_each_target(t, ctx)
> +		damon_for_each_region(r, t)
> +			total +=3D damon_sz_region(r);

Could the total variable overflow on 32-bit architectures? Since a single
DAMON context can monitor multiple processes, the combined virtual memory s=
ize
might exceed 4 GiB. Would it be safer to use u64 to accumulate the total si=
zes
and avoid wrapping?

> +	return total;
> +}
> +

[ ... ]

> @@ -2621,6 +2634,7 @@ static void damos_set_effective_quota(struct damon_=
ctx *ctx, struct damos *s)
>  {
>  	struct damos_quota *quota =3D &s->quota;
>  	unsigned long throughput;
> +	unsigned long total_sz;
>  	unsigned long esz =3D ULONG_MAX;
> =20
>  	if (!quota->ms && list_empty(&quota->goals)) {
>  		quota->esz =3D quota->sz;
>  		return;
>  	}

The commit message mentions this is a final bound after all other quota
calculations. If a purely static size quota is configured with no time limit
and no tuning goals, the early return here bypasses the new safety cap. Is
this intended behavior, or should the static quota also be constrained by
total_sz?

> @@ -2649,6 +2663,11 @@ static void damos_set_effective_quota(struct damon=
_ctx *ctx, struct damos *s)
>  	if (quota->sz && quota->sz < esz)
>  		esz =3D quota->sz;
> =20
> +	/* Safety cap: never migrate more than total monitored memory */
> +	total_sz =3D damon_ctx_total_monitored_sz(ctx);
> +	if (total_sz && esz > total_sz)
> +		esz =3D total_sz;
> +

Can this cap force the effective quota below the minimum region size? If
total_sz happens to be smaller than ctx->min_region_sz, applying this cap at
the very end would make esz smaller than min_region_sz. If that occurs, will
operations layer checks like esz - charged_sz < min_region_sz always evalua=
te
to true and permanently starve the scheme?

Does the goal tuner's internal state also need to be bounded here? While the
effective output esz is capped, quota->esz_bp remains untouched.

If a workload consistently misses its tuning goal, quota->esz_bp might
exponentially increase until it hits ULONG_MAX. Once the workload behavior
changes, could the wound-up state take a prolonged time to decay back down
below the physical limit, leaving the scheme unresponsive during recovery?

>  	quota->esz =3D esz;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516210357.2247=
-1-ravis.opensrc@gmail.com?part=3D2

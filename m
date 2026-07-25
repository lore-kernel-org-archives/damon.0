Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3AA303C9C
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785014056; cv=none; b=IgTgquKjCGeDfhgOEAVUnIARJI13SpJmLIjfTvOyc/mUmAedgaa/CTbPdPC/sdcUYqtuPthjGkTluJv+AYAchatrv+4qiaKDLLj6svEm53N7ODHypP1rk5KX8M4EAJjBed3McewR4EeOoIhRYTwinQ1ozKgGEsTS7Hxs7refnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785014056; c=relaxed/simple;
	bh=kudzMKAHJenXe76mRhuOD/LFDnMRoTbJ96cAZp3FLIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IU42jnIflWzYN6lSf/qRcbxOtUGM7WBFUB2g0hVlL5yPfNB1SVSxGbCGexPIg8i+oh0NkwjY0rdAMadQGNWoE9Y5hMyB3drgwIJl2sGWAvCVrtxMjx9/9AWnn2ieQQxe+cZWVqcuBayy5B31jiW5NpzUoUOMvEU2KuPyRO3RrJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL6PQQU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL6PQQU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED581F000E9;
	Sat, 25 Jul 2026 21:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785014054;
	bh=s5OQzxtUSNHJJldyBXs43YhXo205mSS1CCGGmXqnsz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WL6PQQU1aekQAG/9D6A1qZArLPWEhB76iEOPdxjaSM8/C0aUPxCU2x2puaWlhqHWd
	 qW+STEUeo61RHFQLV00npzSm9zsT+YblJf41yr8DRJWFXvphjXJ1qvq45+S/0X9F9h
	 SdbMLDsFmOAusW98kciyWWlEwTTKbgXXNOPwd5f+32Q12SmlFscT1MdoWvNSCXTcBY
	 Nbz2t6u6ue/Borvk9Ks5W2Nfn7Y9PRXq+FrWOXeERrdMaPGoWHoUEKm6TQj7hbyBRU
	 /M9tACS9fTccvZ/u779vKNfHLzAt2y3FH5iMAz5NChS4gmgla13NZgojzep42yn6wo
	 DkdX86gr6HW4Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/17] mm/damon/core: introduce
 damon_operations->prep_probes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260725210225.129944-8-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
 <20260725210225.129944-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:14:14 +0000
Message-Id: <20260725211414.8ED581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] prep_probes receives has_prep instead of access_check_disabled &=
& has_prep, causing it to overwrite sampling_addr during normal access chec=
king.
- [Medium] Uninitialized sampling_addr usage in apply_probes if prep_probes=
 is not implemented.
--

--- Patch [7]: [RFC PATCH 07/17] mm/damon/core: introduce damon_operations-=
>prep_probes() ---
commit 62e96fea7e813101fb4353abda03a93a90ef358a
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damon_operations->prep_probes()
   =20
damon_prep needs to be executed by the underlying DAMON operation set.
Extend the operation set callback list for the execution of damon_prep
actions.  If the underlying operation set implements the callback, DAMON
core executes it in the monitoring preparation time.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 127d3a7c27280..d5b1e0b5851a1 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3878,6 +3891,8 @@ static int kdamond_fn(void *data)
> =20
>  		if (!access_check_disabled && ctx->ops.prepare_access_checks)
>  			ctx->ops.prepare_access_checks(ctx);
> +		if (ctx->ops.prep_probes)
> +			ctx->ops.prep_probes(ctx, has_prep);

[Severity: Medium]
Could this overwrite the tracked sampling_addr during normal access checkin=
g?

If a configuration has a prep without probe weights, access_check_disabled
is false and has_prep is true. prepare_access_checks() sets sampling_addr=20
and marks it for tracking.=20

If prep_probes() is implemented by a backend, passing has_prep (true) here
instead of access_check_disabled && has_prep would cause it to generate
a new, unprepared sampling_addr that silently overwrites the tracked one.

> =20
>  		kdamond_usleep(sample_interval);
>  		ctx->passed_sample_intervals++;
> @@ -3892,7 +3907,8 @@ static int kdamond_fn(void *data)
>  			else
>  				get_max_wsum =3D false;
>  			max_wsum =3D ctx->ops.apply_probes(ctx,
> -					access_check_disabled, get_max_wsum);
> +					access_check_disabled && !has_prep,
> +					get_max_wsum);

[Severity: Medium]
Does this result in uninitialized sampling_addr usage in apply_probes() if
the backend doesn't implement prep_probes?

If a probe has a weight and a prep, both access_check_disabled and has_prep
evaluate to true, which skips prepare_access_checks().

If the current operations do not implement prep_probes
(ctx->ops.prep_probes =3D=3D NULL), that callback is also skipped.

When apply_probes() is called, set_samples evaluates to false (because
access_check_disabled && !has_prep is false). As a result, no function
initializes r->sampling_addr, and the uninitialized memory could be read
by apply_probes().

>  			if (get_max_wsum)
>  				max_merge_score =3D max_wsum;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210225.1299=
44-1-sj@kernel.org?part=3D7

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCCD3D5246
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790511294; cv=none; b=dWy9Mgs+8eQ70J4UGKvCXPm3OwAWJJSCpMMUlWZfTkVjb+nCvDACBZieyMuR8gDlsB1V+UWb67j3i1jNYIelDHcJuBFXnnkWh/3LfN/iW32ZQofvRobIqXsaLpLW6vvsZIlf4mumleLXa0TxfLk2CPAhzElh1IMoh5xk1GnmDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790511294; c=relaxed/simple;
	bh=bmcab5tv719vx2oeT2mvdhL7BOsJ5l1ohGxV97sBfbA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BwdNOslyvIpJzUa5RLpTii+HIDDURXcmkTq08hEjXUn6WFbffa1rGBorrMFi3F5SxBpRlpoKjpzDda3rziqLavQJkWQjB2ZsP1uFoe2dGDpQQnYr+oo1HRVx6eVlI9ZCwgR5AV/Wan5LvAKCBesM9mX3ShGlwcMldmOrxBHC8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaXRFSP5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaXRFSP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7A21F00893;
	Sun, 27 Sep 2026 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790511293;
	bh=cECjaHVr3C9YylGYGcAadUdUOYDJ6fQF5AVXATq8gfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SaXRFSP5nNb0AlubnhA3HlAIkqcA3Dzl32TP4Nn/xqgEjuQzUQicv61nVEFgHc86h
	 rCu+iTkTFaMhm+rm/WismjyVnbjghkixaz5Uhs1f8aQ4zG+APNogI/rEFLLV+ajuTZ
	 YlO2E0pEYKHym/NEJZlc1jNjp3q0XvvY9E/LHn89U7ppd30MXsseWFbg9MAqBdieJS
	 V3BZ2FRVDCP871MI8kGkduQbYYVGZF0nZKwP26aVfN3Zip3MTTkxH1m5YcPL6WrFb9
	 CVciL/dorE3VXAQzCejxo5WDxG+st0V7VHoqcZWxgukoynGi38RARy8AYg3nWhCRZ+
	 KSFC1U0SmY/wA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 7/7] Docs/ABI/damon: update for quota goal metric
 complement sysfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260927120533.50484-8-sj@kernel.org>
References: <20260927120533.50484-1-sj@kernel.org>
 <20260927120533.50484-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 12:14:52 +0000
Message-Id: <20260927121452.ED7A21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm/damon: build failure due to typo 'complementfalse' in tests
--

commit c13d1579fc49797d69a40d8e22286757e16cdd20
Author: SJ Park <sj@kernel.org>

mm/damon/core: add complement argument to damos_new_quota_goal()

This commit extends the damos_new_quota_goal() constructor to receive and
set a complement flag argument. It updates all API callers to use the new
signature to prevent manual assignment mistakes.

[ ... ]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index df84d9cc7d204..20bba7421a406 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -930,6 +930,7 @@ static void damos_test_commit_quota_goals_for(struct =
kunit *test,
>  		 * Make it kfree()-able.
>  		 */
>  		goal =3D damos_new_quota_goal(dst_goals[i].metric,
> +				dst_goals[i].complementfalse,
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Does this code cause a build failure when CONFIG_DAMON_KUNIT_TEST=3Dy is
enabled?

The struct damos_quota_goal does not have a member named complementfalse,
so accessing dst_goals[i].complementfalse in
damos_test_commit_quota_goals_for() fails to compile. Should this be
dst_goals[i].complement instead?

>  				dst_goals[i].target_value);
>  		if (!goal)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927120533.5048=
4-1-sj@kernel.org?part=3D7

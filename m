Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A33C060E
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790511151; cv=none; b=hVMByS1AuCnWKQZK7pW32dKWp3Xpb5qCGfXgWGT/17EZRXvZOjrJTiK9i2Pc772Qz2ruOrIma9BDdu41G/j7yEo6FHM70a1Uafr/PBaLRsRF51YbfB0huuCJJeQ/1mf+XE8uRAZA9L4g6ODf9s4xvlTdFkZdKuRscfGbWrIsXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790511151; c=relaxed/simple;
	bh=Js3avhUlpQxe7rGB2nRdt/6J5wUDTS3PldzwE2gNfZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=onvZ6UrcbdpXeb97qbj6iYLarPIGmHBdUfMIbZTA0YFvop4SZyRPkNfRyC3JN1YfRZYa/0do9Y0HS1PHuLj2ScsowEw0QMVhOck/0Tb/eIYXuqB16it/sbioTBKgL0oZDptz8jnRWuXOzV2JTW2g0JGdwubU8Ck/P7KOV5+FjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqSSJF99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqSSJF99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE811F000FF;
	Sun, 27 Sep 2026 12:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790511149;
	bh=RTeznr9FFEMpe7c3phSZtPyP+JqEkJm7uq/DK4zlVds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqSSJF99JHHca+r3C3quIvJ3/Pso2MTBboFPurDg1lbZdXCSi8iY8g2Ia45ZoaFkT
	 IUPyc494p9AnLDXLQ+ua2UL+Eo0SCynWwGgTHzYWrDEeT4ThktTKPk+xXs8SSAOqKU
	 bVErtBwUuB3ihg/wSqWPtsx/MtWwpl6TAR9uMdXEs1kDo1sUJjeVVMsB46LHgYN312
	 4SeGs1WdICHRmnmLm8MXiVWMX8H05FLmFswjcABPYzyC/H2MEf2oUm9XhJRWx2+NOA
	 5tih4f5cH5akAIDWp4g2mMtIqSexHFC1QeXKOJL3XbmspDlfj0mbUKrmNfW7fav0dg
	 lw6di9sfgzUtg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 2/7] mm/damon/core: add complement argument to
 damos_new_quota_goal()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260927120533.50484-3-sj@kernel.org>
References: <20260927120533.50484-1-sj@kernel.org>
 <20260927120533.50484-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 12:12:29 +0000
Message-Id: <20260927121229.7AE811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] damon: build failure in KUnit tests due to 'complementfalse' typo
--

commit c13d1579fc49797d69a40d8e22286757e16cdd20
Author: SJ Park <sj@kernel.org>

mm/damon/core: add complement argument to damos_new_quota_goal()

Extend the quota goal constructor, damos_new_quota_goal(), to receive and
set the complement flag value. This commit also updates all callers to use
the new signature.

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

[Severity: Low]
Does this code cause a build failure when compiling the KUnit tests?

In damos_test_commit_quota_goals_for() within mm/damon/tests/core-kunit.h,
it looks like there is a typo (complementfalse) which will break the
build when CONFIG_DAMON_KUNIT_TEST=3Dy is set.

>  				dst_goals[i].target_value);
>  		if (!goal)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927120533.5048=
4-1-sj@kernel.org?part=3D2

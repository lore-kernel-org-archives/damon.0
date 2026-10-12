Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056F499F0D
	for <damon@lists.linux.dev>; Mon, 12 Oct 2026 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818093; cv=none; b=r6ah/xZ2M9JJk6mWq+pmXDesblrWtNI39+MuDjJ6y8CO71duhvgVao1ePeOUe7n9qDXuPiuZ6dYGXbMtaQ2SZhEccPPP73QKK/CNM9SuAsoKJyWyux2FV4VRn2n/77o4x/m/7YNKNVRpZ7oNa2hjHIA9oamJZb459iKLWvK7xms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818093; c=relaxed/simple;
	bh=nBp44IX/LvaPh/MU/21jFn+MM2lynrXQlQxy1QtkEfQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=o1+RNs4nCXXfuuVo/ig9G/kLsJAF2l+lLFjXls6kRoR3DIp7sNDFIXVweAkAuAk9rjm013XPnfIlZybt+VWOGI5PRnU8+rAzIsnfDaM9shspuEoJp/CBfiwgaeZYZumjfFWfXBYQM8mWEq+605xoVsZ9ZZCgDXiSPfDQQKgtCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6Ukee/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6Ukee/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BE91F0089B;
	Mon, 12 Oct 2026 15:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818092;
	bh=KMLN4ixUpAOM0its3R+3Mc1AIZxbVXRVDRYqznRSzUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U6Ukee/bysg/fUhky/UIhIaYKfnF5ib2dv8pDuNayM0qV1j/Jm3F6XOOBRoLBNY3l
	 DeMaR/5Qe0iQlSbHU+yggjSCHpUyJ8G0udFoLBeR+rkCkiB9ueC4wMV0+w50E30RJc
	 vuxiA1u5d9dasi74AAsYszwOpHSAV+WJmHQ5HGoWR6oRAPC8Z3bkWMwORqDLH6F34E
	 GhHrRLNsApAFfSyu3UQ2xnLEEuKJjxYfyiFfpeGnpezGcu+7Um2EMqzbj0pcMOGvw0
	 ZDevpSBcTencRKrOb9RpMb1Vx5A7325BCayQAl0A27knNxjP2B1kEbp2zs47Aww3AL
	 IAfZlV7wQbsRQ==
Message-ID: <sashiko-outbox-168320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] mm/damon/core: Use only installed probe in
 damon_merge_two_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suhaas Joshi" <suhaas@s-joshi.in>
Cc: damon@lists.linux.dev
In-Reply-To: <20261012150045.169377-1-suhaas@s-joshi.in>
References: <20261012145636.168436-1-suhaas@s-joshi.in>
 <20261012150045.169377-1-suhaas@s-joshi.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:14:52 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm/damon: memory leak of test resources on damon_new_probe() failure
--

commit 04d02846ea56f0db196cf44b60e21ab0f25afe04
Author: Suhaas Joshi <suhaas@s-joshi.in>

mm/damon/core: Use only installed probe in damon_merge_two_regions()

This commit optimizes region merging by iterating only over installed
probes rather than the entire maximum probe array. It also introduces
a struct damon_ctx parameter to damon_merge_two_regions() and updates
tests to pass this new argument.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 3fbb4e4e36fac..385d32901650e 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
[ ... ]
> @@ -206,7 +208,21 @@ static void damon_test_merge_two(struct kunit *test)
>  	r2->age =3D 21;
>  	damon_add_region(r2, t);
> =20
> -	damon_merge_two_regions(t, r, r2);
> +	p =3D damon_new_probe();
> +	if (!p) {
> +		kunit_skip(test, "probe alloc fail");
> +		damon_free_target(t);
> +	}

[Severity: Low]
Does this code leak the allocated target t and its regions on probe
allocation failure?

Since kunit_skip() invokes kunit_try_catch_throw() which halts the test
case execution immediately, the code does not return from this macro.
This means the subsequent damon_free_target(t) call is unreachable dead
code.

Should the cleanup be performed before calling kunit_skip(), similar to
how it is handled in the subsequent context allocation failure block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012145636.1684=
36-1-suhaas@s-joshi.in?part=3D1

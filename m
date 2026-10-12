Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A04921A6
	for <damon@lists.linux.dev>; Mon, 12 Oct 2026 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818099; cv=none; b=q0w3LeHXkhzR1xD3dEyAF3qdlCIBZIRNOlPQwMVLUIwuOZ2De+ht+M9MELJCiSKbtjcspLqwfRfdOy7Ho1KXNZmYpxU3wpVg12hVao0WHQsy1SqgfqnQencjZHzGhQxyY5UrVhjUq6iR7Vy1noo7TApO1mj10wdszm65HCCjNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818099; c=relaxed/simple;
	bh=ZuV36dee78Y5cJZ1O4JQ/LCcP2kuASj0u+RRvk7wGbw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VyJOO5gq+DFfnhtTcZlrKg3urCZqcbIO5Ltfmd3k0luI3KNxSu5jssY9xyz1W1E86RUWqzCRGm5n4KAC5PY28OIwS+HmimOuzbPhyGOu1ZmXeltReMfwd7NFvGTgr70bsp00jR07/066q70I3R8+Lb9GGxMF+n+wK3qvXyxretg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbi4nClp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbi4nClp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295191F0089B;
	Mon, 12 Oct 2026 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818098;
	bh=4CydOBsWjKx4yBz5n/w+f2k2cHPlhmjKp3il3fGPnUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hbi4nClpNgSNOzgxzfYerw69X5qRstnLkXHWEVjYAxFGCf4d+JjCpMYcBqPnibZBA
	 0o0OsHxpBak+R4BCWikgIx7LbVEFnOBxFB1VLpH4IfhNC8nM+hs1KLnW80d9/RYQmU
	 gqWocFRsLGmD7p8u4cEsQh2c0Pcs5TQlkPOjd4imOJxzrBpTymAf22Oc6DI02RwC16
	 j66gL2akRVw/zVZ8L2Bi/hlXE92w6fIv1sHW/H+6kiQooLrRp8r3JIKAu3atdZsYA0
	 VEsWGixb14Kb1TmGx8nCLARHrGidNkZuRSVeYN+miadX4kgYhsJxTTrjmlWxruGluj
	 R8jhUrgDJ9nVA==
Message-ID: <sashiko-outbox-168321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] mm/damon/core: Copy only installed probe in
 damon_split_region_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suhaas Joshi" <suhaas@s-joshi.in>
Cc: damon@lists.linux.dev
In-Reply-To: <20261012150045.169377-2-suhaas@s-joshi.in>
References: <20261012145636.168436-1-suhaas@s-joshi.in>
 <20261012150045.169377-2-suhaas@s-joshi.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:14:57 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mm: damon: memory leaks in kunit tests due to unreachable cleanu=
p code after kunit_skip()
- [Low] mm: dead code and memory leaks in DAMON kunit tests on error paths
--

commit 0052b3fffc74be07964d42e4abe4023a18442771
Author: Suhaas Joshi <suhaas@s-joshi.in>

mm/damon/core: Copy only installed probe in damon_split_region_at()

This commit updates damon_split_region_at() to take a struct damon_ctx
pointer, iterating only over installed probes when copying probe hits.=20
It also updates all callsites and KUnit tests to supply the context.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 385d32901650e..61ce085549a66 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
[ ... ]
> @@ -150,13 +152,25 @@ static void damon_test_split_at(struct kunit *test)
>  		damon_free_target(t);
>  		kunit_skip(test, "region alloc fail");
>  	}
> +	p =3D damon_new_probe();
> +	if (!p)
> +		kunit_skip(test, "probe alloc fail");

[Severity: Medium]
Since kunit_skip() internally calls kunit_try_catch_throw() which is marked
as __noreturn, execution will halt here.

Will this leak the previously allocated target 't' and region 'r', as they
are not freed before calling kunit_skip()?

> +	ctx =3D damon_new_ctx();
> +	if (!ctx) {
> +		damon_destroy_probe(p);
> +		damon_free_target(t);
> +		kunit_skip(test, "context alloc fail");
> +	}

[Severity: Medium]
Will this leak the allocated region 'r'?

In damon_test_split_at(), 'r' is allocated early, but it is not attached to=
=20
the target 't' until damon_add_region(r, t) is called later. Calling
damon_free_target(t) here won't free 'r'.

[ ... ]
> @@ -206,7 +222,21 @@ static void damon_test_merge_two(struct kunit *test)
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
Is this damon_free_target(t) call unreachable dead code?

Because kunit_skip() does not return, any cleanup code placed after it will
never execute, which results in leaking 't' and its attached regions.

[ ... ]
> @@ -1802,28 +1834,42 @@ static void damos_test_filter_out(struct kunit *t=
est)
>  	}
>  	damon_add_region(r, t);
> =20
> +	p =3D damon_new_probe();
> +	if (!p) {
> +		kunit_skip(test, "probe alloc fail");
> +		damon_free_target(t);
> +	}

[Severity: Low]
Does this have the same unreachable dead code issue as the one in
damon_test_merge_two()? The damon_free_target(t) is placed after the
__noreturn kunit_skip() call.

> +	ctx =3D damon_new_ctx();
> +	if (!ctx) {
> +		damon_destroy_probe(p);
> +		damon_free_target(t);
> +		kunit_skip(test, "context alloc fail");
> +	}
[ ... ]
> @@ -2468,7 +2515,14 @@ static void damon_test_last_region_quota_reset(str=
uct kunit *test)
>  	s.quota.charge_target_from =3D t;
>  	s.quota.charge_addr_from =3D r1->ar.end;
> =20
> -	skipped =3D damos_skip_charged_region(t, r2, &s, min_region_sz);
> +	ctx =3D damon_new_ctx();
> +	if (!ctx) {
> +		kunit_skip(test, "ctx alloc failed");
> +		damon_free_target(t);
> +	}

[Severity: Low]
Again, is this damon_free_target(t) unreachable because kunit_skip() aborts
the execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012145636.1684=
36-1-suhaas@s-joshi.in?part=3D2

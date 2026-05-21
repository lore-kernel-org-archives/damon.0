Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B912BDC13
	for <damon@lists.linux.dev>; Thu, 21 May 2026 04:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336327; cv=none; b=dMHuKbmD0HwmHX3OHSqWaQj02JFNGnb5DXfpjYMt1/bHcu6FoVA0YdVnmM4UMdqSk1GW6Zs8bIdx4PQkZad6I7vXEb2Sv45s01k81j/s8TC6a6KiQnb3Oq57HhIeHO5yNijw608BkDjb/fatJL9ye+HZS9DX8MebHQnvkbWZ+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336327; c=relaxed/simple;
	bh=mTQM38nGm7ZKE7EQ/RZRp/a+/SHVPY9ps/Sge9pI+9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ia1g0RqiTshPKZSIszTbGKtwqFMN42pnqatpBeHVg7XlI/7rcWk5HgkIvKQkvH2FYAXYt3Ar6MO0NgjCIpttrTqrKJ1+/9bIebtUeC0w9B/j6RVh/z6fpQRJ1Y/NQK5stbwgWeBxN8qFVqsKmBADPkaWXO6y7Q1OkqSrO68YDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxi0o7uV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxi0o7uV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620A81F000E9;
	Thu, 21 May 2026 04:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779336326;
	bh=8t59k+yfQ+I0yzkp3pN7jJdl4Q5mLTewVyrOu0Jw1L0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qxi0o7uVGmYK1XJT0MCWzD5XHstBaesoookCljjHGbsxa/J3x4H6gnAj9C6UDOKum
	 sZPDAhVDnWet8Rs00zwanvgJLmU3wj0Nk/jLvezyYdYqgKoRbzfnTOEvpnxoNuyvga
	 HApr7vDMdXBTUE6oUyvMPm/tMbpiJ0G0+VY/d0IqukXmFXdgceF+INz3Eco7MF8bVC
	 3T4BYWPSJRusxrLgbY73uhRSTtNiiGmNNKre7qWqM1icZcpX5pIGyqlp2IPAwgd8He
	 2nx2b8LXZvplGTSMAVnA9IH8NEhl8KRZA4gVFgHJv07LZuqddePtCV7b4XJRdJIDlR
	 iD0TQYZO5lQSw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 04/14] mm/damon/tests/vaddr-kunit: replace
 damon_add_region() with damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260521035349.87565-5-sj@kernel.org>
References: <20260521035349.87565-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 04:05:25 +0000
Message-Id: <20260521040526.620A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of the `damon_target` structure and attached regions=
 when `damon_set_regions()` fails.
--

commit e0458a31c6f6c7f46d6a9ef3e90d4098d89686fd
Author: SeongJae Park <sj@kernel.org>

mm/damon/tests/vaddr-kunit: replace damon_add_region() with damon_set_regio=
ns()

This commit updates the DAMON virtual address operation set unit tests to
use damon_set_regions() instead of damon_add_region() for region setup. This
aligns the tests with how other DAMON API callers set up regions.

> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> index 98e734d77d517..de30db9b753e5 100644
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h
> @@ -132,22 +132,32 @@ static void damon_do_test_apply_three_regions(struc=
t kunit *test,
>  				unsigned long *expected, int nr_expected)
>  {
>  	struct damon_target *t;

[ ... ]

>  	t =3D damon_new_target();
>  	if (!t)
>  		kunit_skip(test, "target alloc fail");
> +
> +	ranges =3D kmalloc_array(nr_regions / 2, sizeof(*ranges), GFP_KERNEL);
> +	if (!ranges) {
> +		damon_destroy_target(t, NULL);
> +		kunit_skip(test, "ranges alloc fail");
> +	}

[ ... ]

> +	if (damon_set_regions(t, ranges, nr_regions / 2,
> +				DAMON_MIN_REGION_SZ)) {
> +		kfree(ranges);
> +		kunit_skip(test, "damon_set_regions() fail");

[Severity: Medium]
Does this error path leak the damon_target structure and its attached regio=
ns?

Unlike the earlier kmalloc_array() error path which calls
damon_destroy_target(t, NULL) before skipping, this failure path seems
to omit the cleanup. Because kunit_skip() aborts test execution via a
long jump, the target allocated via damon_new_target() wouldn't get freed.

>  	}
> +	kfree(ranges);
> =20
> -	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
> +	if (damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ))
> +		kunit_skip(test, "second damon_set_regions() fail");

[Severity: Medium]
Could the same memory leak occur here?=20

If the second damon_set_regions() fails, kunit_skip() is called without
first freeing the target structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521035349.8756=
5-1-sj@kernel.org?part=3D4

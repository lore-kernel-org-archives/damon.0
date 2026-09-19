Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284EA1BD9D0
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789805561; cv=none; b=NLEgSYrXJ/EvPkju+rDSfgsHDzemlR1nUHiypdnxestPyFMdk+4lQElNStpPmvwsagkRVQh4lsjBlzwooGgKQBe73ZUITxB4oNb0wL/hCBvHXQw1TeJxNJi7ub6BylRK0vzN9PKwB9Qfd8XkAaCyJZGb0J4CItFzqVqE7Me8gaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789805561; c=relaxed/simple;
	bh=OgPvuqO83BEvuGghuiy3CR+xmL87HIA6P4eWJ+A2C1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cAfgTUkEawto+30sJy7P8ZEgZ0IY1oTk5SuqrmuWJWPVtP5c4X8ntCrLp1mXZB6ToaygoD+GzhT0qO3Y1k21XtrzjT+DPjBuqbqsHYFN7WYeM56ZON1xLM85+zdRohKWzJT7gkv1JPb+07i4AfTqR2rmDBxk+QGi1xxtgNq/eIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHQcK6Ds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHQcK6Ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3D91F000FF;
	Sat, 19 Sep 2026 08:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789805559;
	bh=lwP3A/673VbgDfoQCrTICraehMl+miQlS62+ZX9wtFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VHQcK6DsSshgtvZHd77G+cTjQxFbllH7TUXGTlFUrSn+/B4wBT9XTlhsnf9vv9SG0
	 6WhgDJg1Uz87H+5CveUANWRrIcEOUNpzWzVvIe/8EAbSF7YYRo/ha+g5JdYVGWMIRp
	 WI+tlX6NHqMh3UoN8X+FQC4e0McvT4Lo2cKCbzEk9DzeU/3mAxx6lX2SeiBcjdMMeh
	 xXy6AByL05Zg0XwA1SEhqyMgaVq0jMKFAcrb7TDzjCgk5GKtgtxeTC66TkimZCFXh1
	 oVFGEr2qJV5ApGrVr8+RPVpvNj17pgijo8ZtU2SHNQto/VDqfMiCHAfK3iROQ84KMM
	 duJfozE1ZKICA==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH] mm/damon/tests/core-kunit: add test for
 unconditionally skipping the last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260919080453.628679-1-aethernet65535@gmail.com>
References: <20260919080453.628679-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 08:12:39 +0000
Message-Id: <20260919081239.8A3D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: invalid non-power-of-two alignment in damon test
--

commit a99d6a5362b525870f71ce4be82705b420aea7ef
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/tests/core-kunit: add test for unconditionally skipping the last r=
egion

This commit adds a kunit test to ensure the last region is not skipped
before it is processed.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 5ff0436c58441..84e50f08f417d 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h

[ ... ]

> @@ -1929,6 +1929,48 @@ static void damon_test_rand(struct kunit *test)
>  	}
>  }
> =20
> +static void damon_test_last_region_quota_reset(struct kunit *test)
> +{
> +	struct damos s =3D {0};
> +	struct damon_target *t;
> +	struct damon_region *r1, *r2;
> +	unsigned long min_region_sz =3D 10;

[Severity: Low]
Is it safe to initialize min_region_sz to a non-power-of-two value?

The ALIGN_DOWN() macro inside damos_skip_charged_region() relies on bitwise
masking and mathematically guarantees correct alignment arithmetic only when
the alignment boundary is a strict power of two. Passing 10 yields incorrect
values (e.g., ALIGN_DOWN(120, 10) incorrectly evaluates to 112).

> +	bool skipped;
> +
> +	t =3D damon_new_target();

[ ... ]

> +	s.quota.charge_target_from =3D t;
> +	s.quota.charge_addr_from =3D r1->ar.end;
> +
> +	skipped =3D damos_skip_charged_region(t, r2, &s, min_region_sz);

[Severity: Low]
Can this call silently corrupt the region skip calculation in the future?

While the current test parameters bypass the ALIGN_DOWN() logic inside
damos_skip_charged_region(), any future expansion or variation of the test
that hits the branch will encounter the incorrect alignment arithmetic
caused by min_region_sz being set to 10.

> +
> +	/* 'r2' is not processed, it should not skip */
> +	KUNIT_EXPECT_EQ(test, skipped, false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919080453.6286=
79-1-aethernet65535@gmail.com?part=3D1

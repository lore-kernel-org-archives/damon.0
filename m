Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857409;
	b=HoLW/HGRVnB50qDEcIjjWtnh2KCx2X3V6lz9OOA/WK0ZimQIt7g1mzCdFdm1nwX3c11K
	 iCzs9VNl+1bTwjkOsSPlyzdW80GF+et7rXBbgegiQrhlnWj45DlR7bD7huaUFQYl7Ej5y
	 0RfqPCiENaOObbQ1IvkEHOv6iu88LABEcbhtLYHHHEZYxAnFNcKU93dWHWvKjwYVtlVZe
	 HYnShmhzceIjYW0xX6DGye/7mVfItqvG3r7sAmfqA6wCJ8HUe0L8t7y37OF+PMhHReIck
	 V+c2F94znnIpE1Pf1HvABzLzPl4twpkR5LFH2H3uTYMW73zZamHlYa4HZS+Sp4HoINA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857409;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bo/CR0SsELHFfPRDIloEEvLL0kxbrHtpD01b5Y9R2Dk=;
	b=RJpvMscd2z6fwhHElQ94xYp6PDO/MoDIWzoQKVr5tXjw3SHAOd3twvCxmPZHq32aPbaz
	 IphoaR8PC54fhw2mMKLkSVApxG8OFCdRqd5EcQmJNiQR2nFBjJVZHRENHiBnLj/C8hOlo
	 i7areOqlBlK4qe/NzKFWfzQm0DpEq8sjFYjSNeHPb2qTENgEi6dZOvfql1dyuJ8cftVfy
	 1V+B/Zk4iTSifTEchsUQ0DVD0ipF03+AvGHStS/29Ryd2PMuCn2HFGU+h/rMogzXD1pwH
	 x58CpBtEov1yFn5Is/hlb4fPmYVAutDIK43663jaTJk+EyDnHnQGy2bwwcc16DCTMlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XpQze/+2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D3606A329
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpQze/+2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986BF1F000C8;
	Mon, 16 Nov 2026 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794857409;
	bh=bo/CR0SsELHFfPRDIloEEvLL0kxbrHtpD01b5Y9R2Dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XpQze/+29bH6dcz7C0L8T+YU9J/gAOw6GMnnw1ho4vBXuIFcuO7JnbLkj2Q+Ilmci
	 0nUGb4Zq+Z3Rm6pYKRew1ufv4/xwbtsWBOH2BdxvRKdqKsyVPyG/mYSchZ09JCMBgJ
	 sSyUriTXykQZu0wrW7Ky99Zr2JMmGiQJx8GjaypGr57RqAqvAoOoiLeIPm55Ury/9t
	 bKYLOJyke/Rrexv8b9lL1UKM7PHOHnEA9gMUkB3EAIdwAuro6YHgsVXdN0ra9VaG7z
	 7Uhbh2u/AX9UXPsWcQkIpLgnJMu6DoQsSVK0VHrgVaVv5Q7pG8uXPhYscpzcizHthG
	 VQIk+JqslgYzA==
Message-ID: <sashiko-outbox-217563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] mm/damon/tests/core-kunit: test
 sz_ops_filter_passed_last
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattathias Pinchover" <mattathias.pinchover@uber.com>, "SJ Park" <sj@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261116-damon-sz-ops-b4-v1-3-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
 <20261116-damon-sz-ops-b4-v1-3-1cffe7227e6d@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:30:08 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mm/damon: uninitialized core_filters_default_reject read in
  kunit test
--

commit 64315024865456d25a50aac3fbbdfa4d480bec80
Author: Mattathias Pinchover <mattathias.pinchover@uber.com>

mm/damon/tests/core-kunit: test sz_ops_filter_passed_last

This commit adds a KUnit test verifying that s->stat.sz_ops_filter_passed_l=
ast
records the ops filter-passed size for the last apply interval and remains
unchanged between apply intervals.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index a5ca4bfe2f0db..ec83598fff0e6 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -2541,6 +2541,97 @@ static void damon_test_last_region_quota_reset(str=
uct kunit *test)
[ ... ]
> +static void damos_test_sz_ops_filter_passed_last(struct kunit *test)
> +{
[ ... ]
> +	c =3D damon_new_ctx();
> +	if (!c)
> +		kunit_skip(test, "ctx alloc fail");
> +	c->ops.apply_scheme =3D damos_test_apply_scheme_passed_stub;
> +
> +	s =3D damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
> +			NUMA_NO_NODE);
> +	if (!s) {
> +		damon_destroy_ctx(c);
> +		kunit_skip(test, "scheme alloc fail");
> +	}
> +	damon_add_scheme(c, s);

[Severity: Medium]
Does this leave s->core_filters_default_reject uninitialized before
kdamond_apply_schemes() runs?

damon_new_scheme() allocates struct damos with kmalloc_obj() without
initializing core_filters_default_reject, and damon_add_scheme() does not
set it either.  When damos_test_apply_interval() runs
kdamond_apply_schemes() -> damos_apply_scheme() -> damos_core_filter_out()
with an empty s->core_filters list, damos_core_filter_out() returns
s->core_filters_default_reject directly.

If that slab byte is non-zero (for example when reusing a struct damos
freed by an earlier test in damon_test_cases[] that set
core_filters_default_reject to true), damos_apply_scheme() filters out the
region before calling c->ops.apply_scheme(), causing KMSAN/UBSAN warnings
and false test failures with s->stat.sz_ops_filter_passed_last remaining 0.
Calling damos_set_filters_default_reject(s) after damon_add_scheme(c, s),
as in damos_test_apply_scheme_quota_sz(), initializes the field.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-damon-sz-o=
ps-b4-v1-0-1cffe7227e6d@uber.com?part=3D3

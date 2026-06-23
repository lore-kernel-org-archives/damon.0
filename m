Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD823859EB
	for <damon@lists.linux.dev>; Tue, 23 Jun 2026 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178469; cv=none; b=fHCvbfdjonQDHDcV1Ug5a3w11SfRNgG8W1vhDioGs8HuGGsslOpPQP/6SQ/3Nv3lYi2DK16HszMIviPTnYbA6rc/XX0PPa6HoFih9/hnSslw6q+RAXoRQ8YuCC8mTovluCc9a6Ma/i4iMspEE6/yGWOsk22KDUfYVaf0g4ATGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178469; c=relaxed/simple;
	bh=33ybJHO9yj0W6p1owZqWssyOFj3jkwgY64pvK1DMoDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fuGBGvU9ZU72FJWPe5XLcB2z24actG2cuqDOGbvKeH9xUsYX7COGcer2B2zAkHYqaA6jvAOy7C3h+t0PjVXRz4D4XpjkxRS2plw9QhJjzUQ4YeGmTcZVq+uGWcU55vn3gXr2iWNaZ1+9SU3ttoIiPTRAVuvBQ1mUXRyhk/8jl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imbdmBKY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imbdmBKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8D61F000E9;
	Tue, 23 Jun 2026 01:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782178468;
	bh=9cAclIXCQ3YJbZkGDXd+wil/4Pj65zdO532nRcPw5H8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imbdmBKYd9DRn2gfQFQCEvL4Ygv4o5R6w6TTnRCFqHvWX6EMV9w33CNdKQT+ywe3X
	 0lkTqmBtgCgjVMCST214R/4RuCJoj2FvzM3mRL1bQfZfgwX8z4Xq5ykjUKT9wx5VVX
	 ffcY/LO8HahT/OQFUOgVlOaap2LDxuBk0rIwIbCKOHg0WTEwPZBF03kQYAsQd0AW2s
	 Y4eePmzZzsurqjPyZaWKGAkHImrhgPOZDmbsgFzzIaQJ8JHQW5tXSzXCiWVg9hht7D
	 KMH/GDvO2UsDX5cNaoziqA8hRl8NDTWHVU4A0P1up1xM6ZiSeGOsuwnGh2Z0SHRyKG
	 X+4I9Kf2GvvxQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3] mm/damon/ops-common: handle extreme intervals
 in damon_hot_score()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260623011652.1354-1-sj@kernel.org>
References: <20260623011652.1354-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 01:34:24 +0000
Message-Id: <20260623013428.4A8D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `age_in_sec` calculation silently overflows on 32-bit architec=
tures, breaking age-based subscores.
- [Medium] Multiplication of `r->nr_accesses` by `DAMON_MAX_SUBSCORE` silen=
tly overflows 32-bit arithmetic for heavily accessed regions, breaking hotn=
ess scoring.
- [Medium] Weighted average calculation in `damon_hot_score` can overflow i=
f large weights are provided via sysfs.
--

commit 9cb0813af4dd40334d721106d6d0be2f72fa88ca
Author: SeongJae Park <sj@kernel.org>

mm/damon/ops-common: handle extreme intervals in damon_hot_score()

This patch fixes three issues in damon_hot_score() caused by extreme
monitoring intervals. It explicitly handles zero intervals to prevent
divide-by-zero errors and bounds the return value to prevent out-of-bounds
array access.

Link: https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

[ ... ]

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 5c93ef2bb8a97..d1842e2b00ef8 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -143,6 +143,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon=
_region *r,

[Severity: Medium]
This is a pre-existing issue, but while we are fixing extreme intervals in
damon_hot_score(), could the frequency subscore calculation silently overfl=
ow
on 32-bit architectures?

Looking at the calculation earlier in the function:

freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE /
                damon_max_nr_accesses(&c->attrs);

If an administrator configures a large aggr_interval and a small
sample_interval, a frequently accessed region's nr_accesses could exceed
42,949,672. Since DAMON_MAX_SUBSCORE is 100, the multiplication would silen=
tly
wrap around modulo 2^32. This might give hot memory regions an artificially
low frequency score.

[Severity: High]
This is also a pre-existing issue, but does the age calculation earlier in
this function suffer from a similar 32-bit overflow?

age_in_sec =3D (unsigned long)r->age * c->attrs.aggr_interval / 1000000;

On 32-bit architectures where unsigned long is 32 bits, with a default
aggr_interval of 100,000 us (100ms), r->age increments every 100ms. After
about 71.6 minutes of continuous inactivity, r->age reaches 42,950. The
product reaches 4,295,000,000, overflowing ULONG_MAX (4,294,967,295).

The wrapped value divided by 1,000,000 yields 0, which artificially resets
age_in_sec to 0 and could cause old cold memory regions to be misclassified
as young.

[Severity: Medium]
This isn't a bug introduced by this patch, but could the weighted average
calculation also overflow if large weights are provided via sysfs?

hotness =3D (freq_weight * freq_subscore + age_weight * age_subscore);
if (freq_weight + age_weight)
        hotness /=3D freq_weight + age_weight;

The weights freq_weight and age_weight are read from sysfs and accept up to
UINT_MAX. This expression evaluates entirely in 32-bit unsigned math. If
large weights are provided, the calculation will wrap around the 32-bit
boundary. Because the intermediate hotness variable wraps and is later cast
to a signed int, this could result in wildly incorrect or even negative
prioritizations before clamping.

>  	 * Transform it to fit in [0, DAMOS_MAX_SCORE]
>  	 */
>  	hotness =3D hotness * DAMOS_MAX_SCORE / DAMON_MAX_SUBSCORE;
> +	hotness =3D max(min(hotness, DAMOS_MAX_SCORE), 0);
> =20
>  	return hotness;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623011652.1354=
-1-sj@kernel.org?part=3D1

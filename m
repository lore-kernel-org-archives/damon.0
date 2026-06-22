Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758939AD25
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138970; cv=none; b=bqodYv/7cM4GxaoM0puasSOZLtScdobEDdnqddJJdj/v8YieHTnIvisINK6sRMce5w1bR2JYpgyoaofOK75qgg0C4kkHDtU1qtRfxGLi23AznGfdwgdB5PBOG+MwcJpGpcPaGfLaXzOGmKIMn+1/Eq1tY1ZE07EgIKifqypYJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138970; c=relaxed/simple;
	bh=FO8205LuMLf1omqoqol3hQMgoanTplpxOE9sgnEJXxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GTnfNS/3der7dEH9zdYGl0DCXAGVwZMmjwqvMNGuSzo5JwZPw2FnzV8l5YUUeusC8TYDSa5E1HU2kYstzRWOa5qaMYr+u2CTgxpnEcjJ3xMmAtsXs9Uk5L0oKzBzzjHZqA8lOzHtAeSM1nKNVCC2yvuTG+uSGdQH6Vb0iIKx5PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OifGb+Pw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OifGb+Pw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1668B1F000E9;
	Mon, 22 Jun 2026 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138969;
	bh=AXH1VaA+3GZDgFh4QJ4i+mXMmyltmemtwzCm6vKW8Lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OifGb+PwXcjkBGZNydT8SlSqDHnf12ISCf3F0ze+m+KpPtKVMI/LWTtrgq/mWVBzi
	 PD7hvSDnVxODRvE7iPiLtsFH6MRn/pkIBv4oxpkUobMXMMYE1Lc4UjIuqZlyNb5IXK
	 mrFireD5wGDG5oCgZmaj+s7MdEMHFmaPo3t5Q08vqvSBNon8z3+suhBgvy3N4BKr91
	 lJgALIDEDv7SCLl988NtjLqNDDWIHedyXLFbdnDlkiPEw884m7sJKQmqejoxcKK2Bs
	 6qOZnf82IbSu7lqdAAM/Qo0N4FCe+xZtqZ/ZeqUGbh1uVp9cy9orVT3IDNOY0BWxtP
	 opG8RrI6qLEDg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 01/18] mm/damon: introduce
 damon_nr_accesses_mvsum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260622142139.30269-2-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
 <20260622142139.30269-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 14:36:08 +0000
Message-Id: <20260622143609.1668B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Potential 32-bit integer overflow in `damon_nr_accesses_mvsum()`=
 when calculating `left_window_bp` using `mult_frac()` for large interval r=
atios.
--

commit e0ac3f6397c85ca0b28c3db5a3bfa0bbe79402ee
Author: SeongJae Park <sj@kernel.org>

mm/damon: introduce damon_nr_accesses_mvsum()

This commit introduces a new DAMON core function, damon_nr_accesses_mvsum(),
which returns a pseudo moving sum value of a given region's nr_accesses for
the last aggregation interval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -210,6 +210,68 @@ static struct damon_probe *damon_nth_probe(int n, st=
ruct damon_ctx *ctx)

[ ... ]

> +unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
> +		struct damon_ctx *ctx)
> +{
> +	unsigned long sample_interval, aggr_interval;
> +	unsigned long window_len, left_window, left_window_bp;
> +
> +	sample_interval =3D ctx->attrs.sample_interval ? : 1;
> +	aggr_interval =3D ctx->attrs.aggr_interval ? : 1;
> +	window_len =3D aggr_interval / sample_interval;
> +	if (time_after_eq(ctx->passed_sample_intervals,
> +				ctx->next_aggregation_sis))
> +		left_window =3D 0;
> +	else
> +		left_window =3D ctx->next_aggregation_sis -
> +			ctx->passed_sample_intervals;
> +	left_window_bp =3D mult_frac(left_window, 10000, window_len);

[Severity: Medium]
Can this cause a 32-bit integer overflow on 32-bit architectures?

The mult_frac(x, n, d) macro internally computes the remainder multiplied b=
y n
using the native type of x. Since left_window is an unsigned long, it will =
be
32 bits on 32-bit architectures.

If window_len (and thus left_window) exceeds 429,496, the multiplication
left_window * 10000 will overflow the 32-bit integer maximum (~4.29 billion)
before division.

This easily occurs if a user configures a long aggregation interval via sys=
fs.
For example, a 1 hour aggregation interval (3,600,000,000 us) with a 5,000 =
us
sampling interval gives a window_len of 720,000.

This overflow would result in an incorrect left_window_bp and consequently =
an
inaccurate pseudo moving sum access score, which could improperly drive DAM=
OS
policies.

> +
> +	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
> +			left_window_bp);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622142139.3026=
9-1-sj@kernel.org?part=3D1

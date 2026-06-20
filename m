Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABC331207
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977299; cv=none; b=fp1p6Qog2w+5YTkk3Z6vTWRis37U8QDosGGnr4XK9WNrWtm4UKI/4N3YV5nLPWtKnLJezJEKs+OVZfcOBYKx6J0pnxrevaYKjoV84kDQTVcqA/3etmrN/xRsbrfLPWKLJV2GICRgXUfV7DxqKbmaZhniCRrfti5lBs+mC2thJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977299; c=relaxed/simple;
	bh=IawGBNVW/ASqQnakDpo+nH+9Gj13I2QsZEgF2FkoHOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gWBp1HgtoW38BZL4AWIAHRCkkWCZk9V428HAZDlL1P2Mw5rXAy8BRQ3WWBtxkaSriNV5n2gOUM7uHAG6OZDxqv1keB6lBZZByHqa2uK9V5w1XA6Rijtph6Fk4EI7lhmLHt1OWsuoaqjBpnG+w8lDJ3hEcUQ0iyyfILr33pK448w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm1psS8D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm1psS8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EFB1F00A3E;
	Sat, 20 Jun 2026 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781977297;
	bh=kGRc/nEfMVNMHouMj2ypvcl3/ZLGJlDZaJcXrmsYPzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sm1psS8DMmrh9tN+uQwXIrOY2JM5QMpV6aX0JC+zIIfnNwefsvziNcF3XS/RoRFlI
	 sQnj4gUs/wumyFc8EJenNl6yCKn7jm25bTpY6cJUQWWhRofBdjP9p2zktIMa5c6dY4
	 lwjzm3QVUE1t5YZyTl3JD5x5DKArRFs/EoHJsMC9etZznBQJxjnIHaim2omfjkCg0x
	 H6ApI0CGSYyhaj0mz4rkQI9whn7rf5zm1ZYKAAZRpteuOuxgz2H7+Me7cJih4uMd5T
	 MojOyx5gT4SdHi9eMjN7G1SqNxltYklVVzJe4caXr8MZW+lWIrfr9Oy5f80zqwUIAl
	 nGQw906K5g2Eg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 03/13] mm/damon/core: use
 damon_nr_accesses_mvsum() in __damos_valid_target()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260620172244.90953-4-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
 <20260620172244.90953-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:41:36 +0000
Message-Id: <20260620174137.53EFB1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new __damos_valid_target implementation uses damon_nr_accesses=
_mvsum(), which is vulnerable to time-of-check state desynchronization if c=
tx->next_aggregation_sis is updated asynchronously via kdamond_call(). This=
 causes massive over-estimation of the target access frequency.
--

commit 2274522ec6ea648db508697b0a1f57a8bf4e864d
Author: SeongJae Park <sj@kernel.org>
Subject: mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_targ=
et()

This commit replaces the direct read of r->nr_accesses_bp with a call
to damon_nr_accesses_mvsum() inside __damos_valid_target(). The author
notes that while execution is slightly more expensive, the function is
simpler and more tolerant to errors.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index af95783d3402a..ee4f0f0e583bd 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2120,10 +2120,11 @@ static void kdamond_tune_intervals(struct damon_c=
tx *c)
>  	damon_set_attrs(c, &new_attrs);
>  }
> =20
> -static bool __damos_valid_target(struct damon_region *r, struct damos *s)
> +static bool __damos_valid_target(struct damon_region *r, struct damos *s,
> +		struct damon_ctx *c)
>  {
>  	unsigned long sz;
> -	unsigned int nr_accesses =3D r->nr_accesses_bp / 10000;
> +	unsigned int nr_accesses =3D damon_nr_accesses_mvsum(r, c);

[Severity: High]
Could this lead to double-counting access scores if the context attributes
are updated asynchronously?

In kdamond_fn(), when an aggregation interval finishes, pending API requests
are processed via kdamond_call(ctx, false) right before
kdamond_apply_schemes() is called. If a processed request triggers
damon_set_attrs() (e.g., via sysfs), ctx->next_aggregation_sis is eagerly
advanced to the end of the newly configured interval.

When __damos_valid_target() subsequently calls damon_nr_accesses_mvsum(),
it calculates the time window based on ctx->next_aggregation_sis:

mm/damon/core.c:damon_nr_accesses_mvsum() {
    left_window =3D ctx->next_aggregation_sis - ctx->passed_sample_interval=
s;
    left_window_bp =3D mult_frac(left_window, 10000, window_len);
    return damon_mvsum(r->nr_accesses, r->last_nr_accesses, left_window_bp);
}

Because ctx->next_aggregation_sis was just advanced, left_window equals the
full new window length, resulting in a left_window_bp of 10000.

Since damon_mvsum() assumes it is at the start of the window, it will add
the unscaled r->last_nr_accesses to the current r->nr_accesses. Because the
aggregation interval just finished, r->nr_accesses already holds the
fully-accumulated access count. Adding last_nr_accesses effectively doubles
the access score and could misclassify regions during target validation.

The pre-patch code avoided this by safely reading the decoupled
r->nr_accesses_bp, which preserved the correct scaled value across
kdamond_call() boundary transitions.

>  	sz =3D damon_sz_region(r);
>  	return s->pattern.min_sz_region <=3D sz &&

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620172244.9095=
3-1-sj@kernel.org?part=3D3

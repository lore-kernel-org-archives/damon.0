Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A340D58A
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793542; cv=none; b=jKi0vCK6pdcoKdJPNqdakLG1NVGoalckiXq4ECNvyZl36T11YMFLPX1OOHOonwHFrWZfmyJ1ptVR0sK1fg8/5XnPASWpRhd/uN2wprOVT6BnDMaK2WhxYVkLfrj/KoPJBSIq0BMgrosoyfrPAztZ2LHSLlVWGAP79vj1Q3Qe5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793542; c=relaxed/simple;
	bh=TwcPzTox7hx4g1Gwi4fKPXtBi9Xc2hIIeJfrVle+wUo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ejWrTRXU6gGLg4Q0WJ14JRUih7i3fSY5Lu1gNS9y1ejisuNuF1gg2wk5imiCH0QlkXxKboSr48XfiOtL3K4p0xu2UwNDLNHous87QHfno71wDR0fE96/4z7khFd76QxeAXmm1xWwK3X14ETQskObvsjj+xCayfWx+NX4DtuuYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbymCBXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbymCBXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8461F000E9;
	Tue, 30 Jun 2026 04:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793540;
	bh=4dHW//uBpTaXlQOLd16vLjT52sEZqreI4m7WyzeRGbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LbymCBXClcCtGQQrg57GiGDBkwU0kFR9S5PgXWF16K+LajfX58GTkLaMriXDzGPjh
	 J99s3sEqRzIHhKW0VC2xzKwRgSXnkGs8ysL51H0mu364e4Up6iZu4ITJDjfPqtG4vc
	 mKnskmNj62vcY0QLHm3YfCVlpFY1tKuTDh2sNcAwjGqO5acboeOt7Me4myPbL0AyRM
	 c26TKpisgRWqwNq5oNU7DZ1gdZKpvee01PNic/wRAEyhcaADiArczYIrar8gelgaeZ
	 nmhEOBcgRn/ocC8iTA/PZV4SNcV3xUs69WLmZ6YikvV4WC+eQt4qzlwrw8SJNsOx3g
	 1grUtHpyxmLgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/18] mm/damon/core: use damon_nr_accesses_mvsum() in
 __damos_valid_target()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260630040812.149729-6-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
 <20260630040812.149729-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 04:25:40 +0000
Message-Id: <20260630042540.7F8461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] 32-bit integer overflow in `damon_nr_accesses_mvsum()` when calc=
ulating `left_window_bp` via `mult_frac()`.
--

commit 73c4d41e08fa85ce70e1cc04b1dee325a553e44e
Author: SJ Park <sj@kernel.org>

mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()

This commit replaces the direct read of nr_accesses_bp with a call to
damon_nr_accesses_mvsum() in __damos_valid_target(). This calculates the
access score dynamically to be more tolerant to errors.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index df79f4d10bdc3..50939c3359bf7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -2126,10 +2126,11 @@ static noinline_for_stack void kdamond_tune_inter=
vals(struct damon_ctx *c)
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

[Severity: Medium]
Does wiring up damon_nr_accesses_mvsum() to the active DAMOS region filteri=
ng
path expose a 32-bit integer overflow?

Inside damon_nr_accesses_mvsum(), the calculation of left_window_bp uses
the mult_frac() macro:

left_window_bp =3D mult_frac(left_window, 10000, window_len);

If a user or auto-tuning configures an aggr_interval / sample_interval ratio
greater than ~429,496 (for example, an aggr_interval of 5,000,000 us and a
sample_interval of 10 us), the intermediate multiplication inside mult_frac=
()
can exceed the maximum 32-bit unsigned long value on 32-bit architectures:

(left_window % window_len) * 10000

This truncation would result in a severely deflated left_window_bp, leading
to incorrect moving sum access scores.=20

Could this cause DAMOS schemes to evaluate targets improperly, leading to=20
sub-optimal memory reclaim or migration decisions?

> =20
>  	sz =3D damon_sz_region(r);
>  	return s->pattern.min_sz_region <=3D sz &&

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630040812.1497=
29-1-sj@kernel.org?part=3D5

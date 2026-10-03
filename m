Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8FC4315F
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062147; cv=none; b=QqMCaPaT+x4PVfrtrQUvZMxUT7jRz4ukoU3TZJ1erRA5LgFXyfrF0M1+0nqIZ5lxCFFB0zVMR6drqFhSqOv1kNx60OjLoCVwXeQNqaZDyOH2jtQxj1W0ZBsYGjBkYGfScX7j8pe/yk2AwP1WSKGYAWKj+UC+ztUpQgx1R37vPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062147; c=relaxed/simple;
	bh=p6ylEgmz7rmGA84+dtmUg/2xfUw0LElyYb5vr8XCjvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s0BT14B2jHxtIWYlfdsNoAnoJYJ/jbbfMoQrzTKVniajKqUGB6/Oa+4Bwh9EPUq62q3hPE4aRERrj9tRmxvOzAC7d00yCyJ2WSY0mblIkoooNSj7ONvrRm8ZnSYLAlMxPuWnWZqUziiCVX3DrrOIgDnFvm84Qkxh29/HF75F6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTZRE2+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTZRE2+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D761F0089B;
	Sat,  3 Oct 2026 21:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791062145;
	bh=7XLehgGygn4OxqqIpxJAgcpYvWA9pCzfl6ZUHsEaIFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTZRE2+rzdJ1tsVUtygvYDX5GM9exTqslSCfjB1ebrB82lr9tLNG0jjt0EbJy4zoq
	 HvaBXtDlTt9///kejKY5ibJgbFZ8Dzg906f9R231XzRnjolgNO561yBluvQTrxO/DX
	 2OesTNepVZ++5e8iFWsq1bci2iwRPjKPZ57eMG36DAtviXyl49BFl713g120T4bZQq
	 NK/tw9JrIqfnZtZb5Vfgt2yJ8yQEyRx0TdhEkqrxqKyjPknAvo+71x5QbYetIdETEU
	 prIvGK1EnLgjkrtkhB8s9lWLrFJH2qCp2O1umwgVM/Snt3V6kcx247Hx5O/YvzZU/O
	 2fsy95xTRDBYA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 4/9] mm/damon/ops-common: use probe-weighted
 score when probe weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-4-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
 <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-4-0f00417b41bc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 21:15:45 +0000
Message-Id: <20261003211545.A8D761F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm/damon: integer overflow and flawed signed cast in hotness calcu=
lation inverts scores
- [Medium] mm/damon: unwarranted +1 divisor guard distorts probe-based freq=
uency subscore
--

commit 789313bd7b3378340e31414deb770dbabf9ae379
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon/ops-common: use probe-weighted score when probe weights are set

This commit updates damon_hot_score() to use probe-weighted hardware
event counts for the frequency subscore when probe weights are configured.
It also exports damon_has_probe_weights() and attempts to guard against
integer overflow when calculating the new subscore.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c

[ ... ]

> @@ -172,9 +172,24 @@ int damon_hot_score(struct damon_ctx *c, struct damo=
n_region *r,
>  	unsigned int age_weight =3D s->quota.weight_age;
>  	int hotness;
> =20
> -	freq_subscore =3D mult_frac(damon_nr_accesses_mvsum(r, c),
> -			DAMON_MAX_SUBSCORE,
> -			damon_nr_samples_per_aggr(&c->attrs));
> +	if (damon_has_probe_weights(c)) {
> +		unsigned int wsum =3D damon_probe_hits_wsum(r, false, true, c);
> +
> +		/*
> +		 * Route perf-event hardware event counts into the score.
> +		 * Clamp to DAMON_MAX_SUBSCORE so a large weighted-hit sum
> +		 * cannot overflow the subscore range.
> +		 */
> +		freq_subscore =3D min_t(int,
> +				mult_frac(wsum, DAMON_MAX_SUBSCORE,

[Severity: High]
Could this combination of mult_frac and min_t cause highly active regions
to be scored as completely cold?=20

Since wsum is an unsigned int accumulating raw hardware events from perf
probes, it can reach very large values. The mult_frac macro uses 32-bit
unsigned math for its internal scaling. If the intermediate result of the
scaling exceeds the 32-bit maximum, it will silently wrap around.

Furthermore, min_t forces this unsigned result into a signed 32-bit integer.
If the wrapped intermediate result has the sign bit set, the signed cast
produces a large negative number. Since this negative value is less than
DAMON_MAX_SUBSCORE, min_t will incorrectly return it instead of clamping.
This negative freq_subscore could then corrupt the subsequent hotness
calculation, paradoxically scoring highly active regions as zero.

> +					/* +1 guards divide-by-zero: samples-per-aggr can be 0 */
> +					damon_nr_samples_per_aggr(&c->attrs) + 1),

[Severity: Medium]
Is this +1 divisor guard necessary here? The comment mentions that
samples-per-aggr can be 0, but looking at damon_nr_samples_per_aggr(),
it appears explicitly designed to never return 0:

include/linux/damon.h:damon_nr_samples_per_aggr() {
        ...
        return nr_samples ? : 1;
}

Because the function already guards against zero, adding 1 introduces an
unwarranted off-by-one division error. For example, it could change a
divisor of 1 to 2, halving the score. Could this permanently and
disproportionately dampen the frequency subscores of probed regions
compared to unprobed regions in the else block, mathematically distorting
the tiering decisions?

> +				DAMON_MAX_SUBSCORE);
> +	} else {
> +		freq_subscore =3D mult_frac(damon_nr_accesses_mvsum(r, c),
> +				DAMON_MAX_SUBSCORE,
> +				damon_nr_samples_per_aggr(&c->attrs));
> +	}
> =20
>  	age_in_sec =3D div_u64((u64)r->age * c->attrs.aggr_interval,
>  			     USEC_PER_SEC);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-damon-perf=
-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com?part=3D4

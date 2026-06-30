Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017C3B71D7
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793305; cv=none; b=igEO4ME7R938Mbo1FPPBj/h/CRFAIXiYZhz/LkH3eAngwenGb9DHp4eOgotMo5zYcS9+cga7LH8o+/tI1z1QmGVN/oH7hVSSp2jxeAGTNhGxnVedZuyCFW9FgSZS4f3hM7XjZyzxoqKsKgYF4r67hf5CZA/az9B5ZozdJZcRQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793305; c=relaxed/simple;
	bh=odIdqJqVglBbnH8UD4/bd+aajyIWA4XvGLgBhZz02gw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K/2rKqMplEYCgwqPCOLktZgejxFdFN/dZiQG6AO/uPa3LR+666KjWOJXOlJLWDdtTrkVC0up+miQ4xXhPKGo/JKvW8gYDHoH5Ahm/q3RQH0htr98ZSqJNy/Rz82hltBg9nUzI0EnSPr+PW+24AKGxwyNX9wBkEoB5AIsIiHBaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkqMLMhD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkqMLMhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5261F000E9;
	Tue, 30 Jun 2026 04:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793303;
	bh=QhI45JR3HCxQS9klqM2+7XNovmoXayIIXhhP8Xzva00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AkqMLMhD6IrnmBT208yCxBpkvT0OAldWP4N+xPKp3Mknpjd+moDln2kv/wLa9Ie93
	 Rkd7VV0inKD+G78pLr4g+gIvEU+FB2Zkser5WPF7YzPbCa7+BkmFuKjpr7EwietvIm
	 V+JQgExb0CaKyB7t5W8kJkC9ER1RgCg6VM/HcR9q85EYj0wbWJ+G7/VuMWPUDywanh
	 13wAmnYLMZXxNv9SOp//TA7RUECPJGxpot1o9dU3eGB0QCco4L5Hb0+VVBjT91KQ1i
	 9PiCWnZlvCtA8Dl5hydg2OEhIpevnvTS14TjUJeLF85DiBMbRuTNal8Mb80QNsW4fA
	 3zg5bBpRC9IZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/18] mm/damon/core: always update ->last_nr_accesses
 for intervals change
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260630040812.149729-4-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
 <20260630040812.149729-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 04:21:43 +0000
Message-Id: <20260630042143.7C5261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A 32-bit unsigned integer overflow in `mult_frac()` silently corru=
pts region access basis point conversions when the aggregation interval is =
significantly larger than the sample interval.
--

commit f786cbe1a79f2e1958843b60ee1875084aebedbc
Author: SJ Park <sj@kernel.org>

mm/damon/core: always update ->last_nr_accesses for intervals change

Each iteration of kdamond_fn() caches the next aggregation time. This patch
ensures last_nr_accesses is always updated to prevent returning wrong values
when damon_nr_accesses_mvsum() is called during an intervals change.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -871,6 +871,8 @@ static void damon_update_monitoring_result(struct dam=
on_region *r,
>  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
>  		bool aggregating)
>  {
> +	r->last_nr_accesses =3D damon_nr_accesses_for_new_attrs(
> +			r->last_nr_accesses, old_attrs, new_attrs);

[Severity: High]
This is a pre-existing issue, but does the underlying access basis point
conversion silently overflow on 32-bit values?

When this calls damon_nr_accesses_for_new_attrs(), it relies on
damon_nr_accesses_to_accesses_bp() to calculate the scaling:

mm/damon/core.c:damon_nr_accesses_to_accesses_bp() {
    return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
}

Because mult_frac() evaluates the multiplication using the type of
nr_accesses (a 32-bit unsigned int), multiplying by 10000 will silently wrap
around if nr_accesses exceeds ~429,496. This could happen if a large ratio
between the aggregation interval and sample interval is configured via sysf=
s,
causing hot memory regions to be incorrectly evaluated as cold.

A similar issue appears to exist in damon_nr_accesses_mvsum() where
left_window (a 32-bit unsigned long on 32-bit architectures) is multiplied
by 10000 inside mult_frac():

mm/damon/core.c:damon_nr_accesses_mvsum() {
    ...
    left_window_bp =3D mult_frac(left_window, 10000, window_len);
    ...
}

Could these operands be safely cast to a larger type to prevent the overflow
before passing them to mult_frac()?

>  	if (!aggregating) {
>  		r->nr_accesses =3D damon_nr_accesses_for_new_attrs(
>  				r->nr_accesses, old_attrs, new_attrs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630040812.1497=
29-1-sj@kernel.org?part=3D3

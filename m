Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5637C92C
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793176; cv=none; b=ukeXgMkbVeBVaCSj7ITnNJ07aAUtGbcQ+6vchyl9JYaJHSrLCNCnftKDNn+T2NkZ6bByBHaMpBo6oQ3i+EgeLjTw87XsWim0AdJPxSVtFwuiepl9WD/ZVU/r4XWvKIaM5BetysNAPjfSq+Xtkjwi6SVoLAEKQo1LTsXpv9qI350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793176; c=relaxed/simple;
	bh=VpDj2aha94rgpD/Eszcsg+bGseKQPww6HCw7JX5EYUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b/9lOX5+3WmPFeaw4b5Zgo9JjpVGnrVbxSOvljliEWN9J7pH25sazkrY2lkL4h3NFHAwIPB+8FkMLcrRofRZQvW7ARrLIxizdzzrGCIkaTGKkKGH5U4R5sRFvic/ecbi20WAZu1mMrfSx0DwvZK4x3D5iTmG5J05/wCM10cJUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4WWNMee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4WWNMee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2076E1F000E9;
	Tue, 30 Jun 2026 04:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793175;
	bh=ZCRy1K03Dp5r0GRJ9zpj5Zxwasa5ztEsgXsntNUzVWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D4WWNMeeG2sIVi3Ys6/99DwMQdriOiUNNDTQJMc6cMrkLg0tCM+xT6dObXW+WUC7T
	 zwH398epe/KZJG+A0qQFKFlsaVlAJacH1KtHZ5MrmFRtVbsG/ndrEQsMIJvb3j7bP3
	 93V24dJo8HzIDU7G7wqaMbSgQ4TBwv1FV4n7P7aSmUHNAck6QIKRERuGODn+t2Dazv
	 yuGbnjFYc2dWQJ5KXR3hQhNPMNYX+hn3ixoyw+7550T9rq0PZgzxWI5En/ax8UeayO
	 5zONmMeRiZKyQaFP4vyvjiM9JLWPzG6jqm6kGIzFWkHKHh/jO/McJAsMAncRwXhvJh
	 7ZXQjDZoQj9/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/18] mm/damon/core: introduce
 damon_nr_accesses_mvsum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260630040812.149729-2-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
 <20260630040812.149729-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 04:19:34 +0000
Message-Id: <20260630041935.2076E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Calculation of `left_window_bp` and moving sums in `damon_nr_acc=
esses_mvsum()` and `damon_mvsum()` suffers from an integer overflow on 32-b=
it architectures when `window_len > 429,496`.
--

commit 55e8315faa6caec232a35b71d630c4dd8cbb568f
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damon_nr_accesses_mvsum()

Introduce a new DAMON core function, damon_nr_accesses_mvsum(). It returns a
pseudo moving sum value of a given region's nr_accesses for the last
aggregation interval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 027250e43c66f..fe4c470726d0b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -208,6 +208,68 @@ static struct damon_probe *damon_nth_probe(int n, st=
ruct damon_ctx *ctx)
>  	return NULL;
>  }
> =20
> +/*
> + * damon_mvsum() - Returns pseudo moving sum value for a time window.

[ ... ]

> +static unsigned long damon_mvsum(unsigned long current_nr,
> +		unsigned long last_nr, unsigned long left_window_bp)
> +{
> +	return current_nr + mult_frac(last_nr, left_window_bp, 10000);

[Severity: Medium]
Could this mult_frac() calculation suffer from an integer overflow on 32-bit
architectures?

If a user configures DAMON with a large aggr_interval and a small
sample_interval such that window_len exceeds 429,496, last_nr could be
equally large. Since unsigned long is 32 bits on those systems, can the
internal multiplication inside mult_frac() silently overflow and result in
incorrect moving sums?

> +}
> +
> +/**
> + * damon_nr_accesses_mvsum() - Returns moving sum access frequency score.

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
Does this calculation also overflow on 32-bit systems?

The mult_frac() macro calculates (left_window % window_len) * 10000. If
left_window is greater than 429,496, multiplying by 10000 will exceed the
maximum 32-bit unsigned long limit (4,294,967,295), causing a truncated
left_window_bp result.

Should these calculations use 64-bit arithmetic, such as div64_ul(), to
safely support large intervals on 32-bit systems?

> +
> +	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
> +			left_window_bp);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630040812.1497=
29-1-sj@kernel.org?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997F3BFE3A
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781112; cv=none; b=GR0u0yTepbApJmEt4FM6yj+QG3VoqRQixo24E9EMAxrH9WabJdwb8BtSmmRX6NBkM6eDhaTn6zjpPbSX1iq6dyrcwY6l6c4DyyFWxBeR0qagUVSEveH32tOdN3QfjZV5Fn81y52aB62sx33aXv8PWao0U4OB3tZp0SI9qb0Rzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781112; c=relaxed/simple;
	bh=oIWSRUE3uZvICWyFb/1PtOQ9x+nDe8jRr7DUaHH2Z3U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cVv7xlI+4BzcCdu8nBtq19uFEOj6jQVXU8OmxNTeT8Jq8bhGbOdNNJp0necT4/TLaHDaNc0lrb5L4YjOuLQfA0JBqx1bFBM8OoGGbgLgQXDC3NevmEWlbCsCR46APuKqZZDYgxz7xvIkwcjDXhd+MDZgyuYiWQzCRuDeTasbfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTuCf21k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTuCf21k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CD61F000FF;
	Sat, 19 Sep 2026 01:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781110;
	bh=9rsv6FrMITii6c5+QJJKg+fmVDPzH39VVI1nbdrbIT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JTuCf21kjNEoJ9En8k6g7gT0+KofwdG548F10ng3iHo9Gx4MNBv47s61vKeOf8a5s
	 112DpbVodszHpTy57PHl7PeVnOHrY1vzwjzOoj81PubvQ5qq5Fp+fQyvMn8JjOXvcP
	 vnZR0Jkrqecmdh7k9cVro3gt18xdOz+osvn8ojLBft18aTctGuX5jae7poXIbNegLu
	 sMranWKBl2SRSjveHV5viYk5nU8KGInSnab4UD/iZSr1G2xXwFn5cpwJg1ZEBN3zB+
	 Dailm8wZhQRnS6n1ekGYRDM2nrbHQSIix8iqIPPgnhneMwMo0iFNh/9NKWnW5y4/Dy
	 iPDbetp8y2f4Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/7] mm/damon/core: introduce
 damos_quota_goal->complement
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260919011359.88921-2-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
 <20260919011359.88921-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:25:09 +0000
Message-Id: <20260919012510.22CD61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: Integer underflow in DAMOS_QUOTA_SOME_MEM_PSI_US complement ca=
lculation
--

commit f2de2d4493473c2c847f3ad213eaef640f0e1600
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damos_quota_goal->complement

Introduce damos_quota_goal->complement for specifying whether to use a
complemented value of the given goal target metric. Add the field to
the data structure and implement essential core support. Handle the
flag in the quota goal commit and current quota goal metric value
retrieval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 2258b72da7a78..9fd08cbfacd8c 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3238,6 +3239,23 @@ static void damos_set_quota_goal_current_value(str=
uct damon_ctx *c,
>  	default:
>  		break;
>  	}
> +	if (!goal->complement)
> +		return;
> +
> +	/* updte current_value to complemented value */
> +
> +	/* for user_input, users set complemented value on their own */
> +	if (goal->metric =3D=3D DAMOS_QUOTA_USER_INPUT)
> +		return;
> +	if (goal->metric =3D=3D DAMOS_QUOTA_SOME_MEM_PSI_US) {
> +		goal->current_value =3D s->quota.reset_interval * 1000 -
> +			goal->current_value;

[Severity: High]
Does this unsigned subtraction underflow if goal->current_value exceeds
s->quota.reset_interval * 1000?

If goal->current_value exceeds the nominal reset interval, which can happen=
 on
the first iteration when initialized to an arbitrarily large user-provided
target_value, or on subsequent iterations if kernel scheduling delays cause=
 the
actual elapsed time between callbacks to exceed the nominal reset_interval,
this subtraction will underflow and produce a massive current_value near
ULONG_MAX.

This large value is then passed to damos_quota_score(), which computes a
normalized score that maxes out the feedback loop, forcing the tuned quota
limit to drop aggressively.

> +		return;
> +	}
> +	if (goal->current_value < 10000)
> +		goal->current_value =3D 10000 - goal->current_value;
> +	else
> +		goal->current_value =3D 0;
>  }
> =20
>  /* Return the highest score since it makes schemes least aggressive */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919011359.8892=
1-1-sj@kernel.org?part=3D1

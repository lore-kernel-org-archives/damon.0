Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F420491589
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588642; cv=none; b=fcUuSLsymGru4f2FFOq6oZH1Wk1FB0aap42xqKixiHb7Khxi4r0+eNy18HMYIjno0bNHBRM3mdypjwG3sqiaavozpbMDeHbnWLrhjH/lz48pf/bVuYohU6rTig+L5r/jIE7iRi2hDEX1BeTuVpJqBeJn8CMmsrBy/bhLSu/z+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588642; c=relaxed/simple;
	bh=1HEFznXDaAr+C+pw5efOZSffTJerRV3LcAFE3JjZh1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bP+7YQ1C+YOow9WqgclTjYbK/vvMlum6Dlqpk+d4f8VTSU2kInYSl9J0M6SAQoW3Wzq5AiV+bZT/2HfTgo3LrMEqv4w1ir/5ir66KO06gUpY8ICKvYSru0aAXoZP7Jasxr4CoqoGA9rai2SIHAzpFLbK/2K5lRWH/7fPuLUMvS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxGrCwlR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxGrCwlR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0DF1F000FF;
	Mon, 28 Sep 2026 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588640;
	bh=8i7J+k6nNn/J3wwwCeSzCepZ3dnNqUskr6m8TcAwzDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dxGrCwlRzTyKKq0sLMKGvYoPuL9ZNcdYXV1Ivc3ctjchOxiO537b+UeLt1ekTwL2V
	 yycdKJ1g75hot6FwJw42T188UZi8XkYFfo1NkpwiqioyqfAQ7t/se/qTGUPcHtVdri
	 u/Ft3sbUd6Z9It6ohQbDsA+Yt9OdV2kk2TYRxTWbPjDk4m3CV0X2Bk9jqiFJBSENEi
	 /ZNYV1s5FTZuO/qmFLlEefNURLTCHrvFQ5L7pobaocD8CYe+1xvG97ZsbcNQQLsDnv
	 9T5amBzxrXnAJGF7dViJCfEHs14nsFYTTCz36qEA0lc8juhgoM8ZvE1nZllhDcZft/
	 GZij9Kql7Kp2A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 8/8] Docs/ABI/damon: update for quota goal metric
 complement sysfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928093342.16584-9-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
 <20260928093342.16584-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:43:59 +0000
Message-Id: <20260928094400.5B0DF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: integer overflow in damos_set_psi_current_val() on 32-bit
--

commit 5d7327c0afcb5fe144677a675b1eea685917f61e
Author: SJ Park <sj@kernel.org>
Docs/ABI/damon: update for quota goal metric complement sysfs file

This commit introduces a complement flag for the quota auto-tuning goal met=
ric
and updates the sysfs ABI documentation to reflect this addition. It also
modifies the core DAMON tuning logic to support the complement calculation.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 733025b367457..86f13411b91fa 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2960,10 +2962,18 @@ static void damos_set_psi_current_val(u64 now_psi=
_total,
>  		struct damos_quota_goal *goal, struct damos *s)
>  {
>  	u64 last_psi_total =3D goal->last_psi_total;
> +	unsigned long val;
> =20
>  	goal->last_psi_total =3D now_psi_total;
>  	if (last_psi_total !=3D U64_MAX) {
> -		goal->current_value =3D now_psi_total - last_psi_total;
> +		val =3D now_psi_total - last_psi_total;
> +		if (goal->complement) {
> +			if (val < s->quota.reset_interval * 1000)
> +				val =3D s->quota.reset_interval * 1000 - val;

[Severity: Medium]
Could this multiplication in mm/damon/core.c:damos_set_psi_current_val()
overflow on 32-bit systems?  If reset_interval is configured to a value
greater than 4,294,967 (about 71 minutes) via sysfs,
s->quota.reset_interval * 1000 will exceed the maximum value of a 32-bit
unsigned long.

This could cause the complement calculation to yield corrupted values or
premature zeros, breaking the auto-tuning logic.

> +			else
> +				val =3D 0;
> +		}
> +		goal->current_value =3D val;
>  		return;
>  	}
>  	/* uninitialized last_psi_total; make no effect this round */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928093342.1658=
4-1-sj@kernel.org?part=3D8

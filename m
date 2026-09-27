Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90809253951
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790511436; cv=none; b=clUtPyRDP2y5rbREIoP3TngcjTm61kjgpTikAD0DrR4g2+pEQcFrNWYvvByWZSCNYABEB5WEHlZ6X8CRptuavq+B5EjBMz7rJG8UxUZY1OCGBxoMNAUQZP6KghBPipuScPPxk93dePoAPdmLe7NV+K4e+UdXsWJq2ddA7c76UQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790511436; c=relaxed/simple;
	bh=naT6/wi2rI6n3UE0CxMlv+6x6IdrjPXQebs/Tzuoje0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HUKqWOehXqiifMrPy1DYZFuMBY5wGxDkXN5FEL6Ef3CHQOpwV3WEC9uTbrB1K/HT4vQfpp+uCe6Gvty/bjXs8AP5m7PdYKMye8f2G1cW4x5NIAbGqNVkS2CFPrlNhVcomrRA55hMk1VTuSOJ61BoCsa/r3w0FadKpBpzx3Rv/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVgivn6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVgivn6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E841F000FF;
	Sun, 27 Sep 2026 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790511435;
	bh=1URzDCMuiwy7VlgUE25l+xksN7v5OypIcxLAnvLuHac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iVgivn6dVt1lS1qFsdEAvhEfLWEnpkAwKQQna0mHnoCNQY6c6xTai/9C+tBIQkjp4
	 NAqZBoJoFpR9HY0AAr8CxXi+0lK6SmsvS5uh5Ab2Gg8+47hwaGJt61bjyBLP7U/cur
	 ffQJnIJP3Yg2idnleLQYc5qOFKv4dZhkiwM9d5+QBmq//UtSdHWgdW9KGgVQCXKtN1
	 ipseg9Hd5Le/xsUbav6/BOmgpEItKB3cutcw89qzw+teAVh0uw16bIu3BODcx43flM
	 6rkB3+23IpjDo5IOD0DGrg8A/Dl4fXJejHUuEn4iupNj74ETsB1Shk4YBo3JpkK1Tz
	 CB53SsyiPzUzA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 1/7] mm/damon/core: introduce
 damos_quota_goal->complement
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260927120533.50484-2-sj@kernel.org>
References: <20260927120533.50484-1-sj@kernel.org>
 <20260927120533.50484-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 12:17:14 +0000
Message-Id: <20260927121715.19E841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: integer overflow in damos_set_psi_current_val on 32-bit
--

commit 4f53a2ca54f02309422119354f04050f15950222
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damos_quota_goal->complement
   =20
Introduce damos_quota_goal->complement for specifying whether to use a
complemented value of the given goal target metric.  Add the field to
the data structure and implement essential core support.  Handle the
flag in the quota goal commit and current quota goal metric value
retrieval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 733025b367457..270ce9c85a2ce 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -2960,10 +2961,18 @@ static void damos_set_psi_current_val(u64 now_psi=
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
Will this calculation overflow on 32-bit platforms?

When reset_interval is configured to a value > 4,294,967 ms (around 1.19
hours), s->quota.reset_interval * 1000 will silently overflow when evaluated
as a 32-bit unsigned long multiplication.

If this wraps around, could it corrupt the complemented PSI value and lead
to faulty auto-tuning feedback? Does this need a cast or different typing to
avoid the overflow?

> +			else
> +				val =3D 0;
> +		}
> +		goal->current_value =3D val;
>  		return;
>  	}
>  	/* uninitialized last_psi_total; make no effect this round */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927120533.5048=
4-1-sj@kernel.org?part=3D1

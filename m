Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F63EFD26
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339218; cv=none; b=q3yCgW7I9tiR9+kEf09+h7Z9L7FEf92RDQt6yh1DpeJvmPGI8w7fuzZq9byWgDmOP1WhuQSnU/C8ZjTLCtSCaBFDOFVRYUqxmiyPostXOy283DTGHxB2MZpEZLsiniXzgaD9eyptdzj0YnohmtaadL2Sy5wyb+hxkM8GoaWnki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339218; c=relaxed/simple;
	bh=juHh5HoPESdNq0nZPiNRz4IN2BJc17VfPsCN119XFHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bna+pN9JF4TtSo3voGV6ntss13azZoOcRJD5EHxusZO5cASYkunVId92Y0Mokg0EYnddCa0hdOi5HzL9Q0zhquUTcqLeJVdew6v/WiMRNJd/RAU/Zx69LQj34E7RGStmxnCfFNMuN6coCmDrSnLl/NXy2EuPa4QfFPEhDDRNTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9Q4ti4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9Q4ti4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0B91F000E9;
	Wed,  2 Sep 2026 08:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788339216;
	bh=4MuqOQcTfzMJcxONb75Sw+hn7dIXNYlyceN7LnTMBEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L9Q4ti4KAhKFcyMH3oOSTQt3ab1Eum+BYWL6B++ozFsLeJCRd+OhKI0WkLNOGFqSN
	 5tKOF60qG2yO258FayuhEWZJsax4qjQi5gwCrTpgXcNNpJq41Xs2jCq8D39KzqDAmG
	 h1bCUbtYcvfJnVxtDlr0tx+0Q8nXyEA8TPmXqK3stN4ldRC5zj16qiVp74gEUsjrkM
	 Y2svviwsR3F15JUgZANP4I3WoXXiLESb5PI085FtdykAUh7RzMdIy7Oat5p4abdsQZ
	 hn8W50vl8+StzxtnMe3ovvxTbGAyNjngHPiLSPMGEvjsuQo8VbxJsXlb8zMsTchw17
	 Q12ax9gKuf3Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in
 damos_quota_is_full() when esz is zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902084445.27170-1-aethernet65535@gmail.com>
References: <20260902084445.27170-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:53:35 +0000
Message-Id: <20260902085336.6F0B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Schemes without configured quota limits (unlimited quotas) are com=
pletely skipped and never applied due to the new `!quota->esz` early exit c=
heck.
- [Medium] Incorrect quota evaluation for very small quotas (`0 < esz < min=
_region_sz`) breaks the early short-circuit optimization, causing wasted CP=
U cycles, artificially inflated statistics, and broken telemetry.
--

commit 4718f859e447852ff19b6830ab8bf79106ad37d1
Author: Liew Rui Yan <aethernet65535@gmail.com>
Subject: mm/damon/core: fix false positive in damos_quota_is_full() when es=
z is zero

This patch aims to fix an issue where damos_quota_is_full() returns true wh=
en
quota->esz_bp drops to zero, even if no regions have been tried. It attempts
to resolve this by adding early checks for zero quota->charged_sz and
zero quota->esz.

Cc: <stable@vger.kernel.org> # v7.2.x

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index df22621765911..f8c784df24600 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2655,6 +2655,8 @@ static bool damos_quota_is_full(struct damos_quota =
*quota,
>  {
>  	if (!damos_quota_is_set(quota))
>  		return false;
> +	if (!quota->charged_sz)
> +		return false;

[Severity: Medium]
Could this cause an evaluation loop that degrades performance when the
configured quota is very small?

If a quota is configured such that 0 < quota->esz < min_region_sz,
quota->charged_sz starts at 0 at the beginning of the quota window.
This new check will return false, bypassing the subsequent small remaining
quota check:

    return quota->esz - quota->charged_sz < min_region_sz;

This falsely signals available quota. Later, when damon_do_apply_schemes()
calls damos_apply_scheme(), the size is calculated as:

    sz =3D ALIGN_DOWN(quota->esz - quota->charged_sz, c->min_region_sz);

Because esz < min_region_sz and charged_sz is 0, sz evaluates to 0. The code
then jumps to update_stat, which increments nr_tried but does not increase
charged_sz.

Since charged_sz remains 0, the next region will also evaluate to 0 and skip
charging. Won't this loop wastefully over every region in an O(N) fashion,
artificially inflating the nr_tried statistics and breaking the qt_exceeds
telemetry?

>  	if (quota->charged_sz >=3D quota->esz)
>  		return true;
>  	/*
> @@ -2750,6 +2752,9 @@ static void damon_do_apply_schemes(struct damon_ctx=
 *c,
>  		if (!s->wmarks.activated)
>  			continue;
> =20
> +		if (!quota->esz)
> +			continue;
> +

[Severity: High]
Does this unconditional check completely skip schemes that do not have quota
limits configured?

For unlimited schemes (schemes without configured quotas), damos_adjust_quo=
ta()
returns early without calculating esz, leaving quota->esz initialized to 0.
With this check, won't unlimited schemes silently fail to apply entirely
because the loop unconditionally continues?

>  		/* Check the quota */
>  		if (damos_quota_is_full(quota, c->min_region_sz))
>  			continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902084445.2717=
0-1-aethernet65535@gmail.com?part=3D1

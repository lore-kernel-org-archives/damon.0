Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27F2D12EE
	for <damon@lists.linux.dev>; Sun, 26 Apr 2026 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777246092; cv=none; b=WttRIZHwWSA+proVcXMTMjIp5e4ofr7vltT6pPoP0li02HUcNV73Du57veUqFE5NTB0InqjMTwL07khEDPw3rGO3aJikFB2sLzZrBcmxOcXUmqeu2Y3AfkV9tHBUXAbQYpAJphzL9TiubemIxT0GuCEJ1oZ5Ze8XVQVKMafOgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777246092; c=relaxed/simple;
	bh=wofQx/yGxuBVEEA2YCxVE6Aotg1dwq+RBfk4+WB5Zas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iZlFY4ujb/OR2wM1K28rHFsjfzemFnDdFIFOj6WbTS9dZjDbEH6sUDgm8sXa7Z1C9EdjVLPYtncHmimq91h7Ezy5Af7OwmT4h70gUZsDaA4zpltMZDPfpJu8+X1aBCaWQ547vijkkPxzKuWN/RZyo0/SCf2vtZG7myQEWERWpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSPGmt8Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSPGmt8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618BFC2BCAF;
	Sun, 26 Apr 2026 23:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777246091;
	bh=wofQx/yGxuBVEEA2YCxVE6Aotg1dwq+RBfk4+WB5Zas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uSPGmt8ZDNoMJDUSh6pjmrNtulkXdo692g9VxojaPptOZ03BOS76ajB6+B62QS48Q
	 9lgZIOflx1LCurZvXT0UBMECVTqzWlUX773fEJe7kU0yssKhGacxBgCHuh+I/NLUh1
	 q+kWU0ruvTVBd2BZhIK6ae3lT0ucnFMB4XQmO0h5+2pcUNfMbh2KNzQ7ek2VfG9zzP
	 Fhyfa/yk/DaAr7uTztkKU74w98id2mxwkpFWlCOd7BZVycVbi6UDgRNn28zx/TF6tY
	 TgFZXEbvveSPE5nrh6dbZfigcQLClY2LLm03UEDQdsWkacIYYoAmkKsRndL2Zsz7Ay
	 tQh2fuhBZglBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] mm/damon/ops-common: optimize damon_hot_score()
 using ilog2()
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260426231619.107231-2-sj@kernel.org>
References: <20260426231619.107231-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 23:28:10 +0000
Message-Id: <20260426232811.618BFC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 3 potential issue(s):
- [High] Arithmetic overflow on 32-bit architectures during `age_in_sec` ca=
lculation.
- [Low] The logic using `ilog2()` with a zero-check branch can be simplifie=
d by directly using `fls()`.
- [Low] Unnecessary double blank line introduced.
--

commit c096ebdf3dd6d7a6e783e2ac65dec1740282929f
Author: Liew Rui Yan <aethernet65535@gmail.com>

    mm/damon/ops-common: optimize damon_hot_score() using ilog2()

This commit replaces the manual for-loop used to calculate age_in_log
in damon_hot_score() with the ilog2() function. This optimization aims to
significantly reduce the latency of the hotness score calculation.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 8c6d613425c1..3a0ddc3ac719 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -117,9 +117,12 @@ int damon_hot_score(struct damon_ctx *c, struct damo=
n_region *r,
>  		damon_max_nr_accesses(&c->attrs);
> =20
>  	age_in_sec =3D (unsigned long)r->age * c->attrs.aggr_interval / 1000000;

This isn't a bug in your patch, but does the multiplication of
(unsigned long)r->age * c->attrs.aggr_interval overflow on 32-bit
architectures?

Since both variables evaluate as 32-bit types on 32-bit architectures,
if aggr_interval is 1,000,000 (1 second), the multiplication will wrap
around when r->age exceeds 4294. This wrap-around could result in a very
small age_in_sec value for extremely cold regions, causing them to be
falsely evaluated as young and hot.

Should this calculation be cast to a 64-bit integer prior to multiplication,
perhaps using div_u64()?

> -	for (age_in_log =3D 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
> -			age_in_log++, age_in_sec >>=3D 1)
> -		;
> +	if (age_in_sec)
> +		age_in_log =3D min_t(int, ilog2(age_in_sec) + 1,
> +				DAMON_MAX_AGE_IN_LOG);
> +	else
> +		age_in_log =3D 0;

Instead of using ilog2() with a zero-check branch, could this be simplified
by directly using fls()?

The fls() function safely returns 0 when the value is 0 and correctly
calculates the 1-based log2 value for positive numbers, allowing this
branch to be removed entirely while preserving the exact mathematical
result.

> +
> =20
>  	/* If frequency is 0, higher age means it's colder */

This isn't a bug, but an extra blank line appears to be introduced here,
creating two consecutive blank lines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426231619.1072=
31-1-sj@kernel.org?part=3D1

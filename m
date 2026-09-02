Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C52C11E4
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328331; cv=none; b=pyBKWm/uVV63j4YV1BDp/y59wkyUJeAuiwzi82TpwL1ScuPMISZXFegDzuMNGogo58NonPZxwfY9KBqjSu3yUdMQ0t6hfcoyLpTPqD3dEuZ217rBC1L/3zYyZuBw+4cM08SYLCL4PDltDUGBIXPjavxsAFxb2prKybPxCACEEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328331; c=relaxed/simple;
	bh=U51V8mppgkhlzlbrkRSe22fwBvksDRG9pUPxpKA5cd4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oivwi1ov0JmqCvm0GszrwzA2IkvX9j5PvYANo07ICK0JRFDvZ54PGt4M9bW8YlV3XKH73gTB+Ama9pSMAaNhGNVXdO0MuwppPdGvgdE5vTQM4sud3GYD2TlAVBW/b9D2AeFUECyiwzWBipKiUUDtpXeiv9E3u43i+mKLMYVIzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6TcnocW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6TcnocW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9401F000E9;
	Wed,  2 Sep 2026 05:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328330;
	bh=OP0M8V1AnB3RcYYODzkYZy1eUgOqZj+xgWj0occJS3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6TcnocWFyqAQALpH/utBgIDh+nWDTNhQ1tkQKDbhuR0ZaRu+p/3RSvKOt9tmKcSc
	 nhIyojq+/Tn6kFeKtW393cwwlwe0l2SuqkDSkIpgibpFP3fj5lq7UcoNbYDOunvY0m
	 owNPTLuyWG+u2gVzrslUcXKnfVxFg4TYzDLuxTxY9Al3ZossN+IrbXljAHcKSym4Rt
	 pF/U7VW58fQZfKC5471wQMNJaII53wd1WR5CinAUHWW5V4x8DbU+b3FOQoNGZykrVD
	 tBl6g1JxXWHlZCTRGxA+xZww0cWBmKwvDUPmEj3Mg0tAQbDoPpCaiXFyFbvzRJEDDH
	 KoxyRJ7QdF07A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] mm/damon/core: remove debug messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-3-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:52:09 +0000
Message-Id: <20260902055210.2D9401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch removed the last usage of `str_high_low()` but did not re=
move the now-unused `#include <linux/string_choices.h>`.
--

commit 43d661e4f50bbdfb8a2cca56bf761ac52256d5cd
Author: SJ Park <sj@kernel.org>

mm/damon/core: remove debug messages

This patch removes several unused debug messages from the DAMON core to
clean up the code.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index bda8e23c10560..3e42f370ea67f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3729,10 +3729,6 @@ static unsigned long damos_wmark_wait_us(struct da=
mos *scheme)
> =20
>  	/* higher than high watermark or lower than low watermark */
>  	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
> -		if (scheme->wmarks.activated)
> -			pr_debug("deactivate a scheme (%d) for %s wmark\n",
> -				 scheme->action,
> -				 str_high_low(metric > scheme->wmarks.high));

[Severity: Low]
Since this removes the last usage of str_high_low() in mm/damon/core.c,
should the include for <linux/string_choices.h> near line 18 also be
removed?

>  		scheme->wmarks.activated =3D false;
>  		return scheme->wmarks.interval;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D2

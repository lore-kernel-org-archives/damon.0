Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB83BB112
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551194; cv=none; b=QwE8ObngYoK24FTMOMjhoPi/mWqq4rpEcIqCoKZCUAqPDosLz7COSzrTQ7HmLtWSock4IHY85cLBBESf0YVAM2Ho1BQ8LS5ht69TZ3nJmz2UsdjPQtOs2LscbYTty8DN173wvkcoULQBDuC2tuKrwxlcYQeelaAm4OosozOswVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551194; c=relaxed/simple;
	bh=FdPEdnEOywRWmMeGuzRiC+JvXPSD+u4YQyLpG+yTROY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ki+R/YNw/fZBi8mvMTB/RwO6N5XrMhIzUnUjavZqvjVKd+53EYT0wPWZ4tsVcOjNM8OFgb1W60M8789CmQy5iBOXlnPMcavUUtBcHv5YHdQj/Mxv1NaSSw1s2Ew2tfBOjqjKiFuAxVBmgTGs528tIJ6XZNOU1/oq0iKq6ccZABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFq/vN7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFq/vN7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA01A1F000FF;
	Fri,  9 Oct 2026 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791551192;
	bh=G3JK48enmv97ijKFGEPwewLLjmfUyjMCmfsP5ub1c1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nFq/vN7bmUL+RRAdXGrMwLOtovknCHoOgLLehPfxO/rLAhZTK3osoeSvT1BAVrssZ
	 9bwxRfoocwr7Ud4+WpoR2HEh56Ha0CmRpWNi7YBwJfE4gxAbY8v/UEGtkGs/n4/8w/
	 Pb+P8fa2vBIjbPlFW83cCia9AI8h4SWZlhbf4Ste2AP+vebas5FmS+bDF0rAvx0qAG
	 a2X7AxXVNLD+xpK9PJT3XtDygrweXe/loEqz+qF2hAvlIktRefW+yzP94ZQa2Ed1tX
	 QqexkJMi8Dge3ihNJrXgb222g2H7ZCd5aVOUHn+PbqX87aMCBF2CkEC6HvK/Fo0cda
	 00aj284TJ4uHg==
Message-ID: <sashiko-outbox-165593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y v3 2/2] mm/damon/core: fix unconditionally skip
 last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261009123651.6585-3-sj@kernel.org>
References: <2026092948-agency-overhand-3fd1@gregkh>
 <20261009123651.6585-1-sj@kernel.org> <20261009123651.6585-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:06:32 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/damon: dangling charge_target_from pointer permanently freezes =
schemes
--

commit a9baf64370898b2dec04fa2f17e4061166d6d27a
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix unconditionally skip last region

This commit modifies damos_skip_charged_region() to clear the quota's
charge_target_from pointer only when the last region of a target is
reached, rather than clearing it unconditionally during previous charge
checks.

Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1323,36 +1323,39 @@ static bool damos_skip_charged_region(struct damo=
n_target *t,
>  		struct damon_region *r, struct damos *s)
>  {
>  	struct damos_quota *quota =3D &s->quota;
>  	unsigned long sz_to_skip;
> +	bool skip =3D false;
> =20
>  	/* Skip previously charged regions */
>  	if (quota->charge_target_from) {
>  		if (t !=3D quota->charge_target_from)
>  			return true;

[ ... ]

> +	}
> +out:
> +	if (r =3D=3D damon_last_region(t)) {
>  		quota->charge_target_from =3D NULL;
>  		quota->charge_addr_from =3D 0;
>  	}

[Severity: High]
If the target tracked by quota->charge_target_from is dynamically
destroyed via sysfs, or if it loses all of its regions, will this
clearing logic ever be reached?

If the saved target is removed or has zero regions, the region loop will
be empty, meaning r =3D=3D damon_last_region(t) is never evaluated for
that target.

Since charge_target_from is never cleared in these scenarios, wouldn't
this cause the condition earlier in this function:

        if (t !=3D quota->charge_target_from)
                return true;

to remain true indefinitely for all other valid targets, permanently
freezing the scheme? Additionally, if the target is freed, does this
leave a dangling pointer comparison for future checks?

> -	return false;
> +	return skip;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009123651.6585=
-1-sj@kernel.org?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252FF2BEFEE
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764312; cv=none; b=TZOxv6yHfbN+7RIKt2q2wGZQ4d9zzegIeooUxNTnvxR5k8x94Gl87K+Rwa09+7Krehh6lHjslo6tj+Nj8qT8KWPFqUNE857shuvOZUDZld0B+lqmDNX+vqrRkPLLohG8DXdpcxSRQwst6I5+snJhcazCEoRtyuKk3oM8UovAYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764312; c=relaxed/simple;
	bh=VuhPBuQLkpE3t3A6wjqAocrKx6FTd+DaWwW3zfPRnQM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i22TAYyvyaaiWOU2535Fr7yhdpel/xwMtd3+ENAniIA2soCTkS27PGrAllH5RC2TRuXxvcoa9ufEV4DAZEbsGo77LBXJt9wro9uyBp4VsInKv00/1gS0kPJDFkEb35bnbcvpHKCts0IojhPR61U9YruSxNB+lqR2/fmRlwm76v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+g0+hDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+g0+hDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9890A1F000FF;
	Wed, 30 Sep 2026 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764310;
	bh=EnO0EHVX9RGEm9ImU06STtMB4J09QV1HFRRvFtEYTkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b+g0+hDBfcVwAGs0iXy5NL/pOFxEpyTnjLmYDd8RXw6NSNNFxgVdH206zs0mhrNMU
	 75MniL4FDy29B6YKWi5OJ5jjv2jrpamHwTXLIDcF2RZjignT+2jg1tN9ZHyyFzKwQI
	 +WvcMlYLOXiF/yVLFJKJr+maABnnkaRIQ608T02YdenKEhmtX6yAtBmDYh5906hU72
	 8A71+oB0Zg1EXuu9DQlC2OehJuHNbQrOK8lr5mv510YWeq9uf0uZBk2Q00afFX8cRA
	 E4F3vRk1wVwYF1f+EckXLwTG+aC1hOk6OfVNmqsdOQEYxfMyDSQujhE5wwWDzCT6/d
	 BK98hcoG5SDsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y v2] mm/damon/core: fix unconditionally skip last
 region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260930101853.58786-1-sj@kernel.org>
References: <2026092948-moonrise-persecute-3597@gregkh>
 <20260930101853.58786-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:31:50 +0000
Message-Id: <20260930103150.9890A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/damon: list head type confusion and memory corruption on alloca=
tion failure
--

commit 47762d8f5b1f74489d2b1ca149de65b77ac867a2
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix unconditionally skip last region

Once quota set, the charge_{target,addr}_from unconditionally skips and
resets at the last region of the tracked target, so the last region can be
skipped even when it has not been processed. Fix this by only resetting
the charge_{target,addr}_from when last region is reached, only skipping
when it is applied or cannot split.

Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0713fda22682c..c31683c12dd48 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -883,37 +883,41 @@ static bool damos_skip_charged_region(struct damon_=
target *t,
>  	struct damon_region *r =3D *rp;
>  	struct damos_quota *quota =3D &s->quota;
>  	unsigned long sz_to_skip;
> +	bool skip =3D false;
> =20
>  	/* Skip previously charged regions */
>  	if (quota->charge_target_from) {
>  		if (t !=3D quota->charge_target_from)
>  			return true;

[ ... ]

>  		if (quota->charge_addr_from && r->ar.start <
>  				quota->charge_addr_from) {
>  			sz_to_skip =3D ALIGN_DOWN(quota->charge_addr_from -
>  					r->ar.start, DAMON_MIN_REGION);
>  			if (!sz_to_skip) {
> -				if (damon_sz_region(r) <=3D DAMON_MIN_REGION)
> -					return true;
> +				if (damon_sz_region(r) <=3D DAMON_MIN_REGION) {
> +					skip =3D true;
> +					goto out;
> +				}
>  				sz_to_skip =3D DAMON_MIN_REGION;
>  			}
>  			damon_split_region_at(t, r, sz_to_skip);
>  			r =3D damon_next_region(r);
>  			*rp =3D r;
> +			skip =3D false;

[Severity: High]
If damon_split_region_at() fails to allocate memory for the new region, it
silently returns without splitting. When r is the last region,
damon_next_region() wraps around to the list head, resulting in an invalid
struct damon_region pointer. Can this cause an invalid pointer to be
assigned to *rp?

>  		}
> +	}
> +out:
> +	if (r =3D=3D damon_last_region(t)) {
>  		quota->charge_target_from =3D NULL;
>  		quota->charge_addr_from =3D 0;
>  	}
> -	return false;
> +	return skip;
>  }

[Severity: High]
If the allocation failed and r evaluates to a bogus list head pointer, this
check for damon_last_region() will fail. The function will then return
skip =3D false, causing the caller in damon_do_apply_schemes() to proceed
with the invalid pointer.

Could this lead to out-of-bounds reads in damos_valid_target() and
out-of-bounds writes in damos_apply_scheme() when the pointer is
dereferenced?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930101853.5878=
6-1-sj@kernel.org?part=3D1

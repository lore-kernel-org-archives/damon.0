Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3847F2D3
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986512; cv=none; b=VwtTqi7V6DVwO2EgYEStTU5CHu0abwCICIW/5gqX9aW8gs0/75CmODf14DsXsYyVBWH3EEC9w/+ulSI7D/CKJ75Oz2maXEP1nsvhyRlSJmwqg/8LqYH03+2eBc8b8XATlTH9U3HXD9Pi/4MqiIB9QhV7Kn9/rAtMNnfE2eV16/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986512; c=relaxed/simple;
	bh=cOyp2darqsyIVjl5R7wHkkQyR6iYw+9V6fXjPaq+VEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VsXUaC75we6tzK+hsuYnUqNP1uHUkgPQU1ePeGR5IUtUcHQyEjlsSTfS2sNQlL1aq3bpaA2TnUMjJGaPgkINLiD28GMj0jqJhsVvHIMKPnpqcsxndtMkl5D0/WtvA8fusKWC01br45VF85JVHNxvJSGEoZbD2U7SmGuHw3tHq0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKY6uBdT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKY6uBdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48F81F000E9;
	Thu,  2 Jul 2026 10:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782986511;
	bh=DgFxJkMoVzZP3NjLvwfaVtNqd6lcaG5vYqi7os0otCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LKY6uBdTsuoJzmrwA7ZLG2hy6/RWhbQyBMNld5rKt8XgNP9I7AmV+ZX0SVCUtERaL
	 LuW+CfeRzmuBJNVmUR2AsbcU8BCDmJ7QWK/Vv4mrwmHcUYIQceyxUMyoaSyCCeXDgc
	 ndswTm/r+NC3y3LzmGHNoKJlIf8Zgh1YuqeD9njH4oA1kn4x757w21Xa+ZRehT+DPt
	 m3LEAelRAal7tWExHFxkWvbBqdwbayVjTL5JrD5/YWIK0D7UM0g1uF28v0Lo1DZecH
	 N7Z8ShbqFvpd22qqsaIFaBOwU+NGftiSRPmEqOJzeP9et1kE4JD+bzGgHQnmGav42w
	 gJJnYG47viLTg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND RFC PATCH v2 1/5] mm/damon: add target_order field for
 DAMOS_COLLAPSE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lian Wang" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702094633.75658-2-lianux.mm@gmail.com>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
 <20260702094633.75658-2-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:01:50 +0000
Message-Id: <20260702100150.E48F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Double-read of `sysfs_scheme->action` allows a concurrent sysfs =
write to bypass the `target_order` validation.
--

commit 8f068b9d900dccbf38f0673e711831fdf8cce5dc
Author: Lian Wang <lianux.mm@gmail.com>

mm/damon: add target_order field for DAMOS_COLLAPSE

This commit adds a target_order field to the DAMOS scheme structure to supp=
ort
per-order mTHP collapse operations. It also exposes this new parameter via
sysfs with basic validation.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index dbf2b0515d582..9067cb66632ed 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> @@ -3010,6 +3052,25 @@ static struct damos *damon_sysfs_mk_scheme(
>  	if (!scheme)
>  		return NULL;
> =20
> +	target_order =3D sysfs_scheme->target_order;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (sysfs_scheme->action =3D=3D DAMOS_COLLAPSE &&

[Severity: Medium]
Is there a time-of-check to time-of-use (TOCTOU) race condition here?

The scheme action is read earlier and passed into damon_new_scheme(),
which saves it to the newly allocated scheme:

	scheme =3D damon_new_scheme(&pattern, sysfs_scheme->action, ...);

Then it is read again here directly from sysfs_scheme->action for the
target_order validation.

If a concurrent sysfs write modifies the action parameter after
damon_new_scheme() but before this validation, could it bypass the check
and allow the scheme to be created with an invalid target_order?

Would it be safer to check the snapshotted scheme->action instead?

> +	    target_order !=3D 0 &&
> +	    target_order !=3D HPAGE_PMD_ORDER) {
> +		pr_warn("DAMON collapse: target_order %u not supported, only PMD order=
 (%u) is available. Use 0 or %u.\n",
> +			target_order,
> +			HPAGE_PMD_ORDER, HPAGE_PMD_ORDER);
> +		target_order =3D 0;
> +	}
> +#else
> +	if (sysfs_scheme->action =3D=3D DAMOS_COLLAPSE && target_order !=3D 0) {
> +		pr_warn("DAMON collapse: target_order not supported without THP. Use 0=
.\n");
> +		target_order =3D 0;
> +	}
> +#endif
> +	scheme->target_order =3D target_order;
> +
>  	err =3D damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota=
);
>  	if (err) {
>  		damon_destroy_scheme(scheme);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702094633.7565=
8-1-lianux.mm@gmail.com?part=3D1

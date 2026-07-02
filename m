Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A2A377006
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987698; cv=none; b=i0FgCMeuqEqTIdjCSQyjMWJEC712NZr/YaETkZJ/mJmIxVrK7Nf8P6Hso/SXdX2A2jrn2VzODWrwt/s4THr05LQDDUSl19Ym0uu7Jg6Zms9xi9cCk0tLzoj/sXXLbcf9AoxXxFTeaCKZVOJGrlLue/hdGlZWkqsWOkX3lavZ1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987698; c=relaxed/simple;
	bh=WGMbS16ct0K/swj8ovg7d8YcRalpB8mwfNBvB3NLMXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a6bVteSt6Rav8pp0Scz/o3/zbwXsgmGg4AGxAHYeIqbNkl/ZvHBxWagOr3OGzNjHO9KnW7WYAk9P86D5UXup0uc2e61mAdGFCTaWFEK2jpCKtAX1P+tkQeDvb4fbSsXs8Tlov0MKIRfY/PIhgW64E6stGaY6RaKVCKkTtqWH1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7km7PzW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7km7PzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F7F1F000E9;
	Thu,  2 Jul 2026 10:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987697;
	bh=Ujq/W+nNWSYGSLZMYxHb2iNvcd7c3x8AtsbFZbqqgXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H7km7PzW78AeJpGScgT1yT/5t1MBb9cnD2vEJIbgMJrv5qVCssNFJCeZfIEFJmLKs
	 eGxnKYMg681h3qxhpvwmDKWAJ6jmoV9Hs6HLxF0wYRmkrdonu7HT0rLGCM1r61sFq5
	 Pz/0lgiEEmTxFQMjadf9QLArehwRPVUKMxLN/kshHc0pcsHR1iJy7vZrh5Gtlfe8Yl
	 2w57B6H7XmkkJIF3nbWQ1Ash6VO12jmdpvZ8jTurEccy9WDteKRueLFlVGcU19stb3
	 8hb6Eh6X59elggTuY0MwYsVN2ZzrPV7T2RmZ9nzEhoV1dw/+s99kAsLmWhRMcea8gF
	 pqrunko9nSE1Q==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND RFC PATCH v2 4/5] mm/damon: introduce DAMOS_SPLIT
 action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lian Wang" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702095227.75866-5-lianux.mm@gmail.com>
References: <20260702095227.75866-1-lianux.mm@gmail.com>
 <20260702095227.75866-5-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:21:36 +0000
Message-Id: <20260702102137.12F7F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Sysfs state inconsistency when an invalid target_order is suppli=
ed for DAMOS_SPLIT
--

commit 2142d0d071963cdc56d472e03ea29ec38eeda286
Author: Lian Wang <lianux.mm@gmail.com>

mm/damon: introduce DAMOS_SPLIT action

This commit adds the DAMOS_SPLIT action for splitting large folios into
smaller mTHP-order folios. It exposes this action through the DAMON sysfs
interface and validates the target_order to be within the allowed bounds.

[ ... ]

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 9067cb66632ed..198b64ca22598 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> @@ -3063,11 +3067,23 @@ static struct damos *damon_sysfs_mk_scheme(
>  			HPAGE_PMD_ORDER, HPAGE_PMD_ORDER);
>  		target_order =3D 0;
>  	}
> +	if (sysfs_scheme->action =3D=3D DAMOS_SPLIT &&
> +	    (target_order =3D=3D 0 ||
> +	     target_order >=3D HPAGE_PMD_ORDER)) {
> +		pr_warn("DAMON split: target_order %u invalid, need 2..%u. Defaulting =
to 2.\n",
> +			target_order,
> +			HPAGE_PMD_ORDER - 1);
> +		target_order =3D 2;
> +	}

[Severity: Medium]
Does this create a state inconsistency between the user-facing sysfs
interface and the actual running kernel configuration?

When an invalid target_order is supplied, target_order is overridden to a
safe default for the internal scheme here, but the sysfs_scheme->target_ord=
er
field is left unmodified. As a result, the sysfs read interface will
continue to report the incorrect value (such as 0) instead of the actual
value (2) being used by the active scheme.

>  #else
>  	if (sysfs_scheme->action =3D=3D DAMOS_COLLAPSE && target_order !=3D 0) {
>  		pr_warn("DAMON collapse: target_order not supported without THP. Use 0=
.\n");
>  		target_order =3D 0;
>  	}
> +	if (sysfs_scheme->action =3D=3D DAMOS_SPLIT) {
> +		pr_warn("DAMON split: not supported without THP.\n");
> +		target_order =3D 2;
> +	}
>  #endif
>  	scheme->target_order =3D target_order;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702095227.7586=
6-1-lianux.mm@gmail.com?part=3D4

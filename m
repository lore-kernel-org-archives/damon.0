Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507237700A
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907477; cv=none; b=LNLc/eEc8Z8OMLMi4Zria1E9hsItW3CKZ+ALK9q1XxOSLneFTdhiPk96ioLPs4j5PEWgX95GVXJDM06WoD2Gg42fHDFe0ye8RehT6Zrh/JDA3tQQkc79K9AkDRaQnw0zaAfic5glTW9w2MHmRxAYMyNCqJ3DfEcx8696W/MTOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907477; c=relaxed/simple;
	bh=t00/0SDfH0CLbE+RhrXgRjkeezSA83TDAoE1mSh+y60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l8zOrAWW3nCONmKUmIm40ArOwDoeolYDR5sneMumSBhD6v3Rg1pIP3cy6o4tTUSBZQ1aj+0XBssH+gJnXCK26J0al3k7gIinPdhf6qGx6Soh1Yd3jjCtDqAgGBq2V4DQU/w8JMwm7eA9odxLAmD9RNVtY1E6SADqvd9TEe0dzJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZJIYn2e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZJIYn2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206361F000E9;
	Wed,  1 Jul 2026 12:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907476;
	bh=TID9KAGQMERUH0wT9dQRI0Owuxry2KZxy5QrE3BY/WY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KZJIYn2epVQRQ+7hzu3e5mlq+I8Lcql9mc5ui6I4wXftL80oiGoDBvMa4mM9dx8XF
	 z68zB6InjgPcKO3XC9DUVdOVNJtL68lXcwciUp0wzObV/U+vIF8P8iO8tKOJdMQP73
	 VCRcRheJI3EHcKAcBd5Aktmm6r6X59YYe6s6ePOQePHzI/X1kaFRuMJZkXcFbNRFJ4
	 VdPPlO8YEPcopM+x+pFtnk7TKvBTOCMCPf0QPpPht1WWwu86hShpFNZAvS+ii1rlLh
	 dA/y4yy2sT2OgiDeItPxSjqmdDv1uBrsNBpsVAPlvU+EmcHBw82DhlwmzTencjBUkY
	 4nQohcF8R4vcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] mm/damon: introduce DAMOS_SPLIT action
Reply-To: sashiko-reviews@lists.linux.dev
To: "wang lian" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701114716.56503-5-lianux.mm@gmail.com>
References: <20260701114716.56503-1-lianux.mm@gmail.com>
 <20260701114716.56503-5-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:04:35 +0000
Message-Id: <20260701120436.206361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] TOCTOU race in damon_sysfs_mk_scheme() allows bypassing bounds v=
alidation for DAMOS_SPLIT target_order.
- [Medium] Uninitialized target_order field in damon_sysfs_scheme_alloc() l=
eaks kernel memory to userspace.
- [Low] Unconditional use of HPAGE_PMD_ORDER causes a build failure when hu=
ge pages are disabled.
--

commit 3d569aafbbd14d480f96311f5d7fa6a898ce6974
Author: Wang Lian <lianux.mm@gmail.com>

mm/damon: introduce DAMOS_SPLIT action

Add DAMOS_SPLIT to the damos_action enum for splitting large folios
into smaller mTHP-order folios.  Add a target_order field to struct
damos to specify the desired split order.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 35b90b47e35a0..766984a1e63c5 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -571,8 +573,11 @@ struct damos {
>  	struct damos_access_pattern pattern;
>  	enum damos_action action;
>  	/*
> -	 * @target_order: target order for mTHP actions (DAMOS_COLLAPSE).
> -	 * 0 means system default (PMD order).  Valid: 0, 2..HPAGE_PMD_ORDER.
> +	 * @target_order: target mTHP order for DAMOS_COLLAPSE and
> +	 * DAMOS_SPLIT.  For COLLAPSE, 0 means PMD order default,
> +	 * valid values: 0, 2..HPAGE_PMD_ORDER.  For SPLIT,
> +	 * valid values: 2..HPAGE_PMD_ORDER-1; 0 and HPAGE_PMD_ORDER
> +	 * are rejected at scheme creation time (defaulting to 2).
>  	 */
>  	unsigned int target_order;
>  	unsigned long apply_interval_us;
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 085b8042d1250..00d502119c3a5 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[ ... ]
> @@ -3053,6 +3057,14 @@ static struct damos *damon_sysfs_mk_scheme(
>  			HPAGE_PMD_ORDER, HPAGE_PMD_ORDER);
>  		sysfs_scheme->target_order =3D 0;
>  	}
> +	if (sysfs_scheme->action =3D=3D DAMOS_SPLIT &&
> +	    (sysfs_scheme->target_order =3D=3D 0 ||
> +	     sysfs_scheme->target_order >=3D HPAGE_PMD_ORDER)) {

[Severity: Low]
When huge pages are disabled, HPAGE_PMD_ORDER can evaluate to a BUILD_BUG()
expression on some architectures. Will using it unconditionally here cause a
build failure during compile time?

> +		pr_warn("DAMON split: target_order %u invalid, need 2..%u. Defaulting =
to 2.\n",
> +			sysfs_scheme->target_order,
> +			HPAGE_PMD_ORDER - 1);
> +		sysfs_scheme->target_order =3D 2;
> +	}
>  	scheme->target_order =3D sysfs_scheme->target_order;

[Severity: Medium]
Could a concurrent sysfs write change sysfs_scheme->target_order between
the validation above and this assignment?

If sysfs_scheme->target_order is modified locklessly, it might bypass
the boundary checks and assign an invalid value to scheme->target_order.

[Severity: Medium]
It appears sysfs_scheme->target_order might be uninitialized when a scheme
is first allocated. In damon_sysfs_scheme_alloc(), the scheme structure is
allocated without zeroing:

mm/damon/sysfs-schemes.c:damon_sysfs_scheme_alloc() {
	...
	struct damon_sysfs_scheme *scheme =3D kmalloc_obj(*scheme);
	...
}

If target_order_show() reads this field before it is explicitly set:

mm/damon/sysfs-schemes.c:target_order_show() {
	...
	return sysfs_emit(buf, "%u\n", scheme->target_order);
}

Could this leak uninitialized kernel memory to userspace?

> =20
>  	err =3D damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota=
);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701114716.5650=
3-1-lianux.mm@gmail.com?part=3D4

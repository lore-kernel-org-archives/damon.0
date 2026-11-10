Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278154;
	b=zF7FwmXNj/F9h3NuksMkzvDQDSMWEJBotmXKMUaw2hJ4nbGotlgMBUdzIzKiiivH+EZm
	 0ObGwNM2P1IP/mWyf13d8lHeyBCt460S8Pv9mZjnt4tlEjYrX7CrRDLSArnA15DFvCmUQ
	 erg0g2/pBpG4IkHYloqs/nxMmMquTIkre8xe5iFQK9Ra+eDzyYwyeIMZtMAEk+bbQYitV
	 x6lmlJBMhq4xmCBytYC60kVvsyF+M0uPiO8Up2iOsUoef6YDggIPZfyAukr/ZQ4rmoNrZ
	 U507RBsGWwusnOj0D0D8TWFGAXjMBm7rOxGP6XvnQD9K4x/N/K7to4NlBnJZqc7l6Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278154;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GUKtxhOMIkSEdSdla2M6h/eM7ymf9sJ0/eqi4VjICc4=;
	b=uZbefDNHPVwCvJPdQZqt/kG3y77CJZlGy4/kXQzSGtrUMOTgIQjlzbkh33pnrmEDkekq
	 U8HtA8Tq1HUL7L1kr7S6erTgY79wjDqTOjletvrOg6KhiGgI1BSobiOjGK+4PY72kWHvZ
	 OPAzOcJybxjADus9WMpiyckuPwg6X5EH8cQfkBH62SdlwQy1pk2DpR5i4DMv3g07WqZal
	 VIh9TMxT+ODujEVMwibgoFa7kt9JKjXaBw7HRRIURfM8KyB8Wm3W9FimnBv3O/ej6FjRj
	 5KMTYytAHxtYuocBCUhAItgSd7wEr0GN2o5gA4HMhc/u5tz2PpH2rMPLCyyQsc4kYlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3tH3h7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57D606A321
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3tH3h7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D099A1F0089F;
	Tue, 10 Nov 2026 02:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278154;
	bh=GUKtxhOMIkSEdSdla2M6h/eM7ymf9sJ0/eqi4VjICc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E3tH3h7HXqaPi3H76iNlXeC3en80biuIz4aoJbBXzDyr3Yo1VguZAtsBbVdkDYYXM
	 9IP5k2s07FOMZk8DimN/6dP7ITDzDCsGsvk727Dm2EGmPzaDoswBvDuzDLgpw84TcQ
	 CFRL3BZIl0zxqXHTYAkFYyN3sknFPBl6tPw6u7VXuls3MtCOSZd0C9zx6jZXa5w7Ry
	 Or77nRwdUzGoNaoUKj72aq1VPOlxjozJgoWY4og37csTGvVwGJ+4O09Veeq/iImBsL
	 kMlP9aY2e6+6Hd5oftQSaGfC9xL2v9trKrkIVHcpG+tdbDCuZL17OTnf8s7oX1IZQg
	 WfyxuRdkD4IZg==
Message-ID: <sashiko-outbox-206056@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/core: move static variable
 last_nr_regions to damon_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110022924.115699-1-sj@kernel.org>
References: <20261109200803-failed-6.12-26ae50a0901a@kernel.org>
 <20261110022924.115699-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 02:35:53 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mm/damon: last_nr_regions placed in public section of struct
  damon_ctx
--

commit eb0ad0bdecede5a2fbbdad016dac644dd4b389f4
Author: SJ Park <sj@kernel.org>

mm/damon/core: move static variable last_nr_regions to damon_ctx

This commit moves the static last_nr_regions variable from
kdamond_split_regions() into struct damon_ctx so parallel kdamond threads
do not race on region split state.

Link: https://lore.kernel.org/20261025164808.152048-3-sj@kernel.org

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 4688a10eca89b..dfd0295104d37 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -641,6 +641,11 @@ struct damon_ctx {
> =20
>  	struct list_head adaptive_targets;
>  	struct list_head schemes;
> +	/*
> +	 * number of regions after last merge.  Read kdamond_split_regions()
> +	 * for more details.
> +	 */
> +	unsigned long last_nr_regions;
>  };
> =20
>  static inline struct damon_region *damon_next_region(struct damon_region=
 *r)

[Severity: Low]
Should last_nr_regions be placed inside the /* private: internal use only */
section of struct damon_ctx (or preceded by a /* private: */ marker)?

In this tree, the end of struct damon_ctx is after /* public: */, so adding
last_nr_regions here without a kernel-doc entry causes scripts/kernel-doc
(via Documentation/mm/damon/api.rst) to warn:

  Function parameter or struct member 'last_nr_regions' not described in 'd=
amon_ctx'

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110022924.1156=
99-1-sj@kernel.org?part=3D1

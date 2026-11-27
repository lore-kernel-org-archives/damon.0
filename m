Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795812497;
	b=ShFma47pmALqMfx3RYOr+2jV0bzzORVHRJ2d2/Bvs3697Djc5Tlb4HcaNzvHAyKsuO0x
	 74vFnGMRqgh6WZhmhM5VX6w0Tz0jY2dH85fA9DwbKWVUW1A6QoVSGIx3InFUycwis6/Jt
	 MIFYn9KuOClkbu9cQrmUj5wv1WHXbSifSEU43ad7aCe0mz0q5kim+8qU5dWz16GXeYkOL
	 ru6KcCtvjQ+aSb2hglIqnmv6i59E9j9T5bCsN8Xx4qSMkX/fLiA4k7KOx9lbWVYORK/lj
	 lQavC8fscV7NvJO2nvhMch4JhbtHl1H+AZUB2sXZIHO3uXZi/SGFYvBik9juLgAiYUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795812497;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sllkbWDxXjWYtj7uG2v2TOwOgj+n7g6G9IaAtPlGIVE=;
	b=z7rjVAB3o7zz9llYwhy6OwR/1zNGseSIhvj/QF2QgcTANGRYBjUsbkzNSWh39jhfyQmd
	 tNwxaUe2i01BGAQrPo5pUizD1aIdbLcNdRDJr6Q3jdec9VWfSYtctsUezRkPDv5zdkuHa
	 YqqZ2Avtt6awybAZpnVwfoNL8Jif5/1mddYqZGUgOr5T1yPngg1IJjwN61YO7YQoJpJKz
	 tktHqYc2H16gtaF4ZH8xjBn5m/foKN5MKCxgEB0hvHSkER4ap57eIWNLl/z0dpDsaygRF
	 nPXCbqq/U47TavNH8iv7cfFr/qUQrT35U+kioQKlAL6uVjBCDlrZ/AFKl6VeTOal9+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFt7j+mY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7178606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFt7j+mY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1DB1F000C1;
	Fri, 27 Nov 2026 20:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795812497;
	bh=sllkbWDxXjWYtj7uG2v2TOwOgj+n7g6G9IaAtPlGIVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bFt7j+mY7bZARjb3g9pJPiITfMS0DJEXkG9SMIhpRJqGG6LlyojRMgCzsepzLvV6B
	 KcR3DRgLYogyhtNxeL4xiyQWSnc63OhegISiFOeRKXLe9Miqux+aDC/Ukz2hoP+pxq
	 oqDwFHrdiN/fv4/+JHDdb4FYeTZ3TT5yIgh+rMtnRwICOGFb566vE7hVbckAXqQBlr
	 qe4bmyNL+N/ZhPMPwGdNuUIP98Ql/8PySR9opLPzyS5qUJYpSjjqoBkMqaIZ6uarPB
	 KeaUdJEG4jLFQwDEUcH72VNu0bQLRH5ZyQf0rLCtsrWlhspQgqpfqTyyzspJMVIqI6
	 xyz/TlJdpnMLQ==
Message-ID: <sashiko-outbox-238270@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH mm-hotfixes-unstable] mm/damon/core: do not update
 stat for core filter rejecting region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261127203938.94339-1-sj@kernel.org>
References: <20261127203938.94339-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 20:48:16 +0000
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
- [High] mm/damon/core: stale region size in damos_apply_scheme()
  corrupts regions
--

commit 2aba0f31066065a1efc163e77a7548d189458afa
Author: SJ Park <sj@kernel.org>

mm/damon/core: do not update stat for core filter rejecting region

This commit moves the damos_core_filter_out() check in
damos_apply_scheme() ahead of the quota enforcement check so that
regions rejected by core filters are not accounted in DAMOS statistics
when the quota is full.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0e6b361f97ea6..e0ea93de100d8 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2785,6 +2785,8 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  	}
> =20
>  	if (c->ops.apply_scheme) {
> +		if (damos_core_filter_out(c, t, r, s))
> +			return;
>  		if (damos_quota_is_set(quota) &&
>  				quota->charged_sz + sz > quota->esz) {
>  			sz =3D ALIGN_DOWN(quota->esz - quota->charged_sz,
> @@ -2794,8 +2796,6 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  			if (damon_split_region_at(t, r, sz))
>  				goto update_stat;
>  		}
> -		if (damos_core_filter_out(c, t, r, s))
> -			return;
>  		sz =3D damon_sz_region(r);

[Severity: High]
Should sz be refreshed with damon_sz_region(r) right after
damos_core_filter_out() rather than after the quota check?

damos_core_filter_out() -> damos_filter_match() can split r in place and
shrink r->ar.end for a DAMOS_FILTER_TYPE_ADDR filter.  Because sz still
holds the pre-filter region size during the quota check, when the
remaining aligned quota falls between the post-filter and pre-filter
sizes, damon_split_region_at(t, r, sz) is called with sz >=3D
damon_sz_region(r).  That expands r->ar.end back across the filter
boundary and inserts a zero-length or inverted region (start >=3D end)
into t->regions_list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127203938.9433=
9-1-sj@kernel.org?part=3D1

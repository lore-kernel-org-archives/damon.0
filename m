Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774963;
	b=eBT/Qj/rQpsDFZecuVlbMwiP3Eqf5MthSHSkJ20aNK+HBZ9W1Fbm1zmkbStdXrHHVxdJ
	 MKtb/0lbwL8aTV9RazrAEBDtRwnGkjGeScJgEMVQiglGdFBXvV2JNqcRbvjZ/FU6EpUDq
	 7zrv88uynxzpr2EGZkmMVT2fiWYXUKK4uwag5O88K9Cb/F4bKm0PEuSJh1dv0471MaOYE
	 zRuzUQSBRv1Iq2VA+8XIuyLzCnJ034OnqVAN/VSXgFNwICw0CjfZbKD7qxDg04ZK8iv1O
	 Mm6s0RAE2X5dsrnCQQwfsknU4RiNx7wE8waalxRV5Wt4s733PtD/b6FNEm3bZ6Pc+Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774963;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IHToU/BiGUI+WxfYLTR89D31Aiw4o97ubpuVSP2LxpE=;
	b=lc7yMmdi4jbnqSXCO3uKS9xcfXpnHEOzesz36E3LCCnbbhKdL5pTOKNWoZmuRBiDYnBC
	 yk+fD4dVS+8i+j1kU7vor85D5b+ge+3Q2egSdwvpZq5jSiYlXpSOhPvxNg21Ivo3cB6C0
	 kn7aautbtblo/4A3RUTfhcy7p4LhOdGLOJIqQ5pJzRerAWgqaq1wb5/HlZVn8keVwHR3D
	 73oKcthiR8SrXA0bO02wnkuoInMhkhgi7f0L97NKVBxGOvkusxXSH9a6vEe6pgtN1Dn7w
	 hmrJ/i84BBUyGay+cTS2mZsxrXz6tU6CYR5pfuajwXGM8cmNmrp1+7esuUxXXraegAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCOI3UKP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134C606A323
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCOI3UKP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EDF1F000C5;
	Sun, 15 Nov 2026 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774962;
	bh=IHToU/BiGUI+WxfYLTR89D31Aiw4o97ubpuVSP2LxpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cCOI3UKPD8xCU7gxQ9rrCBQF3qv4LlGfW+UCMfm+uAdGuGLixyiip6w5ph0lzIGeF
	 QOetJcW2SCJexTtScjpeBQXOTUv11nMVeh9yoEPWIgeV5Uaof0OMl+Hb2TQ44DnbIU
	 nCayCRNOs0yDRoU+TOEP9rnEnQxlTMVkni91BSeOmjZ4eHR3ncTc7RyJG2VZIZOMfK
	 pNLu9PXSpuWlCNTMclNCWQhbCMFL/H44g5giD+d3KDdqhZEtwKQVhBeOjlcEIDkSLG
	 XPm6oEBH4Xi0ls4NwK28uhsAG/9Ht/z50yN6yL6P6/VcVXS2289XIJvUzSNxi2lfQK
	 IUaS44dQUxW1g==
Message-ID: <sashiko-outbox-215843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 12/27] mm/damon/core: introduce
 DAMON_FILTER_TYPE_REPORT_MADE
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261115202849.99134-13-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:36:01 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] mm/damon: missing report_type copy in damon_commit_filters()
- [Low] mm/damon: missing kernel-doc for report_type in struct
  damon_filter
--

commit 4743cf0114c7407b0d8b853557595a3a4674cb82
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce DAMON_FILTER_TYPE_REPORT_MADE

This commit introduces the DAMON_FILTER_TYPE_REPORT_MADE probe filter
type, adds report_type to struct damon_filter, and copies it in
damon_commit_filter().

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index ca0135c6f6700..cce7d344c585b 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h

[ ... ]

> @@ -834,6 +836,7 @@ struct damon_filter {
>  			unsigned long range_min;
>  			unsigned long range_max;
>  		};
> +		enum damon_report_type report_type;
>  	};

[Severity: Low]
Should @report_type be documented in the kernel-doc comment for struct
damon_filter to avoid a kernel-doc warning?

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 06b85d00e38d9..c02c7fbc1d864 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1834,6 +1834,9 @@ static int damon_commit_filter(struct damon_filter =
*dst,
>  		dst->range_min =3D src->range_min;
>  		dst->range_max =3D src->range_max;
>  		break;
> +	case DAMON_FILTER_TYPE_REPORT_MADE:
> +		dst->report_type =3D src->report_type;
> +		break;

[Severity: Medium]
Does damon_commit_filters() also need to copy report_type when allocating
a new filter?

damon_commit_filter() is only called when overwriting an existing filter
in dst.  When src has more filters than dst, damon_commit_filters()
allocates new_filter via damon_new_filter() (which uses kmalloc_obj()
without initializing the union) and runs a separate switch on
src_filter->type:

mm/damon/core.c:damon_commit_filters() {
	...
		new_filter =3D damon_new_filter(
				src_filter->type, src_filter->matching,
				src_filter->allow);
		if (!new_filter)
			return -ENOMEM;
		switch (src_filter->type) {
		case DAMON_FILTER_TYPE_MEMCG:
			new_filter->memcg_id =3D src_filter->memcg_id;
			break;
		case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
			...
			break;
		default:
			break;
		}
	...
}

Because DAMON_FILTER_TYPE_REPORT_MADE is not handled there, committing a
newly added report_made filter leaves new_filter->report_type
uninitialized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D12

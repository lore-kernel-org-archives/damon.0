Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807424;
	b=v2EcFivA8+luT+l9c3tQexrqonw2Z5raZHyQ3aLIs5BnmKC5i2b1XWPIumaN5z29Abgi
	 /ST+jgBlcXFLJOQ6qyJOQvetgfzBAHxHsLhQjwIiVAv5uIJ2NorsueBv0jJsytEF+UjG2
	 lJoTwPXvv/wR0jv/ep6TInwotKjsAkXchVz/lu6bBhuNVzuQ8smht0Nd1YAVQ0mEGmNn5
	 +cEZFNeTjHk6BzqMWbYTVNgiAn1aOaw10ETw/pGNxgvorQkVZLmiXXw4msMrIKcvgH9cB
	 H0zP3a2IWT7U8lV64m6u5vrx0e76SJ5p9UTqvOOwjeEivA6rcgbYcQEIV+GXrusDKVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807424;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K2Rm/qqSbuCxIXb1iiVZqgo+p9PpDw6v0y8c0lPMvLc=;
	b=zEtshc8M7mZT7yczGD5xwG3Y5YreBuuTZ90wqthYVMnE6l2Oz92SRf1BhC1kZHiDzBPL
	 a8s4grR4VPDn4npX68/k8le4dQTIfTZ3Xt+/LVB9rEO3K49XCn2AsTSNi83xrL+eK9jbz
	 4RTShkMJuS8M2XyFFWsnFiBTrbqzE/ii7xj8UEFyg9SbtD4JMaeXsnILGWm5U0LpZQRyF
	 k3a/Ot+TdMaf+Oc7sBLk9FIyvJmH9HiT6Hc6qlTGyII7hMvF9zNhTXEp7s4SCYJVYoqiZ
	 DI3jNMakPDs8Q3F2z++YFvPzDTr/qXdXMF/UUOwZDxBzIA2KLkfdSDeuRume0V+/hag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I3/ZktAz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B96606A31B
	for <damon@lists.linux.dev>; Wed,  4 Nov 2026 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3/ZktAz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85851F000C1;
	Wed,  4 Nov 2026 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807424;
	bh=K2Rm/qqSbuCxIXb1iiVZqgo+p9PpDw6v0y8c0lPMvLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I3/ZktAzonT+YJQP1B7Dfbe167+htrikqCuyVM1BQMd+f/JXPzVqNuLHllKkPiSYt
	 7rpVHNHimWsaAZSQFYYQ/GUcXH6uqne+IjWdKwyOHxrNg9DAnXORe/XgB4mao/MN45
	 f9aLgSiDPn2BsFsL1HFusNldxTDrlooToV32anBz3oTmL31kVqAL9GRhgKeI2JcGeg
	 QgmvxvdQ5BNrrYs7pmuAjNW03JLOH+lVbJtS/oKbOr9hh45VQrQvSsvNXjaxJnBGCt
	 k3PD2xA93KBNRx0Ad0q5L3NJexTpfb1p2VTSzg9blgxVDFBaN7eRHZEKq7t27Arhit
	 jD+Ixkzc8qseA==
Message-ID: <sashiko-outbox-197544@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] mm/damon/sysfs-schemes: support
 DAMOS_FILTER_TYPE_AGE_MS
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261104153645.82945-3-sj@kernel.org>
References: <20261104153645.82945-1-sj@kernel.org>
 <20261104153645.82945-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:50:23 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/damon: 32-bit overflow calculating age_ms in damos_filter_mat=
ch()
--

commit 9c78f1b31239922167bf213c5406c37c05fd310f
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: support DAMOS_FILTER_TYPE_AGE_MS

This commit exposes DAMOS_FILTER_TYPE_AGE_MS to the DAMON sysfs interface
using the "age_ms" filter type keyword and the existing min and max sysfs
range files.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 637f1bd0c950b..230987efac3ac 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> @@ -2875,6 +2879,7 @@ static int damon_sysfs_add_scheme_filters(struct da=
mos *scheme,
>  			filter->sz_range.max =3D sysfs_filter->range_max;
>  			break;
>  		case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> +		case DAMOS_FILTER_TYPE_AGE_MS:
>  			filter->range_min =3D sysfs_filter->range_min;
>  			filter->range_max =3D sysfs_filter->range_max;
>  			break;

[Severity: Medium]
When userspace configures an age_ms filter with range_min and range_max via
damon_sysfs_add_scheme_filters() on a 32-bit system, can age_ms overflow in
damos_filter_match()?

When kdamond evaluates the filter via
kdamond_apply_schemes()->damon_do_apply_schemes()->damos_apply_scheme()->da=
mos_core_filter_out()->damos_filter_match():

mm/damon/core.c:damos_filter_match() {
	...
	case DAMOS_FILTER_TYPE_AGE_MS:
		age_ms =3D r->age * ctx->attrs.aggr_interval / USEC_PER_MSEC;
		matched =3D filter->range_min <=3D age_ms &&
			age_ms <=3D filter->range_max;
		break;
	...
}

Here r->age is unsigned int and ctx->attrs.aggr_interval is unsigned long
(in microseconds). On 32-bit architectures, multiplying r->age by
ctx->attrs.aggr_interval is performed in 32-bit unsigned arithmetic before
dividing by USEC_PER_MSEC, which wraps around once a region's age exceeds
approximately 4,295 seconds (~71.6 minutes) even though the resulting
millisecond value fits in a 32-bit unsigned long.

A similar 32-bit overflow on r->age * c->attrs.aggr_interval in
damon_hot_score() in mm/damon/ops-common.c was fixed in commit 0284dff76e87
("mm/damon/ops-common: fix age_in_sec overflow on 32-bit"). Should
damos_filter_match() use div_u64((u64)r->age * ctx->attrs.aggr_interval,
USEC_PER_MSEC) as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104153645.8294=
5-1-sj@kernel.org?part=3D2

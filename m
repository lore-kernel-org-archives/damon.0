Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E6304BB3
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929356; cv=none; b=BUqCGwAT3PbGBxvBK8pRGxbVd4wOa6unCmA4ZwdYHfnIrbUkvvTpv8ojJxTJSZAbxup5u3f1q8K2cmKLqjSm+LdaySeOzLKFCmEclv1NbmL5XkJmFYzrlNJWk0ZND+VCK6r6UUGsMoN8cN+tAThqYd1Eej42QXbRnKiY5ZsXNfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929356; c=relaxed/simple;
	bh=6doAkw/qcBQgeLH2wqRN1hFHgN5Y61bBuKlwmDYnYy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M6TQuRyy//8OSK15FAKwk9OaTkQVPQ2zbtxVIXGyZB3WvBd9Yy+npRVNafJ4lWhICfUGRYgM1JmYDOjSDl4nwQT5XkGKGLuhBpPQqnW69cK1nQyiNSAnGUo/iPE2ocRriGPxov1yMyjejYwwW14PgIUspjyD36wQcQosZdUcKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss1FbCL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss1FbCL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2841F1F00A3A;
	Wed,  9 Sep 2026 04:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788929355;
	bh=cRGNBGZUEeU80mnZf7pz2bs76EYE+10a3/O5SkaVhxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ss1FbCL9F/evi5rDzld5sRiqAHz1XCv3HqT5/LaAE5z103kr50PcfkPuiiMkteMGl
	 y5PNSXRcat+qtP02NepV1EQIWBoh+ag2MLFPikaEBaXuBGwsjEP/Sb/AXcWHNJW7r9
	 wuIZI8byHJGi2soybU+oGK3NA9DiVlpjDrC4nzKIGGjtDF+6/GUdDR7DcMmsyPwT5P
	 R6ZkrgpgFycKJLrdZ6CVu/qRrc9eDa1WIPAWWo99zf4pzUxCkxqu7TgiB1pqZpOjrD
	 Fk5LMAU4yLco3Vt6CYhXfGctNWkWlAnvHCHeUqfjpN67aQn0901XinIvO/zIonGSne
	 1sSmKOUvhpjOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.2.y] mm/damon/core: skip aging from repeated
 aggressive merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909043419.207354-1-sj@kernel.org>
References: <2026090839-reoccupy-dizzy-a7bd@gregkh>
 <20260909043419.207354-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:49:14 +0000
Message-Id: <20260909044915.2841F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsigned integer wrap-around of `threshold` causes an infinite loo=
p in `kdamond_merge_regions`.
--

commit 1ad6fba11a691c8367f432e647523c0214515b3e
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip aging from repeated aggressive merging

This commit addresses an issue where the number of DAMON regions can
temporarily exceed the maximum limit. It updates kdamond_merge_regions
to skip aging during repeated aggressive merging to avoid corrupting
monitoring results.

Link: https://lore.kernel.org/20260712165432.87609-1-sj@kernel.org
Link: https://lore.kernel.org/20260621203548.10718-1-sj@kernel.org [1]
Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org [2]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index cff932b3317d0..024a3a185bfe8 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3160,15 +3162,18 @@ static void kdamond_merge_regions(struct damon_ct=
x *c, unsigned int threshold,
>  	struct damon_target *t;
>  	unsigned int nr_regions;
>  	unsigned int max_thres;
> +	bool count_age =3D true;
> =20
>  	max_thres =3D c->attrs.aggr_interval /
>  		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
>  	do {
>  		nr_regions =3D 0;
>  		damon_for_each_target(t, c) {
> -			damon_merge_regions_of(t, threshold, sz_limit);
> +			damon_merge_regions_of(t, threshold, sz_limit,
> +					count_age);
>  			nr_regions +=3D damon_nr_regions(t);
>  		}
> +		count_age =3D false;
>  		threshold =3D max(1, threshold * 2);
>  	} while (nr_regions > c->attrs.max_nr_regions &&
>  			threshold / 2 < max_thres);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but could this loop become infinite?

If a user with access to DAMON sysfs sets aggr_interval and sample_interval
such that their ratio, stored in max_thres, is greater than 1073741824, can
the 32-bit unsigned int threshold wrap around?

Inside the do-while loop, threshold continuously doubles. When it reaches
2147483648, doubling it would wrap it around to 0.

Consequently, threshold / 2 would never exceed 1073741824, making the exit
condition infinitely true.

If regions cannot be merged below max_nr_regions due to sz_limit, would
this result in a kernel hang on the kdamond thread?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909043419.2073=
54-1-sj@kernel.org?part=3D1

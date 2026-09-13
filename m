Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FEE36C588
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320295; cv=none; b=KTL8OvWbHqlr1r39o/OTB+HVMj7ONvFIVd3R2uCEIgZOSZa4cpuOHsdztDNUwWcfUtJ8/c7vs9WDhAcEHlxMJFLpiVJ97uEc+XLTkmIts1sMDd4MUvlla9jbtueD6nbad9lYIXn8JFrTDDx52xhr9AvPAO4n2Zu0/+rBmYY8jgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320295; c=relaxed/simple;
	bh=6Iv6pb7Za7SsbCQKoXxjwhsdDC6zCcVT2uy1Lv8f1Ng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sumLXt4iWc4STUCleSACgXSZcCyYnyicdjdkmq4VOxpIVmUVLD7/5xaFNfO103nVvLaNnmYoXHBTeCpWDrSedLewg2Uj3/6kEySZ3Iv5YSHNh87h9kJOvSxSEsQFra2sJLWg8ARA6NlMGANAmihcJgPjmLR6ECeh8aAPegFasbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnKee9DU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnKee9DU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9592D1F000FF;
	Sun, 13 Sep 2026 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320293;
	bh=mgnbIK5DcYzeXmFqvLEAv9dCZMWaQykXx0xDeyAsV9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cnKee9DUUU5XiloTEAQkbSIJ1MIj4NsQ6bcozJ5Alkj8oXuKCCQZyEjNwMOqDonNS
	 5wVVg1xp140X+9dlZgFBpZx3tEnfnFIij/MkaCq9dcLV9pr5ZjhooLX2ph9Yz9iUIX
	 ghbjTcAe6HiwtoRUIpTds7TURpmFE5d9S9GFi6HJjZsv5+EsHN2TQW/8FiieyclIva
	 vnOw7eex36AVqiVDQUayTxkzF45SA1huzbs6oYkEeIp4z+PtuUk5eg8VB0HWj4QilJ
	 fdC2iQCORNDBApkQHOkba32BFnXG0eQm66jYnMaanNXN1KIwPNC+sZ4rwuPxNCO4ww
	 w9Nn56QLsvEkw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/8] Docs/mm/damon/design: update for hugepage_size
 probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171133.102366-7-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
 <20260913171133.102366-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:24:53 +0000
Message-Id: <20260913172453.9592D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Newly added probe filters of type DAMON_FILTER_TYPE_HUGEPAGE_SIZE =
are left with uninitialized `range_min` and `range_max` values, and bypass =
bounds validation.
--

commit b9cb7bf28c7342005a919d584ad8cc1ce1cf9694
Author: SJ Park <sj@kernel.org>

Docs/mm/damon/design: update for hugepage_size probe filter

Update DAMON design document for the newly added hugepage_size data
attribute probe filter type.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0c98f7e267d07..a3febdc355c1e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1807,23 +1807,33 @@ static void damon_commit_filter(struct damon_filt=
er *dst,
>  	case DAMON_FILTER_TYPE_MEMCG:
>  		dst->memcg_id =3D src->memcg_id;
>  		break;
> +	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> +		if (src->range_max < src->range_min)
> +			return -EINVAL;
> +		dst->range_min =3D src->range_min;
> +		dst->range_max =3D src->range_max;
> +		break;
>  	default:
>  		break;
>  	}
> +	return 0;
>  }
> =20
>  static int damon_commit_filters(struct damon_probe *dst,
>  		struct damon_probe *src)
>  {
>  	struct damon_filter *dst_filter, *next, *src_filter, *new_filter;
> -	int i =3D 0, j =3D 0;
> +	int i =3D 0, j =3D 0, err;
> =20
>  	damon_for_each_filter_safe(dst_filter, next, dst) {
>  		src_filter =3D damon_nth_filter(i++, src);
> -		if (src_filter)
> -			damon_commit_filter(dst_filter, src_filter);
> -		else
> +		if (src_filter) {
> +			err =3D damon_commit_filter(dst_filter, src_filter);
> +			if (err)
> +				return err;
> +		} else {
>  			damon_destroy_filter(dst_filter);
> +		}
>  	}
> =20
>  	damon_for_each_filter_safe(src_filter, next, src) {

[ ... ]

> 		new_filter =3D damon_new_filter(src_filter->type,
> 				src_filter->matching, src_filter->allow);
> 		if (!new_filter)
> 			return -ENOMEM;
> 		switch (src_filter->type) {
> 		case DAMON_FILTER_TYPE_MEMCG:
> 			new_filter->memcg_id =3D src_filter->memcg_id;
> 			break;
> 		default:
> 			break;
> 		}
		^^^^

[Severity: High]
Does this code miss copying range_min and range_max when a HUGEPAGE_SIZE fi=
lter
is dynamically appended?

Since damon_new_filter() allocates new_filter without zeroing it, range_min=
 and
range_max are left uninitialized for newly appended HUGEPAGE_SIZE filters.

Furthermore, because damon_commit_filter() isn't called here, the bounds
validation (src->range_max < src->range_min) added above is completely
bypassed. This leads to erratic memory filtering behavior since DAMON might
skip or apply actions based on memory garbage.

Should case DAMON_FILTER_TYPE_HUGEPAGE_SIZE be added to this switch block, =
or
perhaps the code could be refactored to reuse damon_commit_filter() here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171133.1023=
66-1-sj@kernel.org?part=3D6

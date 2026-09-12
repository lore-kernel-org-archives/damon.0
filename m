Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941002594BD
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241404; cv=none; b=Fcbz0FBGv4QfCn5/NeyNQAnfkSDrA+GaXfTz8mqj9vKPDHZUYaZyS1U+g1EwC0JxeuEgFUKk00c48WVv/eh9ppeTKmLJAeQGaIxn4CTyiSArQC4Y6KeMBlovz7UPdCY7IhBgZELB9xQOzK2dwhl0Ayzqt2pZW/DIwv8Vn7ZithA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241404; c=relaxed/simple;
	bh=rfeyEsvB4A9USS7gWS58anQlA2XsY1B77ENtuuBVdQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KGcYzKA1VEvoqVLMNkz0cvsii8wVb8T9sFjFIUzvA7NoLEig4dYvpE69T1fsxuEB4RhBBh+Ly3HK3vbWZyvvecR27wlQzEOpwH437HTC6c8r/Y3vVZUKVeNJQ0roiEH3i1ws9n9to259/lzQKnlZsNA7Xcx63wXSowUq5HPTLSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfiGEBzk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfiGEBzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B061F000FF;
	Sat, 12 Sep 2026 19:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789241403;
	bh=8sfi5gNf+5oEj1l39Mu8w35eOIKQFGxgsn8Za/JLT7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SfiGEBzk7XuFqXd8vVBhxFoeuPykqMByVx/5tRRnRe1wmjcR5NY2FDcoHm0th7S39
	 hgb2jtTnmxpFxavDNVfc3geqnZDfgXExKDv/xzUWg/Os7bj4z2CJWx1Dre3rmcuzB8
	 +AFpniZE/67UQgZO/qaoWGQ1OMecJyTd5WNbdrBK0S0uto5LZz5JczM7uJxY1kfehQ
	 57RLRZKM5L6huaqCYi0tDwDDKEJ/9h5cpIt1pgU04MbREwazlXm8f7KxpBbD3CkZFt
	 CfBkEx/FgO6ERDjV2uqsLnwg4swwTUFSHsdvAZXQ//LjwLbpdwspKmQY8nnqldN8WR
	 0QUmZZRsVnoAQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/8] mm/damon/sysfs-schemes: drop centralized filter
 range arg validations
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912191807.138502-6-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
 <20260912191807.138502-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 19:30:02 +0000
Message-Id: <20260912193003.54B061F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the filter range argument validation in `damon_sysfs_add_=
scheme_filters()` relies on the core layer to perform this validation. Howe=
ver, the core layer's commit functions (`damos_commit_core_filters()` and `=
damos_commit_ops_filters()`) silently ignore the return value of `damos_com=
mit_filter_arg()` when adding new filters. When an invalid range is provide=
d via sysfs, `damos_commit_filter_arg()` returns `-EINVAL` and aborts befor=
e copying the arguments. Because `damos_new_filter()` uses `kmalloc_obj()` =
(which does not zero memory), the new filter's union arguments (e.g., `addr=
_range`) are left completely uninitialized. The filter is then added to the=
 active DAMON context, resulting in the scheme acting on an unpredictable m=
emory range derived from uninitialized heap garbage.
--

commit a45f05608fa3c7f9050ea4eac0fd8f19b22ee509
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: drop centralized filter range arg validations

This patch drops the centralized filter range argument validations in the
DAMON sysfs interface, relying on the core layer to perform this validation.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 8c8ab82c8facc..a4ec5d54cfbd1 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> @@ -2832,27 +2832,14 @@ static int damon_sysfs_add_scheme_filters(struct =
damos *scheme,
>  			}
>  		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_ADDR) {
>  			filter->addr_range =3D sysfs_filter->addr_range;
> -			if (filter->addr_range.end <
> -					filter->addr_range.start) {
> -				damos_destroy_filter(filter);
> -				return -EINVAL;
> -			}
>  		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_TARGET) {
>  			filter->target_idx =3D sysfs_filter->target_idx;
>  		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
>  			filter->sz_range.min =3D sysfs_filter->range_min;
>  			filter->sz_range.max =3D sysfs_filter->range_max;
> -			if (filter->range_min > filter->range_max) {
> -				damos_destroy_filter(filter);
> -				return -EINVAL;
> -			}

[Severity: High]
Does removing this validation allow invalid ranges to bypass sysfs and reach
the core layer logic where errors are silently ignored?

Looking at damos_commit_core_filters() in mm/damon/core.c, the return value
of damos_commit_filter_arg() is not checked when adding new filters:

mm/damon/core.c:damos_commit_core_filters() {
    ...
    damos_commit_filter_arg(new_filter, src_filter);
    damos_add_filter(dst, new_filter);
    ...
}

A similar pattern exists for ops filters in damos_commit_ops_filters():

mm/damon/core.c:damos_commit_ops_filters() {
    ...
    if (src_filter)
        damos_commit_filter(dst_filter, src_filter);
    ...
    damos_commit_filter_arg(new_filter, src_filter);
    damos_add_filter(dst, new_filter);
    ...
}

When an invalid range is provided via sysfs, damos_commit_filter_arg()
returns -EINVAL and aborts before copying the arguments. Because the new
filter is allocated without zeroing its memory, the filter's union arguments
(like addr_range) are left completely uninitialized.

Since the error is ignored and damos_add_filter() is still called, won't
this result in the scheme acting on an unpredictable memory range derived
from uninitialized heap garbage?

>  		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
>  			filter->range_min =3D sysfs_filter->range_min;
>  			filter->range_max =3D sysfs_filter->range_max;
> -			if (filter->range_min > filter->range_max) {
> -				damos_destroy_filter(filter);
> -				return -EINVAL;
> -			}
>  		}
> =20
>  		damos_add_filter(scheme, filter);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912191807.1385=
02-1-sj@kernel.org?part=3D5

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4018A93F
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320264; cv=none; b=DhScg2KQUem4O0mNKn/zhF/cXQyIImqoeDx8oYYY4XogzbyEdpHP+MANpu5BgTqhT96v/BbN8iOJ5ZAWiTi3GZsUs3rP5146gywKk+RDT+urNJ9XCzlrxfssrY05+acmrTNhAILFezAvBD5uFCNZ2XjC568Pu/BtleGod6ZjojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320264; c=relaxed/simple;
	bh=6vh+GjTB2vDtE1ju5qfmd7UkqxIzcQiVnhpfza/E2i4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tX5MGn7/v63RXH+OPkdYhtSR2d4hAZnwkEKCbF/+8vML7K6yVejPokCL/4+Ge6TfAilaj3IMmKrrYMisjYikb+ppztnG9hjCD5SRvh0TCR2IbLO5RAa7NYcINMW43yA9Xpd5xV6N4e3l/pId1SFtc/J8pqrBsZUeZiziOfHie6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVnNKNik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVnNKNik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7811F000FF;
	Sun, 13 Sep 2026 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320262;
	bh=/MGdVLs8aRjHJVUYoOmHhfcc06iY8RASd+SMEA8f1ZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JVnNKNikAmKpuMzMIwoFUDF41Gy1eAcBGfJhB78UV98PxXY/mGy9ucUF6kTf1+bCs
	 oI1vvaqdvjBrFVJy8NlqLEQYtu7EBPzRL3DLwONsNqP9Aqp4bLhU1K6LK4JM00IlkY
	 qKkyoJJq5fvOEBYpIkVKE9n+kv2P6S5hDNCj98v1pSE3ejGQBLObp+oeCxUnKXd9pR
	 OkK5I/7FGKltTPrfXe/U9RGxbwDjQNVkzrLcFIhq3i0eK3YvovSkN12aQwshQ/Qlwv
	 Zxopvg8StYgtaNYSUlRH6jl9jB35dwjRUbjMJOFapYsXFLP+LWCPjTMEPLkglXhqk2
	 0VwcDUDMl7Nxw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/8] mm/damon/core: commit hugepage_size type damon
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171133.102366-3-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
 <20260913171133.102366-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:24:21 +0000
Message-Id: <20260913172422.3F7811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing initialization and validation of `range_min` and `range_ma=
x` for newly appended `hugepage_size` filters leads to uninitialized memory=
 usage.
--

commit 2b0a5f30b2fda9db59b511fc77d64fcbd35378ca
Author: SJ Park <sj@kernel.org>

mm/damon/core: commit hugepage_size type damon filter

Extend data attribute probe filters commit logic for the new
hugepage_size filter type.  Since it needs to carry the size range of
the hugepage, update the logic to update the size range fields of the
commit destination filter struct.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0c98f7e267d07..a3febdc355c1e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

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

[ ... ]

>  	damon_for_each_filter_safe(src_filter, next, src) {
>  		if (j++ < i)
>  			continue;
> =20
>  		new_filter =3D damon_new_filter(src_filter->type,
>  				src_filter->matching, src_filter->allow);
>  		if (!new_filter)
>  			return -ENOMEM;
>  		switch (src_filter->type) {
>  		case DAMON_FILTER_TYPE_MEMCG:
>  			new_filter->memcg_id =3D src_filter->memcg_id;
>  			break;
>  		default:
>  			break;
>  		}
>  		damon_add_filter(dst, new_filter);

[Severity: High]
Does this code leave range_min and range_max uninitialized for newly
appended hugepage_size filters?

If a user writes a new hugepage_size filter to a running probe via sysfs,
it triggers the filter appending path here:
damon_commit_ctx() -> damon_commit_probes() -> damon_commit_filters()

When the new filter is appended, damon_new_filter() allocates memory with
kmalloc(), which does not zero-initialize the memory. The switch statement
then omits copying range_min and range_max for
DAMON_FILTER_TYPE_HUGEPAGE_SIZE, leaving them as uninitialized heap garbage.

This makes the hugepage_size filter unpredictable and could cause incorrect
memory pages to be filtered in or out. It also completely bypasses the
validation logic added for existing filters in damon_commit_filter().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171133.1023=
66-1-sj@kernel.org?part=3D2

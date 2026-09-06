Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA191F78E6
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788729379; cv=none; b=WqwbLN/pkFZNrmGUh56k9/2HLLe9Wik04SOm3zHEREBaq7oGntdoFaS8rmNotFacbUN0HPeyjFueIFZ7w/9C2qYTRLEuvFGawsyFqTVrvaA3LnQmEvluLL0tDXONXiT+UqotYf5JuAx/4KXqU0MU0EtOci2C4DkggsCgSD8uciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788729379; c=relaxed/simple;
	bh=ccOq6tClu26yJ3ZRbE8lRsuvvp2Ps/Wk+92Msgh+3Bg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kUCDR57CPBiCQWS82DrwT1AlnDwTaKq9TtzsrkSWAAoc9ZifhuIY1mCTW/12b5mgBRnhLl5dI72UFYLeyWVNslQp6fVI3tozERO2EkZlL27bHcAr4pGKFKTWeCjvJ4l/4GiTirSWE2MkjmlIRAycZhkmPV+Dvik09gci9SZkPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz2ngZqp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz2ngZqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED221F00A3A;
	Sun,  6 Sep 2026 21:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788729377;
	bh=X8VOUYWBZmJEPXMCSddk1sZ7lplnTnHTDCTR63qtNkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mz2ngZqphbiUzSWJ/yzCB1ZyVINvWfly/hos87oeIgfU0Ma4nNccGQdhsvdXYIv96
	 qMWdOZ14u6v9OMctLRxU6w5bO6Htji2uJrRW5/J+U3gard3T+1hZOdY2rTalpcCBOG
	 1mVFAQUTkrrhHmICaT8EheQYHeYecKYKueY2LpWHfgjkav2EFws52L/il6iHlzcM0Z
	 6BJ7tBPbZUOy1+ofmq7WnWy0rMFJ1e95ftmvcVQbs9kqNOeqUVyGmmSdN7tH0p1ygK
	 LNE/bL7xFpyAa+Fg3/6AEX3oNgCzebCMxE3BQEA8eOY8hFTJ+vBdkclvmf66E/ExSw
	 510tDg9m8ApJQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/6] mm/damon/sysfs-schemes: setup range_{min,max}
 for probe_hits_wsum filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906210513.106895-5-sj@kernel.org>
References: <20260906210513.106895-1-sj@kernel.org>
 <20260906210513.106895-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 21:16:17 +0000
Message-Id: <20260906211617.9ED221F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect union member assignment for PROBE_HITS_WSUM filter type r=
isks silent corruption if struct layout changes.
--

commit 67e5bf0750883cfdf7b8857b78d72c17c2de406e
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: setup range_{min,max} for probe_hits_wsum filter

This commit extends the DAMON sysfs interface to support probe_hits_wsum
input. It updates the sysfs input based scheme build logic to set up the
min/max probe hits weighted sum range provided by the user.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 4d9147d2a269e..e297a20c0af03 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> @@ -2844,6 +2847,14 @@ static int damon_sysfs_add_scheme_filters(struct d=
amos *scheme,
>  			}
>  			filter->sz_range.min =3D sysfs_filter->range_min;
>  			filter->sz_range.max =3D sysfs_filter->range_max;
> +		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
> +			if (sysfs_filter->range_min >
> +					sysfs_filter->range_max) {
> +				damos_destroy_filter(filter);
> +				return -EINVAL;
> +			}
> +			filter->sz_range.min =3D sysfs_filter->range_min;
> +			filter->sz_range.max =3D sysfs_filter->range_max;

[Severity: Low]
Is this assigning to the wrong union member? Since the filter type is
DAMOS_FILTER_TYPE_PROBE_HITS_WSUM, should this be assigning directly to
filter->range_min and filter->range_max instead of filter->sz_range?

While struct damon_size_range and the anonymous { unsigned long range_min;
unsigned long range_max; } struct currently share the exact same memory lay=
out
in the struct damos_filter union, using sz_range here appears to be a
copy-paste error from the DAMOS_FILTER_TYPE_HUGEPAGE_SIZE block.

This seems to bypass the earlier refactoring that explicitly introduced
the anonymous struct to avoid reusing sz_range for non-size fields. If
struct damon_size_range is modified in the future, assigning via sz_range
while the core logic consumes range_min could lead to silent data corruption
when building a PROBE_HITS_WSUM scheme filter.

>  		}
> =20
>  		damos_add_filter(scheme, filter);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906210513.1068=
95-1-sj@kernel.org?part=3D4

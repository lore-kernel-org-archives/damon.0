Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5607353A70
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320625; cv=none; b=spxhg+eiSHPaonZdQRhloTqdABRGs1I3jMd//sk6C273vbsIzs/ys3V1rmu1bIQ5pT+1+eIXqOiQJ+SeNdJ3bFtnfrJrJ4gB+iqdaLVHgvf5vylOE4qWEk8ytdeVNF3kPhM6br/MnF4due2iqnfqIrkflovvbkG6XFDGqNtJ2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320625; c=relaxed/simple;
	bh=iSN74OHyebEwIxOcnS+YjnG8/gZV2g0i+cr8wwyCnkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NsZiBVsAdMEFszjKTZk3Ph7eVjGurIYeI+BTqaoSqgVintiiPWzcfxECLT1WU8hqG5fYAMKbmQJ6WwlwSxy11och0FuduRuz8GwEMUjoKZAoKOi+mmWbGRoQvZ0DbAgh+ynsfS+jpY7YT7T2LTLgi94fwDj9RYvJ2ZyoSXeM1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le1nIJXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le1nIJXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394EF1F000FF;
	Sun, 13 Sep 2026 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320623;
	bh=kDquz0lgbJgkrY5PREX3A5waihg6uLK3BkPphv/OIyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=le1nIJXDlJidT+TrKRaU7SQRxdvt5xCvmArse6gSy6TPak++CITvC+EBceHxEDbjx
	 iYizqXpVp9raiuvfWc/wcqywuSbTmKO92eIpkPZywXGieLMihgEL/nW4AJcckJ4cvN
	 rCtPKFEBWHtY3X5Kp6XxbAdtI0k7CpCq613/G+bL0cvSWbX5SD39kAi1DwjmWeo/Gv
	 p6XVGLTcSB/JoXNc+9wZdp+MV2dfwxhSxrqJ+jxuvkXdbmA5xhPls2N1gYsNy26kRV
	 b8KS8h0hU+3NwpBGVRqsQbAsA03Yfg4EVj1HeYlNMS96X6+9Qjb94BEfq1bM4PnAsp
	 T9pnhRSCYsEcA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/8] mm/damon/sysfs: support hugepage_size probe
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171133.102366-6-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
 <20260913171133.102366-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:30:22 +0000
Message-Id: <20260913173023.394EF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Missing bounds validation for hugepage_size filter in damon_sysf=
s_set_filters().

Pre-existing issues:
- [High] Newly created hugepage_size filters lack range bounds initializati=
on in damon_commit_filters(), causing the DAMON core to evaluate folios aga=
inst uninitialized kernel heap memory.
--

commit 42f3666a978b5b2934ebb23daaee8fd5163c7793
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/sysfs: support hugepage_size probe filter

This commit extends the DAMON sysfs interface to support the hugepage_size
probe filter. It allows users to set hugepage_size via sysfs min/max files
and passes these arguments to the DAMON core.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 8e8d89b8ed981..43519afb9eb7f 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c

[ ... ]

> @@ -2273,6 +2277,9 @@ static int damon_sysfs_set_filters(struct damon_pro=
be *probe,
>  				damon_destroy_filter(filter);
>  				return err;
>  			}
> +		} else if (filter->type =3D=3D DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
> +			filter->range_min =3D sys_filter->range_min;
> +			filter->range_max =3D sys_filter->range_max;

[Severity: Medium]
Are bounds checks needed here to ensure range_min is less than or equal to
range_max?

Because DAMON's initial startup via damon_start() bypasses the bounds check
in damon_commit_filter(), turning DAMON on with inverted bounds in sysfs
silently accepts the configuration. The filter then unconditionally fails to
match any folios, resulting in a silent functional failure instead of an
expected -EINVAL rejection.

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that newly created
hugepage_size filters lack range bounds initialization in
damon_commit_filters().

If a user configures a new hugepage_size filter via sysfs on an already
running DAMON context and writes 'commit' to the state file, the newly
added filter is allocated without initializing the range:

mm/damon/core.c:damon_commit_filters() {
...
		new_filter =3D damon_new_filter(src_filter->type,
				src_filter->matching, src_filter->allow);
		if (!new_filter)
			return -ENOMEM;
		switch (src_filter->type) {
		case DAMON_FILTER_TYPE_MEMCG:
			new_filter->memcg_id =3D src_filter->memcg_id;
			break;
		default:
			break;
		}
...
}

Because damon_new_filter() allocates memory without zeroing, and the switch
statement explicitly omits DAMON_FILTER_TYPE_HUGEPAGE_SIZE, range_min and
range_max are populated with uninitialized kernel heap memory. Could this
cause the DAMON core to evaluate folios against erratic heap garbage?

> +		}
>  		damon_add_filter(probe, filter);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171133.1023=
66-1-sj@kernel.org?part=3D5

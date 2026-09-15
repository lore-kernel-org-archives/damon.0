Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B02F1FEC
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439072; cv=none; b=fjp4V9k77OqOImKnigbobiCxrzUK87iqWP0KcHKiJSX8ea504RClaOVV5G93TEd36JFTqjZv5tsG5etJfK5El1wvISUN7fOBS+sjlPkHt50CthmixSVm3YF5VyApGxZ0x5rHd+kdzKzpcHUaQv3viorXvF6V7Fyqpv3GccZUVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439072; c=relaxed/simple;
	bh=I6MhdLjcTc8D7dPtG+3PPiPitdW76sN7h10C79mChfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TNEV/mKuFwdgqAaPhcBbFKyjpbfmbxcxHBzcTgiMB9W65zJJQr09npbRZDW11vZ2x5XzL+07J4YJVHz6UZPROfxf0opHWVmjz6EFbwPw1rE0GdqVGDVaa0pqgEmJhJQl3FAkEE3VUCmhEDjfPGp9CLZq0KrE6W4Er1G0Eh+Vgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsTUbZJu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsTUbZJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961FA1F000FF;
	Tue, 15 Sep 2026 02:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789439070;
	bh=0teF7d4Z4mIZ+YRyJajHPD+ASkPCO1FZyj7WDhYOyLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EsTUbZJuvE8sA4cQAny2itQ/qT0upvuqc/r5PLp/W1sEGde6TTjjnKvVB4XxMHy6n
	 ALH8e9KrrlhF9Bhc3kyKeWXZe4H+iDYhxmze/vEVkXGeJEpS7p/WhZcz5ko3Hu86WM
	 oRLniB1wN+LHLE+/jhne34wOcq4p4IGAKW6QFwftzabAXRqaLtex/O4pZnhLLlXGsd
	 M1OSTUAfD+LhD54RpB1QfCSB8f7xdPGz26sKGE5lwybiDoY1HnmnoXVbuMEzSS3Uyb
	 Z7WJUdnDO94u9hwRGlPwD+eZBJNhd87ysbr1Khc7m9QBElSSlKTXbyNQVHujiBHV50
	 HJcCknx9ARryQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 5/8] mm/damon/sysfs: support hugepage_size probe
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915020929.102953-6-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
 <20260915020929.102953-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 02:24:30 +0000
Message-Id: <20260915022430.961FA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: partial commit failure in damon_commit_filter() causes DAMON c=
ontext state corruption
--

commit bba894847aad85f23c968a2f306ec06c6e1b1a8c
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: support hugepage_size probe filter
   =20
Extend DAMON sysfs interface to support hugepage_size probe filter.
Allows hugepage_size user string input to the filter type file.  Pass
the size range argument that users set via min/max files under the probe
filter directory to the DAMON core.

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
>  		}

[Severity: High]
Can an invalid hugepage_size range (where range_min > range_max) cause state
corruption in the DAMON context?

When a user configures a hugepage_size filter with range_min > range_max,
the values are copied blindly here into the intermediate context without
validation.

During the subsequent commit, damon_commit_filter() in mm/damon/core.c
updates the destination filter:

mm/damon/core.c:damon_commit_filter() {
	dst->type =3D src->type;
	dst->matching =3D src->matching;
	dst->allow =3D src->allow;
	switch (dst->type) {
	case DAMON_FILTER_TYPE_MEMCG:
		dst->memcg_id =3D src->memcg_id;
		break;
	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
		if (src->range_max < src->range_min)
			return -EINVAL;
...
}

Because the validation fails and returns -EINVAL after dst->type,
dst->matching, and dst->allow have already been updated, the commit aborts
midway. This leaves the active DAMON context's filter partially mutated,
interpreting its previous union field (like memcg_id) as the new range
bounds.

Could validation be added to damon_sysfs_set_filters() in mm/damon/sysfs.c
to prevent invalid bounds from reaching the core commit logic?

>  		damon_add_filter(probe, filter);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915020929.1029=
53-1-sj@kernel.org?part=3D5

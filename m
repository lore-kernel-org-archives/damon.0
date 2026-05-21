Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45F37C0E6
	for <damon@lists.linux.dev>; Thu, 21 May 2026 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779337204; cv=none; b=h5C48nCmeBqbLoc9aXKxUp5qeoJTRxfePLQMKotI2iRCryxq56mgh4PRGUQqj/xwWr6Yjc6BuzAJZvWNZYNJAkV8TbOBejTyUnn+LT+wI04PpzjLQ5itCGjsbM6VuIk7zntZWzi7LP30gJ5zEqgoaWjdp0x6T2eYqy89rCuOUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779337204; c=relaxed/simple;
	bh=oD0kH2MpCBTaVX2Jsu9CmJygqGDwGfHtL0Bwp4ag8eo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KKeQDd/hvyeM1gW7eINNqrdTuLMSUbMcr/R813qyAmKIT3XDb3uOManzgw0GIGh6b5qIfXO/vO0DZDeIkPGZUVpYJnNSQhKoLjz9cWOEL80F0IMGHg2fQqcdcy5fJbx3GSUG/WxJ9WsbQk/klN/YG/T07pk3GEEd0fECl2LKam0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXcwzgwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXcwzgwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5AF1F000E9;
	Thu, 21 May 2026 04:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779337189;
	bh=MvR74wjVZVOnnQgvhgbGjHlrVqUllYiHTB0Jhs1JgUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VXcwzgwenz8W2+KOp2RJ1hZ3mgIiYwdil5I24egpOSexXUEa6m+wAft1+PjRIgmoZ
	 KKGPgutXtmyFVGAPK2zj+qtbZb7gZ4ESj89dpTd/an+OmcRHw9iAQk4gu35XyJ+cBs
	 xEtPG9zEA4sExFgkKqtEvJWJIiypjgkhkkoQU0BNAG0IbGGQlg2Ba4rJ5RSEPqrbVf
	 s90Ym9/TWdX3/IqAvDg5ebyKMVPXo869/GGT3/zn7naXBMomoC7adQ61M1BrDJFkhM
	 GPaudxrK8vGpDNVI8kGqZLddJZpLWQ2a1Aloyu8OAlOpEwqF6JH2hWOyXnnDKtwm9U
	 Cu9BamxQSYVbQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 02/14] mm/damon/core: do not use region out of
 a loop in damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260521035349.87565-3-sj@kernel.org>
References: <20260521035349.87565-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 04:19:49 +0000
Message-Id: <20260521041949.9E5AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in ALIGN() can result in region with ar.end =3D 0
--

commit d65dcd33c6063ed27bd90da3803c482628ebbc88
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: do not use region out of a loop in damon_set_regions()

This commit cleans up damon_set_regions() to explicitly track if a region
should be inserted before another, avoiding reliance on undocumented
iterator behavior. No behavioral changes are intended.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d0bdf6e01dff8..669fd13776ea2 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -394,7 +397,11 @@ int damon_set_regions(struct damon_target *t, struct=
 damon_addr_range *ranges,
>  					ALIGN(range->end, min_region_sz));

[Severity: High]
This is a pre-existing issue, but can this ALIGN() macro overflow if
userspace provides ULONG_MAX as the region end via the sysfs interface?

If range->end is ULONG_MAX and min_region_sz is 4096, the ALIGN() macro
would evaluate to 0, resulting in a region where ar.end is 0.

When damon_sz_region() subsequently calculates the size using
r->ar.end - r->ar.start, the unsigned arithmetic would underflow to a
massive size.

This could cause the while (damon_sz_region(r) > max_region_sz) loop in
damon_apply_min_nr_regions() to iterate nearly endlessly, allocating new
regions until memory is exhausted.

>  			if (!newr)
>  				return -ENOMEM;
> -			damon_insert_region(newr, damon_prev_region(r), r, t);
> +			if (insert_before_r)
> +				damon_insert_region(newr, damon_prev_region(r),
> +						r, t);
> +			else
> +				damon_add_region(newr, t);
>  		} else {
>  			/* resize intersecting regions to fit in this range */
>  			first->ar.start =3D ALIGN_DOWN(range->start,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521035349.8756=
5-1-sj@kernel.org?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0869F3515DE
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929776; cv=none; b=PpTF1lWZ9laxpHC8+RnG/bXcr8lfrU1xjDmHar6dhWsbUrAXRzWRFsbOLe0zIwr9BCdEnoW2SigB6XtNsEUu6+/Oiz0MNHwbZ1jLp+sSRKvulLR9+60sCEkrtOXuuFn0QBpAz28dxoznOeoBOsyyUq2Nl5f3vo5xjtO2I1Shr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929776; c=relaxed/simple;
	bh=kMaAlm0+KfDU9XlLWlC7EGoYq6i1Qh9CR4jMGFHUa8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BxF2NsENDboJY835Vc0rMn7QGjwheSbYd7xslTYHrX8db8oWD/VprL8RCakoOvvY+rehuhwhLMivFgGgoi7Mpa8mKVW3tiCfGecEqWaeD666T22zVvUMwz0d11lUMahYR0qAFi7AJc5GY2Aqv53N7aCd0bNPdLk7PG51FXZg+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnmCfgbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnmCfgbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108F81F00A3A;
	Wed,  9 Sep 2026 04:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788929774;
	bh=vulqDJOWxwyvTbuPlGSIHMhWK6eteu4QnBIZIXgOgwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UnmCfgbqJ+MQk8ASuDPRHZkCQSByWBGcIZQu85STsThrB9jn5xzcJAxw/UqnZ9xsN
	 nvMOkp9T3qdy42VKMn0biIpn5OX/K8bB73x3qZAif1AmGgf7Vtauk/k/1vgdLBPm0S
	 wijYZqj8Pz+skVg03ttLULUefybKA0rBznNOXfFnuxnSazem3jx/GGvZXL6c4yMzwm
	 l2hw/eUwkbgJos6rYx+8LojPedbZ/LWwXOCIUvafDPOjZtjCo/xN38yLuTwGyupFAx
	 B/5gftuJUl+pqhFPKnSgSEmjdSrM7tmZmHRmFi1fU4cDoUNATpfWOPMDHTTZRMmALO
	 R0bM1cHCFFy1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/core: skip aging from repeated
 aggressive merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909044433.218263-1-sj@kernel.org>
References: <2026090841-catfight-alkalize-108d@gregkh>
 <20260909044433.218263-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:56:13 +0000
Message-Id: <20260909045614.108F81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `kdamond_merge_regions` loop can run infinitely if `max_thres`=
 is extremely large and `sz_limit` restricts further merges, leading to a p=
ermanent kernel thread soft lockup due to a 32-bit `unsigned int` overflow.
- [High] Arithmetic integer overflow during weighted average calculations i=
n `damon_merge_two_regions` on 32-bit systems causes severe corruption of `=
nr_accesses` and `age` metrics.
--

commit 1486ebcac154b450386db76101ad72341a5b5805
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core: skip aging from repeated aggressive merging

This commit modifies kdamond_merge_regions() to skip updating region
ages during repeated aggressive merges. This prevents temporal degradation
of monitoring quality when the maximum number of regions limit is
temporarily exceeded.

Link: https://lore.kernel.org/20260712165432.87609-1-sj@kernel.org
Link: https://lore.kernel.org/20260621203548.10718-1-sj@kernel.org [1]
Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org [2]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index dd4eafe8b9611..859a6a636ab0e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -940,15 +940,17 @@ static void damon_merge_two_regions(struct damon_ta=
rget *t,

[Severity: High]
This isn't a bug introduced by this patch, but could this cause silent
corruption of the region access counts and ages on 32-bit systems?

In damon_merge_two_regions(), the weighted average calculations are:

    l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
                    (sz_l + sz_r);
    l->age =3D (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);

If a region size is very large (e.g., 100 megabytes) and nr_accesses is 45 =
or
greater, the product of l->nr_accesses * sz_l and l->age * sz_l will exceed
4.29 billion. This overflows the 32-bit maximum before the division occurs,
truncating the weighted sum and storing incorrect values in the merged regi=
on.

>   * sz_limit	size upper limit of each region
>   */
>  static void damon_merge_regions_of(struct damon_target *t, unsigned int =
thres,
> -				   unsigned long sz_limit)
> +		unsigned long sz_limit, bool count_age)
>  {

[ ... ]

> @@ -982,15 +984,18 @@ static void kdamond_merge_regions(struct damon_ctx =
*c, unsigned int threshold,
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

[Severity: High]
This is a pre-existing issue, but can this loop run infinitely if
max_thres is extremely large and merges are blocked?

If a privileged user sets a very large aggr_interval relative to
sample_interval such that max_thres exceeds 2^30 (1,073,741,824), and
merges are blocked by size limits, threshold will continually double.

Because threshold is a 32-bit unsigned int, once it reaches 2^31,
threshold * 2 will overflow to 0, which max(1, 0) will reset to 1.
Then threshold / 2 becomes 0.

This causes the exit condition threshold / 2 < max_thres to remain
perpetually true while nr_regions never drops, resulting in a permanent
kernel thread soft lockup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909044433.2182=
63-1-sj@kernel.org?part=3D1

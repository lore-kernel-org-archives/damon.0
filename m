Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA73AAF54
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062289; cv=none; b=O+ll/B4IK7z91DvH8SIftKkqSQn6gL2DI9ExL/SMZmjJp1TdwiQBoQtwXsmcjaSIr+5AlrPFW9MHEAHE+mwI34hL/h2REQajg9mLClb13xLSbWlzwWSSylo/gDsheebvMvRL6fDYMukuve0ORwO1IKkHcC524Md6LEjeVxZoUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062289; c=relaxed/simple;
	bh=Op5LTalbpcBZTIZc1r2s6ux6HMHwoNx1l2odlru0oig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sNJLD1taAtPN9iN7Da7zlZfVv6gNdOf6eeyppvadj42NV6reqDrakFpwiWCIf9EhKT+O0ll+z4HUTcyMri0SOMnuF6o3yfZgaytS1wyhkVv3JwRa0uDV4uwlMzKBFsYISuFWTHxjxc3Xhj3z7G5mQViugTDAQ56FLMzMqJi/tAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8ChcGXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8ChcGXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81871F0089B;
	Sat,  3 Oct 2026 21:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791062288;
	bh=9wX9VachPR1X2U797nXOTbfsxrYVL3SC7ijLas2bFw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k8ChcGXiHV543EHGZ7/8d89X7aYtqFgYfzDQI13z8ZA66V4NbYBNE+4izjb3FLeR9
	 1zA3JXCIR2R70Vj+al8stzYbT0jxoKNdNTwP3rTmasqTylm3IyIQW9z+vsln4kOVPi
	 mFimT/69dMTlPUXIANkYNXH+ivc/5OdrlrA03Knp4iNf4lETIMQ6CJroiwn8g+7OxO
	 4Q0AXhBtLqEPI8gFHNWFtZ/zrRcmYRLb+db1R2g6pJKJuzS32qDRkW3/v6qZgiVl6A
	 bG0OLZBe/IkGmghkuvBWBhHPVV8t3f/y/NijzQgpRo8/Qoy/3f8F7U9Pi5R7+/Nr7w
	 sVyx6swplW+nw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 8/9] mm/damon/core: cap the region merge
 threshold per target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-8-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
 <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-8-0f00417b41bc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 21:18:07 +0000
Message-Id: <20261003211807.D81871F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/damon: region bound violation when probe weights exceed max_thr=
es
--

commit 0342e0b2c0ad1539186d08fbb17c049c0f491a79
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon/core: cap the region merge threshold per target

kdamond_merge_regions() applies one context-wide threshold, the highest
merge score across all targets divided by 10, to every target.  This commit
caps the threshold for each target by a tenth of its own maximum merge score
on the regular merge pass.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 1d25f820e3f93..c2c74d0daf957 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -4175,12 +4175,36 @@ static noinline_for_stack void kdamond_merge_regi=
ons(struct damon_ctx *c,
>  	unsigned int nr_regions;
>  	unsigned int max_thres;
>  	bool count_age =3D true;
> +	bool use_probe_hits =3D damon_has_probe_weights(c);
> =20
>  	max_thres =3D damon_nr_samples_per_aggr(&c->attrs);
>  	while (true) {
>  		nr_regions =3D 0;
>  		damon_for_each_target(t, c) {
> -			damon_merge_regions_of(t, threshold, sz_limit, c,
> +			struct damon_region *r;
> +			unsigned int t_max =3D 0, t_thres =3D threshold;
> +
> +			/*
> +			 * On the regular pass, cap the threshold by this
> +			 * target's own maximum merge score.

[ ... ]

> +			 */
> +			if (count_age) {
> +				damon_for_each_region(r, t)
> +					t_max =3D max(t_max, damon_merge_score(r,
> +							false, c, use_probe_hits));
> +				t_thres =3D min(threshold, t_max / 10);

[Severity: High]
Does this cap the merge threshold for the cold target to near-zero, ensurin=
g it
is highly fragmented on the first pass?

> +			}
> +			damon_merge_regions_of(t, t_thres, sz_limit, c,
>  					count_age);
>  			nr_regions +=3D damon_nr_regions(t);
>  		}
>  		count_age =3D false;
>  		if (nr_regions <=3D c->attrs.max_nr_regions ||
>  				max_thres <=3D threshold)
>  			break;

[Severity: High]
When DAMON is configured with event probes using high weights, does this br=
eak
the loop immediately if the weighted initial threshold exceeds the unweight=
ed
max_thres?

If so, does this prevent the uncapped fallback passes from ever running to
satisfy the region count bound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-damon-perf=
-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com?part=3D8

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2092D0C82
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929821; cv=none; b=QiW7UFtqbErL7Q9oNmnBXue+8g4fUUlilUoirEm7Pn4yrMbaG7Aw89GZS0oGoiY66BClGiR7brM7dgPXZJg1J+Cp2upmcBaKVnJKSJMjRcs7/IMMjR8CO8i0+oOcRLSxOcYxOd3S6AfjbMmMQKTjxUXmh3F1oW+5XfSPWo+l4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929821; c=relaxed/simple;
	bh=HZsRhHT6TuQ5ly4Rhp+x7df7ZCr7NQAHmcObhi/weHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QWAX5Y16e7nvhYtsB0C5CdIsp471gsv0HjQDKtP9qF8w0Y6bjFes0E4vOn25C6qOvnisPntMpyEfqJBByC/6+D5ycCkrQ2ffIBdYeJatHjEAVO1FrMC3QJpwqAejMGDiYM5UdLqrxygMoiXzYy9YDlFyRQVPX65K3u7gskJw/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTgeXtX5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTgeXtX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B591F00A3A;
	Wed,  9 Sep 2026 04:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788929820;
	bh=SZxRJl1PcsxOD02fW1yI2pDuG2rwWOasKZST+NdRwz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RTgeXtX5O8bx7pQdutKtbhUgCpe7jy5xQ3GB0YCpDjPAihFHMo8THIS0HLIjbtspv
	 wlDoNGFtzVOsESJ+1SYDurj+WEEpEeeulUx+gNGWsl3knVisdXaHXO1cO6qzZu/3zO
	 0L2XFqG+3aYL+qCmW17sUh+I/742xLeP4LBcKmWhHViWYh/5GUTAm9fYNrcdvx4JAC
	 FuPGBqmbkvmDMLGxIGF30lnshhNwT8cidNe308YDQh4WxJyRme6XFwck7lgvmkiHY2
	 zWxq7onWL/+nCfjbmbNHUUh9c18pSiz1VwpFTl78aRUOTh6SokXS/2dhCM/aS8mobn
	 04U65mS3xZ0ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/core: skip aging from repeated
 aggressive merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909044707.221421-1-sj@kernel.org>
References: <2026090841-dingo-oxygen-6b88@gregkh>
 <20260909044707.221421-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:57:00 +0000
Message-Id: <20260909045700.72B591F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Infinite loop in `kdamond_merge_regions` when `max_thres` > 2^30 d=
ue to `unsigned int` overflow.
--

commit 2beb7e632c69db2ccfb8ea5cced50b76ca2b931f
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip aging from repeated aggressive merging

This commit modifies the DAMON core to skip aging when repeatedly merging
regions aggressively. It prevents corrupting monitoring results when the us=
er
temporarily lowers the maximum number of regions limit.

Link: https://lore.kernel.org/20260712165432.87609-1-sj@kernel.org
Link: https://lore.kernel.org/20260621203548.10718-1-sj@kernel.org [1]
Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org [2]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 734ab958ec576..0713fda22682c 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1234,15 +1236,18 @@ static void kdamond_merge_regions(struct damon_ct=
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

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to an
infinite loop if max_thres is sufficiently large?

If a user configures DAMON parameters such that the aggregation interval
divided by the sample interval results in a max_thres greater than 2^30,
threshold (an unsigned int) will strictly double each iteration. Once
threshold reaches 2^31, threshold * 2 wraps around to 0, which max() sets
to 1.

At that point, threshold / 2 becomes 0, and the loop condition
threshold / 2 < max_thres will permanently evaluate to true, causing an
unrecoverable hang of the kdamond kernel thread if the region limit is
not met.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909044707.2214=
21-1-sj@kernel.org?part=3D1

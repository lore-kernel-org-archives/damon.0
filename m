Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067482D592D
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928408; cv=none; b=Xqj7vEKzIOszL/1uhmRRfXMycpb1gJa8BEXNa4XgIDmDzjhPMexYKFLpQ5skZG6/m6Uxamen8qPI5tWbrKzdkwNiHfX0lrBErgXGmtJKRyUyCegTojHPtNajAUMFpMCtbAuDRPz2g+hMt/gydjNg6l9T31VrdlCS8BPgrhfQLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928408; c=relaxed/simple;
	bh=GCaNf15AR25YtvoxQVQSu1lW7eQtSDqFo4KNmIhOX3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VCqYO4kpaleiZ5Qnyj0YJ0nLnxv8eahFLS8IIuR8DV+fpTs/QZF9D3l2VKpGIwDCNCTA/b3xIPApgn7dhtYqvuGQ4aTFk+SyN5DanVS9guHjJnQByix1ARHE8zN1qg1Xf4a8CV3st6ovZJkXWIvyZxszT5HWkjT8KNceDI2NlZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXxAO2mJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXxAO2mJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D5E1F00A3A;
	Wed,  9 Sep 2026 04:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788928406;
	bh=uOkWMlLvHLGUZyGWS6AM8Qhbll189i32N/l7BgAUKBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oXxAO2mJWJNkPWVt10n7a6ig39mRkoWV1qBOf63ul881a9BVjL2H31VT2aqDqGyPA
	 Rkb0myEvjg+X1GQGyBCqR6yY6Px+PFfIXutadKU07Ll9mUlR8rUGqd1uASpLrMo2XK
	 fk8yzKYKV61A3Sn35jLMwxp7buAPLeqfAYYRRy65sN8DIws9lnZEMB0cOIRQg7ZHWu
	 w8I/BSzZOazVWHMxXKy8sk8HRbMRvTx1efbpm1zi8gv7bROZDqk/nbdJurcMbVygNk
	 R3HzI58StLi/xO8E8JNZQf+c4Q64M8B/DAPPfjsLfr65XkA8hATvkJHJRT/IB0tWQp
	 AipQSROiLqEZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] mm/damon/core: avoid infinite
 kdamond_merge_regions() internal loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909042418.198028-1-sj@kernel.org>
References: <2026090834-entourage-unwound-48d4@gregkh>
 <20260909042418.198028-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:33:26 +0000
Message-Id: <20260909043326.A7D5E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calculation of merged region access frequency can overflow unsigne=
d long on 32-bit architectures, leading to corrupted access statistics.
--

commit 49c8c958aefed16883d3ce4d2099a0422bae39ec
Author: SJ Park <sj@kernel.org>

mm/damon/core: avoid infinite kdamond_merge_regions() internal loop

This commit fixes a potential infinite loop in kdamond_merge_regions()
by checking the loop break condition before doubling the threshold. It
also prevents the threshold from exceeding the theoretical maximum.

Link: https://lore.kernel.org/20260715031002.108504-1-sj@kernel.org
Link: https://lore.kernel.org/20260715031002.108504-2-sj@kernel.org
Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4f031412f65cc..3a50ced2efc0f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -523,15 +523,20 @@ static void kdamond_merge_regions(struct damon_ctx =
*c, unsigned int threshold,
> =20
>  	max_thres =3D c->aggr_interval /
>  		(c->sample_interval ?  c->sample_interval : 1);
> -	do {
> +	while (true) {
>  		nr_regions =3D 0;
>  		damon_for_each_target(t, c) {
>  			damon_merge_regions_of(t, threshold, sz_limit);

[Severity: High]
This is a pre-existing issue, but does the access frequency calculation in
damon_merge_two_regions() (called via damon_merge_regions_of()) overflow on
32-bit architectures?

In mm/damon/core.c:damon_merge_two_regions(), the new access count is
calculated as:

    l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
                     (sz_l + sz_r);

Since sz_limit allows regions to grow up to 1/10th of the target's address
space, large regions can cause this to silently overflow a 32-bit unsigned
long. For example, merging a 250 MB region with a typical access frequency
of 20 results in 20 * 262,144,000 =3D 5,242,880,000, which exceeds the 32-b=
it
maximum of 4,294,967,295.

Can this lead to severely undercounted access statistics, potentially causi=
ng
DAMON_RECLAIM to aggressively swap out falsely "cold" regions and induce
system thrashing?

>  			nr_regions +=3D damon_nr_regions(t);
>  		}
> -		threshold =3D max(1, threshold * 2);
> -	} while (nr_regions > c->max_nr_regions &&
> -			threshold / 2 < max_thres);
> +		if (nr_regions <=3D c->max_nr_regions ||
> +				max_thres <=3D threshold)
> +			break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909042418.1980=
28-1-sj@kernel.org?part=3D1

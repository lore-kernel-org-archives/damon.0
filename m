Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD7261B8A
	for <damon@lists.linux.dev>; Sun, 12 Jul 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783876223; cv=none; b=HFHjEsdJwP8t2p2QyCnYkZkIHESk3e9VnNidY9AEvDns0oyplQbVWHCzJjBhqW77ZsthXF1F2tR2HNo4acPx2pdtzg9zS6vK2zmKK2C0JDE8o8EMFz89JV9CMeWfAHSqK52JA4QPpCUVNrVYUOuLLL6VvuM8l8oR+oSgXfh4Dq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783876223; c=relaxed/simple;
	bh=RKOK7l4U4+Ncz+SlyNmIcyDuWpBKOYktNP6f+aPWM0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W3f5kNP2yEFnxPjEYXR5DXG95xPFAyF0f0jpP5iF+/4whfFIcQY3/M/DYU7Au3xISeQwkn8ui/1jRQs1MR4DQ60PXwcRobEoWMD/heR3/WE3LsqzcGjgOKBNsA8gBJ1ORB8zkkkYukQvr6NsJgBsfXBt5P+o28qLDw/V0dGMH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPM39bRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPM39bRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10321F000E9;
	Sun, 12 Jul 2026 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783876222;
	bh=T4dTtpefsuWa4DH2SXmtNDInvdph1qAlhgfJt1DWLyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kPM39bRu5WTYPYuudw2FRmbu47LwX5rLRNJ+U9CoJrAo4/Rtms8FBgwmc+45tF4nG
	 NLBGWPE7L3QplYbqUbKC+CDfo3itq9xKw+ImpD/oAj1NxVIfUkKbIQSmqXS2bZfTYC
	 5chSycJ0VBfvRu6b6Mu6xRd193ZXRlPIoyyjX2dzVk6t+jsOMGnVKRVyCt5rStmlFy
	 7tAni5Oe8zC9lOMOyI5bTyxmhIPhJVsOIZz0CJnqeH72T+94GMBi8/DsonOSQlemWi
	 wjzZP6Qkr0rc6Qx5XhxpjIp8aRk5Fj8zWG53aXukznU6nAgpcK9aK0JB+j8n1yv2Ui
	 d9kKEU/Z3LnwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: skip aging from repeated aggressive
 merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260712165432.87609-1-sj@kernel.org>
References: <20260712165432.87609-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 17:10:20 +0000
Message-Id: <20260712171021.D10321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `kdamond_merge_regions()` can fall into an infinite loop due to in=
teger overflow of `threshold`.
--

--- Patch [1]: [PATCH] mm/damon/core: skip aging from repeated aggressive m=
erging ---
commit 1fa7392cc3fc19083e90cfb01dcfa4f03ebbc373
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip aging from repeated aggressive merging

This commit modifies the DAMON core to skip aging when repeating region
merges during corner cases where the number of regions exceeds the
user-defined maximum limit. This prevents temporary degradation of
monitoring quality caused by updating region ages multiple times during
repeated merge operations.

Link: https://lore.kernel.org/20260621203548.10718-1-sj@kernel.org
Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3366,15 +3368,18 @@ static void kdamond_merge_regions(struct damon_ct=
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
> -			damon_merge_regions_of(t, threshold, sz_limit, c);
> +			damon_merge_regions_of(t, threshold, sz_limit, c,
> +					count_age);
>  			nr_regions +=3D damon_nr_regions(t);
>  		}
> +		count_age =3D false;
>  		threshold =3D max(1, threshold * 2);
>  	} while (nr_regions > c->attrs.max_nr_regions &&
>  			threshold / 2 < max_thres);

[Severity: High]
This is a pre-existing issue, but can kdamond_merge_regions() fall into an
infinite loop under certain configurations?

If a user configures aggr_interval and sample_interval such that their
quotient (max_thres) exceeds 0x40000000, threshold could overflow in the
max() assignment above.=20

Since threshold is an unsigned int, doubling it once it reaches 0x80000000
causes an overflow to 0, which max(1, 0) clamps back to 1.

If regions cannot be merged further due to the sz_limit constraint,
nr_regions > c->attrs.max_nr_regions remains true indefinitely.

Because threshold cycles and never exceeds 0xFFFFFFFF, threshold / 2 never
reaches max_thres, causing this loop condition to evaluate to true endlessl=
y.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712165432.8760=
9-1-sj@kernel.org?part=3D1

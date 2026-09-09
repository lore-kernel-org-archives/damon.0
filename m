Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C434041B
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929467; cv=none; b=K65181NaJJtYqY7nijwNxMbvej/OStD6RxPv7nnRAt0y21pbx/ekhbs9bGqH6jgFZLE4kzipghKwT53P3TE3RoyKVY+NLBNQRz8JhewCkTL68YfI5qRGkIuBZwMJJzUJ6dK7X12oJ8ko5L9vf3oPsBu8+mkXQvsr2NWXNqX4UWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929467; c=relaxed/simple;
	bh=R07NI2fjx7vkE0oNO3dsXURWJ6uM1xLrmmWCXaMgQ9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p6fiBVGUDAdq3pEsV5rn7NpIO7vl3DlQ4F/TJuQGeF25xO4EOXjc1Psr8h/mCe0yj/2wscpMLEQ28vmOIGOkOrrAe17PdOeefKZfUTlFLD0nXa3cirxVZ6s8R3G/zZW1A2PrukH4/mnDzaUQS2YcC2pw2hMlilUguAR1JgPbQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLs1GTq7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLs1GTq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F0E1F00A3A;
	Wed,  9 Sep 2026 04:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788929466;
	bh=T9K2ObqJaap9OnhD9XtGwpOWbutkcmTDr52asjzVVN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FLs1GTq7eD+2i08HeUxP3nDD4mOweM9FdrlC9uQoBboEvEXHVKZwsJqLsu7kZrtTk
	 Qs/IEXzlnyI3jPUS4TfDCj4KvZkw//HkNbPSxW0+r/vZxYEnGC8ZO3FkKMPrVOTAuX
	 G2zGYq1S7196wfN0j9NTCkbhn+m19gBvjkEef/JjzkAEw6NipV1JYmnW3hbVgt1w0+
	 8z3u9I/yZtbc2jvdUeycvXiDrR5kglPkIaQzvVfp1ZifoJwxawD3eUBQk1kaUDv0PY
	 6H6Apbuq7C1cydFm5zq8kP4CZYZ7sAjIAf1JjzlKDtgFId2dRc/WnXDnyEQb7KDSns
	 3Y7R79vNBlM+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/core: skip aging from repeated
 aggressive merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909044055.213060-1-sj@kernel.org>
References: <2026090840-shifter-galvanize-450f@gregkh>
 <20260909044055.213060-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:51:05 +0000
Message-Id: <20260909045106.06F0E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Infinite loop in kdamond_merge_regions due to threshold integer ov=
erflow
--

commit af1455c64e5ba1df658a88dc7d8a3cbfe32c0c5b
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip aging from repeated aggressive merging

The number of DAMON regions could temporarily exceed the user-defined
maximum number of regions limit. This patch modifies kdamond_merge_regions()
to skip aging when the merge operation is repeated to meet the max regions
limit, preventing corruption of the monitoring results.

Link: https://lore.kernel.org/20260712165432.87609-1-sj@kernel.org
Link: https://lore.kernel.org/20260621203548.10718-1-sj@kernel.org [1]
Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org [2]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 70ac1f08753d1..c98539efd2a56 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2408,15 +2410,18 @@ static void kdamond_merge_regions(struct damon_ct=
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
This is a pre-existing issue, but can this loop run infinitely due to an
integer overflow?

If a user updates DAMON parameters while it is running, setting a large
aggr_interval and a small sample_interval (for example, aggr_us=3D0x8000000=
0,
sample_us=3D1), max_thres will be greater than or equal to 0x80000000.

Concurrently, if max_nr_regions is dramatically lowered,
kdamond_merge_regions() could be called with a stale, small sz_limit. This
small sz_limit would prevent regions from merging enough to meet the new
max_nr_regions.

Inside the loop, threshold (a 32-bit unsigned int) doubles on each
iteration. If nr_regions > c->attrs.max_nr_regions remains true, threshold
will eventually overflow (for example, 0x80000000 * 2 =3D 0) and reset back
to 1 via max(1, threshold * 2).

Because threshold / 2 never exceeds 0x7FFFFFFF, the condition
threshold / 2 < max_thres will always evaluate to true when
max_thres >=3D 0x80000000, permanently hanging the kdamond thread.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909044055.2130=
60-1-sj@kernel.org?part=3D1

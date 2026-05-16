Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86EB33CEA9
	for <damon@lists.linux.dev>; Sat, 16 May 2026 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778957676; cv=none; b=QWJ7rIpWWB1e8tpaFlhgHlmULHVDjICFJEjo8MJORGO4TuQRV/Wp3jZa2+K2CMdTCPxrOS60GuMSZGWZtlC0PfY9OcuvcE533ZErip4SwtDaikKzcO5qQPY8kgH5dqVGuiSS9clL/w2pxXt8TsDlJ0fJX8HYiKWG0cUevFqaep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778957676; c=relaxed/simple;
	bh=4J7pjig8d4XQfz03FKpncaKkrQda+3mT01fCrlIXqvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tpVDx4tX0BWWL0dztDY1dOQ/OAy0ryxegc/2eYbgygDZtaM2Rcqlw7pDUv1km7C5GQdUD43Ow4zai+P8dgqJoyLdKVIVCJmlE9CgmKHOQGuK8+PylgAZlluVcIlP+jnRvmhCkcPmVLzlVN5N9Aey5ui2VkbuhwIYnQ6rQxVYO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbQeu+b+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbQeu+b+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECEFC19425;
	Sat, 16 May 2026 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778957676;
	bh=4J7pjig8d4XQfz03FKpncaKkrQda+3mT01fCrlIXqvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WbQeu+b+j23cs0ud/ohUEV1+nmDoprWrF9bUuFRaeeW7DCpoXruUH5VJg5xoqWovb
	 md17R6juZNANQP31+rAIYcLZIE/aeLpKWLMjgyODTB1rfRCVMfNwjd+qRPKVyhzWoi
	 dmi3uJOm9fixsGGEnD5iuu17btpg/cEo+IjnWmY19rfK3PYHG0846+WLHZg8XVBeYQ
	 qYRDDJuZIkqfdi2Z0Lhwl3MCdHXa4jwL1jcd8gOXmH2AatXt92hrMsfJqJGU2sbDGX
	 26TA+XIXWubRjvxYVFAVquFIgejodmyl+w39MdjLfkBbcWKWEvXVmnzr3DSDRstP56
	 lTfXCNpvxuq0w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 05/28] mm/damon/core: introduce
 damon_region->probe_hits
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260516183712.81393-6-sj@kernel.org>
References: <20260516183712.81393-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 18:54:35 +0000
Message-Id: <20260516185436.1ECEFC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Data type overflow of `probe_hits` array due to 8-bit `unsigned ch=
ar` limit.
- [High] Integer overflow in `probe_hits` weighted average calculation on 3=
2-bit systems.
--

commit b34f3f1254d83e9491235fb4e8e097729be04e60
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: introduce damon_region->probe_hits

This commit adds a probe_hits array to the damon_region structure to track
the number of positive samples per region for each probe. It limits the
number of probes to a fixed maximum for a simpler implementation.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 32005b8b1f8cd..9e70239e5305f 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -80,6 +83,7 @@ struct damon_region {
>  	unsigned long sampling_addr;
>  	unsigned int nr_accesses;
>  	unsigned int nr_accesses_bp;
> +	unsigned char probe_hits[DAMON_MAX_PROBES];

Does probe_hits need a wider type to prevent wrapping around?

Since the number of samples in an aggregation interval is determined by
aggr_interval / sample_interval, user-configurable values could cause the
sample count to exceed the 8-bit limit of unsigned char (255). This might
lead to silently wrapped monitoring statistics.

>  	struct list_head list;
> =20
>  	unsigned int age;
[ ... ]
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 15f2795a1156f..e5667660b4cd9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -2754,12 +2757,17 @@ static void damon_merge_two_regions(struct damon_=
target *t,
>  		struct damon_region *l, struct damon_region *r)
>  {
>  	unsigned long sz_l =3D damon_sz_region(l), sz_r =3D damon_sz_region(r);
> +	int i;
> =20
>  	l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
>  			(sz_l + sz_r);
>  	l->nr_accesses_bp =3D l->nr_accesses * 10000;
>  	l->age =3D (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
>  	l->ar.end =3D r->ar.end;
> +	/* todo: do this for only installed probes */
> +	for (i =3D 0; i < DAMON_MAX_PROBES; i++)
> +		l->probe_hits[i] =3D (l->probe_hits[i] * sz_l + r->probe_hits[i]
> +				* sz_r) / (sz_l + sz_r);

Could this weighted average calculation overflow on 32-bit architectures?

Both sz_l and sz_r are unsigned long, which is 32 bits on 32-bit systems.
If a region size is large (e.g., > 16.8MB) and probe_hits is up to 255,
multiplying them can exceed the 32-bit limit and wrap around, corrupting
the monitoring statistics.

It appears the nr_accesses calculation just above this has the exact same
flaw, and this patch propagates it to the new probe_hits array.

>  	damon_verify_merge_two_regions(l, r);
>  	damon_destroy_region(r, t);
>  }
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516183712.8139=
3-1-sj@kernel.org?part=3D5

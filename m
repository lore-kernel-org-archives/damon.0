Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215F19DF6A
	for <damon@lists.linux.dev>; Fri, 15 May 2026 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806487; cv=none; b=bFHpn8cRtYt9BbO76K3SVaTIgFUgC7uIRKlL/0v94z3QghWhxN+kuQSSQgLl0/CW5cvNnpzrR32ujVeKV3qLoCk5zfsdUPB933Sz7NngAJjxo36EGOmfxQTg36MzIhOx0QKyK5caZVidjkSBY94HKjzdiSsSI/c8nY/ozaomrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806487; c=relaxed/simple;
	bh=IAF1a063WAwKvyOFM6ViUrBFlIRR6zk5X2ls7cZCwoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I4W3IXTe/kZBKkXxmjXFZaMkGwQRKkd3CjYb4maJOkp5ulzvbG9QxrVbCCjkNF2nMDmf8H/jhGMij3GrjhsfIes+T6N5XesLLqUfeBS/htxuHtPhEzwFcqiJfW5sAi1FDGB9LotW1eUk4o9mOgIjcp6LkUpqxg4G5fk/cyemqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy+bpEs8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy+bpEs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF89C2BCB3;
	Fri, 15 May 2026 00:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778806487;
	bh=IAF1a063WAwKvyOFM6ViUrBFlIRR6zk5X2ls7cZCwoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hy+bpEs89ZQQt8QrQDccHi+5x5WpU7RgQQKuu8YgUA+WJ3EgMg9Ld3AFv1OLBTozB
	 RG8j0EzRryIw7izgxoM4GxLvU1AG+UzXll1lAq8PPn3qlwrpFzH97QXfuXwz+oVkbf
	 iwreFwZdkk6+VAtf3LcCB3NQAAXXCI8G1badXorRCKHQnvZ98yW5e/rlCdDlZ1QQXE
	 Z9RvoqihlwLd2hkVZIPQfLNcjk+zgtBOtTsmfCoW9qHlxURPZquYEONUyvkFhzps4m
	 MhJZV3k+tWt1X6rg73npivZgwB99yoFTMC5GG/10xv4j509EP0iefTYnDovXvsHCsG
	 51rNs1U5NkBVQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 05/28] mm/damon/core: introduce
 damon_region->probe_hits
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-6-sj@kernel.org>
References: <20260515004433.128933-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 00:54:46 +0000
Message-Id: <20260515005446.EEF89C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The `probe_hits` array is not propagated to the new sub-region dur=
ing a region split.
- [High] The `probe_hits` array is not recalculated during a region merge.
- [High] The `probe_hits` counters are susceptible to integer overflow.
- [Medium] The `probe_hits` array is not scaled when monitoring attributes =
change dynamically.
--

commit 5ada6fcb6176988079396fb12d1bf709aa9d2522
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: introduce damon_region->probe_hits
   =20
Add an array for the per-region per-probe positive samples count.  For
simple and efficient implementation, add a limit to the number of data
probes and set the array to support only the limited number of counters.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 9c2576f103767..bf78ad849a9be 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -80,6 +83,7 @@ struct damon_region {
>  	unsigned long sampling_addr;
>  	unsigned int nr_accesses;
>  	unsigned int nr_accesses_bp;
> +	unsigned char probe_hits[DAMON_MAX_PROBES];
>  	struct list_head list;

Can this overflow?

Since it is an 8-bit unsigned char, it can hold a maximum of 255.
The number of samples per aggregation interval is aggr_interval /
sample_interval. Both are user-configurable via damon_set_attrs(), so
configurations that yield more than 255 samples per interval could
overflow this counter and corrupt the exposed data.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 15f2795a1156f..f6b4beb4b8ecd 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -235,6 +236,8 @@ struct damon_region *damon_new_region(unsigned long s=
tart, unsigned long end)
>  	region->ar.end =3D end;
>  	region->nr_accesses =3D 0;
>  	region->nr_accesses_bp =3D 0;
> +	for (i =3D 0; i < DAMON_MAX_PROBES; i++)
> +		region->probe_hits[i] =3D 0;
>  	INIT_LIST_HEAD(&region->list);
> =20
>  	region->age =3D 0;

Are we missing a copy of probe_hits in damon_split_region_at()?

When a region is split, the new right-hand sub-region gets zeroed
counters from damon_new_region(), losing its historical positive sample
counts for the current aggregation interval:

mm/damon/core.c:damon_split_region_at() {
	...
	new =3D damon_new_region(r->ar.start + sz_r, r->ar.end);
	if (!new)
		return;

	r->ar.end =3D new->ar.start;

	new->age =3D r->age;
	new->last_nr_accesses =3D r->last_nr_accesses;
	new->nr_accesses_bp =3D r->nr_accesses_bp;
	new->nr_accesses =3D r->nr_accesses;
	...
}

Should probe_hits also be merged in damon_merge_two_regions()?

When adjacent regions are merged, l->nr_accesses and l->age are
recalibrated using a size-weighted average. However, the probe_hits
array of l is left untouched, and the probe_hits data from r is entirely
discarded:

mm/damon/core.c:damon_merge_two_regions() {
	...
	l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
			(sz_l + sz_r);
	l->nr_accesses_bp =3D l->nr_accesses * 10000;
	l->age =3D (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
	l->ar.end =3D r->ar.end;
	...
	damon_destroy_region(r, t);
}

Does probe_hits need to be scaled in damon_update_monitoring_result()
when monitoring attributes change dynamically?

Since it tracks positive samples over the aggregation interval just like
nr_accesses, leaving it unscaled might result in stale values that
misalign with the new interval constraints.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D5

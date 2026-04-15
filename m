Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91092DAFD7
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218310; cv=none; b=rU8AACffa0SW/u5DAarfazKMmOV+RYM9Ix6oPqBuHu+KKoYToi3Lf4zO9p6ZnDxd/GUXl3PwPusxsuvfEgkk4CSPH/LmUVQTeUWanUF3QeJToU4H1u5puMkVBMndBlV31ZY0bimKn5xd22AcVw8k7zW1hsGnLzLn6+5VjAHzb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218310; c=relaxed/simple;
	bh=Dhak38avbO1duqmiYKNYPvLu0Y9gzAVX/4ZkYzKrMlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CuCclSgv8+gVELcDk8zP9nIIjwM0wnL1vTX1bC7jUy/p1w6lVCdv/TplPewVYzNiVH5yK/nqVDuf/t08htVSY0alQq5L0VUz/s01z2ahgWT8/rQGWopLFtJow3UtQR5pijXyNWHLQqdaGAQtn8PNkyobZeYi2dYxb9D6SpzaUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ8hK9nt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ8hK9nt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F43DC19425;
	Wed, 15 Apr 2026 01:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776218310;
	bh=Dhak38avbO1duqmiYKNYPvLu0Y9gzAVX/4ZkYzKrMlA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qQ8hK9ntC3ouKss0UahHFqkXHZx2P4GCfiV5OXCB9YsQeckkWvpHDqZtTySDbfmmS
	 k19V+uKcEoqXPr+EpXRz9v1Poof9QNvRhorj1uKx5J99+7rPxv2VRlYxQfFfAsrAnT
	 UGrU51k5GnnZU9cNcBtoWw0vTdCDQjFqvnhxuSJ2KuKEjTa5cSLeBIx2t36jWxlgez
	 lgpcYNFVaSOaJMF6eIfunTNN+m+BuKu7PjIznGT71ZnQC48uxak7n7mVZyGr4bI92f
	 cUg23+jxtHixaVI2557d2NiT7qACv/S8XtD/yOgM4JBGzZwziOdP4QD0klMiyS/DdM
	 ImXpx5AYg0p5A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/7] mm/damon/reclaim: cover all system rams
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260415012048.76508-3-sj@kernel.org>
References: <20260415012048.76508-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 01:58:29 +0000
Message-Id: <20260415015830.5F43DC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 3 potential issue(s):
- [High] Unbounded iteration over physical memory holes causes severe sched=
uling latency and soft lockups.
- [High] Inclusion of physical holes permanently exhausts DAMOS quotas and =
starves actual memory reclaim.
- [High] Bounding box over sparse memory dilutes sampling accuracy and trap=
s RAM in cold regions.
--

commit 1ebe17b8690373c96bc931bcacccad9cbc735e44
Author: SeongJae Park <sj@kernel.org>

mm/damon/reclaim: cover all system rams

This commit changes the default DAMON_RECLAIM monitoring region from the
biggest System RAM resource to a single bounding box that spans all System
RAM resources on the system.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da147786583..2a2343d751f3e 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
[ ... ]
> @@ -242,11 +244,9 @@ static int damon_reclaim_apply_parameters(void)
>  		damos_add_filter(scheme, filter);
>  	}
> =20
> -	err =3D damon_set_region_biggest_system_ram_default(param_target,
> -					&monitor_region_start,
> -					&monitor_region_end,
> -					param_ctx->addr_unit,
> -					param_ctx->min_region_sz);
> +	err =3D damon_set_region_system_rams_default(param_target,
> +			&monitor_region_start, &monitor_region_end,
> +			param_ctx->addr_unit, param_ctx->min_region_sz);

When using a single bounding box that covers all System RAM, does this
introduce large physical address holes (like PCIe MMIO gaps) into the
monitored region? On sparse NUMA topologies, these holes can be terabytes
in size.

If operations like DAMOS_PAGEOUT iterate linearly over the region
page-by-page, will they process these massive holes? For physical holes,
damon_get_folio() will return NULL, and the loop might continue without
yielding:

damon_pa_pageout() {
    ...
    while (addr < end) {
        ...
        folio =3D damon_get_folio(PHYS_PFN(addr));
        if (!folio) {
            addr +=3D PAGE_SIZE;
            continue;
        }
        ...
    }
}

Since cond_resched() is often placed outside or after such loops, could this
continuous iteration over unbacked holes trigger soft lockups and severe
scheduling latency?

How does the inclusion of massive physical holes interact with DAMOS quotas?

In damos_apply_scheme(), the scheme's charged size is incremented by the
evaluated region size (quota->charged_sz +=3D sz). If regions span terabyte=
s of
unbacked holes, evaluating them will quickly exhaust the quota (e.g., 128
MiB/sec for DAMON_RECLAIM) without reclaiming any actual pages.

Could this starve actual memory reclaim and inflate the sz_tried statistics?

Does the bounding box approach also affect sampling accuracy?

DAMON samples a random address within a region using
damon_rand(r->ar.start, r->ar.end). If the region is mostly composed of
physical holes, the sample will frequently land in unbacked space and return
zero accesses.

Since the region will continuously appear cold, could
damon_merge_two_regions() merge it with adjacent valid RAM regions? This
might trap valid RAM inside massive cold regions, diluting the sampling
probability for actual memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415012048.7650=
8-1-sj@kernel.org?part=3D2

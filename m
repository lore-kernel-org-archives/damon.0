Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617373;
	b=L7hv2XyLO+0czmGL++kPAJyaGZfA5mvb68wzIuNLQBpVilZ/pJnYma9h9V6ynr/lxlYu
	 Pn2tb8iR6Fx6mvET3EFL52ibXT/CldekuaTdBV4y0OMAgSXEnFX79ntSIhRkibGs1ZpkV
	 C+jwvRMifEmDHEPILfFFw9Bf1xxKo6/QOOR0b9ahdCh262RwvNkc8TAko8ojaNchlt6iR
	 2uw2WABv0gLuKhX6RQU5VFHribkC5YBcQ1DFx4vQBPLfiN+gzHoNp/bwYbyAn7OZ+6QNq
	 Cy6QwzVEG1phImSn9urYO+W3vxxqUjQzqMkn0rbFb8Ji8j75Q8c9JEBsKiTSPDIPdHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5+dL/vx0YREKXe/mmst7t7qjWF6dJz1HPiap+qgB9Tc=;
	b=Nx0Cr2l868gZv659kolusLHLoDL1r1oSuimo/L9V/3xdvzRb6BGiFBcs+P412lagIfX3
	 2GFLDv4T9SuE+hpGacghSrUzBEPzcqhEdh7CkIfwLSkupdCjStQL0ZbVljplp6CU/jkcj
	 pFoxqja4btlQ43pyU7UFrE7jEXgWbz6a/BLUQ15OZ6f+JD7ML+llOcpljhpQ5cKsG2Fcw
	 OzGzUoYaBCrFjqW/SCgKKvmi+EK6w263I08XijYaM4Sf+tVZlDjz5ttHhhGBjgqyVB2Z5
	 QHoI1mMrfuEVrlTc/oVc0YLTcHAPi+SHdfJ6P9rWyWwzPhg3lYGWiNDsVMU2RrT0LAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jit11Agc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C3E606A32D
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jit11Agc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22B21F000C4;
	Sat, 14 Nov 2026 00:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617372;
	bh=5+dL/vx0YREKXe/mmst7t7qjWF6dJz1HPiap+qgB9Tc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jit11AgcD/PICaMOQ6zjYrUiiyztC61kmwqm48OTwjt/hIwKigOL4ofXeHtrKyexA
	 VEgHOAhhmfT+AbuvesPbbljCRo/D721W4U+lC0GsMSBz1G8g7AzDLKUme7HnPcBv3x
	 mlFv0K29ocqK9Tru2rBHgT31uotXa7fHVX1M3d/n882AU/uxJwlIJVyA33hljXnrw8
	 6ZF6q7fgSe58Leck8Ekd5tiOb/8B4r9viwH4MWhExMURPcvJmH9Ms0dso5/rZmvIOr
	 6rsXPEaz628xSDtOPcYS0OGkHSXRw9NNKlNIQB/cBZUdhuhuxEUnEjK2E6b8tpvCFR
	 HT4ivUn8+ZewQ==
Message-ID: <sashiko-outbox-213953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] mm: memcg: read root lruvec stats from the node
 counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joanne Koong" <joannelkoong@gmail.com>, akpm@linux-foundation.org, david@kernel.org
Cc: yosry@kernel.org, mkoutny@suse.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, ljs@kernel.org, linux-mm@kvack.org, damon@lists.linux.dev, tj@kernel.org
In-Reply-To: <20261114002822.1043378-3-joannelkoong@gmail.com>
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
 <20261114002822.1043378-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:49:31 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mm: memcg: missing NR_VMSCAN_WRITE and folio stats in
  lruvec_use_node_stat()
--

commit 95f274e85e4bf7a42c96a69c0a4509c8d43a4417
Author: Joanne Koong <joannelkoong@gmail.com>

mm: memcg: read root lruvec stats from the node counters

This commit makes lruvec_page_state() and lruvec_page_state_monotonic() read
the node counter directly for the root memcg on stats whose node counter
equals the root memcg's hierarchical value.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 091401cecf397..196c0382181b1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -504,13 +504,67 @@ struct lruvec_stats {
>  	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
>  };
> =20
> +/*
> + * Whether to read the node counter for @idx instead of @lruvec's rstat =
value.
> + * This is only done for the root memcg for stats where every update also
> + * updates a memcg's stats, so the root memcg's hierarchical value equal=
s the
> + * node counter. The node counter is preferred since it is always up to =
date,
> + * and avoids an rstat flush which for the root memcg flushes every cgro=
up in
> + * the system.
> + */
> +static bool lruvec_use_node_stat(const struct lruvec *lruvec,
> +				 enum node_stat_item idx)
> +{
> +	if (!mem_cgroup_is_root(lruvec_memcg(lruvec)))
> +		return false;
> +
> +	switch (idx) {
> +	case NR_INACTIVE_ANON:
> +	case NR_ACTIVE_ANON:
> +	case NR_INACTIVE_FILE:
> +	case NR_ACTIVE_FILE:
> +	case NR_UNEVICTABLE:
> +	case WORKINGSET_REFAULT_ANON:
> +	case WORKINGSET_REFAULT_FILE:
> +	case WORKINGSET_ACTIVATE_ANON:
> +	case WORKINGSET_ACTIVATE_FILE:
> +	case WORKINGSET_RESTORE_ANON:
> +	case WORKINGSET_RESTORE_FILE:
> +#ifdef CONFIG_NUMA_BALANCING
> +	case PGPROMOTE_SUCCESS:
> +#endif

[Severity: Medium]
Should lruvec_use_node_stat() also include NR_VMSCAN_WRITE, NR_SWAPCACHE, a=
nd
the other charged-folio stats between WORKINGSET_RESTORE_FILE and
PGPROMOTE_SUCCESS in memcg_node_stat_items[]?

The switch statement drops the entire contiguous block from
WORKINGSET_NODERECLAIM through NR_SWAPCACHE rather than only the kernel
memory items (WORKINGSET_NODERECLAIM and NR_VMALLOC..NR_SECONDARY_PAGETABLE=
):

mm/memcontrol.c:memcg_node_stat_items[] {
    ...
	WORKINGSET_RESTORE_FILE,
	WORKINGSET_NODERECLAIM,
	NR_ANON_MAPPED,
	NR_FILE_MAPPED,
	NR_FILE_PAGES,
	NR_FILE_DIRTY,
	NR_WRITEBACK,
	NR_SHMEM,
	NR_SHMEM_THPS,
	NR_FILE_THPS,
	NR_ANON_THPS,
	NR_VMSCAN_WRITE,
	NR_VMALLOC,
	NR_KERNEL_STACK_KB,
	NR_PAGETABLE,
	NR_SECONDARY_PAGETABLE,
#ifdef CONFIG_SWAP
	NR_SWAPCACHE,
#endif
#ifdef CONFIG_NUMA_BALANCING
	PGPROMOTE_SUCCESS,
#endif
    ...
}

In prepare_scan_control() (the only caller of lruvec_page_state_monotonic()=
),
anon IO cost is computed as WORKINGSET_RESTORE_ANON + NR_VMSCAN_WRITE.
Because NR_VMSCAN_WRITE is only updated via lruvec_stat_mod_folio() in
pageout() and is omitted here, root-lruvec reclaim mixes live node counters
for PGROTATE_ANON and WORKINGSET_RESTORE_ANON with the rstat counter for
NR_VMSCAN_WRITE.  Similarly, reclaimable_anon_is_low() on root_mem_cgroup
compares live node counters for NR_INACTIVE_ANON + NR_ACTIVE_ANON against t=
he
unflushed rstat counter for NR_SWAPCACHE.

NR_ANON_MAPPED, NR_ANON_THPS, NR_SHMEM, NR_SHMEM_THPS, NR_FILE_THPS, and
NR_FILE_DIRTY are also only updated on charged folios, whereas NR_FILE_PAGES
(updated via node_stat_mod_folio() for swapcache), NR_WRITEBACK (updated via
node_stat_mod_folio() for NFS unstable writes), and NR_FILE_MAPPED (updated
for uncharged pages in vm_insert_page()) can exceed the root memcg's rstat
value and would need to be noted as exceptions if excluded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114002822.1043=
378-1-joannelkoong@gmail.com?part=3D2

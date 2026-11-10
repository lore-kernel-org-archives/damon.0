Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277428;
	b=IQQfh9HMXP21iV4AikZoT6M44KQOvjq6HGDgaPNeH/XH9rfg2pfz3nIueDyvLgk5N6du
	 w5gigZo/57NaXYmx4yM1UyZO/CA+TY6ub//JPG+S0a2cK2cD30D1gfWgGui4XKl2iqQnC
	 NtMmiZ8DOq6G8adxe5EKYY3t+Jp7Tc059LZ+tH+5P6AAA8DPztqbQ1bEb76SnRl/hvDum
	 7Vb26Gt2Zm5/FEFNlKfqdj7YmTtOSNvUOw0fdGeqxbubS3wMDG3vhJftjv9njhLRQPg4g
	 ZnDRDOgPJVJm9YbC1bm4+/b9jvgWIDoN8LwKuP6Ho0L5rY8vyZm4yt9jcCO65wB+O5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277428;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A+lzFeOLtG99Ghw9rX8G9p1QUCxnDj5eZlO4QzFSIas=;
	b=RZ3T0vixHRE/9B4V/jxcR6SPdal7+JupRL62DhY6zKgkUK0RJhqQj179v5oyzGx8mPgD
	 vct6LWvzciH2lcfU8aBYSnpGdNAwGXuKzKNvO2s6AKs1JeLLicU/yFBNTgWONt0veykKv
	 Jge2mM9fwgsRpyTLKd8VuaJILz6a+yivrTHUrhaPKRjWU5pdniQp/90cKi+eLQl2SCkmG
	 PlCTnI5BT6Tuh3SYGXMh2BX1NDwlyAcjVaoi+sI8CcexRAh14nBFcknni3pOxbqUUeIhF
	 mZtxWL1BVZZjwq0gYEc/kDXKw7NRrfGc77O7nxGi3cFcoyut5CchXgtzU08krh2cNoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOGLKWu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69135606A321
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOGLKWu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA141F008A1;
	Tue, 10 Nov 2026 02:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794277428;
	bh=A+lzFeOLtG99Ghw9rX8G9p1QUCxnDj5eZlO4QzFSIas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IOGLKWu6U2jlr8eViXU1gCgBZA8adj0frtLiodU/busKR5eEm5s6yfDZntS5oxw6c
	 NTfF9gLWvfACN3wq8trUkbz5JkiasKDhu92o9cmXGRd2kHKWedzv84gLjkectZajP1
	 TGMINjX+nnRDMcp8Z9RUAnmT88gYhyBvqtZTmPZOPyuhdfU+//TY0AttNs6DIZJ0fd
	 ocCkl5A3JKkRdJd8WOskeeu2B4AY3n1bGDOxFhOTY7KBvjjIMnT/soj4hny6bpfSNH
	 cHdA+8LpZNYZH3jerZnhS3V+OSgnJpCVH2KMfP2H53J/ZwxcVATC4effDDlfdIm72L
	 IST5UC/5nfBtA==
Message-ID: <sashiko-outbox-206041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] mm: memcg: read root lruvec stats from the node
 counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joanne Koong" <joannelkoong@gmail.com>, akpm@linux-foundation.org
Cc: yosry@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, david@kernel.org, ljs@kernel.org, linux-mm@kvack.org, damon@lists.linux.dev, tj@kernel.org, mkoutny@suse.com
In-Reply-To: <20261110015321.611093-3-joannelkoong@gmail.com>
References: <20261110015321.611093-1-joannelkoong@gmail.com>
 <20261110015321.611093-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 02:23:46 +0000
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
- [Medium] mm: memcg: node_stat_includes_unaccounted() omits file and
  writeback stats
--

commit d2ba314724a8ba015e3bf2a30f155f1beba25a8c
Author: Joanne Koong <joannelkoong@gmail.com>

mm: memcg: read root lruvec stats from the node counters

This commit changes lruvec_page_state() and lruvec_page_state_monotonic()
to read per-node vmstat counters instead of rstat values for the root
memcg when querying stats that only track memory charged to a memcg.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1ebc9330aeae5..2575bf2ba0ea6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c

[ ... ]

> @@ -504,13 +511,52 @@ struct lruvec_stats {
>  	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
>  };
> =20
> +/*
> + * Whether the node counter for @idx can also count memory that isn't ch=
arged
> + * to a memcg (eg kernel memory that isn't accounted). For these stats, =
the
> + * node counter can be larger than the root memcg's value, so the root m=
emcg
> + * has to read its rstat value instead.
> + */
> +static bool node_stat_includes_unaccounted(enum node_stat_item idx)
> +{
> +	switch (idx) {
> +	case NR_SLAB_RECLAIMABLE_B:
> +	case NR_SLAB_UNRECLAIMABLE_B:
> +	case WORKINGSET_NODERECLAIM:
> +	case NR_VMALLOC:
> +	case NR_KERNEL_STACK_KB:
> +	case NR_PAGETABLE:
> +	case NR_SECONDARY_PAGETABLE:
> +#ifdef CONFIG_HUGETLB_PAGE
> +	case NR_HUGETLB:
> +#endif
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

[Severity: Medium]
Should node_stat_includes_unaccounted() also include NR_FILE_PAGES,
NR_FILE_MAPPED, and NR_WRITEBACK?

For NR_FILE_PAGES, swapcache operations such as __swap_cache_add_folio(),
__swap_cache_del_folio(), and __swap_cache_alloc() update NR_FILE_PAGES
only in the node counter while accounting swapcache in the lruvec under
NR_SWAPCACHE:

mm/swap_state.c:__swap_cache_add_folio() {
	...
	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
	...
}

Reading node_page_state(pgdat, NR_FILE_PAGES) for the root lruvec
therefore includes all swapcache pages, which inflates the "file" counter
in the root cgroup's memory.numa_stat (double-counting swapcache alongside
"swapcached") and causes it to diverge from memory.stat even after a
flush.

Similarly, __folio_mod_stat() -> lruvec_stat_mod_folio() updates the node
NR_FILE_MAPPED counter without updating memcg rstat whenever an uncharged
folio (folio_memcg(folio) =3D=3D NULL, such as a driver mapping or a
root-cgroup __GFP_ACCOUNT kernel folio) is mapped into userspace, and
nfs_folio_mark_unstable() and nfs_folio_clear_commit() update
NR_WRITEBACK only in the node counter for unstable NFS pages awaiting
server COMMIT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110015321.6110=
93-1-joannelkoong@gmail.com?part=3D2

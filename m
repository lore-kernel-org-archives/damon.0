Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD04190462;
	Sat, 21 Jun 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528938; cv=none; b=aTQOw8w5x7HiZIq9qAx8uY2VDfYkIiSUzP4kIvrPzRp5Q5jECd+q66K/7UyDRvSrbt3O628+PMbGDV2zgch3mUPiAC1SJ9ohlsF5sBbde5Hq8tRIzVP+nqT6e1q5PP2jPTqSCBK2+kt1IL/oK6x1NrkmTv6q9KMUHHt+IZZmGbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528938; c=relaxed/simple;
	bh=dKlOJKRFVegUdwZF5N/bCFO78BTODxXDwcSi4VecX6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qMnN8w5EsctfIH8bgipQDp588BeC4sYxPssZCZZs46wVzkvgKKifiLDZkxzLHp1XACmVsOFqtjZmvLeupjxVV5bXvp1k92Yda3O17O0YFeK6fvAQsfc4GJPdVABGCCnHKB11iOWIKpljQnbJChXt8xsaHy0JuYlVTjkHYKUfj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkdoRuqf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkdoRuqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB039C4CEE7;
	Sat, 21 Jun 2025 18:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750528938;
	bh=dKlOJKRFVegUdwZF5N/bCFO78BTODxXDwcSi4VecX6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkdoRuqf//KLfkKrg6Q0zNdKQozBKIooaO+H4LQ9d6+59qQL4vwYuvf8+K6Fj6ErM
	 HCOGzhG5VuJih4z8gsTSol/cDmjTqpyYUeAa/0ejPT9qiZEj59HZboTs02C+MiTbhf
	 9ElVHrvr7AFdwHuu+WhDF2Aztq+L3iYuvo8l6dIQH2RB05V9CtJhj5MfVBkyz2em+V
	 l2epQNCRK7Ogz/On6cC5mbCOskwglkDPHPsKWyfqkmY8WTlMJgS0SnEW3u/7pWyBT8
	 X8LgHADG6j+WwcL0F4xB2bjjHBTlwYGeVp6puD1s4QtvbVskK/GEzdhvxugb3JLddr
	 IqK4srA+YpbYA==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 2/2] mm/damon/paddr: Allow multiple migrate targets
Date: Sat, 21 Jun 2025 11:02:15 -0700
Message-Id: <20250621180215.36243-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620180458.5041-3-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bijan,

On Fri, 20 Jun 2025 13:04:58 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> The migrate_{hot,cold} DAMONS actions take a parameter, target_nid, to
> indicate what node the actions should migrate pages to. In this patch,
> we allow passing in a list of migration targets into target_nid. When
> this is done, the mirgate_{hot, cold} actions will migrate pages between
> the specified nodes using the global interleave weights found at
> /sys/kernel/mm/mempolicy/weighted_interleave/node<N>. This functionality
> can be used to dynamically adjust how pages are interleaved in response
> to changes in bandwidth utilization to improve performance, as discussed
> in [1]. When only a single migration target is passed to target_nid, the
> migrate_{hot,cold} actions will act the same as before.
[...]
>  include/linux/damon.h    |   8 +--
>  mm/damon/core.c          |   9 ++--
>  mm/damon/lru_sort.c      |   2 +-
>  mm/damon/paddr.c         | 108 +++++++++++++++++++++++++++++++++++++--
>  mm/damon/reclaim.c       |   2 +-
>  mm/damon/sysfs-schemes.c |  14 +++--
>  samples/damon/mtier.c    |   6 ++-
>  samples/damon/prcl.c     |   2 +-
>  8 files changed, 131 insertions(+), 20 deletions(-)

If we keep pursuing making DAMON users be able to specify multiple migration
destination nodes and their weights[1], I think we may need only paddr.c part
change of this patch in the final version of this great work.

[...]
>  static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
>  		unsigned long *sz_filter_passed)
>  {
>  	unsigned long addr, applied;
> -	LIST_HEAD(folio_list);
> +	struct rmap_walk_control rwc;
[...]
>  
>  	addr = r->ar.start;
>  	while (addr < r->ar.end) {
> @@ -522,15 +599,38 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
>  		else
>  			*sz_filter_passed += folio_size(folio);
>  
> +		/*
> +		 * If there is only one target node, migrate there. Otherwise,
> +		 * interleave across the nodes according to the global
> +		 * interleave weights
> +		 */
> +		if (nr_nodes == 1) {
> +			target_nid = first_node(s->target_nids);
> +		} else {
> +			target_nid = NUMA_NO_NODE;
> +			/* Updates target_nid */
> +			rmap_walk(folio, &rwc);
> +		}

So we are doing rmap_walk(), which is known to be not very fast, for getting
the target node id of this page, in a way very similar to that of weighted
interleaving, right?  I don't think we really need to behave that same to
weighted interleaving with the cost.

I'd hence suggest to implement and use a simple weights handling mechanism
here.  It could be roud-robin way, like weighted interleaving, or probabilistic
way, using damon_rand().

The round-robin way may be simpler in my opinion.  For example,

unsigned int damos_pa_nid_to_migrate(struct damos_migrate_dest *dest)
{
	static unsigned int nr_migrated = 0;
	unsigned int total_weight = 0;
	unsigned int weights_to_ignore;
	size_t i;

	for (i = 0; i < dest->nr_dests; i++)
		total_weight += dest->weight_arr[i];
	weights_to_ignore = nr_migrate++ % total_weight;
	total_weight = 0;
	for (i = 0; i < dest->nr_dests; i++) {
		total_weight += dest->weight_arr[i];
		if (total_weight >= weights_to_ignore)
			return dest->node_id_arr[i];
	}
	WARN_ON_ONCE(1, "I don't know what I did wrong");
	return 0;
}

Then, we could replace the above rmap_walk() call with this one.  What do you
think?

Nothing stands out from other parts to me.  I will do more thorough read on the
next revision, though.

[1] https://lore.kernel.org/20250621173639.35906-1-sj@kernel.org


Thanks,
SJ

[...]

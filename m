Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9A3EE1C2;
	Wed, 27 May 2026 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882302; cv=none; b=jtvH7+ch4qkd8NQAgYZi7jc6QwoUROIivkda1354ZZbfgCWL4DX1brc9wS2YnLXbXjkKaXCtFC9lfuSG2u363CVBr3GdE2tehjvwg7rDpRtA75F2H4dlNcGxFsCV7H4S5hK1ERjcwJH3iG3HjZblMGT49EpKo6MqHRmyjV6AWbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882302; c=relaxed/simple;
	bh=GIYfYdBRhS8kpfSENeeHNih1c5YaL3XGMxMThQE9b/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvhEJXFUraDb3eCvej2iYGbQHvmsqgVH9bfQLOn/GAF5z869t/u+IoT7jyxuTtOEMHvSF406igswiubgYZfwvTISLwto0H6Y3JcYazfbjIn3sZ/jw3rZgqwmI8oD2umuskfnYsNtvcuU9j6e655bVXWQT8iUyWdXrN0tU0g6QWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmE0ACf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmE0ACf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5441F00A3A;
	Wed, 27 May 2026 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882301;
	bh=6InA4tQAxLsS7j94L5G1yEXJPfdZ+4wJTUuxhR16ysc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jmE0ACf3VqYlPLAURNrUVBUpTirFjm6AOmbp7FRKMCQPS4O7hxubZyIL+l56vhbfB
	 fs3RoVnvEGGcmt243CTajQnTYqO0SYgyRaF84t6ATP47FV1pJYn5iTjqCLmhPAWqwY
	 Mw/snjX5RbRG0fXRfEdYygqgRCxy9F2/4aTsTowLGQF8cfiVDsHLTblBVYcCt7TxDr
	 0m6eCV5JroXQKxiO6hO2mvynMgQFldZ8cQEBOCQQHN4vwpmdUYfV9eVzJ6qJeiSMqe
	 vRlif/RwtY3kl2WyXvbbMIcEdqnmPeHPZWxlS9yjduXHt86hZ4zldvrHh9+SFgJ9E1
	 0Xk1G0csyxJrQ==
Date: Wed, 27 May 2026 12:44:57 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: tao <tao.wangtao@honor.com>
Cc: catalin.marinas@arm.com, will@kernel.org, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, willy@infradead.org, sj@kernel.org, 
	kees@kernel.org, luizcap@redhat.com, zhangjiao2@cmss.chinamobile.com, 
	kas@kernel.org, hpa@zytor.com, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz, 
	riel@surriel.com, harry@kernel.org, jannh@google.com, jgg@ziepe.ca, 
	jhubbard@nvidia.com, peterx@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, 
	nao.horiguchi@gmail.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, pfalcato@suse.de, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, damon@lists.linux.dev, shakeel.butt@linux.dev, ryncsn@gmail.com, 
	21cnbao@gmail.com, jparsana@google.com, dvander@google.com, zhangji1@honor.com, 
	wangzicheng@honor.com
Subject: Re: [PATCH 01/15] mm/rmap: introduce anon_rmap APIs for anonymous
 folios
Message-ID: <ahbWKJL8TtGsFV4r@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <20260527110147.17815-2-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527110147.17815-2-tao.wangtao@honor.com>

On Wed, May 27, 2026 at 07:01:33PM +0800, tao wrote:
> Add a set of anon_rmap APIs to operate on the reverse mappings of
> anonymous folios.
>
> Introduce anon_rmap_for_each_vma() as a wrapper around
> vma_interval_tree_foreach(), so callers no longer access the
> interval tree directly.
>
> This prepares the rmap code for upcoming ANON_VMA_LAZY support and
> RCU-based lockless rmap traversal.
>
> No functional change intended.

This commit message is total garbage. You're not explaining WHY you're
using words to describe what the code does. I can read the code?

>
> Signed-off-by: tao <tao.wangtao@honor.com>

This is all horrible, horribly invasive, and adding a pile of crap on machinery
we want to get rid of.

You've added zero explanation or comments. This is just not upstreamable,
and even if you did explain yourself we don't want to extend a broken
abstraction with more broken complexity?

You're also seemingly introducing a typesafe wrapper to wrap an arbitrary value?

> ---
>  include/linux/rmap.h | 68 +++++++++++++++++++++++++++++++++++++++++
>  mm/rmap.c            | 73 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 8dc0871e5f00..c42314ea4362 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -937,6 +937,44 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
>  void remove_migration_ptes(struct folio *src, struct folio *dst,
>  		enum ttu_flags flags);
>
> +/* Reverse mapping handle for anonymous folio rmap helpers. */
> +typedef struct anon_rmap {
> +	unsigned long rmap;
> +} anon_rmap_t;

I do not know why you're using a typedef when you just treat it as an
arbitrary value?

> +
> +#define ANON_RMAP_NULL make_anon_rmap(0)

This is just equivalent to a NULL value?...

> +
> +static inline anon_rmap_t make_anon_rmap(const void *anon_mapping)
> +{
> +	return (anon_rmap_t){ .rmap = (unsigned long)anon_mapping, };
> +}

You're intentionally defeating type safety to store arbitrary values?...

> +
> +static inline unsigned long anon_rmap_value(anon_rmap_t anon_rmap)
> +{
> +	return anon_rmap.rmap;
> +}

'Untype safe my arbitrarily type safe wrapped type'...?

> +
> +static inline anon_rmap_t anon_vma_to_anon_rmap(const struct anon_vma *anon_vma)
> +{
> +	return make_anon_rmap(anon_vma);
> +}
> +
> +static inline struct anon_vma *anon_rmap_to_anon_vma(anon_rmap_t anon_rmap)
> +{
> +	unsigned long rmap = anon_rmap_value(anon_rmap);
> +
> +	return (struct anon_vma *)rmap;
> +}

A ton of noise for seemingly no value?

> +
> +anon_rmap_t vma_get_anon_rmap(struct vm_area_struct *vma);
> +void put_anon_rmap(anon_rmap_t anon_rmap);
> +void anon_rmap_lock_write(anon_rmap_t anon_rmap);
> +int anon_rmap_trylock_write(anon_rmap_t anon_rmap);
> +void anon_rmap_unlock_write(anon_rmap_t anon_rmap);
> +void anon_rmap_lock_read(anon_rmap_t anon_rmap);
> +int anon_rmap_trylock_read(anon_rmap_t anon_rmap);
> +void anon_rmap_unlock_read(anon_rmap_t anon_rmap);

Yes let's add a bunch of extra broken abstractions on the broken abstraction.

And let's not comment anything!

> +
>  /*
>   * rmap_walk_control: To control rmap traversing for specific needs
>   *
> @@ -969,6 +1007,36 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc);
>  struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
>  					  struct rmap_walk_control *rwc);
>
> +bool folio_maybe_same_anon_vma(const struct folio *folio,
> +	const struct vm_area_struct *vma);

What the hell is this?


> +anon_rmap_t folio_get_anon_rmap(const struct folio *folio);
> +anon_rmap_t folio_lock_anon_rmap_read(const struct folio *folio,
> +	struct rmap_walk_control *rwc);
> +
> +static inline struct vm_area_struct *anon_rmap_iter_first_vma(
> +	anon_rmap_t anon_rmap, unsigned long start, unsigned long last,
> +	struct anon_vma_chain **avc)
> +{
> +	struct anon_vma *anon_vma = anon_rmap_to_anon_vma(anon_rmap);
> +
> +	*avc = anon_vma_interval_tree_iter_first(&anon_vma->rb_root, start, last);
> +	return *avc ? (*avc)->vma : NULL;
> +}

So we're allowing for folios to have NULL entries (really the commit
message should have that, rather than me scanning through uncommented
code), but in what world are we ok with an anon folio NOT BEING LINKED BACK
TO ITS VMA?

That's broken no?

> +
> +static inline struct vm_area_struct *anon_rmap_iter_next_vma(
> +	anon_rmap_t anon_rmap, unsigned long start, unsigned long last,
> +	struct anon_vma_chain **avc)
> +{
> +	if (!*avc)
> +		return NULL;
> +	*avc = anon_vma_interval_tree_iter_next(*avc, start, last);
> +	return *avc ? (*avc)->vma : NULL;
> +}
> +
> +#define anon_rmap_foreach_vma(vma, avc, anon_rmap, start, last) 	   \
> +	for (vma = anon_rmap_iter_first_vma(anon_rmap, start, last, &avc); \
> +	     vma; vma = anon_rmap_iter_next_vma(anon_rmap, start, last, &avc))
> +
>  #else	/* !CONFIG_MMU */
>
>  #define anon_vma_init()		do {} while (0)
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 78b7fb5f367c..1b2dada71778 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -701,6 +701,79 @@ struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
>  	return anon_vma;
>  }
>
> +anon_rmap_t vma_get_anon_rmap(struct vm_area_struct *vma)
> +{
> +	mmap_assert_locked(vma->vm_mm);
> +	VM_BUG_ON(!vma->anon_vma);

We don't use BUG_ON() especially VM_BUG_ON().

> +	get_anon_vma(vma->anon_vma);
> +	return anon_vma_to_anon_rmap(vma->anon_vma);
> +}
> +
> +void put_anon_rmap(anon_rmap_t anon_rmap)
> +{
> +	put_anon_vma(anon_rmap_to_anon_vma(anon_rmap));
> +}
> +
> +void anon_rmap_lock_write(anon_rmap_t anon_rmap)
> +{
> +	anon_vma_lock_write(anon_rmap_to_anon_vma(anon_rmap));
> +}
> +
> +int anon_rmap_trylock_write(anon_rmap_t anon_rmap)
> +{
> +	return anon_vma_trylock_write(anon_rmap_to_anon_vma(anon_rmap));
> +}
> +
> +void anon_rmap_unlock_write(anon_rmap_t anon_rmap)
> +{
> +	anon_vma_unlock_write(anon_rmap_to_anon_vma(anon_rmap));
> +}
> +
> +void anon_rmap_lock_read(anon_rmap_t anon_rmap)
> +{
> +	anon_vma_lock_read(anon_rmap_to_anon_vma(anon_rmap));
> +}
> +
> +int anon_rmap_trylock_read(anon_rmap_t anon_rmap)
> +{
> +	return anon_vma_trylock_read(anon_rmap_to_anon_vma(anon_rmap));
> +}
> +
> +void anon_rmap_unlock_read(anon_rmap_t anon_rmap)
> +{
> +	anon_vma_unlock_read(anon_rmap_to_anon_vma(anon_rmap));
> +}

All of these assume that you're getting an anon_vma even though you have
established above that you can put arbitrary other values?

This is terrible?

> +
> +bool folio_maybe_same_anon_vma(const struct folio *folio,
> +	const struct vm_area_struct *vma)
> +{
> +	struct anon_vma *anon_vma;
> +	struct anon_vma *tgt_anon_vma = vma->anon_vma;
> +	bool same = false;
> +
> +	rcu_read_lock();
> +	anon_vma = folio_anon_vma(folio);
> +	if (anon_vma && tgt_anon_vma)
> +		same = anon_vma->root == tgt_anon_vma->root;
> +	rcu_read_unlock();
> +	return same;

What VMA locks are being held at this point? You assert none.

Why is it maybe?

Why are you taking the RCU lock?

> +}
> +
> +anon_rmap_t folio_get_anon_rmap(const struct folio *folio)
> +{
> +	struct anon_vma *anon_vma = folio_get_anon_vma(folio);
> +
> +	return anon_vma ? anon_vma_to_anon_rmap(anon_vma) : ANON_RMAP_NULL;
> +}
> +
> +anon_rmap_t folio_lock_anon_rmap_read(const struct folio *folio,
> +				      struct rmap_walk_control *rwc)
> +{
> +	struct anon_vma *anon_vma = folio_lock_anon_vma_read(folio, rwc);
> +
> +	return anon_vma ? anon_vma_to_anon_rmap(anon_vma) : ANON_RMAP_NULL;
> +}
> +
>  #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>  /*
>   * Flush TLB entries for recently unmapped pages from remote CPUs. It is
> --
> 2.17.1
>

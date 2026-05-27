Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23794391E7F;
	Wed, 27 May 2026 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883013; cv=none; b=QTo7VVCosyPsnTk3Kh1nAJzoPBozF92/IAOKOSPhEg+OxdG/lAS/IEQfYy/o4FhjgXrgqxb5y9XcN7suh/f7TLyidU8VfIfgHLWEyhuoOK4Lei4Ipc9jVYHJcjBWMwUm+4rmeP14FF1dQWGRPHLEdfqrJ5QWvmOI6cmw9ei/Zjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883013; c=relaxed/simple;
	bh=pqXEBNOIc7QVQcLEAQHN55LJtXTCWStMsL2A99JgpB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFZBAhcR7frh2ocUyC41zEq2Y1zTaLs2nGzhd3va2H2TvQ7B8NeFymPn/RaRgU1VBmnVL9DEs7s9pRJRynqWb2Cy0kw36XHY3klYO9iI4GPKLL8EmTcKxgzSb9KCYM9bQ+y5SfxAeD7tcp+KfrkS5VxiALGA0gO/PkOXxKOsdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NweolyGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NweolyGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CF11F000E9;
	Wed, 27 May 2026 11:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883011;
	bh=ksZ5oHiQw0set/5JzEq4vhK20DwRRO7Os6WxXBqwiRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NweolyGXKEajQ0RagK6sfKNXR3ZzC9vSVU2YLniuEU+Glx+awY5/0FLd0SJ4c2fTA
	 ZEawMCjKSwiuOqJZycIboFWAUXIsXCV3AjZmpmSiUxaUzweLj7Xb3OINPKYt2KuZct
	 pps6h9ZusRXlL+CGq/ZIMQh5wOf0Wucq5+apl8w/QFyWX9GYCW0dUl/bCkG/tbUm2L
	 LOOvm+uurETXlZAVKh1uT8YMvaSSxBD4qqvZJ7FqwYsJXg8WqcAInBwV3ljQt/QVJB
	 4kWeE2s44qxGxrcfoOjgVQp0UjmsVLGZGNOtub+PELBiymmugD3s3Hn2+Rf+jegYJ0
	 jT12W2JGCFVUw==
Date: Wed, 27 May 2026 12:56:35 +0100
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
Subject: Re: [PATCH 03/15] mm: introduce anon_vma_tree_t for multiple
 anon_vma topologies
Message-ID: <ahbatfs3G-Qkh7Vk@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <20260527110147.17815-4-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527110147.17815-4-tao.wangtao@honor.com>

On Wed, May 27, 2026 at 07:01:35PM +0800, tao wrote:
> Prepare for upcoming ANON_VMA_LAZY support and RCU-based lockless rmap
> traversal by clearly separating anon_vma topology handling from the
> anon_rmap semantics.

RCU is not 'lockless'... and if you truly get RCU semantics you break a bunch of
stuff as I found out.

>
> Prepare for supporting multiple anon_vma topologies by introducing
> lightweight abstractions used by the VMA and rmap code.
>
> Introduce anon_vma_tree_t as the type stored in vma->anon_vma:
>
>     typedef unsigned long anon_vma_tree_t;
>
> It represents a tagged pointer encoding a reference to the anon_vma
> topology. The low bits are reserved as type tags to distinguish
> different implementations (e.g. regular anon_vma and lazy anon_vma).
> This keeps the VMA representation compact while allowing the topology
> to evolve without changing the VMA layout.
>
> Signed-off-by: tao <tao.wangtao@honor.com>

The commit message is at least better on this one, but this approach is again,
predicated on extending a broken abstraction.

You could have saved time and effort by coming forward with this earlier to the
community.

You're also adding a bunch more messy code on top of anon_vma. It's just the
wrong direction.

> ---
>  include/linux/mm_types.h |  3 +++
>  mm/internal.h            | 54 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index a308e2c23b82..5f4961ea1572 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -917,6 +917,9 @@ struct vm_area_desc {
>  	struct mmap_action action;
>  };
>
> +/* Tagged pointer stored in vma->anon_vma. Low bits encode anon_vma type. */
> +typedef unsigned long anon_vma_tree_t;
> +
>  /*
>   * This struct describes a virtual memory area. There is one of these
>   * per VM-area/task. A VM area is any part of the process virtual memory
> diff --git a/mm/internal.h b/mm/internal.h
> index 5a2ddcf68e0b..76544ad44ff0 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -246,6 +246,60 @@ static inline void anon_vma_unlock_read(struct anon_vma *anon_vma)
>  	up_read(&anon_vma->root->rwsem);
>  }
>
> +/* anon_vma_tree_t APIs */
> +
> +static inline anon_vma_tree_t make_anon_vma_tree(struct anon_vma *anon_vma)
> +{
> +	return (anon_vma_tree_t)anon_vma;
> +}

You're literally returning an unsigned long of an anon_vma here?

Why is the anon_rmap_t a wrapped struct and this an unsigned long?

> +
> +static inline struct anon_vma *anon_vma_tree_anon_vma(anon_vma_tree_t anon_tree)
> +{
> +	return (struct anon_vma *)anon_tree;
> +}

The anon_tree is an anon_vma? What?

And it's a tagged pointer but we don't bother clearing any bits right?...!

> +
> +static inline void anon_vma_tree_lock_write(anon_vma_tree_t anon_tree)
> +{
> +	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
> +
> +	anon_vma_lock_write(anon_vma);
> +}
> +
> +static inline int anon_vma_tree_trylock_write(anon_vma_tree_t anon_tree)
> +{
> +	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
> +
> +	return anon_vma_trylock_write(anon_vma);
> +}
> +
> +static inline void anon_vma_tree_unlock_write(anon_vma_tree_t anon_tree)
> +{
> +	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
> +
> +	anon_vma_unlock_write(anon_vma);
> +}
> +
> +static inline void anon_vma_tree_lock_read(anon_vma_tree_t anon_tree)
> +{
> +	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
> +
> +	anon_vma_lock_read(anon_vma);
> +}
> +
> +static inline int anon_vma_tree_trylock_read(anon_vma_tree_t anon_tree)
> +{
> +	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
> +
> +	return anon_vma_trylock_read(anon_vma);
> +}
> +
> +static inline void anon_vma_tree_unlock_read(anon_vma_tree_t anon_tree)
> +{
> +	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
> +
> +	anon_vma_unlock_read(anon_vma);
> +}
> +

You keep adding more and more code on top of the existing mess. This is NOT what
we want.

>  struct anon_vma *folio_get_anon_vma(const struct folio *folio);
>
>  /* Operations which modify VMAs. */
> --
> 2.17.1
>

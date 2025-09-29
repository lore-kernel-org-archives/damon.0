Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B833086
	for <damon@lists.linux.dev>; Mon, 29 Sep 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169863; cv=none; b=L5kMc3j7RvFskQap11qLDeG5kpA6q+9/+7qziyudogB8OH8pzeTFT84TPa9XM9+r71bwNtNPtCXu9rquo5l813q3chpAKFB8zWKT+eaBXahhzVcFHHVweqyCzmmQpMEdvZnVR2jgqiMg2gLRW0Hhl5648CYEMSbkhelEBig0/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169863; c=relaxed/simple;
	bh=hs7ZhVlHpDODW1RPNhtz1c+38OKVM5QvKR3052eMTDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHZHl4MN2gUfrMmlHT6tp16ugEizrR5d4jjOoryyF6biFrEznNCvdaJvqd0eKy7LU1kW6mKb+ve+tHYYcikr47r8AaLhKKaRD1VgguT5l0pWWG2bdfcZmPV9BIXQBiAQyD7S9B7KzSMSMOkBL/ULSfkobjsAXW8o7zSmESMUkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSHp/qgY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSHp/qgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C262C2BCAF
	for <damon@lists.linux.dev>; Mon, 29 Sep 2025 18:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759169863;
	bh=hs7ZhVlHpDODW1RPNhtz1c+38OKVM5QvKR3052eMTDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iSHp/qgYkW6XG88ZNR0ezBNEtcnBdVeG6GLGX7KtQ56f5tcoTqny1vw/EvBDnlRsU
	 tB/htyMvSfcK5YD6wgEGt/gIMOifz0Hu49/zK+cSwCRAmW1J6a/+wEF43V3ZxM6Vnd
	 pGD+efla1lc1v+nleVPjR1Wlq8MJ+ECnFP2EpU5LCNFczXtNqxeqPlNmX9svMVvaXl
	 mS+NnJWeGotyATWC4HbEDHOLtJ8vEJ5AURaeRehErk2FIQHf+Qdo7fyCPphxrweNq9
	 wr56cgZW5sl3ZyrGRhCqIonN7PgrwGc+fv5d4+jsI3D/aHxj1d52Qxuw/cVaxAxbXM
	 8FmtZv8Kkxwxw==
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-633b6595287so3611417d50.1
        for <damon@lists.linux.dev>; Mon, 29 Sep 2025 11:17:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6VGtAAvFzCd0iItPYVm6dPfc3/deCNhRphvK5oCIs1bjj5ixOoUwjh3GF1eRnGXY9mRPUaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqetSEpB7XLyd2WBC445mjPA9UK4Y4rYIwctK/iEZNN7ZXLA2y
	fCGYD/1kZ565ntRVQDHGYKcfCNC1zOOhn0tse4htQOfj+EH/Cdq4lJ4+FhyiOPY8LN8Z6W+8ihh
	MNfAA4VusW1dEpqqDGOmeagqkT7eOxGX6b0ll3za73A==
X-Google-Smtp-Source: AGHT+IGE6kd5xs0icSEEZdS7pVFN0cuwPwOYJEJUqimZ27ahOuuNINX3pZfMIADUMTyMWhWu/yapJRXNXT5lGOAZgi4=
X-Received: by 2002:a53:ea42:0:b0:63a:183:ffda with SMTP id
 956f58d0204a3-63a01a28749mr3923965d50.26.1759169862055; Mon, 29 Sep 2025
 11:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250927080635.1502997-1-jianyungao89@gmail.com>
In-Reply-To: <20250927080635.1502997-1-jianyungao89@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 29 Sep 2025 11:17:31 -0700
X-Gmail-Original-Message-ID: <CACePvbWkr79j-ogkp+-Eehx=pssTmb2Cb4npKGd0ehZE-qudcg@mail.gmail.com>
X-Gm-Features: AS18NWDO3sHve2jnUkOqUEozfH6mTV1MNP6z6MOxPopzdQLUYhEQ7K_wVAWGfWA
Message-ID: <CACePvbWkr79j-ogkp+-Eehx=pssTmb2Cb4npKGd0ehZE-qudcg@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix some typos in mm module
To: "jianyun.gao" <jianyungao89@gmail.com>
Cc: linux-mm@kvack.org, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"open list:DATA ACCESS MONITOR" <damon@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KMSAN" <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Sat, Sep 27, 2025 at 1:07=E2=80=AFAM jianyun.gao <jianyungao89@gmail.com=
> wrote:
>
> Below are some typos in the code comments:
>
>   intevals =3D=3D> intervals
>   addesses =3D=3D> addresses
>   unavaliable =3D=3D> unavailable
>   facor =3D=3D> factor
>   droping =3D=3D> dropping
>   exlusive =3D=3D> exclusive
>   decription =3D=3D> description
>   confict =3D=3D> conflict
>   desriptions =3D=3D> descriptions
>   otherwize =3D=3D> otherwise
>   vlaue =3D=3D> value
>   cheching =3D=3D> checking
>   exisitng =3D=3D> existing
>   modifed =3D=3D> modified
>
> Just fix it.
>
> Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> ---
>  mm/damon/sysfs.c  | 2 +-
>  mm/gup.c          | 2 +-
>  mm/kmsan/core.c   | 2 +-
>  mm/ksm.c          | 2 +-
>  mm/memory-tiers.c | 2 +-
>  mm/memory.c       | 4 ++--
>  mm/secretmem.c    | 2 +-
>  mm/slab_common.c  | 2 +-
>  mm/slub.c         | 2 +-
>  mm/swapfile.c     | 2 +-
>  mm/userfaultfd.c  | 2 +-
>  mm/vma.c          | 4 ++--
>  12 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index c96c2154128f..25ff8bd17e9c 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1232,7 +1232,7 @@ enum damon_sysfs_cmd {
>         DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS,
>         /*
>          * @DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS: Update the tuned moni=
toring
> -        * intevals.
> +        * intervals.
>          */
>         DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS,
>         /*
> diff --git a/mm/gup.c b/mm/gup.c
> index 0bc4d140fc07..6ed50811da8f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2730,7 +2730,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>   *
>   *  *) ptes can be read atomically by the architecture.
>   *
> - *  *) valid user addesses are below TASK_MAX_SIZE
> + *  *) valid user addresses are below TASK_MAX_SIZE
>   *
>   * The last two assumptions can be relaxed by the addition of helper fun=
ctions.
>   *
> diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
> index 1ea711786c52..1bb0e741936b 100644
> --- a/mm/kmsan/core.c
> +++ b/mm/kmsan/core.c
> @@ -33,7 +33,7 @@ bool kmsan_enabled __read_mostly;
>
>  /*
>   * Per-CPU KMSAN context to be used in interrupts, where current->kmsan =
is
> - * unavaliable.
> + * unavailable.
>   */
>  DEFINE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 160787bb121c..edd6484577d7 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -389,7 +389,7 @@ static unsigned long ewma(unsigned long prev, unsigne=
d long curr)
>   * exponentially weighted moving average. The new pages_to_scan value is
>   * multiplied with that change factor:
>   *
> - *      new_pages_to_scan *=3D change facor
> + *      new_pages_to_scan *=3D change factor
>   *
>   * The new_pages_to_scan value is limited by the cpu min and max values.=
 It
>   * calculates the cpu percent for the last scan and calculates the new
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 0382b6942b8b..f97aa5497040 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -519,7 +519,7 @@ static inline void __init_node_memory_type(int node, =
struct memory_dev_type *mem
>          * for each device getting added in the same NUMA node
>          * with this specific memtype, bump the map count. We
>          * Only take memtype device reference once, so that
> -        * changing a node memtype can be done by droping the
> +        * changing a node memtype can be done by dropping the
>          * only reference count taken here.
>          */
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 0ba4f6b71847..d6b0318df951 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4200,7 +4200,7 @@ static inline bool should_try_to_free_swap(struct f=
olio *folio,
>          * If we want to map a page that's in the swapcache writable, we
>          * have to detect via the refcount if we're really the exclusive
>          * user. Try freeing the swapcache to get rid of the swapcache
> -        * reference only in case it's likely that we'll be the exlusive =
user.
> +        * reference only in case it's likely that we'll be the exclusive=
 user.
>          */
>         return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio)=
 &&
>                 folio_ref_count(folio) =3D=3D (1 + folio_nr_pages(folio))=
;
> @@ -5274,7 +5274,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct =
folio *folio, struct page *pa
>
>  /**
>   * set_pte_range - Set a range of PTEs to point to pages in a folio.
> - * @vmf: Fault decription.
> + * @vmf: Fault description.
>   * @folio: The folio that contains @page.
>   * @page: The first page to create a PTE for.
>   * @nr: The number of PTEs to create.
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 60137305bc20..a350ca20ca56 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -227,7 +227,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>         struct file *file;
>         int fd, err;
>
> -       /* make sure local flags do not confict with global fcntl.h */
> +       /* make sure local flags do not conflict with global fcntl.h */
>         BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
>
>         if (!secretmem_enable || !can_set_direct_map())
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index bfe7c40eeee1..9ab116156444 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -256,7 +256,7 @@ static struct kmem_cache *create_cache(const char *na=
me,
>   * @object_size: The size of objects to be created in this cache.
>   * @args: Additional arguments for the cache creation (see
>   *        &struct kmem_cache_args).
> - * @flags: See the desriptions of individual flags. The common ones are =
listed
> + * @flags: See the descriptions of individual flags. The common ones are=
 listed
>   *         in the description below.
>   *
>   * Not to be called directly, use the kmem_cache_create() wrapper with t=
he same
> diff --git a/mm/slub.c b/mm/slub.c
> index d257141896c9..5f2622c370cc 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2412,7 +2412,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, =
bool init,
>                 memset((char *)kasan_reset_tag(x) + inuse, 0,
>                        s->size - inuse - rsize);
>                 /*
> -                * Restore orig_size, otherwize kmalloc redzone overwritt=
en
> +                * Restore orig_size, otherwise kmalloc redzone overwritt=
en
>                  * would be reported
>                  */
>                 set_orig_size(s, x, orig_size);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index b4f3cc712580..b55f10ec1f3f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1545,7 +1545,7 @@ static bool swap_entries_put_map_nr(struct swap_inf=
o_struct *si,
>
>  /*
>   * Check if it's the last ref of swap entry in the freeing path.
> - * Qualified vlaue includes 1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM.
> + * Qualified value includes 1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM.
>   */
>  static inline bool __maybe_unused swap_is_last_ref(unsigned char count)
>  {
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index aefdf3a812a1..333f4b8bc810 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1508,7 +1508,7 @@ static int validate_move_areas(struct userfaultfd_c=
tx *ctx,
>
>         /*
>          * For now, we keep it simple and only move between writable VMAs=
.
> -        * Access flags are equal, therefore cheching only the source is =
enough.
> +        * Access flags are equal, therefore checking only the source is =
enough.
>          */
>         if (!(src_vma->vm_flags & VM_WRITE))
>                 return -EINVAL;
> diff --git a/mm/vma.c b/mm/vma.c
> index 3b12c7579831..2e127fa97475 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -109,7 +109,7 @@ static inline bool is_mergeable_vma(struct vma_merge_=
struct *vmg, bool merge_nex
>  static bool is_mergeable_anon_vma(struct vma_merge_struct *vmg, bool mer=
ge_next)
>  {
>         struct vm_area_struct *tgt =3D merge_next ? vmg->next : vmg->prev=
;
> -       struct vm_area_struct *src =3D vmg->middle; /* exisitng merge cas=
e. */
> +       struct vm_area_struct *src =3D vmg->middle; /* existing merge cas=
e. */
>         struct anon_vma *tgt_anon =3D tgt->anon_vma;
>         struct anon_vma *src_anon =3D vmg->anon_vma;
>
> @@ -798,7 +798,7 @@ static bool can_merge_remove_vma(struct vm_area_struc=
t *vma)
>   * Returns: The merged VMA if merge succeeds, or NULL otherwise.
>   *
>   * ASSUMPTIONS:
> - * - The caller must assign the VMA to be modifed to @vmg->middle.
> + * - The caller must assign the VMA to be modified to @vmg->middle.
>   * - The caller must have set @vmg->prev to the previous VMA, if there i=
s one.
>   * - The caller must not set @vmg->next, as we determine this.
>   * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
> --
> 2.34.1
>

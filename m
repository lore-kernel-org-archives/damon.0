Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3C3F9D2
	for <damon@lists.linux.dev>; Tue, 12 Aug 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022174; cv=none; b=E05J43gzUkBB9Plsa1uBl1b7cTVM0ZPPaIS/dXcVQyeIafCn9p0XrJSZJy/3vRc4x0+FdQw7xdI4lg9aJADJL9s2gR8vSuJNo9BITbwL8+XFRc8ZSXTjneHWFEBmVFAF02GP8QQCp3t2NBMUS2Gc536ppOZXPnK36jEDhtShoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022174; c=relaxed/simple;
	bh=70cgqr8HffMA+vqKtde654+uKtYtNAc3JgtQnYP35Mw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKfWx5TtMPcKnYexoSRSD4lJsnmES5U0XChIgG93zbLxsjGVS8C6hzcrrjTytM60T8AlsDMDjPzGz1Jy7j25kCnUwtxsP55fAiuxrKMST+cPOjLqnjUrwj65O6zMEokL6aeGUYDI8DWvz710dm3y/yAXMhaZ8oseBnbRNZpHcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIHF5UG0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIHF5UG0"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55cbf9a78dbso4780428e87.2
        for <damon@lists.linux.dev>; Tue, 12 Aug 2025 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755022171; x=1755626971; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZDUkMKu9atmajMTxQr8Zy4WtzGPeYmeD3V264EGn5E=;
        b=MIHF5UG0wboP4YJWxj8Fer1NRfZqJ2ZTV8iKmCTBX8sxv+zS61NPgPWHn0NOX4Biye
         Hwl2oHh8YRb/+zDsM5PsXjiwOGU/QuNZNyk8jWxbcGsySj2qFdaZSytND28l12I8i6rk
         le0x0ojPepuC8ij9z/OIg1xdqdE6jJ6sL+ZoLVGLHTHzA9ciJz3cehAYhdOdZwNOn09x
         yyCzTuxZCs102moZ7LWgIgIwSwfSHBNKRE/YEYBwOlDgBjNprbYS6abeT0jTG98WtTGx
         MLZzTXsDmY+bczSqt50r9HerlDzpR9flRVDg0IgiMQAOm31Nkws75LOi0Tza1OAiybbz
         oXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755022171; x=1755626971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZDUkMKu9atmajMTxQr8Zy4WtzGPeYmeD3V264EGn5E=;
        b=BVJ1c3Sffhg7sDdU39FeHABS1TqLQwh+TMrfPaWunqAJnvTEKW1uniDdI/F1TgikAG
         xofm8uWiO24VWpJOuhDn5epdGCS2RTz2u+dzEU+Qkw9bdpbZNMdNJz9hwoiKUYdqdvNH
         pFcCmlN4m6ErvhmZIeqDONPd60cRNCAoeGJqo7O9qJDSi4lExrdnRt3POA7oIsj8uCf5
         Ti1AfSh+kv+GWyIbAYsb8OUfxAx0u5QpdHWZRa+Z4cqKtFgXObfvaN4UFugylORMbWMq
         CEduaeF8IfzIX2gDAtGOW3MtvlMdTTmJFb89x3tV0k9vc/YAv6nKkaL9ZaJCAgUh6LRL
         pjug==
X-Forwarded-Encrypted: i=1; AJvYcCVaUORAurSTXa6Md/2BkGAiZpGCzAORI++kOFbRZ3jE1BETHU96fmA2IHgsu5j/jZXVx31zhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMAIvI87WUG6abgcWSqNWcKE4loEKrRmWj1RpYORgUu2/HSfuJ
	nYiB/nG8XfLZP2WkM6qAbr7edTVwfMw8rWkLVYofjuHGTmAtlEGpqd4Z
X-Gm-Gg: ASbGncsmd4DAx4W/lvRKDCrvoLCANusyaE3fu/BXjfhjKDubckLJdJXGiN06525mRFP
	Qo6qJjHDDQ+m+prsp4g8MvQli6mCJlHmCo0jTt+SGZrg4ehcvCtRYfEdH900Di6R6+KelkbSPKz
	+ogqm4TYlydCkjanxuldRavgt5im37uwsakWKZrz0SrXpvJSBh0aNqcYoinrdRYS+tSiEAoUWly
	qlCgVuoXS+sbHDDdAM8LdpiRSpKCwvcDmk9c0pje+grIKcUwLeeKpKfrlGpq2GRoDapu9RypUpF
	yQUgJHGOC1iEvz6ldmj54SNBUsGxR53aLWTUKVZ6iLWIuXX0nA9B6uUabguWxaSV
X-Google-Smtp-Source: AGHT+IEEXGoeStCQXxDKTFTywpHq4TMpC9VS4tHSeegQS3BoIg5LO4J7Q33M2SPYDxo1P69r+f8Ryg==
X-Received: by 2002:a05:6512:3b2b:b0:55b:9647:8e64 with SMTP id 2adb3069b0e04-55ce03b94abmr69831e87.36.1755022170530;
        Tue, 12 Aug 2025 11:09:30 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cae595sm4928492e87.155.2025.08.12.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:09:29 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 12 Aug 2025 20:09:27 +0200
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Qianfeng Rong <rongqianfeng@vivo.com>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
Message-ID: <aJuDV7OzUZZ4g5lL@pc636>
References: <20250812135225.274316-1-rongqianfeng@vivo.com>
 <b5ca3ef2-bd36-4cb5-a733-a5d4f1fb32fa@lucifer.local>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ca3ef2-bd36-4cb5-a733-a5d4f1fb32fa@lucifer.local>

On Tue, Aug 12, 2025 at 05:46:47PM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 12, 2025 at 09:52:25PM +0800, Qianfeng Rong wrote:
> > Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> > GFP_NOWAIT implicitly include __GFP_NOWARN.
> >
> > Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> > `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> > redundant flags across subsystems.
> >
> > No functional changes.
> >
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> 
> LGTM, I wonder if there are other such redundancies in the kernel?
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> > ---
> > v1->v2:
> > - Added a modification to remove redundant __GFP_NOWARN in
> >   mm/damon/ops-common.c
> > ---
> >  mm/damon/ops-common.c | 2 +-
> >  mm/filemap.c          | 2 +-
> >  mm/mmu_gather.c       | 4 ++--
> >  mm/rmap.c             | 2 +-
> >  mm/vmalloc.c          | 2 +-
> >  5 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 99321ff5cb92..b43595730f08 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -303,7 +303,7 @@ static unsigned int __damon_migrate_folio_list(
> >  		 * instead of migrated.
> >  		 */
> >  		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> > -			__GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
> > +			__GFP_NOMEMALLOC | GFP_NOWAIT,
> >  		.nid = target_nid,
> >  	};
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 4e5c9544fee4..c21e98657e0b 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1961,7 +1961,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> >  			gfp &= ~__GFP_FS;
> >  		if (fgp_flags & FGP_NOWAIT) {
> >  			gfp &= ~GFP_KERNEL;
> > -			gfp |= GFP_NOWAIT | __GFP_NOWARN;
> > +			gfp |= GFP_NOWAIT;
> >  		}
> >  		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
> >  			fgp_flags |= FGP_LOCK;
> > diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> > index b49cc6385f1f..374aa6f021c6 100644
> > --- a/mm/mmu_gather.c
> > +++ b/mm/mmu_gather.c
> > @@ -32,7 +32,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
> >  	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
> >  		return false;
> >
> > -	batch = (void *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > +	batch = (void *)__get_free_page(GFP_NOWAIT);
> >  	if (!batch)
> >  		return false;
> >
> > @@ -364,7 +364,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
> >  	struct mmu_table_batch **batch = &tlb->batch;
> >
> >  	if (*batch == NULL) {
> > -		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > +		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT);
> >  		if (*batch == NULL) {
> >  			tlb_table_invalidate(tlb);
> >  			tlb_remove_table_one(table);
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 568198e9efc2..7baa7385e1ce 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -285,7 +285,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
> >  	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
> >  		struct anon_vma *anon_vma;
> >
> > -		avc = anon_vma_chain_alloc(GFP_NOWAIT | __GFP_NOWARN);
> > +		avc = anon_vma_chain_alloc(GFP_NOWAIT);
> >  		if (unlikely(!avc)) {
> >  			unlock_anon_vma_root(root);
> >  			root = NULL;
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 6dbcdceecae1..90c3de1a0417 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -5177,7 +5177,7 @@ static void vmap_init_nodes(void)
> >  	int n = clamp_t(unsigned int, num_possible_cpus(), 1, 128);
> >
> >  	if (n > 1) {
> > -		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT | __GFP_NOWARN);
> > +		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT);
> >  		if (vn) {
> >  			/* Node partition is 16 pages. */
> >  			vmap_zone_size = (1 << 4) * PAGE_SIZE;
> > --
> > 2.34.1
> >
Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

--
Uladzislau Rezki

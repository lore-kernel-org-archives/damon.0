Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430957;
	b=eyAMG4Kvis6Xaok1UvcQfPBPGUBOvTS95kvQQgLfvXpFtGBabw1lFgFOBdDDvKIJRLae
	 F2a9Gbu5pnhQkIfBpOqYTxS71zwVw1li2Tizif04sqjnMr3KWK38LxZJL2acBq9YxlfwC
	 mLHPMheVf639sjLXjIMTIt3Jqxml7biYLKOuiqH+V6ON+pjICd6ld7yGvd7IkgZ5snjO9
	 nHL7rYQ7NBSrZh/bDUs/n8FS9iaT09TP/BhPB4V3zeaDfQeXQMOPEzov8DzRDqmXl2KD1
	 Avqtvsl5CSBE/Mj482zTX+YygGeYCF/aySPiJvmj36FuTsJUzc2zzf8jE1r0shk4gRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=/ggRC6iWaNAZz8PBBX98LO0tMriK9ErQOsDnRJRUWcI=;
	b=BqOERsqPSG5QZI4KInppP+JznGOHYZoU27yRnYuz2PPmqedeWbKEFJYRyBerAdIefBJO
	 tFFORDtmtuhbUcExAGxEf49m1TFfzvGlrcVnHt1nVJUq6wkqvQ2//gne0Kti5IU2luyRh
	 tKEj3j8MvdJJ3/g4wBq72isi3QFDJXJE3ce/pkCh//JE0F08su5IWPOZvbRS6EJADrQgn
	 6tCWOq1QW/W3jEQyRjoKvzhy0Z/hXgKtX5ubODpjrN2fQtksJyUN8MYc+zSbqb5wJk8BZ
	 4cHPWpU0znrD1NifBHdgtsn0T4hmt6viuXDOSHsFAc7zW+7odthGIKdtM1PlHb9ACQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVO60Pn6;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F080606A31F
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 10:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F080606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVO60Pn6
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so1407699a12.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 02:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795430956; x=1796035756; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ggRC6iWaNAZz8PBBX98LO0tMriK9ErQOsDnRJRUWcI=;
        b=DVO60Pn6Addra9Bgs27udun2kIX2Ld8oDMJqzzioKBdfgQcsb3H5nO1hr2mycxNsbQ
         3HvTFM2C6kPA7ovn360y6rNNHAeY0+EpYnZ2AzZjpVjuJhMMlIyairBCODXsM5V0l/77
         Qy5rab+/UAA7DjPhNbyBaN+t+5wqWfWi4Tuni0aiAsE5offjIfxslGv8H5sxT4ZYa4w3
         DlXsVll7iKyMW+UaRpnGcttdtNyTZpP/DlGdn2/xbU5YHgdhVGahe1m9pKW0D2QlULs0
         4e5NXwssMxvMpNFFEXq7NOrKIPXPXwiMkHPGgijolf3VXRcDuLOdU3pzavEOMQ+WAfq3
         X+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795430956; x=1796035756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/ggRC6iWaNAZz8PBBX98LO0tMriK9ErQOsDnRJRUWcI=;
        b=ZBxjVVc2J44lg5T3kChvMdnfBtRvO+VLkn5LGbGwf5O/2lSfoNxfZnS04PYi4EOSk2
         wV7yex1zNZmPPHwkrJx8v+YmCLMsml+1Qii0dfgcJxHBzIQHyotWttOEfgwO+CSgFnIL
         snzmvxbouh36pUh4tjvuqXrzE+MbOyS78wnJwEk0TQEzQIdcygbNiuqi2Ma/MiAS2VNT
         o3c0zJwLAD+f19iUBxRLxH0duVwdWuTcWZMC427R+AlGb+BJTQn31YhSQqUjOC2VJNIt
         AebcA73htqwJeeczK7ZDV1ACGXAakjU9A6+tBVLnH75EY7Z+qion8KhBmbbrIyzk2olH
         bsFg==
X-Forwarded-Encrypted: i=1; AL+hErFzE7UqUSn2QnRPe2iFsq4+hgBPlrPZfBZATyk1OFRxm9PPjOsnFccif8xLrigHgrx1zGU34A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9sTYZvDfAgSLdXFKS8AqeC3EPNEviGRn6IW7MxEF0lJ0VZjjyO
	2OrEnVg8/TTBZWUdHgiNeIUGN9UugF5f8R57aaSr4pTC1/kZ4fIniLBl
X-Gm-Gg: AZFdTZcnQJH2ywtI/MUDsIqGlMJ3SQNsk6vIczUbIbrpb4iT0Aph+Nei2NnQoWz0zPg
	7X43Q5tRT1d5W8YyVC6Q4yfewYzUyZv21pJiQ6CmeU60q7MrkAAWxXMcLWKatikRSnGgVWiFsy7
	r44MRzgF3GhuayX5PX3j3yInaO/XxEDu6Z8zwiilMt02k9ZZGKNp5AIr0+omy7Bl+lldNl39dKS
	yqUHgkaKx2qox8rPwnariR7BKKDVrFb1kZau8f55nkkeX6nB9QBTYdLZ6k/08ygdG4J9v309oh/
	XIWc74SIrMgBVcI1q5H/norCaUeJCYT+uSLXrPAK7QDvjcaVrEwEtAR3YkPHMMxYx9WISglIdbW
	F/XwnK313rfRUQwgu4a8vHL2Bpv/2Snppyg4SKZq3nAQj5QnNjrAKfHdUvKIMVECvJ5TsuGO3aR
	ROhVo2EMS+0J3v10OaGFiTducPer+QAKDTPz9TUoAKeSMersR7G7ri5oGQtnrddsy12hZVR4lPq
	hUBmCgOuzqkT8QIEvSpK5V4w00PfcHcBvnJ/4mxBB7rREo/t3RbJlYSgzSNt9DngV/bp0J8CCZ2
	fJaLrddqAtyjjUX9v/tioc3Diczts0PX4nubnvLyyg04XQ21bjENsnhUynyN6AhW2F0u
X-Received: by 2002:a17:90b:3148:b0:3b3:cab4:5060 with SMTP id 98e67ed59e1d1-3b41c8ffa9fmr10353009a91.17.1795430956275;
        Mon, 23 Nov 2026 02:49:16 -0800 (PST)
Received: from KASONG-MC4 ([114.254.2.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm17613203a91.9.2026.11.23.02.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:49:15 -0800 (PST)
Date: Mon, 23 Nov 2026 18:48:54 +0800
From: Kairui Song <ryncsn@gmail.com>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, Gregory Price <gourry@gourry.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Hugh Dickins <hughd@google.com>, SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, 
	Yu Zhao <yuzhao@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	Zicheng Wang <wangzicheng@honor.com>, Chen Ridong <chenridong@xiaomi.com>, 
	Tal Zussman <tz2294@columbia.edu>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 16/17] mm/mglru: make folio_inc_lru_refs lruvec
 lockless
Message-ID: <awQTdkOPG_bKkY1a@KASONG-MC4>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-16-9eee2fe97a2d@tencent.com>
 <CAN_Opa-+nb0vxQ+HsENCG2fEEMZoxG9Sy_DBC4CLkWjNLzDWKw@mail.gmail.com>
 <CAMgjq7CEdWvv8m9GtWMG=8OFy+1Sehx3HBJt2D=9hntwvfbf6w@mail.gmail.com>
 <CAN_Opa8L3Ygfu5o7Y8ZD9GTmiEygCXpq2TzAJtwgQChdyb2dSQ@mail.gmail.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa8L3Ygfu5o7Y8ZD9GTmiEygCXpq2TzAJtwgQChdyb2dSQ@mail.gmail.com>

On Mon, Nov 23, 2026 at 09:43:12AM +0800, KunWu Chan wrote:
> On Sun, Nov 22, 2026 at 11:33 PM Kairui Song <ryncsn@gmail.com> wrote:
> >
> > On Fri, Nov 20, 2026 at 5:42 PM KunWu Chan <kunwu.chan@gmail.com> wrote:
> > >
> > > On Thu, Nov 19, 2026 at 5:04 AM Kairui Song via B4 Relay
> > > <devnull+kasong.tencent.com@kernel.org> wrote:
> > > >
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > The lruvec spinlock in folio_inc_lru_refs was only taken to keep
> > > > concurrent aging from corrupting the size counters.  This is no
> > > > longer needed: the per-generation counters are atomic, and the
> > > > active/inactive ABI counters are updated per folio and linearized by
> > > > the CAS on the folio flags, so concurrent aging can no longer corrupt
> > > > them.  The same argument is what lets folio_reset_lru_refs() update
> > > > the counters without the lruvec lock.
> > > >
> > > > Use folio_lruvec_live_get()/folio_lruvec_live_put() to hold the RCU
> > > > read lock around the lruvec lookup, and drop the spinlock entirely.
> > > >
> > > > Without the lock, aging can advance max_seq while a promotion is in
> > > > flight.  Generations are indexed by seq % MAX_NR_GENS, so the folio
> > > > flags can return to the value read earlier and the cmpxchg succeeds
> > > > with a target gen computed from a stale max_seq.  Recheck max_seq after
> > > > a gen-changing cmpxchg: if it moved, account the committed update and
> > > > retry with LRU_REF_FORCE, which promotes the folio to the newest gen.
> > > > The retry may count the access twice, which is acceptable and avoids
> > > > folio_activate(), whose LRU lock causes latency jitter.  smp_rmb()
> > > > orders the flags read, including the one returned by a failed
> > > > cmpxchg(), before the max_seq read.
> > > >
> > > > Also simplify the post-CAS accounting guards: gen is only assigned
> > > > non-negative values after the old_gen < 0 early exit, so gen != old_gen
> > > > implies gen >= 0, and lru_gen_update_size() needs no explicit guard.
> > > > The active/inactive ABI update keeps its gen >= 0 check because an
> > > > off-LRU folio has no lruvec to update.
> > > >
> > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > ---
> > > >  include/linux/mm_inline.h | 10 +++++-----
> > > >  include/linux/mmzone.h    |  3 ++-
> > > >  mm/vmscan.c               | 51 +++++++++++++++++++++++++++++------------------
> > > >  3 files changed, 39 insertions(+), 25 deletions(-)
> > > >
> > > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > > index 77f514143266..2c6cbd0df686 100644
> > > > --- a/include/linux/mm_inline.h
> > > > +++ b/include/linux/mm_inline.h
> > > > @@ -317,10 +317,9 @@ static inline bool lru_gen_is_old(struct lruvec *lruvec, int type, int gen)
> > > >                gen == lru_gen_from_seq(min_seq + 1);
> > > >  }
> > > >
> > > > -static inline void lru_gen_update_size(struct lruvec *lruvec, struct folio *folio,
> > > > -                                      int old_gen, int new_gen)
> > > > +static inline void lru_gen_update_size(struct lruvec *lruvec, int type,
> > > > +                                      struct folio *folio, int old_gen, int new_gen)
> > > >  {
> > > > -       int type = folio_is_file_lru(folio);
> > > >         int zone = folio_zonenum(folio);
> > > >         int delta = folio_nr_pages(folio);
> > > >         struct lru_gen_folio *lrugen = &lruvec->lrugen;
> > > > @@ -399,7 +398,7 @@ static inline bool __lru_gen_add_folio(struct lruvec *lruvec, struct folio *foli
> > > >         /* use the refs from the atomic snapshot to avoid raced update */
> > > >         refs = lru_get_refs_flags(flags);
> > > >
> > > > -       lru_gen_update_size(lruvec, folio, -1, gen);
> > > > +       lru_gen_update_size(lruvec, type, folio, -1, gen);
> > > >         if (lru_refs_is_active(refs))
> > > >                 lru += LRU_ACTIVE;
> > > >         __update_lru_size(lruvec, lru, zone, delta);
> > > > @@ -429,6 +428,7 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
> > > >         unsigned long flags;
> > > >         unsigned int refs;
> > > >         int gen;
> > > > +       int type = folio_is_file_lru(folio);
> > > >         int zone = folio_zonenum(folio);
> > > >         int delta = folio_nr_pages(folio);
> > > >         enum lru_list lru = folio_is_file_lru(folio) * LRU_INACTIVE_FILE;
> > > > @@ -452,7 +452,7 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
> > > >         if (!reclaiming && ((max_seq - gen) % MAX_NR_GENS) < MIN_NR_GENS)
> > > >                 folio_set_active(folio);
> > > >
> > > > -       lru_gen_update_size(lruvec, folio, gen, -1);
> > > > +       lru_gen_update_size(lruvec, type, folio, gen, -1);
> > > >         if (lru_refs_is_active(refs))
> > > >                 lru += LRU_ACTIVE;
> > > >         __update_lru_size(lruvec, lru, zone, -delta);
> > > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > > index 2680e15b6de9..235fb04f8d78 100644
> > > > --- a/include/linux/mmzone.h
> > > > +++ b/include/linux/mmzone.h
> > > > @@ -540,9 +540,10 @@ enum lruvec_flags {
> > > >  #define LRU_TIER_MIN           0U
> > > >  #define LRU_TIER_MAX           (MAX_NR_TIERS - 1)
> > > >
> > > > -/* Access source flags for folio_inc_lru_refs() */
> > > > +/* Flags for folio_inc_lru_refs() */
> > > >  #define LRU_REF_MAPPED         0x1U
> > > >  #define LRU_REF_EXEC           0x2U
> > > > +#define LRU_REF_FORCE          0x4U
> > > >
> > > >  #define LRU_REFS_REFERENCED    0x1
> > > >  #define LRU_REFS_WORKINGSET    0x2
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index 78a1b4de7076..4576a7a369e3 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -876,37 +876,35 @@ void folio_inc_lru_refs(struct folio *folio, unsigned int flags)
> > > >         long nr_pages = folio_nr_pages(folio);
> > > >         struct lru_gen_folio *lrugen;
> > > >         struct lruvec *lruvec = NULL;
> > > > +       bool aged = false;
> > > >
> > > > +retry:
> > > >         old_flags = READ_ONCE(*folio_flags(folio, 0));
> > > >         do {
> > > >                 new_flags = old_flags;
> > > >                 old_gen = lru_get_gen_flags(old_flags);
> > > >                 old_refs = lru_get_refs_flags(old_flags);
> > > > -               file = folio_flags_is_file_lru(&old_flags);
> > > >                 refs = old_refs + 1;
> > > >                 gen = old_gen;
> > > > +               file = folio_flags_is_file_lru(&old_flags);
> > > >                 if (old_gen < 0)
> > > >                         goto out;
> > > > -               /*
> > > > -                * Lock the lruvec if the folio is on-list. We are already
> > > > -                * doing lazy promotion so in theory we don't need this,
> > > > -                * but for now, concurrent aging would still corrupt the
> > > > -                * size counters.  This is a temporary limitation and
> > > > -                * will be lifted very soon, so the lock here is not a
> > > > -                * performance concern.
> > > > -                */
> > > >                 if (!lruvec) {
> > > > -                       lruvec = lruvec_live_lock_irq(folio_lruvec(folio));
> > > > +                       lruvec = folio_lruvec_live_get(folio);
> > > >                         lrugen = &lruvec->lrugen;
> > > >                 }
> > > > +               /*
> > > > +                * Read the flags before max_seq, paired with the store of a
> > > > +                * gen, which samples max_seq first.
> > > > +                */
> > > > +               smp_rmb();
> > > >                 max_seq = READ_ONCE(lrugen->max_seq);
> > > >                 max_gen = lru_gen_from_seq(max_seq);
> > > >                 if (old_gen == max_gen)
> > > >                         goto out;
> > > > -
> > > > -               if (flags & (LRU_REF_MAPPED | LRU_REF_EXEC)) {
> > > > -                       /* Promote second page table access or executable */
> > > > -                       if (refs > LRU_REFS_REFERENCED || flags & LRU_REF_EXEC)
> > > > +               if (flags & (LRU_REF_MAPPED | LRU_REF_EXEC | LRU_REF_FORCE)) {
> > > > +                       if (lru_refs_is_workingset(refs) ||
> > > > +                           flags & (LRU_REF_EXEC | LRU_REF_FORCE))
> > > >                                 gen = max_gen;
> > > >                         /* First access only defers eviction of an old generation */
> > > >                         else if (lru_gen_is_old(lruvec, file, old_gen))
> > > > @@ -931,9 +929,19 @@ void folio_inc_lru_refs(struct folio *folio, unsigned int flags)
> > > >                         break;
> > > >         } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));
> > > >
> > > > -       if (gen != old_gen)
> > > > -               lru_gen_update_size(lruvec, folio, old_gen, gen);
> > > > -       if (lru_refs_is_active(old_refs) != lru_refs_is_active(refs) && old_gen >= 0) {
> > > > +       if (gen != old_gen) {
> > > > +               /*
> > > > +                * Gen-index reuse can fool cmpxchg(). Retry locklessly, accepting
> > > > +                * an extra reference to avoid folio_activate() latency.
> > > > +                */
> > > > +               if (unlikely(READ_ONCE(lrugen->max_seq) != max_seq)) {
> > > > +                       flags = LRU_REF_FORCE;
> > > > +                       aged = true;
> > > > +               }
> > > > +               lru_gen_update_size(lruvec, file, folio, old_gen, gen);
> > > > +       }
> > > > +
> > > > +       if (lru_refs_is_active(old_refs) != lru_refs_is_active(refs) && gen >= 0) {
> > > >                 enum lru_list lru = file * LRU_INACTIVE_FILE;
> > > >
> > > >                 __update_lru_size(lruvec, lru + lru_refs_is_active(old_refs),
> > > > @@ -941,8 +949,12 @@ void folio_inc_lru_refs(struct folio *folio, unsigned int flags)
> > > >                 __update_lru_size(lruvec, lru + lru_refs_is_active(refs),
> > > >                                   folio_zonenum(folio), nr_pages);
> > >
> > > Could this leave the parent's local active count too high?
> > > Isolation can debit the child's active count after the refs
> > > 2 -> 3 CAS. If CSS_DYING is set before the stats update, the credit
> > > can go to the parent. On SMP, reparenting can clamp the child's
> > > negative local count to zero.
> >
> > Thanks again for the careful review.
> >
> > But hmm, I'm not sure what you mean by "too high". Maybe there is a
> > temporary skew of counter due to various races, but we are fine with
> > that, it will be consistent soon.
> >
> > The key here is update is gated on gen >= 0, and the gen is part of
> > the CAS: only a folio that is actually on an MGLRU list has its
> > refs-based active/inactive credit already accounted will be recredit
> > the counter update here. An isolated folio has no lruvec to attribute
> > it to, so nothing will be changed.
> >
> > And for reparenting, we are also following the ordering in the
> > document: the updater holds rcu_read_lock() over the lruvec lookup and
> > the counter update, and reparenting waits for a grace period, so
> > either the memcg is already dying and we credit the parent, or the
> > update lands on the child and is part of what reparenting moves
> > afterwards.
> >
> > So the credit and the reparent move always cover the same folios and
> > land on the same side: there is no path where the parent is credited
> > for a folio it does not end up owning, and no debit that lands where
> > the credit did not. I don't see anything to fix here.
> 
> Thanks for explaining, Kairui. I had isolation after the CAS in
> mind, before the stats path rechecks CSS_DYING. I'm happy to leave
> that for a follow-up.

Hi Kunwu, thanks for review!

I thought again about this, and, there seems to be a corner case I didn't
notice, sorry I missed that. The reparenting used the clamped value, so
if the child's counter goes nagative due to temporary race, we will
indeed lost that part, and this should fix that, I'll include this as
a stand alone patch with your reported by:

(Usually we won't hit this unless the memcg have only a few folios left
 and raced with repanrting, and I think using clamped value for
 reparenting is correct on its own)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 091401cecf39..3f551e2e3206 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -562,11 +562,10 @@ unsigned long lruvec_page_state_monotonic(const struct lruvec *lruvec,
 	return (unsigned long)READ_ONCE(pn->lruvec_stats->state[i]);
 }
 
-unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
+static long __lruvec_page_state_local(const struct lruvec *lruvec,
 				      enum node_stat_item idx)
 {
 	const struct mem_cgroup_per_node *pn;
-	long x;
 	int i;
 
 	if (mem_cgroup_disabled())
@@ -577,7 +576,14 @@ unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
 		return 0;
 
 	pn = container_of_const(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = READ_ONCE(pn->lruvec_stats->state_local[i]);
+	return READ_ONCE(pn->lruvec_stats->state_local[i]);
+}
+
+unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
+				      enum node_stat_item idx)
+{
+	long x = __lruvec_page_state_local(lruvec, idx);
+
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -595,7 +601,8 @@ void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
 
 	for_each_node(nid) {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
-		unsigned long value = lruvec_page_state_local(lruvec, idx);
+		/* Reparent the raw value: the clamp drops the child's debit. */
+		long value = __lruvec_page_state_local(lruvec, idx);
 
 		__mod_memcg_lruvec_state(memcg, nid, idx, -value);
 		__mod_memcg_lruvec_state(parent, nid, idx, value);

> 
> Here's my tag for 16/17, also sent in the 15/17 thread.
> 
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks, will be glad if you can help look at the updated v6 later too :D

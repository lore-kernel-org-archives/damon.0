Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844514CACB
	for <damon@lists.linux.dev>; Fri, 23 Feb 2024 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726851; cv=none; b=kSZ4afvgcg4Ay6MV2s657Uok6s1jxGEicrD6qZ0qR0TD3RIflir/TkcMXPdW0/g0f38Ia6Kf70OEJRhKmgY8LknE8KhgZTwEPfgLMRmaEwOwoEInoRgovLeUTaWqTx/vMqvmn7rzdffeNtp6OdRUyEjHF/iR8b75i0QeKHsygNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726851; c=relaxed/simple;
	bh=2ewFfHqwslPMlbxM+1sLeqdGacpFDMTN+m47JT4rxhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrJ+gAynG6dardQLF2sCLz+eVZXcI0qnuQunGMk0mHXyaDSnqWDYY5ZVXapujwMaoklQwP2eMhz5TUrXqynjZX7Ku/ereiSHJ1tQN6lQOigLdBIjOLR2CD1d5fN+0DsOXzjOxZPxh0HIudkRtEL2bsLisHE5jDjDeawq9wtE04Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eByTm6Ae; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eByTm6Ae"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso750645241.2
        for <damon@lists.linux.dev>; Fri, 23 Feb 2024 14:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708726848; x=1709331648; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tnf0UCnczzqZkJrcJnLBW756ktsgx2tF5puvvkvbzc=;
        b=eByTm6Aee2ZJp+uGN0L69Ua5hGxSz2ykGA+u434oslVO4qxSt5plfc+fOiPArYPcAY
         0lKi7NOfxguHzMoqniEWpBJo+VTvCwRTzoHbVDMdTjfLlKxpE+o1bDMXhpx0Nc+HaCKJ
         hKWmExIoi3cDi6T8kxEL4IEnbAXxM4T0rYknQyiG1UFeixUpf1QdIQlB+3PSPAbCOj3j
         mM8SZ4DWrqK+ZGfc/0T1pECDvEpowk47SypBi2qLsAztKsFhkK/b9xpskiSWDBxMok5u
         wm8iTzmddYVM7OMEVVN2IN+KV2+rZnodPbqmXG97E/xcr6zbVp9wAkwb6m78dPMFoExd
         joEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726848; x=1709331648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tnf0UCnczzqZkJrcJnLBW756ktsgx2tF5puvvkvbzc=;
        b=uJ7dPKUC6nAO+kUPTHZhMCP4Qz7kLMKgjkXZszvoZPz8g+uvrrQ6/VnjGf+L6ffvhB
         OtJcWBxy7r3RsAadrGT1cJJxEv3fojdFckZYvxkwzD7GcBAM9HvT2zQCwGWcH3qwMMDg
         ML92+oB1upXJS9rpb+Str1Jlwe5+xmuZXkfJsISKL/gahBq67pOt8mPyZoZtXvpEt34y
         6nsXuSlKPRriryFMU2njVuYHngk3ZYCCNIYc6G3HV9qJs1afBLKDHMEPbMve4ctESYjh
         XWeyYYO24pdr3SmTpFtnvAAjl7PHWQIo4Tf8aYVngYlIHIGRQtunJtgijeMhbVCYIERK
         bnTA==
X-Forwarded-Encrypted: i=1; AJvYcCVly08HPb87NYcPsBYW30tDMj7ifhr4VAgCIPqpQGuYT9SqU+iPF3ixMnBx2cA2WuW0CjrbB8jGHcB4wq/KW4+MMJSnc4I=
X-Gm-Message-State: AOJu0YyaJDBnE1KKNg+9p3wKltFdl0SnPgp6qGAY4yw1p5OanPcgsQOA
	/OMCVYYNF3Oo8uWbq5FNAdpT/HbOJhF8c2ClXtYwW+/+BosybgKdCjf2TFhjXSiXnXRHkRYGKFI
	xWT7TRMVJ/lLzZlUTqDK3B4i1eiE=
X-Google-Smtp-Source: AGHT+IEiiRffkuV3Tls4JY0NY5ew2NENgDZ86ddM/QxqIYcfgucw/QBar9EBLUhesx3Qketwm+17dagWsta+mWFLke4=
X-Received: by 2002:a05:6102:3964:b0:471:54c:81dd with SMTP id
 ho4-20020a056102396400b00471054c81ddmr1151432vsb.17.1708726847671; Fri, 23
 Feb 2024 14:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240223041550.77157-1-21cnbao@gmail.com> <ZdkXpcAB6xWj2geh@google.com>
In-Reply-To: <ZdkXpcAB6xWj2geh@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 24 Feb 2024 11:20:36 +1300
Message-ID: <CAGsJ_4zPVNcP-7YQ8wkxmZu0xLkaQ-hyh98Ot0+RpyXm9o1krQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
To: Minchan Kim <minchan@kernel.org>
Cc: sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	hannes@cmpxchg.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 11:09=E2=80=AFAM Minchan Kim <minchan@kernel.org> w=
rote:
>
> Hi Barry,
>
> On Fri, Feb 23, 2024 at 05:15:50PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > While doing MADV_PAGEOUT, the current code will clear PTE young
> > so that vmscan won't read young flags to allow the reclamation
> > of madvised folios to go ahead.
>
> Isn't it good to accelerate reclaiming? vmscan checks whether the
> page was accessed recenlty by the young bit from pte and if it is,
> it doesn't reclaim the page. Since we have cleared the young bit
> in pte in madvise_pageout, vmscan is likely to reclaim the page
> since it wouldn't see the ferencecd_ptes from folio_check_references.

right, but the proposal is asking vmscan to skip the folio_check_references
if this is a PAGEOUT. so we remove both pte_clear_young and rmap
of folio_check_references.

>
> Could you clarify if I miss something here?

guest you missed we are skipping folio_check_references now.
we remove both, thus, make MADV_PAGEOUT 6% faster.

>
>
> > It seems we can do it by directly ignoring references, thus we
> > can remove tlb flush in madvise and rmap overhead in vmscan.
> >
> > Regarding the side effect, in the original code, if a parallel
> > thread runs side by side to access the madvised memory with the
> > thread doing madvise, folios will get a chance to be re-activated
> > by vmscan. But with the patch, they will still be reclaimed. But
> > this behaviour doing PAGEOUT and doing access at the same time is
> > quite silly like DoS. So probably, we don't need to care.
> >
> > A microbench as below has shown 6% decrement on the latency of
> > MADV_PAGEOUT,
> >
> >  #define PGSIZE 4096
> >  main()
> >  {
> >       int i;
> >  #define SIZE 512*1024*1024
> >       volatile long *p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> >                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >
> >       for (i =3D 0; i < SIZE/sizeof(long); i +=3D PGSIZE / sizeof(long)=
)
> >               p[i] =3D  0x11;
> >
> >       madvise(p, SIZE, MADV_PAGEOUT);
> >  }
> >
> > w/o patch                    w/ patch
> > root@10:~# time ./a.out      root@10:~# time ./a.out
> > real  0m49.634s            real   0m46.334s
> > user  0m0.637s             user   0m0.648s
> > sys   0m47.434s            sys    0m44.265s
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/damon/paddr.c |  2 +-
> >  mm/internal.h    |  2 +-
> >  mm/madvise.c     |  8 ++++----
> >  mm/vmscan.c      | 12 +++++++-----
> >  4 files changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 081e2a325778..5e6dc312072c 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -249,7 +249,7 @@ static unsigned long damon_pa_pageout(struct damon_=
region *r, struct damos *s)
> >  put_folio:
> >               folio_put(folio);
> >       }
> > -     applied =3D reclaim_pages(&folio_list);
> > +     applied =3D reclaim_pages(&folio_list, false);
> >       cond_resched();
> >       return applied * PAGE_SIZE;
> >  }
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 93e229112045..36c11ea41f47 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -868,7 +868,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(st=
ruct file *, unsigned long,
> >          unsigned long, unsigned long);
> >
> >  extern void set_pageblock_order(void);
> > -unsigned long reclaim_pages(struct list_head *folio_list);
> > +unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_=
references);
> >  unsigned int reclaim_clean_pages_from_list(struct zone *zone,
> >                                           struct list_head *folio_list)=
;
> >  /* The ALLOC_WMARK bits are used as an index to zone->watermark */
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index abde3edb04f0..44a498c94158 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -386,7 +386,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
> >                       return 0;
> >               }
> >
> > -             if (pmd_young(orig_pmd)) {
> > +             if (!pageout && pmd_young(orig_pmd)) {
> >                       pmdp_invalidate(vma, addr, pmd);
> >                       orig_pmd =3D pmd_mkold(orig_pmd);
> >
> > @@ -410,7 +410,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
> >  huge_unlock:
> >               spin_unlock(ptl);
> >               if (pageout)
> > -                     reclaim_pages(&folio_list);
> > +                     reclaim_pages(&folio_list, true);
> >               return 0;
> >       }
> >
> > @@ -490,7 +490,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
> >
> >               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >
> > -             if (pte_young(ptent)) {
> > +             if (!pageout && pte_young(ptent)) {
> >                       ptent =3D ptep_get_and_clear_full(mm, addr, pte,
> >                                                       tlb->fullmm);
> >                       ptent =3D pte_mkold(ptent);
> > @@ -524,7 +524,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
> >               pte_unmap_unlock(start_pte, ptl);
> >       }
> >       if (pageout)
> > -             reclaim_pages(&folio_list);
> > +             reclaim_pages(&folio_list, true);
> >       cond_resched();
> >
> >       return 0;
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 402c290fbf5a..ba2f37f46a73 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2102,7 +2102,8 @@ static void shrink_active_list(unsigned long nr_t=
o_scan,
> >  }
> >
> >  static unsigned int reclaim_folio_list(struct list_head *folio_list,
> > -                                   struct pglist_data *pgdat)
> > +                                   struct pglist_data *pgdat,
> > +                                   bool ignore_references)
> >  {
> >       struct reclaim_stat dummy_stat;
> >       unsigned int nr_reclaimed;
> > @@ -2115,7 +2116,7 @@ static unsigned int reclaim_folio_list(struct lis=
t_head *folio_list,
> >               .no_demotion =3D 1,
> >       };
> >
> > -     nr_reclaimed =3D shrink_folio_list(folio_list, pgdat, &sc, &dummy=
_stat, false);
> > +     nr_reclaimed =3D shrink_folio_list(folio_list, pgdat, &sc, &dummy=
_stat, ignore_references);
> >       while (!list_empty(folio_list)) {
> >               folio =3D lru_to_folio(folio_list);
> >               list_del(&folio->lru);
> > @@ -2125,7 +2126,7 @@ static unsigned int reclaim_folio_list(struct lis=
t_head *folio_list,
> >       return nr_reclaimed;
> >  }
> >
> > -unsigned long reclaim_pages(struct list_head *folio_list)
> > +unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_=
references)
> >  {
> >       int nid;
> >       unsigned int nr_reclaimed =3D 0;
> > @@ -2147,11 +2148,12 @@ unsigned long reclaim_pages(struct list_head *f=
olio_list)
> >                       continue;
> >               }
> >
> > -             nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, NO=
DE_DATA(nid));
> > +             nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, NO=
DE_DATA(nid),
> > +                                                ignore_references);
> >               nid =3D folio_nid(lru_to_folio(folio_list));
> >       } while (!list_empty(folio_list));
> >
> > -     nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, NODE_DATA(=
nid));
> > +     nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, NODE_DATA(=
nid), ignore_references);
> >
> >       memalloc_noreclaim_restore(noreclaim_flag);
> >
> > --
> > 2.34.1
> >

Thanks
Barry

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795398207;
	b=CUdkXp/1radii8cL+1JBEpMb67568MSW2KNQ2KW9XpRTQ/xgVF2AEcSzTem8yG8kJD0p
	 JJ7U3iGVXlahR76W+XprJ9Nqi0AetSsgiMNy/3f9MmSIjtVsWIb4f3tVFLArtEcxtpcUr
	 eUfLvLNvUb12eJLqWxkfuuACUB1QnnQJ9iThea/syHM02vwjKH1fn+2Uglrv12Lk4BGkx
	 C1FKLO+7fmO8tZTOrkr5DdWk2U81ZtbPy4HXmzjWr1ZXvrMGdgfzCJVOe+ltWFMfiisZH
	 hmALwpV9cHBa5xPKg0sz7HH4hp20Vx0LWiYKRnAdvqVb3QzakWto5QJJVxTEl6qihxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BrVQwSIPnVhHdrsgKZy8tODX9WT1tDuIYLyA3zVqg3w=;
	b=xrWmArqvL5Nb8rJfvdW/P5Pl+C6XKB8BFfKZ0yQ+1FYclcvkij5fPB9CYJ/b5LRvx4LO
	 JvexKjAYJSuGELFvtglyuutZTRu3JyWTq6a3xyDfjxAtu0hEpPt3NTmTZvciDQLqw36XO
	 K4wMcXuSN96X/RQFVCVJYRT6TUncOTSk/f7bKyfX/6NuMpl16NYU5Pa7v1W1p1OiHxPtJ
	 nuiiGTJoXS6BMZZab5VNoBN9KykudIf0C7HvsIoRNVwzRHmjHQZ8AH4xeIaNxtmyqu9Bm
	 mCZm+s6EBFxN4xWDSI3lIoZfSBaiXHXeFfv6CBq6w/q7z74Iqam3Gs+raqPWWIRbQDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fURxZWFb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B0606A320
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 01:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 811B0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fURxZWFb
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb606491faso15019205e9.3
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 17:43:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795398205; cv=none;
        d=google.com; s=arc-20260327;
        b=Yu3NT845fSwJDU7bkAeI0KyTa8mbEXpaHdDMhcrAzIlBIDRncxnR0zK9uXrFH86N5q
         goaBtiwzvKwnGx+2gaJysDkc/WdXY6x4mQK/uqQbIwESmaSYkclafvpGYAYPyG75PvXT
         7Nba5IMi9efMz3lMZF+vNZCJ4H7wKNg+RrJm+M7yKTRhSNoHjatNvuh6Y7aqwqyuIK13
         JtSjnaM+Tw2VhQ1daUhsqOQDfmRyhw3BLz8pS8z5jlXgJdRQyBQvjcfiyUUQHloTng3h
         OGJtv/HIayeCWEMyRiGxQBGvAxjqLksk9w+UOH0GWlPIOTR1gR4A5AWkvKF7vXJOBjh2
         DN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BrVQwSIPnVhHdrsgKZy8tODX9WT1tDuIYLyA3zVqg3w=;
        fh=IBGU6hlw11hwzUIXcQZxI9/EYUw0t87Rn62MJzicuO8=;
        b=j50VQw8N6qWQF98JPqZNZQoIIGM0DCTKvuqdUstWN31m/+ApEGoVUKu6JAGMLuA1pz
         QyIuzLNoPpCEqBFMdVPlKnTGtGj43cvbgOx2GBIOwOLawe7e8JLYodho9Fo8hdAc/Gut
         Y8z5aQDAGXxQEC9Rc8wYG4yj1JMJ3tJOncUSpzw4zFs265LosJbGsx7fDCy2/6nOh453
         1GB1SFLsREg6+Q3Y9JcyX8FFl5X+gCjl5E3K3Ic3fNbqfzeuQFGiD35YsRMCgVdnj20y
         JJmaTK3zoQkE4bS8sY+ZN7xLp0NvCdOu0wnvgP5DFylW+tKWBsz+koDUCDSrt2CBovX2
         Rvnw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795398205; x=1796003005; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrVQwSIPnVhHdrsgKZy8tODX9WT1tDuIYLyA3zVqg3w=;
        b=fURxZWFbKyfcGnbiDqgtW4oAbGG5chXx0ox/o7AiQU4pxI5GWmZaCmDKSxS99HiYAv
         1MQxTz6qNjjILMYrnO3mQG/M4iHK5McCJ8WcOBMpIyFm0CFlwOFuR4Untz44CTwHfx1y
         unhleguGt7ptwW9eHVSmAmIGuqaIIACmNkYbHzRreu+TIVDGdRFdZgX2Mhfqhk6C3+A2
         5qfN8tHio9yIY0goR9nYizRg2da3gYm0LTdmqg03HWOjUjS1t6rLZuF6g0qfWDPiRX6G
         QISOkseJa6lkAVAFk364rIbNerXFKuUaUluFkLGUglfmcuPDwMEuBCViccKz3o67Vnnk
         dmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795398205; x=1796003005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrVQwSIPnVhHdrsgKZy8tODX9WT1tDuIYLyA3zVqg3w=;
        b=tKkFm4hyWBmgCm+DwqdjPVy89xW8WMW11cqOfEvETJBBEpHYXYEYm4sn6BbvLTbkhI
         JyFA/yIeW7vivMWdQWgxTYlPDPLyk4wdbRCL+REmglZFxeq8dWGJQdnq4y/hKmILxIBZ
         UobJU0cF3zBEI5tNiRnphppFcjaD9HNVtm2g2Jy0OQkQJvcQdjfikSkOXelPk/3WBo5X
         DMO6xaxabKbPhjIfuPQ47RfMpzzfhdtDlk6F/0gUYxcRUZ8t+E0lsOOBFKDYGWn/VjZy
         bHzocj1PpgQ7tzETGycfCZU2FDwAu5EL3IMX/l/Ons/TvDn+3kSh4ixV0NapJCuoNb8w
         wwFA==
X-Forwarded-Encrypted: i=1; AL+hErFwcp39b0Bwcxr9aSf+g+upommDu4dLr4XXRZ2F+QZcDtuVvnT/4URcF+Lbp2Ljt7aUA1o1Zg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8jOJlQvVetjgxQo8yQ+kz1kyOtAIEUKr/6CLD1WRx23suGeuoy
	LumqXrBij8yCYTWHKIsZRKI3eo8+zC6ouQp7wskH1YKbFgbqbkaeeSpwEo34Px5khxPuAe3bMfj
	goWaBvp5ARnEMKe2jQ2FPVuztguvmihc=
X-Gm-Gg: AZFdTZedk8J6s0LBBVDU3TjMx22XD7f0ahtOVcFimPF4LT5U+PhiisRsU4d74+ctNXu
	IKjvBViNz55k61hwxNB5U/hr2RfzQend0YjCclXKFjREvXuEsSEG+IZHuh9b7XjOyNDfwNfV578
	G/X0+fuhxWbgGqPmZZCdJDNsOz7ftZ9KJlWzggiVGOa1pHjU+wet+qWYNl+QpdhNT5F6Vx6gQZq
	FjBY9/hp7VliU2u9+oQcucj5sDMEOYKIx1Whm/RWO18ViZV04G8SHbeQIhXpE5SniARSKmOh0My
	ENiHAYJOEjQzKxp/emkYCh9aWLcdOxFA0nD7vpld0btoH0pCPw5qbc5WpGckb+Bz7vGt8tbtqjS
	4GaJYMoSpn85ooiiL26aLrdZh5+mNR/j40fTCp1xs4WKMgEC/Aey/uMrYPw2bjdQ4CTId1dTO9W
	MmkVVRSVhnlWGqEDv3Oun+kayggh5ZglBovBpcFi4yoWRifO68jAL6rZboMEqywK8TPw6onGimq
	g==
X-Received: by 2002:a05:600c:8b11:b0:4bb:6871:8f21 with SMTP id
 5b1f17b1804b1-4bb88822346mr213653915e9.23.1795398204221; Sun, 22 Nov 2026
 17:43:24 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-16-9eee2fe97a2d@tencent.com> <CAN_Opa-+nb0vxQ+HsENCG2fEEMZoxG9Sy_DBC4CLkWjNLzDWKw@mail.gmail.com>
 <CAMgjq7CEdWvv8m9GtWMG=8OFy+1Sehx3HBJt2D=9hntwvfbf6w@mail.gmail.com>
In-Reply-To: <CAMgjq7CEdWvv8m9GtWMG=8OFy+1Sehx3HBJt2D=9hntwvfbf6w@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 23 Nov 2026 09:43:12 +0800
X-Gm-Features: Aa3M54oNBYyw9pCyIXqZNWTI0hkUvgld-jGgCS21qlijWr31Z0q9q7Y9XszeYmQ
Message-ID: <CAN_Opa8L3Ygfu5o7Y8ZD9GTmiEygCXpq2TzAJtwgQChdyb2dSQ@mail.gmail.com>
Subject: Re: [PATCH v5 16/17] mm/mglru: make folio_inc_lru_refs lruvec lockless
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Chen Ridong <chenridong@xiaomi.com>, Tal Zussman <tz2294@columbia.edu>, 
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 11:33=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Fri, Nov 20, 2026 at 5:42=E2=80=AFPM KunWu Chan <kunwu.chan@gmail.com>=
 wrote:
> >
> > On Thu, Nov 19, 2026 at 5:04=E2=80=AFAM Kairui Song via B4 Relay
> > <devnull+kasong.tencent.com@kernel.org> wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > The lruvec spinlock in folio_inc_lru_refs was only taken to keep
> > > concurrent aging from corrupting the size counters.  This is no
> > > longer needed: the per-generation counters are atomic, and the
> > > active/inactive ABI counters are updated per folio and linearized by
> > > the CAS on the folio flags, so concurrent aging can no longer corrupt
> > > them.  The same argument is what lets folio_reset_lru_refs() update
> > > the counters without the lruvec lock.
> > >
> > > Use folio_lruvec_live_get()/folio_lruvec_live_put() to hold the RCU
> > > read lock around the lruvec lookup, and drop the spinlock entirely.
> > >
> > > Without the lock, aging can advance max_seq while a promotion is in
> > > flight.  Generations are indexed by seq % MAX_NR_GENS, so the folio
> > > flags can return to the value read earlier and the cmpxchg succeeds
> > > with a target gen computed from a stale max_seq.  Recheck max_seq aft=
er
> > > a gen-changing cmpxchg: if it moved, account the committed update and
> > > retry with LRU_REF_FORCE, which promotes the folio to the newest gen.
> > > The retry may count the access twice, which is acceptable and avoids
> > > folio_activate(), whose LRU lock causes latency jitter.  smp_rmb()
> > > orders the flags read, including the one returned by a failed
> > > cmpxchg(), before the max_seq read.
> > >
> > > Also simplify the post-CAS accounting guards: gen is only assigned
> > > non-negative values after the old_gen < 0 early exit, so gen !=3D old=
_gen
> > > implies gen >=3D 0, and lru_gen_update_size() needs no explicit guard=
.
> > > The active/inactive ABI update keeps its gen >=3D 0 check because an
> > > off-LRU folio has no lruvec to update.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  include/linux/mm_inline.h | 10 +++++-----
> > >  include/linux/mmzone.h    |  3 ++-
> > >  mm/vmscan.c               | 51 +++++++++++++++++++++++++++++--------=
----------
> > >  3 files changed, 39 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > index 77f514143266..2c6cbd0df686 100644
> > > --- a/include/linux/mm_inline.h
> > > +++ b/include/linux/mm_inline.h
> > > @@ -317,10 +317,9 @@ static inline bool lru_gen_is_old(struct lruvec =
*lruvec, int type, int gen)
> > >                gen =3D=3D lru_gen_from_seq(min_seq + 1);
> > >  }
> > >
> > > -static inline void lru_gen_update_size(struct lruvec *lruvec, struct=
 folio *folio,
> > > -                                      int old_gen, int new_gen)
> > > +static inline void lru_gen_update_size(struct lruvec *lruvec, int ty=
pe,
> > > +                                      struct folio *folio, int old_g=
en, int new_gen)
> > >  {
> > > -       int type =3D folio_is_file_lru(folio);
> > >         int zone =3D folio_zonenum(folio);
> > >         int delta =3D folio_nr_pages(folio);
> > >         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> > > @@ -399,7 +398,7 @@ static inline bool __lru_gen_add_folio(struct lru=
vec *lruvec, struct folio *foli
> > >         /* use the refs from the atomic snapshot to avoid raced updat=
e */
> > >         refs =3D lru_get_refs_flags(flags);
> > >
> > > -       lru_gen_update_size(lruvec, folio, -1, gen);
> > > +       lru_gen_update_size(lruvec, type, folio, -1, gen);
> > >         if (lru_refs_is_active(refs))
> > >                 lru +=3D LRU_ACTIVE;
> > >         __update_lru_size(lruvec, lru, zone, delta);
> > > @@ -429,6 +428,7 @@ static inline bool lru_gen_del_folio(struct lruve=
c *lruvec, struct folio *folio,
> > >         unsigned long flags;
> > >         unsigned int refs;
> > >         int gen;
> > > +       int type =3D folio_is_file_lru(folio);
> > >         int zone =3D folio_zonenum(folio);
> > >         int delta =3D folio_nr_pages(folio);
> > >         enum lru_list lru =3D folio_is_file_lru(folio) * LRU_INACTIVE=
_FILE;
> > > @@ -452,7 +452,7 @@ static inline bool lru_gen_del_folio(struct lruve=
c *lruvec, struct folio *folio,
> > >         if (!reclaiming && ((max_seq - gen) % MAX_NR_GENS) < MIN_NR_G=
ENS)
> > >                 folio_set_active(folio);
> > >
> > > -       lru_gen_update_size(lruvec, folio, gen, -1);
> > > +       lru_gen_update_size(lruvec, type, folio, gen, -1);
> > >         if (lru_refs_is_active(refs))
> > >                 lru +=3D LRU_ACTIVE;
> > >         __update_lru_size(lruvec, lru, zone, -delta);
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index 2680e15b6de9..235fb04f8d78 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -540,9 +540,10 @@ enum lruvec_flags {
> > >  #define LRU_TIER_MIN           0U
> > >  #define LRU_TIER_MAX           (MAX_NR_TIERS - 1)
> > >
> > > -/* Access source flags for folio_inc_lru_refs() */
> > > +/* Flags for folio_inc_lru_refs() */
> > >  #define LRU_REF_MAPPED         0x1U
> > >  #define LRU_REF_EXEC           0x2U
> > > +#define LRU_REF_FORCE          0x4U
> > >
> > >  #define LRU_REFS_REFERENCED    0x1
> > >  #define LRU_REFS_WORKINGSET    0x2
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 78a1b4de7076..4576a7a369e3 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -876,37 +876,35 @@ void folio_inc_lru_refs(struct folio *folio, un=
signed int flags)
> > >         long nr_pages =3D folio_nr_pages(folio);
> > >         struct lru_gen_folio *lrugen;
> > >         struct lruvec *lruvec =3D NULL;
> > > +       bool aged =3D false;
> > >
> > > +retry:
> > >         old_flags =3D READ_ONCE(*folio_flags(folio, 0));
> > >         do {
> > >                 new_flags =3D old_flags;
> > >                 old_gen =3D lru_get_gen_flags(old_flags);
> > >                 old_refs =3D lru_get_refs_flags(old_flags);
> > > -               file =3D folio_flags_is_file_lru(&old_flags);
> > >                 refs =3D old_refs + 1;
> > >                 gen =3D old_gen;
> > > +               file =3D folio_flags_is_file_lru(&old_flags);
> > >                 if (old_gen < 0)
> > >                         goto out;
> > > -               /*
> > > -                * Lock the lruvec if the folio is on-list. We are al=
ready
> > > -                * doing lazy promotion so in theory we don't need th=
is,
> > > -                * but for now, concurrent aging would still corrupt =
the
> > > -                * size counters.  This is a temporary limitation and
> > > -                * will be lifted very soon, so the lock here is not =
a
> > > -                * performance concern.
> > > -                */
> > >                 if (!lruvec) {
> > > -                       lruvec =3D lruvec_live_lock_irq(folio_lruvec(=
folio));
> > > +                       lruvec =3D folio_lruvec_live_get(folio);
> > >                         lrugen =3D &lruvec->lrugen;
> > >                 }
> > > +               /*
> > > +                * Read the flags before max_seq, paired with the sto=
re of a
> > > +                * gen, which samples max_seq first.
> > > +                */
> > > +               smp_rmb();
> > >                 max_seq =3D READ_ONCE(lrugen->max_seq);
> > >                 max_gen =3D lru_gen_from_seq(max_seq);
> > >                 if (old_gen =3D=3D max_gen)
> > >                         goto out;
> > > -
> > > -               if (flags & (LRU_REF_MAPPED | LRU_REF_EXEC)) {
> > > -                       /* Promote second page table access or execut=
able */
> > > -                       if (refs > LRU_REFS_REFERENCED || flags & LRU=
_REF_EXEC)
> > > +               if (flags & (LRU_REF_MAPPED | LRU_REF_EXEC | LRU_REF_=
FORCE)) {
> > > +                       if (lru_refs_is_workingset(refs) ||
> > > +                           flags & (LRU_REF_EXEC | LRU_REF_FORCE))
> > >                                 gen =3D max_gen;
> > >                         /* First access only defers eviction of an ol=
d generation */
> > >                         else if (lru_gen_is_old(lruvec, file, old_gen=
))
> > > @@ -931,9 +929,19 @@ void folio_inc_lru_refs(struct folio *folio, uns=
igned int flags)
> > >                         break;
> > >         } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_=
flags));
> > >
> > > -       if (gen !=3D old_gen)
> > > -               lru_gen_update_size(lruvec, folio, old_gen, gen);
> > > -       if (lru_refs_is_active(old_refs) !=3D lru_refs_is_active(refs=
) && old_gen >=3D 0) {
> > > +       if (gen !=3D old_gen) {
> > > +               /*
> > > +                * Gen-index reuse can fool cmpxchg(). Retry lockless=
ly, accepting
> > > +                * an extra reference to avoid folio_activate() laten=
cy.
> > > +                */
> > > +               if (unlikely(READ_ONCE(lrugen->max_seq) !=3D max_seq)=
) {
> > > +                       flags =3D LRU_REF_FORCE;
> > > +                       aged =3D true;
> > > +               }
> > > +               lru_gen_update_size(lruvec, file, folio, old_gen, gen=
);
> > > +       }
> > > +
> > > +       if (lru_refs_is_active(old_refs) !=3D lru_refs_is_active(refs=
) && gen >=3D 0) {
> > >                 enum lru_list lru =3D file * LRU_INACTIVE_FILE;
> > >
> > >                 __update_lru_size(lruvec, lru + lru_refs_is_active(ol=
d_refs),
> > > @@ -941,8 +949,12 @@ void folio_inc_lru_refs(struct folio *folio, uns=
igned int flags)
> > >                 __update_lru_size(lruvec, lru + lru_refs_is_active(re=
fs),
> > >                                   folio_zonenum(folio), nr_pages);
> >
> > Could this leave the parent's local active count too high?
> > Isolation can debit the child's active count after the refs
> > 2 -> 3 CAS. If CSS_DYING is set before the stats update, the credit
> > can go to the parent. On SMP, reparenting can clamp the child's
> > negative local count to zero.
>
> Thanks again for the careful review.
>
> But hmm, I'm not sure what you mean by "too high". Maybe there is a
> temporary skew of counter due to various races, but we are fine with
> that, it will be consistent soon.
>
> The key here is update is gated on gen >=3D 0, and the gen is part of
> the CAS: only a folio that is actually on an MGLRU list has its
> refs-based active/inactive credit already accounted will be recredit
> the counter update here. An isolated folio has no lruvec to attribute
> it to, so nothing will be changed.
>
> And for reparenting, we are also following the ordering in the
> document: the updater holds rcu_read_lock() over the lruvec lookup and
> the counter update, and reparenting waits for a grace period, so
> either the memcg is already dying and we credit the parent, or the
> update lands on the child and is part of what reparenting moves
> afterwards.
>
> So the credit and the reparent move always cover the same folios and
> land on the same side: there is no path where the parent is credited
> for a folio it does not end up owning, and no debit that lands where
> the credit did not. I don't see anything to fix here.

Thanks for explaining, Kairui. I had isolation after the CAS in
mind, before the stats path rechecks CSS_DYING. I'm happy to leave
that for a follow-up.

Here's my tag for 16/17, also sent in the 15/17 thread.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

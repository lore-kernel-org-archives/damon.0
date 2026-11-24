Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795485158;
	b=tqGEUM1nq8eGZ0qscQTfAP41SoajeAwHP3Zu0iFdrwycYK2GIU7ekzycsMew074J4uDj
	 f1osw/vorHx7Z5YPoeuOz1cQSpBUPy4ehOPRRVcLgpEjkJbF2AIGikewiBdkMxo+B6Ln+
	 wvtwdTsjjY7V8AyGzZVCu5xeIBTt8NPkVAt8+NgZOybVn4kUivVzyJnJTlFEqV7y8PqEo
	 YKfvAWV4S7gsa9bjsY5xrmiZsCSHClTrQX9vI8I08ToVV2z+zka6TgsIYxB1cFvTHT7u9
	 QoBJCnZmHPBxdSlhwPye1d6jcZlwlf+2/q2Kemd9Q5rF5wgwprVs3jw5MK0caJvsr/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XYy52i1VlUDrudHoFBdDu5SiNfto95Bn3ifLTlKRy3g=;
	b=4Zok9ngp17f3+A+rCy1UhjpZGjVJ7poCdFhi7Q3ogES4imCLg9UFUF1Cm+RuGsIQMP4T
	 5LAyiXvtZ65wIDTokC+QdLBu430wrn14GCsF605cVM9WVQUWcQ3ViRD4hovpdeIk4vyjC
	 FzyWflmFgwjO0o+4/McTZ+r0yDJoecLg6C99XrDZ818MTSCY5bDpGJjhu/+GNFHjDihgT
	 IwTktkPJEYt+sSr26RA8DLHaOdO06qEwgDkE1WULzJ7VViRkMxutOtz6euMpbPagnCyAS
	 iCxE6L40dVXnwuBSqC1BCeexXCKDUcUpqDNgSNvGMnyJ4LnkfsWlrrK11ibEXu8bFxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fpXDIJDp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF361606A321
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 01:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF361606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fpXDIJDp
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so31972505e9.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:52:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795485156; cv=none;
        d=google.com; s=arc-20260327;
        b=Kz//2h6fYh9DJyDTmNRlrMpxDszfILa8V+ob8TQ6iR2GJzeyIC2AgXSvnfS/gbrXEs
         rhajJIB0HloOB9dIWDdB3ew4UbB69iQN9GqPphx5Sb2nhezLlPNbNTebpvs6BxacepNP
         mKSwXCmoM/1ilqs8L4PYDEhQVpnhyzz8un/qAbX/xUMjwaQuzJVRY3vQBgs8by+o454Y
         phqiWoigCwLFbIckq/CvLHq+cP/i3eKgbE6+yaROQDoAXeVI71MvTZ413y1OfnPjNWTB
         EK19nkHVTWqsnOHnKlzXF4czFz3bONlQ7eVfNpENg/BNgT6GN2RvC16q2e7RJS3jD62g
         76PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XYy52i1VlUDrudHoFBdDu5SiNfto95Bn3ifLTlKRy3g=;
        fh=g8KWJb6Ofp6CGMiV1nHPoV98OVg/uBtskPeFFcAryPk=;
        b=gM42wnRDx9G3fDrXif009HV8J7daeP2ESPXs8gNSbAu3ssRo+Rz1D1iNbFCHbzAuXT
         3mpbkK7y5zaLwD1yfKLQL1zO+TMUHd8Awb8KX0Tz++vhif0886644A+ZjJRri5QzLMI+
         LBWPYGsofu5dnyumYVUvIy09Crqy7x/SSZ1wvJH7aeOlldrfN30LrD/w9R1MT5dnNjiz
         a8hjN0lxs9sq8G/my93UlFIZ1Zk6RGy0I3N49OKZycg1UVbluE0WTO0FF5f3mRHWIM+/
         rNI2kBBdyrI0b/KtY6YcOs6a/ix5gNIReBSgBX2OO7q/a4Ae73Xheb0CdUiCcBTVVtxQ
         6SaA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795485156; x=1796089956; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XYy52i1VlUDrudHoFBdDu5SiNfto95Bn3ifLTlKRy3g=;
        b=fpXDIJDp26qiuJtwkLjnMJ9QiO+IsTRc6ot/CxNlMXgxY1WYR8Yhp6/+zCVHXC4pod
         LaqBlx9LaM47/rmaXkDorW//kanbL1spLAgMffp1ES32TOpVh8FlmN1iOcE9c5lB2pnQ
         VGa65A61bXIpsi5qUfSiFAoEWPgbNJhjeLGHLyfZ/L2zb0mBcnisdUqURtow233w4+3r
         xjDXj/eJB76a/C/ITgtsd+PufSdudNzE95AbN3d/vuRGeV+mgpkH9qnNozEYIpWHJ9gm
         LkHGakU208tvmQV8zBuIFO5JlAoJNZvnHsV7SjbkPsMsw/YqJKwfpXJdyv/bnkIDkkas
         mx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795485156; x=1796089956;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XYy52i1VlUDrudHoFBdDu5SiNfto95Bn3ifLTlKRy3g=;
        b=Fm058uHojCvN6Cc53JF2QuFngaTF2y7ZfGm70fRJWTddJTcvjk5HZwwN+E9UrJ8t+V
         RDSMzbx8gzVWGNrnxcUYEWpbUQ0WQxYHGcH5MESQ1ClrHL+cJqIko0FcIwoGqQW2dnOq
         jInRdvSdrNFtVMcDgFsB7E4XCcwodM98v6punSYN5TjoXokf0nyzXR4wLl5AAR7P4nn0
         zI/6mDjM3brA9gwDwNbT2qeEBhWoIbU4P3Pf/U+RejQjAIeMansTVKaoDGd7ID3Sqsln
         bM6JHxClOaZ65KtZ/RsHPcXgRI7GUlcQNmvI5dGEuM+OY7l1uiEHlEcACHaKKdxVKO0h
         +K5w==
X-Forwarded-Encrypted: i=1; AL+hErGE/p/ixApDiQeNwh49IILrXQT9LKs6KNiZe5R2dIkG/TZTDp4gtwFeCjWitdODLz/4G4foIA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9HuN+qQQtGhMUsenA+h+G/ehNlZN2bCP9ko0G5y0jcw6eBWWeU
	zTp4HkQTKtyaHYIOLz0s/5CL++Na8j5AoCT70r5Cq1wx3STuwfezgq9XMyDW9Sarjvx3l0s08MD
	6J+nrFyguc84QXgmzRV9573D7rng9txc=
X-Gm-Gg: AZFdTZdCTCsQMwqOS3sl0IlR8sliFuqb9iQN2WHpqk7rE49ixAZudZES1D3ioU+7ys/
	1umA23xEpKeGriUAP+wP8gMfF/zVUz9VH0vRW4nj3pBGEKgZkdp4R58EGl1cwbNvE1VuAO6HAmY
	CycDuUHpKUBP0LfSq5U+WhI0pWHNgpgYeNLh/pTxvsvOE0ZPJgIJi0bdbh5OEcx/YK4H+ErY4HS
	rh+vMUcJmSEXos7K7GUXMY4FNTn7j+SwDo+E4/QSiopSC9CVb5FxTeTgEYmw9v8ML1dWcd4thOK
	xnnUQOKxIjp3xVi6SfKKv1w9Vl1S+0wHDdsPE219XsbBhgZBYjaLqtgZe0/91TJTCPrhTJ+0KZl
	bHwwxRf4MdKvD+rOm01YILaRfLq4axMYcMpEluZeX2thp4Q27Nd5kTOZvoXrKKx9gnFYr8WzUWE
	4WcKmTXT1jNeIlLaxopXpzfSJQdneGE1Kuwsu3KR1dZCNc6umfMmmb
X-Received: by 2002:a05:600c:64c8:b0:4bb:68e5:b952 with SMTP id
 5b1f17b1804b1-4bb88819be1mr252564985e9.16.1795485155450; Mon, 23 Nov 2026
 17:52:35 -0800 (PST)
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
 <CAN_Opa8L3Ygfu5o7Y8ZD9GTmiEygCXpq2TzAJtwgQChdyb2dSQ@mail.gmail.com> <awQTdkOPG_bKkY1a@KASONG-MC4>
In-Reply-To: <awQTdkOPG_bKkY1a@KASONG-MC4>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 24 Nov 2026 09:52:23 +0800
X-Gm-Features: Aa3M54rNVRedVBKWrSc3NKkfSlK46ArucsaQHzq7jpyNkszROWpY1teS5JMIwgY
Message-ID: <CAN_Opa-TgMWWMjjzuwnVcC3XEBW4FV2eFx2gpiMYvReLhhc=xw@mail.gmail.com>
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

On Mon, Nov 23, 2026 at 6:49=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Mon, Nov 23, 2026 at 09:43:12AM +0800, KunWu Chan wrote:
> > On Sun, Nov 22, 2026 at 11:33=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > On Fri, Nov 20, 2026 at 5:42=E2=80=AFPM KunWu Chan <kunwu.chan@gmail.=
com> wrote:
> > > >
> > > > On Thu, Nov 19, 2026 at 5:04=E2=80=AFAM Kairui Song via B4 Relay
> > > > <devnull+kasong.tencent.com@kernel.org> wrote:
> > > > >
> > > > > From: Kairui Song <kasong@tencent.com>
> > > > >
> > > > > The lruvec spinlock in folio_inc_lru_refs was only taken to keep
> > > > > concurrent aging from corrupting the size counters.  This is no
> > > > > longer needed: the per-generation counters are atomic, and the
> > > > > active/inactive ABI counters are updated per folio and linearized=
 by
> > > > > the CAS on the folio flags, so concurrent aging can no longer cor=
rupt
> > > > > them.  The same argument is what lets folio_reset_lru_refs() upda=
te
> > > > > the counters without the lruvec lock.
> > > > >
> > > > > Use folio_lruvec_live_get()/folio_lruvec_live_put() to hold the R=
CU
> > > > > read lock around the lruvec lookup, and drop the spinlock entirel=
y.
> > > > >
> > > > > Without the lock, aging can advance max_seq while a promotion is =
in
> > > > > flight.  Generations are indexed by seq % MAX_NR_GENS, so the fol=
io
> > > > > flags can return to the value read earlier and the cmpxchg succee=
ds
> > > > > with a target gen computed from a stale max_seq.  Recheck max_seq=
 after
> > > > > a gen-changing cmpxchg: if it moved, account the committed update=
 and
> > > > > retry with LRU_REF_FORCE, which promotes the folio to the newest =
gen.
> > > > > The retry may count the access twice, which is acceptable and avo=
ids
> > > > > folio_activate(), whose LRU lock causes latency jitter.  smp_rmb(=
)
> > > > > orders the flags read, including the one returned by a failed
> > > > > cmpxchg(), before the max_seq read.
> > > > >
> > > > > Also simplify the post-CAS accounting guards: gen is only assigne=
d
> > > > > non-negative values after the old_gen < 0 early exit, so gen !=3D=
 old_gen
> > > > > implies gen >=3D 0, and lru_gen_update_size() needs no explicit g=
uard.
> > > > > The active/inactive ABI update keeps its gen >=3D 0 check because=
 an
> > > > > off-LRU folio has no lruvec to update.
> > > > >
> > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > ---
> > > > >  include/linux/mm_inline.h | 10 +++++-----
> > > > >  include/linux/mmzone.h    |  3 ++-
> > > > >  mm/vmscan.c               | 51 +++++++++++++++++++++++++++++----=
--------------
> > > > >  3 files changed, 39 insertions(+), 25 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.=
h
> > > > > index 77f514143266..2c6cbd0df686 100644
> > > > > --- a/include/linux/mm_inline.h
> > > > > +++ b/include/linux/mm_inline.h
> > > > > @@ -317,10 +317,9 @@ static inline bool lru_gen_is_old(struct lru=
vec *lruvec, int type, int gen)
> > > > >                gen =3D=3D lru_gen_from_seq(min_seq + 1);
> > > > >  }
> > > > >
> > > > > -static inline void lru_gen_update_size(struct lruvec *lruvec, st=
ruct folio *folio,
> > > > > -                                      int old_gen, int new_gen)
> > > > > +static inline void lru_gen_update_size(struct lruvec *lruvec, in=
t type,
> > > > > +                                      struct folio *folio, int o=
ld_gen, int new_gen)
> > > > >  {
> > > > > -       int type =3D folio_is_file_lru(folio);
> > > > >         int zone =3D folio_zonenum(folio);
> > > > >         int delta =3D folio_nr_pages(folio);
> > > > >         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> > > > > @@ -399,7 +398,7 @@ static inline bool __lru_gen_add_folio(struct=
 lruvec *lruvec, struct folio *foli
> > > > >         /* use the refs from the atomic snapshot to avoid raced u=
pdate */
> > > > >         refs =3D lru_get_refs_flags(flags);
> > > > >
> > > > > -       lru_gen_update_size(lruvec, folio, -1, gen);
> > > > > +       lru_gen_update_size(lruvec, type, folio, -1, gen);
> > > > >         if (lru_refs_is_active(refs))
> > > > >                 lru +=3D LRU_ACTIVE;
> > > > >         __update_lru_size(lruvec, lru, zone, delta);
> > > > > @@ -429,6 +428,7 @@ static inline bool lru_gen_del_folio(struct l=
ruvec *lruvec, struct folio *folio,
> > > > >         unsigned long flags;
> > > > >         unsigned int refs;
> > > > >         int gen;
> > > > > +       int type =3D folio_is_file_lru(folio);
> > > > >         int zone =3D folio_zonenum(folio);
> > > > >         int delta =3D folio_nr_pages(folio);
> > > > >         enum lru_list lru =3D folio_is_file_lru(folio) * LRU_INAC=
TIVE_FILE;
> > > > > @@ -452,7 +452,7 @@ static inline bool lru_gen_del_folio(struct l=
ruvec *lruvec, struct folio *folio,
> > > > >         if (!reclaiming && ((max_seq - gen) % MAX_NR_GENS) < MIN_=
NR_GENS)
> > > > >                 folio_set_active(folio);
> > > > >
> > > > > -       lru_gen_update_size(lruvec, folio, gen, -1);
> > > > > +       lru_gen_update_size(lruvec, type, folio, gen, -1);
> > > > >         if (lru_refs_is_active(refs))
> > > > >                 lru +=3D LRU_ACTIVE;
> > > > >         __update_lru_size(lruvec, lru, zone, -delta);
> > > > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > > > index 2680e15b6de9..235fb04f8d78 100644
> > > > > --- a/include/linux/mmzone.h
> > > > > +++ b/include/linux/mmzone.h
> > > > > @@ -540,9 +540,10 @@ enum lruvec_flags {
> > > > >  #define LRU_TIER_MIN           0U
> > > > >  #define LRU_TIER_MAX           (MAX_NR_TIERS - 1)
> > > > >
> > > > > -/* Access source flags for folio_inc_lru_refs() */
> > > > > +/* Flags for folio_inc_lru_refs() */
> > > > >  #define LRU_REF_MAPPED         0x1U
> > > > >  #define LRU_REF_EXEC           0x2U
> > > > > +#define LRU_REF_FORCE          0x4U
> > > > >
> > > > >  #define LRU_REFS_REFERENCED    0x1
> > > > >  #define LRU_REFS_WORKINGSET    0x2
> > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > index 78a1b4de7076..4576a7a369e3 100644
> > > > > --- a/mm/vmscan.c
> > > > > +++ b/mm/vmscan.c
> > > > > @@ -876,37 +876,35 @@ void folio_inc_lru_refs(struct folio *folio=
, unsigned int flags)
> > > > >         long nr_pages =3D folio_nr_pages(folio);
> > > > >         struct lru_gen_folio *lrugen;
> > > > >         struct lruvec *lruvec =3D NULL;
> > > > > +       bool aged =3D false;
> > > > >
> > > > > +retry:
> > > > >         old_flags =3D READ_ONCE(*folio_flags(folio, 0));
> > > > >         do {
> > > > >                 new_flags =3D old_flags;
> > > > >                 old_gen =3D lru_get_gen_flags(old_flags);
> > > > >                 old_refs =3D lru_get_refs_flags(old_flags);
> > > > > -               file =3D folio_flags_is_file_lru(&old_flags);
> > > > >                 refs =3D old_refs + 1;
> > > > >                 gen =3D old_gen;
> > > > > +               file =3D folio_flags_is_file_lru(&old_flags);
> > > > >                 if (old_gen < 0)
> > > > >                         goto out;
> > > > > -               /*
> > > > > -                * Lock the lruvec if the folio is on-list. We ar=
e already
> > > > > -                * doing lazy promotion so in theory we don't nee=
d this,
> > > > > -                * but for now, concurrent aging would still corr=
upt the
> > > > > -                * size counters.  This is a temporary limitation=
 and
> > > > > -                * will be lifted very soon, so the lock here is =
not a
> > > > > -                * performance concern.
> > > > > -                */
> > > > >                 if (!lruvec) {
> > > > > -                       lruvec =3D lruvec_live_lock_irq(folio_lru=
vec(folio));
> > > > > +                       lruvec =3D folio_lruvec_live_get(folio);
> > > > >                         lrugen =3D &lruvec->lrugen;
> > > > >                 }
> > > > > +               /*
> > > > > +                * Read the flags before max_seq, paired with the=
 store of a
> > > > > +                * gen, which samples max_seq first.
> > > > > +                */
> > > > > +               smp_rmb();
> > > > >                 max_seq =3D READ_ONCE(lrugen->max_seq);
> > > > >                 max_gen =3D lru_gen_from_seq(max_seq);
> > > > >                 if (old_gen =3D=3D max_gen)
> > > > >                         goto out;
> > > > > -
> > > > > -               if (flags & (LRU_REF_MAPPED | LRU_REF_EXEC)) {
> > > > > -                       /* Promote second page table access or ex=
ecutable */
> > > > > -                       if (refs > LRU_REFS_REFERENCED || flags &=
 LRU_REF_EXEC)
> > > > > +               if (flags & (LRU_REF_MAPPED | LRU_REF_EXEC | LRU_=
REF_FORCE)) {
> > > > > +                       if (lru_refs_is_workingset(refs) ||
> > > > > +                           flags & (LRU_REF_EXEC | LRU_REF_FORCE=
))
> > > > >                                 gen =3D max_gen;
> > > > >                         /* First access only defers eviction of a=
n old generation */
> > > > >                         else if (lru_gen_is_old(lruvec, file, old=
_gen))
> > > > > @@ -931,9 +929,19 @@ void folio_inc_lru_refs(struct folio *folio,=
 unsigned int flags)
> > > > >                         break;
> > > > >         } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, =
new_flags));
> > > > >
> > > > > -       if (gen !=3D old_gen)
> > > > > -               lru_gen_update_size(lruvec, folio, old_gen, gen);
> > > > > -       if (lru_refs_is_active(old_refs) !=3D lru_refs_is_active(=
refs) && old_gen >=3D 0) {
> > > > > +       if (gen !=3D old_gen) {
> > > > > +               /*
> > > > > +                * Gen-index reuse can fool cmpxchg(). Retry lock=
lessly, accepting
> > > > > +                * an extra reference to avoid folio_activate() l=
atency.
> > > > > +                */
> > > > > +               if (unlikely(READ_ONCE(lrugen->max_seq) !=3D max_=
seq)) {
> > > > > +                       flags =3D LRU_REF_FORCE;
> > > > > +                       aged =3D true;
> > > > > +               }
> > > > > +               lru_gen_update_size(lruvec, file, folio, old_gen,=
 gen);
> > > > > +       }
> > > > > +
> > > > > +       if (lru_refs_is_active(old_refs) !=3D lru_refs_is_active(=
refs) && gen >=3D 0) {
> > > > >                 enum lru_list lru =3D file * LRU_INACTIVE_FILE;
> > > > >
> > > > >                 __update_lru_size(lruvec, lru + lru_refs_is_activ=
e(old_refs),
> > > > > @@ -941,8 +949,12 @@ void folio_inc_lru_refs(struct folio *folio,=
 unsigned int flags)
> > > > >                 __update_lru_size(lruvec, lru + lru_refs_is_activ=
e(refs),
> > > > >                                   folio_zonenum(folio), nr_pages)=
;
> > > >
> > > > Could this leave the parent's local active count too high?
> > > > Isolation can debit the child's active count after the refs
> > > > 2 -> 3 CAS. If CSS_DYING is set before the stats update, the credit
> > > > can go to the parent. On SMP, reparenting can clamp the child's
> > > > negative local count to zero.
> > >
> > > Thanks again for the careful review.
> > >
> > > But hmm, I'm not sure what you mean by "too high". Maybe there is a
> > > temporary skew of counter due to various races, but we are fine with
> > > that, it will be consistent soon.
> > >
> > > The key here is update is gated on gen >=3D 0, and the gen is part of
> > > the CAS: only a folio that is actually on an MGLRU list has its
> > > refs-based active/inactive credit already accounted will be recredit
> > > the counter update here. An isolated folio has no lruvec to attribute
> > > it to, so nothing will be changed.
> > >
> > > And for reparenting, we are also following the ordering in the
> > > document: the updater holds rcu_read_lock() over the lruvec lookup an=
d
> > > the counter update, and reparenting waits for a grace period, so
> > > either the memcg is already dying and we credit the parent, or the
> > > update lands on the child and is part of what reparenting moves
> > > afterwards.
> > >
> > > So the credit and the reparent move always cover the same folios and
> > > land on the same side: there is no path where the parent is credited
> > > for a folio it does not end up owning, and no debit that lands where
> > > the credit did not. I don't see anything to fix here.
> >
> > Thanks for explaining, Kairui. I had isolation after the CAS in
> > mind, before the stats path rechecks CSS_DYING. I'm happy to leave
> > that for a follow-up.
>
> Hi Kunwu, thanks for review!
>
> I thought again about this, and, there seems to be a corner case I didn't
> notice, sorry I missed that. The reparenting used the clamped value, so
> if the child's counter goes nagative due to temporary race, we will
> indeed lost that part, and this should fix that, I'll include this as
> a stand alone patch with your reported by:
>
> (Usually we won't hit this unless the memcg have only a few folios left
>  and raced with repanrting, and I think using clamped value for
>  reparenting is correct on its own)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 091401cecf39..3f551e2e3206 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -562,11 +562,10 @@ unsigned long lruvec_page_state_monotonic(const str=
uct lruvec *lruvec,
>         return (unsigned long)READ_ONCE(pn->lruvec_stats->state[i]);
>  }
>
> -unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
> +static long __lruvec_page_state_local(const struct lruvec *lruvec,
>                                       enum node_stat_item idx)
>  {
>         const struct mem_cgroup_per_node *pn;
> -       long x;
>         int i;
>
>         if (mem_cgroup_disabled())
> @@ -577,7 +576,14 @@ unsigned long lruvec_page_state_local(const struct l=
ruvec *lruvec,
>                 return 0;
>
>         pn =3D container_of_const(lruvec, struct mem_cgroup_per_node, lru=
vec);
> -       x =3D READ_ONCE(pn->lruvec_stats->state_local[i]);
> +       return READ_ONCE(pn->lruvec_stats->state_local[i]);
> +}
> +
> +unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
> +                                     enum node_stat_item idx)
> +{
> +       long x =3D __lruvec_page_state_local(lruvec, idx);
> +
>  #ifdef CONFIG_SMP
>         if (x < 0)
>                 x =3D 0;
> @@ -595,7 +601,8 @@ void reparent_memcg_lruvec_state_local(struct mem_cgr=
oup *memcg,
>
>         for_each_node(nid) {
>                 struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_D=
ATA(nid));
> -               unsigned long value =3D lruvec_page_state_local(lruvec, i=
dx);
> +               /* Reparent the raw value: the clamp drops the child's de=
bit. */
> +               long value =3D __lruvec_page_state_local(lruvec, idx);
>
>                 __mod_memcg_lruvec_state(memcg, nid, idx, -value);
>                 __mod_memcg_lruvec_state(parent, nid, idx, value);
>
> >
> > Here's my tag for 16/17, also sent in the 15/17 thread.
> >
> > Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> Thanks, will be glad if you can help look at the updated v6 later too :D

Thanks for the fix, Kairui! I've had a look at v6 and will
follow up there.

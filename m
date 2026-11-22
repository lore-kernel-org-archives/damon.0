Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795361603;
	b=xYfajNpJEOev5wCsemBY2t2Rd0fs7TwDnQh8HoDli9JtyenwtFAootif4JzC1++c8L4N
	 7hby92ZnFZzN8t1xB1aUkfgtLcW25Vu2q195BDuPe5UhkltZBr+r3EthlI7DOGCjGAyIA
	 aqjzPGn2yaPQ1tgpd3h+Ys/wohyTaVV6SSm9NQkZnUxBNEZqv7Y0XQOkBJDATT2WESO08
	 hjgzI0Rve3M/ljs1kAqYyE1Q7NHmVavwFvtTC/C2gJKoJGEuSrI8Ll7fFPWkSTLL6gXKu
	 e9fe6NcxsnY2eYJNfZuwjtS2d+hMZtCrsrLydTiW0VJc7fBunK/u8sikGVpuh9U0O+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795361603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J3PNVyFxIacZxXwvCauYesumPiWXN0gbWEJ3UEmd/S0=;
	b=BJ8rfUsxw++95ZhZBe8kyrMGRwcjIJJEAR4JynWrfj2rutwbnxH/GN7TbNliywj8F+UC
	 ao5xBFsYZoOkPGnkCqYiFUw1eJTpyV33uCvYG/WidjLzG1FsHWJWMpgn5JJsO1bx3jM8h
	 UCAzhPf29u4MpuMlH3sH+xqgUr6IwNUXtFmf5BzTbsogfdUT8u/WQGozXitFJvlMaIIpH
	 TFGqS6pOATokdQ6CkH1s2MznrHnzSFYACmeXGAyNLgpcqm8lzhp3Z08mBD6PIm27wR4Rp
	 339damGNCARqeVE2ygpQbcjjfD1pMFbw2/OB/bfzUXa5+kY9PMW2JpYUYw+G6TZrHBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A4DuN3mI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BA606A682
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 15:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 276BA606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A4DuN3mI
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c5127c7abd5so407870666b.3
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 07:33:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795361600; cv=none;
        d=google.com; s=arc-20260327;
        b=YElTK+YJyc3/dnjl8Ra6HDYssBhwZ0GYR9TPRSE7f6xZHDrSO+ML1vGL30I100n3cV
         /9M7QHi+2Xeq36T8T4/xrIyyUk+hkowNZRR7HMxQ+p0fq9fx7xclf/2PsXGBfo8npiz1
         68jdnlaeBmDfWpEqdmAFJgYUsw6aE7jr2s3SlaZ6sUws5UZYtBVnY00I5tHHmyA1EXFF
         lPc1C8jS3w+rjepMtWKEfaGtaMT0DZjdRqH4IvdYA/+l6k0zGthBjNio2TZqbfYDOjV+
         f0SOx/56S1rYSiko0nb35arOx+uTvrifRBvHM1Wow24PgHXmZEDZ6xSc9GrFSpElbOfP
         z7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J3PNVyFxIacZxXwvCauYesumPiWXN0gbWEJ3UEmd/S0=;
        fh=6MUBevt+h7uWVGa4LIxZ4qq2QhBc/2uTw+hejYyBQwI=;
        b=nbp1VuwDMeTBs4FyW28E9wRkCp2AFqxFvDP2rnbl5qnKpiIMvq30Qt39kN54CXQI6B
         gz2MYXdKBIDN+wTJjpzuVEXjdRpNJ3/Ma+CpsBd467pPiWptGwjUGjWdK3B80FpVoqN0
         MePvcQ7362ui3odqhNxx0Setzm0sBWCpOdXJ1iK0eTUIxzh78vo06xNnLCvFBbLfhcWW
         o4MMwh35dhttJa2xuiqlvfAOiV7/0tP5mjpwEbqTbnivgbwZ2cOYlhT8/l3ONIK+B4MR
         zjcYhCh00EkaJX9ZBCJxLG/3VVEowX1OPfgkUSHU5W9sO2gMyo8G17D6+H8d3mE/NSSQ
         5iCQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795361600; x=1795966400; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J3PNVyFxIacZxXwvCauYesumPiWXN0gbWEJ3UEmd/S0=;
        b=A4DuN3mIOiRLZhSLNA8nkQUBdWqq/FFauOEytP7USE4sAW0VhJ/sxja8HvCQx2YErs
         g4+9XXxL6H93jdPFbqLVfNmyMqNoX1kgt0YAJOJxAoMErqORzxH/TnhFpwl/8m8DvXEC
         CaMZbbV408qfEAKP2/hE4JNTbn+LDntn52YYhsOxT3yzI8MeoiHY6zN/0EfhJVqk2D0d
         SMqsLyuUSuPeg1GLMErje4RC+2ic9EpOX8TGXxatlHlQ2Abd2qJWDqUgXn058+Sthxnb
         tVMnu4KfRj6PwC4oL+YCY/8RSAKmmGP4eb2OVzk+OtuX03hE5uDaCDlkmDaFinf1EP/S
         vHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795361600; x=1795966400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J3PNVyFxIacZxXwvCauYesumPiWXN0gbWEJ3UEmd/S0=;
        b=KC1/8u96qBg/1oUMG2iWAdVeCEOflYSbScS+ffVZjPr6GUi/hXXaOigu/9s+vkejkc
         F42hlbv76iAiWJYBM5sSV6rhZX59zmK3soG5tB24lRTnh2RcumJuSLmec94uGOJi6CFX
         9F4NGSHiznMu/wnwYPciv3EM1GbbLWRFhx//NblyWVr78l2rxhru8I020a/mKDjZFFge
         XtlM0MKX5fuGceODSrLyWxuqpGDjwZ0Ujs2I19nXzrJC8QV7sMPHGTwC0hdqodHSjJmf
         eCEorZ5FmlUHfXmV9fAiWa3h7GwgFuY9IvzWQgmpBj9Wk4Bj7LfVVz+Po3ypabblswTx
         5LVg==
X-Forwarded-Encrypted: i=1; AL+hErHRGqLOsb3LXV23bhzrK6nQzCpA7jBf7SAhR9dscgr+BnQ/jT9j/6kRHX7OFpyXyPJTFG0J+A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9RGayIS0SteKXeuOdqGZmz5TmjE3pheYHgvWi0sZ2o9xEQcrtL
	sL8J4iYW0DaOsd02vBfx8lynoTuYjXvnge+EREyy4NFQxn495GQoxdSdEbdtnJQPyQM4j0MiaNY
	8/TO2bFN3gK23SqA0NpuGGpNuK91F/2c=
X-Gm-Gg: AZFdTZfG1ksGmvAbCYIjjm+RCFJWeVYwAC5QQjh8ErF/O2QsBQxXmhzMbCy8ZdbA2rA
	1KbwhR/u86Xpgqf74brr5J7SG/CBsnjhO3Apph9GnqfKa7oBV8cIjZCR8EkVjbQrPs7yxsYWFbg
	bGqPIuHrHnAsYOWO+WUu3LBG/QZfJFgpcgVNb9ZWdW9e2T/nzhK10vZyZ0O606liZmpB829fS/X
	jHqmpLkV5cWP5BA7L2hkXWKAB9iGSAu2xs2jW58H+3XEaYFH9baHzPUvdTtn5+Z/nBk+Z24Cg/P
	VWXOWDFIpnMl/hG4eWydPxe4eJTfILdrSnJB/53XDGELM8lrmtCt64ukllm3JF2InZ67BH32yUa
	V4PAh8AQW8UHzYWp95L1cb1cYReoRkd4cJN3w6Xtt0CQbe0fsix5/JddLjAeggaVhdoUIdUg=
X-Received: by 2002:a05:6402:1941:b0:6ba:7b46:78c3 with SMTP id
 4fb4d7f45d1cf-6ba7b46833cmr2556438a12.22.1795361600177; Sun, 22 Nov 2026
 07:33:20 -0800 (PST)
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
In-Reply-To: <CAN_Opa-+nb0vxQ+HsENCG2fEEMZoxG9Sy_DBC4CLkWjNLzDWKw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 22 Nov 2026 23:32:43 +0800
X-Gm-Features: Aa3M54pHOiCztVzRTyhXWZzF_Dp5eaWz0CfbXn8E3WzEubwRH9E6XJ8yTzGAkf8
Message-ID: <CAMgjq7CEdWvv8m9GtWMG=8OFy+1Sehx3HBJt2D=9hntwvfbf6w@mail.gmail.com>
Subject: Re: [PATCH v5 16/17] mm/mglru: make folio_inc_lru_refs lruvec lockless
To: KunWu Chan <kunwu.chan@gmail.com>
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

On Fri, Nov 20, 2026 at 5:42=E2=80=AFPM KunWu Chan <kunwu.chan@gmail.com> w=
rote:
>
> On Thu, Nov 19, 2026 at 5:04=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > The lruvec spinlock in folio_inc_lru_refs was only taken to keep
> > concurrent aging from corrupting the size counters.  This is no
> > longer needed: the per-generation counters are atomic, and the
> > active/inactive ABI counters are updated per folio and linearized by
> > the CAS on the folio flags, so concurrent aging can no longer corrupt
> > them.  The same argument is what lets folio_reset_lru_refs() update
> > the counters without the lruvec lock.
> >
> > Use folio_lruvec_live_get()/folio_lruvec_live_put() to hold the RCU
> > read lock around the lruvec lookup, and drop the spinlock entirely.
> >
> > Without the lock, aging can advance max_seq while a promotion is in
> > flight.  Generations are indexed by seq % MAX_NR_GENS, so the folio
> > flags can return to the value read earlier and the cmpxchg succeeds
> > with a target gen computed from a stale max_seq.  Recheck max_seq after
> > a gen-changing cmpxchg: if it moved, account the committed update and
> > retry with LRU_REF_FORCE, which promotes the folio to the newest gen.
> > The retry may count the access twice, which is acceptable and avoids
> > folio_activate(), whose LRU lock causes latency jitter.  smp_rmb()
> > orders the flags read, including the one returned by a failed
> > cmpxchg(), before the max_seq read.
> >
> > Also simplify the post-CAS accounting guards: gen is only assigned
> > non-negative values after the old_gen < 0 early exit, so gen !=3D old_g=
en
> > implies gen >=3D 0, and lru_gen_update_size() needs no explicit guard.
> > The active/inactive ABI update keeps its gen >=3D 0 check because an
> > off-LRU folio has no lruvec to update.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/mm_inline.h | 10 +++++-----
> >  include/linux/mmzone.h    |  3 ++-
> >  mm/vmscan.c               | 51 +++++++++++++++++++++++++++++----------=
--------
> >  3 files changed, 39 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 77f514143266..2c6cbd0df686 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -317,10 +317,9 @@ static inline bool lru_gen_is_old(struct lruvec *l=
ruvec, int type, int gen)
> >                gen =3D=3D lru_gen_from_seq(min_seq + 1);
> >  }
> >
> > -static inline void lru_gen_update_size(struct lruvec *lruvec, struct f=
olio *folio,
> > -                                      int old_gen, int new_gen)
> > +static inline void lru_gen_update_size(struct lruvec *lruvec, int type=
,
> > +                                      struct folio *folio, int old_gen=
, int new_gen)
> >  {
> > -       int type =3D folio_is_file_lru(folio);
> >         int zone =3D folio_zonenum(folio);
> >         int delta =3D folio_nr_pages(folio);
> >         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> > @@ -399,7 +398,7 @@ static inline bool __lru_gen_add_folio(struct lruve=
c *lruvec, struct folio *foli
> >         /* use the refs from the atomic snapshot to avoid raced update =
*/
> >         refs =3D lru_get_refs_flags(flags);
> >
> > -       lru_gen_update_size(lruvec, folio, -1, gen);
> > +       lru_gen_update_size(lruvec, type, folio, -1, gen);
> >         if (lru_refs_is_active(refs))
> >                 lru +=3D LRU_ACTIVE;
> >         __update_lru_size(lruvec, lru, zone, delta);
> > @@ -429,6 +428,7 @@ static inline bool lru_gen_del_folio(struct lruvec =
*lruvec, struct folio *folio,
> >         unsigned long flags;
> >         unsigned int refs;
> >         int gen;
> > +       int type =3D folio_is_file_lru(folio);
> >         int zone =3D folio_zonenum(folio);
> >         int delta =3D folio_nr_pages(folio);
> >         enum lru_list lru =3D folio_is_file_lru(folio) * LRU_INACTIVE_F=
ILE;
> > @@ -452,7 +452,7 @@ static inline bool lru_gen_del_folio(struct lruvec =
*lruvec, struct folio *folio,
> >         if (!reclaiming && ((max_seq - gen) % MAX_NR_GENS) < MIN_NR_GEN=
S)
> >                 folio_set_active(folio);
> >
> > -       lru_gen_update_size(lruvec, folio, gen, -1);
> > +       lru_gen_update_size(lruvec, type, folio, gen, -1);
> >         if (lru_refs_is_active(refs))
> >                 lru +=3D LRU_ACTIVE;
> >         __update_lru_size(lruvec, lru, zone, -delta);
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 2680e15b6de9..235fb04f8d78 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -540,9 +540,10 @@ enum lruvec_flags {
> >  #define LRU_TIER_MIN           0U
> >  #define LRU_TIER_MAX           (MAX_NR_TIERS - 1)
> >
> > -/* Access source flags for folio_inc_lru_refs() */
> > +/* Flags for folio_inc_lru_refs() */
> >  #define LRU_REF_MAPPED         0x1U
> >  #define LRU_REF_EXEC           0x2U
> > +#define LRU_REF_FORCE          0x4U
> >
> >  #define LRU_REFS_REFERENCED    0x1
> >  #define LRU_REFS_WORKINGSET    0x2
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 78a1b4de7076..4576a7a369e3 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -876,37 +876,35 @@ void folio_inc_lru_refs(struct folio *folio, unsi=
gned int flags)
> >         long nr_pages =3D folio_nr_pages(folio);
> >         struct lru_gen_folio *lrugen;
> >         struct lruvec *lruvec =3D NULL;
> > +       bool aged =3D false;
> >
> > +retry:
> >         old_flags =3D READ_ONCE(*folio_flags(folio, 0));
> >         do {
> >                 new_flags =3D old_flags;
> >                 old_gen =3D lru_get_gen_flags(old_flags);
> >                 old_refs =3D lru_get_refs_flags(old_flags);
> > -               file =3D folio_flags_is_file_lru(&old_flags);
> >                 refs =3D old_refs + 1;
> >                 gen =3D old_gen;
> > +               file =3D folio_flags_is_file_lru(&old_flags);
> >                 if (old_gen < 0)
> >                         goto out;
> > -               /*
> > -                * Lock the lruvec if the folio is on-list. We are alre=
ady
> > -                * doing lazy promotion so in theory we don't need this=
,
> > -                * but for now, concurrent aging would still corrupt th=
e
> > -                * size counters.  This is a temporary limitation and
> > -                * will be lifted very soon, so the lock here is not a
> > -                * performance concern.
> > -                */
> >                 if (!lruvec) {
> > -                       lruvec =3D lruvec_live_lock_irq(folio_lruvec(fo=
lio));
> > +                       lruvec =3D folio_lruvec_live_get(folio);
> >                         lrugen =3D &lruvec->lrugen;
> >                 }
> > +               /*
> > +                * Read the flags before max_seq, paired with the store=
 of a
> > +                * gen, which samples max_seq first.
> > +                */
> > +               smp_rmb();
> >                 max_seq =3D READ_ONCE(lrugen->max_seq);
> >                 max_gen =3D lru_gen_from_seq(max_seq);
> >                 if (old_gen =3D=3D max_gen)
> >                         goto out;
> > -
> > -               if (flags & (LRU_REF_MAPPED | LRU_REF_EXEC)) {
> > -                       /* Promote second page table access or executab=
le */
> > -                       if (refs > LRU_REFS_REFERENCED || flags & LRU_R=
EF_EXEC)
> > +               if (flags & (LRU_REF_MAPPED | LRU_REF_EXEC | LRU_REF_FO=
RCE)) {
> > +                       if (lru_refs_is_workingset(refs) ||
> > +                           flags & (LRU_REF_EXEC | LRU_REF_FORCE))
> >                                 gen =3D max_gen;
> >                         /* First access only defers eviction of an old =
generation */
> >                         else if (lru_gen_is_old(lruvec, file, old_gen))
> > @@ -931,9 +929,19 @@ void folio_inc_lru_refs(struct folio *folio, unsig=
ned int flags)
> >                         break;
> >         } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_fl=
ags));
> >
> > -       if (gen !=3D old_gen)
> > -               lru_gen_update_size(lruvec, folio, old_gen, gen);
> > -       if (lru_refs_is_active(old_refs) !=3D lru_refs_is_active(refs) =
&& old_gen >=3D 0) {
> > +       if (gen !=3D old_gen) {
> > +               /*
> > +                * Gen-index reuse can fool cmpxchg(). Retry locklessly=
, accepting
> > +                * an extra reference to avoid folio_activate() latency=
.
> > +                */
> > +               if (unlikely(READ_ONCE(lrugen->max_seq) !=3D max_seq)) =
{
> > +                       flags =3D LRU_REF_FORCE;
> > +                       aged =3D true;
> > +               }
> > +               lru_gen_update_size(lruvec, file, folio, old_gen, gen);
> > +       }
> > +
> > +       if (lru_refs_is_active(old_refs) !=3D lru_refs_is_active(refs) =
&& gen >=3D 0) {
> >                 enum lru_list lru =3D file * LRU_INACTIVE_FILE;
> >
> >                 __update_lru_size(lruvec, lru + lru_refs_is_active(old_=
refs),
> > @@ -941,8 +949,12 @@ void folio_inc_lru_refs(struct folio *folio, unsig=
ned int flags)
> >                 __update_lru_size(lruvec, lru + lru_refs_is_active(refs=
),
> >                                   folio_zonenum(folio), nr_pages);
>
> Could this leave the parent's local active count too high?
> Isolation can debit the child's active count after the refs
> 2 -> 3 CAS. If CSS_DYING is set before the stats update, the credit
> can go to the parent. On SMP, reparenting can clamp the child's
> negative local count to zero.

Thanks again for the careful review.

But hmm, I'm not sure what you mean by "too high". Maybe there is a
temporary skew of counter due to various races, but we are fine with
that, it will be consistent soon.

The key here is update is gated on gen >=3D 0, and the gen is part of
the CAS: only a folio that is actually on an MGLRU list has its
refs-based active/inactive credit already accounted will be recredit
the counter update here. An isolated folio has no lruvec to attribute
it to, so nothing will be changed.

And for reparenting, we are also following the ordering in the
document: the updater holds rcu_read_lock() over the lruvec lookup and
the counter update, and reparenting waits for a grace period, so
either the memcg is already dying and we credit the parent, or the
update lands on the child and is part of what reparenting moves
afterwards.

So the credit and the reparent move always cover the same folios and
land on the same side: there is no path where the parent is credited
for a folio it does not end up owning, and no debit that lands where
the credit did not. I don't see anything to fix here.

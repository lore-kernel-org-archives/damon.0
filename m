Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795173714;
	b=nQuwm1wt40QYfswy51+FzWfUKLwCBZqbNb0FQS7nMoa3bmIqq89bdJhXXEzEpCOEQbn7
	 92y59qRryNL30uuh7Ey+suKM0edKDSo4x6Z5CN41f3GHL1ZF77bzAngXsRoetnTdvkJPm
	 SV56qJ5z5+oXkpwdignZl/R7hU92GgnMj1tokiWCraBvcDRmGsOqdyLmC9oJ8xc08xxct
	 dUDoCJPh9OKqR7VpdN/8N21pAZ0Rb6fq2mrud+e5zZLXFKh+uYd6FX6UBKOo2iPG5lf2H
	 U4QifxzpcyVmmMOi7uDaFvUg64P1nF8K5WmoqVUPrD9qMOR+4GgwcjvxX5R9o2TCB+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=O0gyuRcS8updM7cyErWfjNuPYzAePnX33DJmz3Z+xgg=;
	b=Y79iedURd6bAN9Z3yaIbPfK7LW5IeJPRNGi6/CsS+uWZF3FgWaVoJjK8Y4A76srH05CD
	 +k9PdQycC/HyXe9/3lalPuxaQIN/mNSEZtDQq2e8h6A/JT7zht0Mqi8mpojbrVVRBKMhe
	 Iows+XCwFygSTvxWC8w1+bnz1VwKAcALnDjiHVZFeGCpP76H+Ka1zYFELOgMbIS3T70Yr
	 2+noYtdq/BWrzXV0c/IeAuxdB6bbKKbX0gJeJYH91wFws/qt7q5fuGtLvnirLnmJ0UQf6
	 24rjBXTt9TpIYTdb1NSr6ICnSt4woxSyKrTX1BeWK3huczTJwgslqrAxi4XkOdV77ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vwm6jPSw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850F606A326
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 11:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B850F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vwm6jPSw
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c445c95d553so112580066b.1
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 03:21:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795173712; cv=none;
        d=google.com; s=arc-20260327;
        b=Ru4sHvTsXd6pp1NHzpjqyJdZo5lYaNVHtDdQptQK8CitOQBEMJG6O0xNcttlGU0pC5
         SvlNrBZqO01FmHuG8ly3m+fQAp9g/qp7lf6P0ZT5aDIU0yNqTFRLHLlkR/0Kpy0RnavS
         yydZ0HrX37x0ZeooBABYdoYZuWLjTF0ww1P0T7s922MjuxyC5V9oDVYyZK3uKodY98BK
         svoskiyIq1q9CVbFXXnNgw0THcaRkUd0oozwijAy2KtxrUERCWEinvQAjTa+br5BVcvd
         WPXJQXtoNg9BvZNyxMqG0iHvkkqwkYi47oHZdIHl7yzDB8MU1Ka90j3wtCxbZDpSeIwg
         fjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O0gyuRcS8updM7cyErWfjNuPYzAePnX33DJmz3Z+xgg=;
        fh=R28Wz1Vk+OlCnn43xwmpHPwnR9BnvHKQ87WR2vc9vv0=;
        b=SFOO/Xy52KitZFP3HMtnsdRA6y89pOlGXmN5B/3MWXUQvwChUCkhPxphO0PUu7LwPj
         2TnC00SG8S+QPqVjIMMpQt+hzmtd02BcBNgU76nk5cNQBE61HsNQ7w3Y65BpoB+yIWEp
         GcwXQAR30XP0Bh1mJNbsDAvMQ395THUF8yxOAVrXjjaHG+WhAJG1g0xZdKNbxDgFnWGa
         +uPPayp86j+XWYhVad/S89IchE7M8eLfIAzWXXEAD/PRMf9DTXvKDtDQlFH+d9x66tKW
         yyLrm9xAd0Gjxy1SxmEp0b9SnhcjEAnXgDfuQwPQRTXPsqGjqqGwytLeb4JpMQzs46uX
         I7qg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795173712; x=1795778512; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O0gyuRcS8updM7cyErWfjNuPYzAePnX33DJmz3Z+xgg=;
        b=Vwm6jPSwH8fY25P11uK0JVhAM2Jr9Wuxzr91EPY0/RmZJUDbakOEYNdip3h8kyzdxK
         NLE6JZAddQwlver2fpNd42uWi4WLoas417jguxBFJv70prVfjuJ9Sz6LTIGmWyLwWVjF
         qQmtJX56U2BmNbaS1Lg2V3ev9Ltk1IsUIjp+lylT+W8AOXAMkIYh+SE4gnp+fBxw2TuO
         L2fuwq8ioHWpDHLQGDuDud9aUtFujFvnX79cm0Ag6W4RFZlg7npAVDpjacKRkSGMee6V
         p3QsB5GyQxRjH0v1crDqyalBpuaA4Atq1XqgaluijeiZWYSz6mcIUfBiPRWYrQ/fTCy7
         j7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173712; x=1795778512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0gyuRcS8updM7cyErWfjNuPYzAePnX33DJmz3Z+xgg=;
        b=zcunkeUdVZqU899NDRXCzrr8lOQ4Y7oQ2Jl+JSDcb8V0U7HxUYdS2s2aXVRGs2GqlB
         m5R7KW4ZZSFx6ilUwOvldr8OhoU4gjBbNxEXNmNmScTQB/TSfJGOE1JD5qpt5zLW0SD1
         f5+5eQBdOZsmVcTzGKyj4yq/yT3rgY5JFrzxmif6bud5Y3/7JMvWfFenT1hehtpiO9GV
         4U8bG12DKXmohXC7up2SBmfVlEDgh4sPVBj8CYMfUNvxL43+j6zN1U4Ubul7EkmumhxZ
         vJ+x+O49wNEG0RYjUnibKrtOec3D9ifP9p8KUXE1d187frIJmukoHoJKQxwvp7FnO2SF
         9ukg==
X-Forwarded-Encrypted: i=1; AL+hErGMxArAmOzlief+8Ep4BELEVRHXxbcqaCmCYv27ME8OHoixekc7JBBL9gNSkPxV9Rgh4r+hqA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8rW1RiZon2vT3WgI07TW5TxfngK/aIx0q00A3MBR+LtVFWbgJ1
	kb365O1UgTMXSPqXhn8pqAaEa250FcLFvWWzfaiacc0TGmtaAY6mIfSwx8yUbEtwLkz7Fkm7lAP
	32AVL/WlfQLKDHPFLTT2g4AC3d/VgkYM=
X-Gm-Gg: AYBFou1ZjyS8zucLRwH6nYMUImgQwTQ3yh0GYhIH+RzKGg+AQ4i+r1C9wCiElJRhlDX
	eZ+K+wiOMm7uDL3qH8nbVLtydHSGC1rkOxdsxw7V0F/wUokics4qyTLj3gcp4dLkNygj4iTJ7fR
	JfiMVMbZUzccb7lXkIDWSjfQNfiup72d7+aHEKGxU4dUbhTkFiAwtv+I6kF95lFb5mLyiFPj7EK
	ATaRRqvUrq9njwn+K0ABvPFap5Pe2ZaMDXWtMwW2ew+7LPtSrsHeoAQAret3tGgkvHaDEhlKncD
	9Xol1B9Pr5/hTc+hPPovvWMRJ24q4wxCf++EjzkkrqkP1R+9Dv2aI0oBG33c+Ufiou/fRpHGCjQ
	cDgm6Om+QEHqcPDpVxNavg+HiirS37nQIwNDsjSI85k7Kf/7/7+Mj9V/lwxhAIfbhjakq7Qj7N2
	NhYjr5EzWHM4z/u04=
X-Received: by 2002:a17:907:b053:20b0:c49:8fa2:4a22 with SMTP id
 a640c23a62f3a-c513acaefdfmr195873966b.41.1795173711896; Fri, 20 Nov 2026
 03:21:51 -0800 (PST)
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
 <20261119-mglru-fg-v5-15-9eee2fe97a2d@tencent.com> <CAN_Opa8jGstV=s9S=c842XFJ_H8m5txc6eJDH2AF=KuJSHAe6Q@mail.gmail.com>
In-Reply-To: <CAN_Opa8jGstV=s9S=c842XFJ_H8m5txc6eJDH2AF=KuJSHAe6Q@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 20 Nov 2026 19:21:14 +0800
X-Gm-Features: Aa3M54rMYFW9cBTPV1lgA61bbuCuAwYh6vZiA0Qdy_vRr3vzdcMN80G05Szd5JE
Message-ID: <CAMgjq7C+7=k9f9HVtYn_VwB96TZAJ=D8cbMh0mV7wCsW3m0ZWA@mail.gmail.com>
Subject: Re: [PATCH v5 15/17] mm/mglru: folio LRU refs based active/inactive
 number accounting
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

On Fri, Nov 20, 2026 at 5:30=E2=80=AFPM KunWu Chan <kunwu.chan@gmail.com> w=
rote:
>
> On Thu, Nov 19, 2026 at 5:04=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Currently the active/inactive LRU sizes exported through /proc/vmstat
> > and memory.stat are derived from the generation window: folios in the
> > two newest generations are accounted as active, the rest as inactive.
> > This causes several problems:
> >
> > - Unmapped file folios can stay in older gens despite repeated use,
> >   so active files can be under-reported, unlike classical LRU.
> >
> > - The reading is jumpy: on aging, the second-newest gen, previously
> >   active, becomes inactive all at once, causing a huge drop of active
> >   folios without any change in use.
> >
> > - The reading is reversed on swapless machines. When swapping is
> >   disabled or unavailable, MGLRU ages anon by moving the gens directly
> >   without walking or touching any folio, to reduce the overhead. So
> >   inactive anon folios can suddenly count as active, or vice versa,
> >   despite no change in their hotness.
> >
> > With frequency guided promotion, hotness is already tracked per folio b=
y
> > its referenced count, so we can do folio level accounting instead: a
> > folio is active once its refs reach LRU_REFS_ACTIVATED (currently
> > LRU_REFS_PROTECTED).
> >
> > On reaching this threshold, folios are accounted to the active part.
> > On forced per-folio aging or PID protection, refs are capped at
> > LRU_REFS_WORKINGSET, dropping active folios to the inactive part.
> > Note that on swapless machines anon refs are not reset by aging (the
> > shortcut skips the per-folio walk), but the counts no longer oscillate
> > as the generation indices wrap.
> >
> > The accounting is now per folio and lruvec independent, so no size
> > adjustment is needed when reparenting a dying memcg: the hierarchical
> > stats keep the counts in the parent automatically.
> >
> > folio_migrate_lru_refs() also gains off-LRU VM_WARN_ON_ONCE checks and
> > __folio_set_lru_refs() warns when the folio is still on an LRU list.
> >
> > The latter uses lru_get_gen_flags(), so that helper now has to move out=
 of
> > the CONFIG_LRU_GEN block and is built with the option off, where
> > LRU_GEN_WIDTH is 0 and LRU_GEN_MASK is zero.  Keep the decoded value in
> > int so the subtraction of the one-off encoding cannot fold to ULONG_MAX
> > before it happens: that is -Woverflow, and fatal with CONFIG_WERROR.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  Documentation/admin-guide/mm/multigen_lru.rst |   4 +-
> >  include/linux/mm_inline.h                     | 118 +++++++-------
> >  include/linux/mmzone.h                        |  23 ++-
> >  mm/folio.c                                    |  39 +----
> >  mm/madvise.c                                  |   2 +-
> >  mm/vmscan.c                                   | 218 +++++++++++++++++-=
--------
> >  mm/workingset.c                               |   2 +-
> >  7 files changed, 230 insertions(+), 176 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/multigen_lru.rst b/Documentat=
ion/admin-guide/mm/multigen_lru.rst
> > index 9cb54b4ff5d9..808d2e97b3f3 100644
> > --- a/Documentation/admin-guide/mm/multigen_lru.rst
> > +++ b/Documentation/admin-guide/mm/multigen_lru.rst
> > @@ -149,8 +149,8 @@ generations less than or equal to ``min_gen_nr``.
> >      ``- memcg_id node_id min_gen_nr [swappiness [nr_to_reclaim]]``
> >
> >  ``min_gen_nr`` should be less than ``max_gen_nr-1``, since
> > -``max_gen_nr`` and ``max_gen_nr-1`` are not fully aged (equivalent to
> > -the active list) and therefore cannot be evicted. ``swappiness``
> > +``max_gen_nr`` and ``max_gen_nr-1`` are not fully aged and therefore
> > +cannot be evicted. ``swappiness``
> >  overrides the default value in ``/proc/sys/vm/swappiness`` and the val=
id
> >  range is [0-200, max], with max being exclusively used for the reclama=
tion
> >  of anonymous memory. ``nr_to_reclaim`` limits the number of pages to e=
vict.
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 14aab2b1ed08..77f514143266 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -105,6 +105,22 @@ static __always_inline enum lru_list folio_lru_lis=
t(const struct folio *folio)
> >         return lru;
> >  }
> >
> > +/**
> > + * lru_get_gen_flags - Return the LRU generation number from folio fla=
gs.
> > + * @flags: folio flags
> > + *
> > + * Returns: A number between 0 and (MAX_NR_GENS - 1), inclusive. Retur=
ns
> > + * -1 if the flags indicate the folio is off the list (e.g., isolated)=
.
> > + */
> > +static inline int lru_get_gen_flags(unsigned long flags)
> > +{
> > +       int gen =3D (int)((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF);
> > +
> > +       /* The gen is stored offset by one, so zero means off-list */
> > +       VM_WARN_ON_ONCE(gen > MAX_NR_GENS);
> > +       return gen - 1;
> > +}
> > +
> >  #ifdef CONFIG_LRU_GEN
> >
> >  static inline bool lru_gen_switching(void)
> > @@ -168,22 +184,6 @@ static inline void lru_set_gen_flags(unsigned long=
 *flags, int gen)
> >         *flags |=3D (gen + 1UL) << LRU_GEN_PGOFF;
> >  }
> >
> > -/**
> > - * lru_get_gen_flags - Return the LRU generation number from folio fla=
gs.
> > - * @flags: folio flags
> > - *
> > - * Returns: A number between 0 and (MAX_NR_GENS - 1), inclusive. Retur=
ns
> > - * -1 if the flags indicate the folio is off the list (e.g., isolated)=
.
> > - */
> > -static inline int lru_get_gen_flags(unsigned long flags)
> > -{
> > -       int gen =3D ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > -
> > -       /* Exclude the legal -1 from the unsigned MAX_NR_GENS compariso=
n */
> > -       VM_WARN_ON_ONCE(gen !=3D -1 && gen >=3D MAX_NR_GENS);
> > -       return gen;
> > -}
> > -
> >  static inline int folio_lru_gen(const struct folio *folio)
> >  {
> >         return lru_get_gen_flags(READ_ONCE(*const_folio_flags(folio, 0)=
));
> > @@ -247,12 +247,21 @@ static inline bool lru_refs_is_workingset(unsigne=
d int refs)
> >         return refs >=3D LRU_REFS_WORKINGSET;
> >  }
> >
> > -static inline void folio_set_lru_refs(struct folio *folio, unsigned in=
t refs)
> > +/**
> > + * __folio_set_lru_refs - Set a folio's LRU refs.
> > + * @folio: the folio
> > + * @refs: the new referenced count (0 .. LRU_REFS_MAX)
> > + *
> > + * Set the folio's LRU refs.  The folio must be off the LRU list (e.g.=
,
> > + * isolated), or use folio_inc_lru_refs or folio_reset_lru_refs instea=
d.
> > + */
> > +static inline void __folio_set_lru_refs(struct folio *folio, unsigned =
int refs)
> >  {
> >         unsigned long new_flags, old_flags =3D READ_ONCE(*folio_flags(f=
olio, 0));
> >
> >         do {
> >                 new_flags =3D old_flags;
> > +               VM_WARN_ON_ONCE(lru_get_gen_flags(old_flags) !=3D -1);
> >                 lru_set_refs_flags(&new_flags, refs);
> >                 if (new_flags =3D=3D old_flags)
> >                         break;
> > @@ -261,12 +270,18 @@ static inline void folio_set_lru_refs(struct foli=
o *folio, unsigned int refs)
> >
> >  #ifdef CONFIG_LRU_GEN
> >  void folio_inc_lru_refs(struct folio *folio, unsigned int flags);
> > +bool folio_reset_lru_refs(struct folio *folio);
> >  #else
> >  static inline void folio_inc_lru_refs(struct folio *folio, unsigned in=
t flags)
> >  {
> >         /* Should not be called with !CONFIG_LRU_GEN */
> >         WARN_ON_ONCE(1);
> >  }
> > +
> > +static inline bool folio_reset_lru_refs(struct folio *folio)
> > +{
> > +       return false;
> > +}
> >  #endif
> >
> >  /**
> > @@ -280,10 +295,18 @@ static inline void folio_inc_lru_refs(struct foli=
o *folio, unsigned int flags)
> >   */
> >  static inline void folio_migrate_lru_refs(struct folio *new, const str=
uct folio *old)
> >  {
> > -       folio_set_lru_refs(new, folio_lru_refs(old));
> > +       VM_WARN_ON_ONCE_FOLIO(folio_test_lru(old), old);
> > +       VM_WARN_ON_ONCE_FOLIO(folio_test_lru(new), new);
> > +       __folio_set_lru_refs(new, folio_lru_refs(old));
> >  }
> >
> >  #ifdef CONFIG_LRU_GEN
> > +static inline bool lru_refs_is_active(unsigned int refs)
> > +{
> > +       VM_WARN_ON_ONCE(refs > LRU_REFS_MAX);
> > +       return refs >=3D LRU_REFS_ACTIVATED;
> > +}
> > +
> >  static inline bool lru_gen_is_old(struct lruvec *lruvec, int type, int=
 gen)
> >  {
> >         unsigned long min_seq =3D READ_ONCE(lruvec->lrugen.min_seq[type=
]);
> > @@ -294,23 +317,12 @@ static inline bool lru_gen_is_old(struct lruvec *=
lruvec, int type, int gen)
> >                gen =3D=3D lru_gen_from_seq(min_seq + 1);
> >  }
> >
> > -static inline bool lru_gen_is_active(const struct lruvec *lruvec, int =
gen)
> > -{
> > -       unsigned long max_seq =3D READ_ONCE(lruvec->lrugen.max_seq);
> > -
> > -       VM_WARN_ON_ONCE(gen >=3D MAX_NR_GENS);
> > -
> > -       /* see the comment on MIN_NR_GENS */
> > -       return gen =3D=3D lru_gen_from_seq(max_seq) || gen =3D=3D lru_g=
en_from_seq(max_seq - 1);
> > -}
> > -
> >  static inline void lru_gen_update_size(struct lruvec *lruvec, struct f=
olio *folio,
> >                                        int old_gen, int new_gen)
> >  {
> >         int type =3D folio_is_file_lru(folio);
> >         int zone =3D folio_zonenum(folio);
> >         int delta =3D folio_nr_pages(folio);
> > -       enum lru_list lru =3D type * LRU_INACTIVE_FILE;
> >         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> >
> >         VM_WARN_ON_ONCE(old_gen !=3D -1 && old_gen >=3D MAX_NR_GENS);
> > @@ -321,19 +333,6 @@ static inline void lru_gen_update_size(struct lruv=
ec *lruvec, struct folio *foli
> >                 atomic_long_sub(delta, &lrugen->nr_pages[old_gen][type]=
[zone]);
> >         if (new_gen >=3D 0)
> >                 atomic_long_add(delta, &lrugen->nr_pages[new_gen][type]=
[zone]);
> > -
> > -       /* return now if not a promotion */
> > -       if (old_gen < 0 || new_gen < 0)
> > -               return;
> > -
> > -       /* promotion */
> > -       if (!lru_gen_is_active(lruvec, old_gen) && lru_gen_is_active(lr=
uvec, new_gen)) {
> > -               __update_lru_size(lruvec, lru, zone, -delta);
> > -               __update_lru_size(lruvec, lru + LRU_ACTIVE, zone, delta=
);
> > -       }
> > -
> > -       /* demotion requires isolation, e.g., lru_deactivate_fn() */
> > -       VM_WARN_ON_ONCE(lru_gen_is_active(lruvec, old_gen) && !lru_gen_=
is_active(lruvec, new_gen));
> >  }
> >
> >  static inline unsigned long lru_gen_folio_seq(const struct lruvec *lru=
vec,
> > @@ -376,7 +375,8 @@ static inline bool __lru_gen_add_folio(struct lruve=
c *lruvec, struct folio *foli
> >  {
> >         unsigned long seq;
> >         unsigned long flags;
> > -       int gen =3D folio_lru_gen(folio);
> > +       unsigned int refs;
> > +       int gen;
> >         int type =3D folio_is_file_lru(folio);
> >         int zone =3D folio_zonenum(folio);
> >         int delta =3D folio_nr_pages(folio);
> > @@ -384,7 +384,7 @@ static inline bool __lru_gen_add_folio(struct lruve=
c *lruvec, struct folio *foli
> >         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> >
> >         BUILD_BUG_ON(BIT(LRU_GEN_WIDTH - 1) !=3D MAX_NR_GENS);
> > -       VM_WARN_ON_ONCE_FOLIO(gen !=3D -1, folio);
> > +       VM_WARN_ON_ONCE_FOLIO(folio_lru_gen(folio) !=3D -1, folio);
> >
> >         if (folio_test_unevictable(folio) || !lrugen->enabled)
> >                 return false;
> > @@ -395,10 +395,12 @@ static inline bool __lru_gen_add_folio(struct lru=
vec *lruvec, struct folio *foli
> >         gen =3D lru_gen_from_seq(seq);
> >         flags =3D (gen + 1UL) << LRU_GEN_PGOFF;
> >         /* see the comment on MIN_NR_GENS about PG_active */
> > -       set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK | BIT(PG_acti=
ve), flags);
> > +       flags =3D set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK | B=
IT(PG_active), flags);
> > +       /* use the refs from the atomic snapshot to avoid raced update =
*/
> > +       refs =3D lru_get_refs_flags(flags);
> >
> >         lru_gen_update_size(lruvec, folio, -1, gen);
> > -       if (lru_gen_is_active(lruvec, gen))
> > +       if (lru_refs_is_active(refs))
> >                 lru +=3D LRU_ACTIVE;
> >         __update_lru_size(lruvec, lru, zone, delta);
> >
> > @@ -425,24 +427,33 @@ static inline bool lru_gen_add_rejected_folio(str=
uct lruvec *lruvec, struct foli
> >  static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct fol=
io *folio, bool reclaiming)
> >  {
> >         unsigned long flags;
> > -       int gen =3D folio_lru_gen(folio);
> > +       unsigned int refs;
> > +       int gen;
> >         int zone =3D folio_zonenum(folio);
> >         int delta =3D folio_nr_pages(folio);
> >         enum lru_list lru =3D folio_is_file_lru(folio) * LRU_INACTIVE_F=
ILE;
> > +       unsigned long max_seq =3D READ_ONCE(lruvec->lrugen.max_seq);
> >
> > +       /* Keep LRU_REFS_FLAGS: refs carry access history across isolat=
ion */
> > +       flags =3D set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK, 0)=
;
> > +       gen =3D lru_get_gen_flags(flags);
> > +       refs =3D lru_get_refs_flags(flags);
> >         if (gen < 0)
> >                 return false;
> >
> >         VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
> >         VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
> >
> > -       /* for folio_migrate_flags() */
> > -       flags =3D !reclaiming && lru_gen_is_active(lruvec, gen) ? BIT(P=
G_active) : 0;
> > -       flags =3D set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK, fl=
ags);
> > -       gen =3D ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > +       /*
> > +        * See the comment in lru_gen_folio_seq.  For migration, compac=
tion,
> > +        * or any other isolation of a hot folio, try best to retain it=
s gen
> > +        * info. Ideally we would keep the full gen info.
> > +        */
> > +       if (!reclaiming && ((max_seq - gen) % MAX_NR_GENS) < MIN_NR_GEN=
S)
> > +               folio_set_active(folio);
> >
> >         lru_gen_update_size(lruvec, folio, gen, -1);
> > -       if (lru_gen_is_active(lruvec, gen))
> > +       if (lru_refs_is_active(refs))
> >                 lru +=3D LRU_ACTIVE;
> >         __update_lru_size(lruvec, lru, zone, -delta);
> >         list_del(&folio->lru);
> > @@ -499,6 +510,7 @@ static __always_inline void folio_inc_lru_refs_fast=
(struct folio *folio)
> >                 return;
> >         }
> >
> > +       BUILD_BUG_ON(LRU_REFS_REFERENCED >=3D LRU_REFS_ACTIVATED);
> >         old_flags =3D READ_ONCE(*folio_flags(folio, 0));
> >         do {
> >                 if (lru_get_refs_flags(old_flags))
> > @@ -534,7 +546,7 @@ static inline bool folio_check_lru_refs(const struc=
t folio *folio)
> >  static inline void folio_clear_lru_refs(struct folio *folio)
> >  {
> >         if (lru_gen_enabled())
> > -               folio_set_lru_refs(folio, 0);
> > +               folio_reset_lru_refs(folio);
> >         else
> >                 folio_clear_referenced(folio);
> >  }
>
> Can clear_refs race with disabling MGLRU? Once the static key is
> off, it can drop refs from 3 to 2 on a folio still on a gen list.
> The drain then subtracts it from inactive, though it was counted
> as active.

Thanks for the very careful review!

I think we are fine, folio_reset_lru_refs checks gen >=3D 0 before
touching things, gen >=3D 0 means the folio is manged by MGLRU, right?
The worst could happen is we clear PG_workingset for CLRU, which
really doesn't matter, one metric off by one folio for a very short
period and self healing, not a measurable thing even if you do that on
purpose.

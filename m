Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795609974;
	b=kipZ4soHp4Tl0Y830VJg55Kaw0UFR+VifVUHrtmN+J1C6y91W4cqZno2aLZKE5CxG0P/
	 cXI2aziPRUPisl4P137WrIXyDRdeEsZldQLymOYcB/rxV1qe4nJnLmlAWYeB2xJAWupYj
	 STR5L2byoN0NDaXf4PVeKiH3xHe6Qd4exVbfx9QMMuv/rE6FueOphBLPCaHpmcX5tAdXB
	 0Fws8Bl0M/uyNEEaL9+5WoPgU7Xh5PEzr1JqBrWMHch7lSrFxrgup53W5hWzvo6KOZaRJ
	 K9R2S1Q7qaiLxr/Nh9bb7WVYdeQuTII5mu1W9Zl3ARctbNKoLekyidRUBp2OuvoHmNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zRIgVqfWg+QEl68a/JHuBJi2X/pJTjAcVfLhgF2ZyDM=;
	b=JMOKjuNyrdLNJhGTZn4ZVwPimd//WJn46umB72iq4EM6EUa+zrCky6emErTx2TKgxQSi
	 d0qBsUIEEbV4r32GIrbWpXV2EtaSaaAkhhFA/lQsBCwfOo/oOwPo6nNyCh3lS8kNRxKfn
	 bM59tzbdFs03bBJhr1LTGygKABBTvOTwUMs6Y+Z/QOA2oMPdASir6Lqm6d4lz/IaWSf12
	 R1VHA6rGFUlDaucZL7iAQaK86GHEOBg+7BTOsnbQX9g2QLkApDtfX5I/2DdJB7v6D0OaB
	 nc1MCM1mJprNjkLv7FDmxZcrG1eQ1P9EDDXwhy76HZHQ7E0GPBRLK89QyQjkoxfrvqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SC7RiKoZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0010606A333
	for <damon@lists.linux.dev>; Wed, 25 Nov 2026 12:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0010606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SC7RiKoZ
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b8a1f59d5eso7384251a12.3
        for <damon@lists.linux.dev>; Wed, 25 Nov 2026 04:32:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795609972; cv=none;
        d=google.com; s=arc-20260327;
        b=m+6uBBqCgzUienalt1PRZdeUJ7OB9MB+6uc/za32GAi8VbCUeMTCcusVKaT8rxoW49
         OBQc/HtH9PD/RRng6AseIQVbZgKa0eXkrDRzZ6vl26WfIUX5Uf9gywfg58lQ5mdrDUvb
         WiPAL9UFvOWdhKRW/RWgxkXN5kcBEtZK4mx7pW8lroCMBQSY0Z6Qngx0VWjG89aNp4LO
         kpnO4ScHqH9tDnn0oUBcJRwHqPKO/PNApvXl1Ee67/uB7uG16wcuBDALCtmr9Tx9AS0v
         folmsWcANWQehvJ0NfzrEYBk5lknjOYUw7BY1c+EU9+YQEzSW7q3lEsLu9sJimrE4zBR
         06ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zRIgVqfWg+QEl68a/JHuBJi2X/pJTjAcVfLhgF2ZyDM=;
        fh=V4WaRr+gglIzySgb18BoaKL2whgo1UIxu3kJQZ0oz04=;
        b=q9NcUAIX9ypKFIKNAkqEmxDzhlWkAqxcZtxRFj5mih8Ne89e8pQrzyOwv3Q4aF1lCT
         Yk9ehLfgDN6pTFowN65C3iu9tOO9LFNpO0a/0I83fsAXoMpvriw4e+6OjidmTFh84NoP
         Pt/UFvLRmBpFGpfti/xhuymB97+GtIo6HmEPJJ95IAFmtRQ3Xq24NEVIK3bBUifV+eho
         FYWp3JWC2j+dVd29HJHDRlxXpcGQYzL6z3Qz7IXYV5Vx8rBCGIT+fv8wospZ+6XMuIRz
         r1ZYEU+4hUYjLdM8hZLeyrkYUNFs/+FY2X2rUkMx31lwAVMk1D4RyPN4QvA8cW9dyYHX
         nFeQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795609972; x=1796214772; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zRIgVqfWg+QEl68a/JHuBJi2X/pJTjAcVfLhgF2ZyDM=;
        b=SC7RiKoZIF/27cutretxOtdhvERk+vFaHCkDBnLDIda2MqLQ6DO5LcTpTHw68agaKL
         2Og9BNgmVj/DnnV7TmUomQ3Ei/B236PrGlBtfB3ST4wBqxb8WH6J7KQteJUmgsZGlNeZ
         MR1mwh+uID5Xr6bABCShqYxxjnmIqK8yGpNp61vS7H+5aUE6lIAJequ8fi0vceJ9sX5m
         LtTlr1siROGFlpDbt0AR5O6LgseGjEhNJ/QflszG3NEMnbZbDY3/RScxQyKHeoQuEhrP
         5VfaA/EEU2vAS08sMbC8KpEGDJg/mJR69AwpmHXpjVBMm71Jl4ZOoBykOVHWNTucGRHm
         io7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609972; x=1796214772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zRIgVqfWg+QEl68a/JHuBJi2X/pJTjAcVfLhgF2ZyDM=;
        b=hrfhDDtWGyuQPiGxVZATVpQLu4BauB6VFUXJiB5SlGLadlWa1bn6GLExYVGGCmNJLL
         9n3j7Hqsgj+4O9xIV/TBQj+MoafNjTGw/du2p6u9AKYzg5wkSe+yrq1OfS4htbkXmw0Q
         9QqRJI+Y9Ej1+xt5+GDgguDZ22kDV7aqIol9Dj0v/CjmnskYM/RWhNNbqluXtxaJecIV
         1b9ZV9nWBGE3wuxcp3WvH4F9Zy0kDGX2w9/TVxQ1+D8bh8xbTJauq51geUBO+CVIZzPz
         /eSk22JTY0DkRNh+tLtVeyGA3Abj9indTldoCu10FSZm92hTnC0oGeLdhfmJCHDlsyWV
         Erpg==
X-Forwarded-Encrypted: i=1; AL+hErGC5MCl1lNJStVR1aw2l5qmH14be/5u1VTnDFk7qjBleaTbtmU/XzSlqX++4HvYvdXTUbursQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ugmoVzsetbQuvIHZqbqkvunonMEUoAO8tM4H9JGOIetsne6Kz
	rJ82bp59CHIgV9kwvREOXebllqfMC90NAb6bKdOwCbWU5EyR/R0AjDa9obn5ia/vMcdfoGayy5Q
	CLQKRyJQbC+IdWxoLXc1IJaHae5gB1Vc=
X-Gm-Gg: AZFdTZe8W4lcxKOhAIBjDRU/S3aMV6aD9yUa6MCVmz0W24wwe7BudgSamlh2boQSzrd
	6iKN9QC6Jzox5N/hk4AY+xs1Ry5n9kdxyZV+ChbKgwFwsRC05zY+Sb8mDHXLPI2ZRO5dVxN1chW
	WWi3bp7cEYzTAggcr10qBianK4Q1HzWCZWYWHKqKaP1bvGEU9x3R8cSfrvHADkN5r2XwyMidbDD
	BvH9SReVKERQVzW3rJ7l8QTRfVoOLolxP4RFBglahLFJ2zB2wN2CqXa5uYuljCn0IRC4PXRgSOL
	gnyorZfGCTPhjv7CMd3uCaa5h5aa5WcFWD/RT5EHGfV/1Z9rg/iNXnsT09OSvvwzUSXz0dMLfGb
	bekE8f1+ychauqFzv4zlWuNRCtQvxSXHyAt5pQvJp+mN6tqQbDr1wtB7ImJT1ixqp6LlC+Q==
X-Received: by 2002:a17:907:7f91:b0:c50:c747:a4ce with SMTP id
 a640c23a62f3a-c513a4b083bmr1510819666b.4.1795609972048; Wed, 25 Nov 2026
 04:32:52 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-10-8ffea39934a6@tencent.com> <ce7c1974-2524-4d49-91f1-508acf2e33d8@kernel.org>
In-Reply-To: <ce7c1974-2524-4d49-91f1-508acf2e33d8@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 25 Nov 2026 20:32:15 +0800
X-Gm-Features: Aa3M54pyChceg9ROmZV659afdcgKNDI5RisCi7hnLxG16VuSebxmazytrDQ-wFs
Message-ID: <CAMgjq7B7dsT4xOfcpnC8XdXZSPd0OOw1br64M+HA_3E+ZeZ-5A@mail.gmail.com>
Subject: Re: [PATCH v6 10/18] mm/mglru, gup: mark folios referenced via a fast helper
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Tal Zussman <tz2294@columbia.edu>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>, 
	Ridong Chen <ridong.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 6:14=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 11/23/26 19:53, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Introduce folio_inc_lru_refs_fast(): raise refs from 0 to
> > LRU_REFS_REFERENCED via cmpxchg, or just set PG_referenced for the
> > classical LRU as before. No counter update or promotion is needed,
> > nonzero MGLRU refs are left unchanged.
> >
> > The classical path is taken for a folio that is off the gen lists while
> > MGLRU is off, not on lru_gen_enabled() alone: while MGLRU is being
> > turned off, a folio can still be on a gen list after the static key
> > flips, and setting PG_referenced there would bump its refs count.
> >
> > That check uses lru_get_gen_flags(), so move the helper out of the
> > CONFIG_LRU_GEN block, it is now built with the option off, where
> > LRU_GEN_WIDTH is 0 and LRU_GEN_MASK is zero. Keep the decoded value in
> > an int so the subtraction of the offset-by-one encoding cannot fold to
> > ULONG_MAX before it happens to avoid -Woverflow error with CONFIG_WERRO=
R.
> >
> > This helper only aims to be fast, it exists so the gup fast path can
> > stay a fast path. The new helper doesn't account for refs above
> > LRU_REFS_REFERENCED but that's fine for now as GUP never used that
> > or anything similar for CLRU either.
> >
> > Convert the gup fast-path sites. No behavior change for classical LRU,
> > no regression for MGLRU either. Just prepare for the following changes
> > by providing a helper that follows the new convention.
> >
> > Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> > Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/mm_inline.h | 62 +++++++++++++++++++++++++++++++++++----=
--------
> >  mm/gup.c                  |  6 ++---
> >  2 files changed, 49 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index b15c3618a1f2..13c8b6bce349 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -105,6 +105,22 @@ static __always_inline enum lru_list folio_lru_lis=
t(const struct folio *folio)
> >       return lru;
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
> > +     int gen =3D (int)((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF);
> > +
> > +     /* The gen is stored offset by one, so zero means off-list */
> > +     VM_WARN_ON_ONCE(gen > MAX_NR_GENS);
> > +     return gen - 1;
> > +}
> > +
> >  #ifdef CONFIG_LRU_GEN
> >
> >  static inline bool lru_gen_switching(void)
> > @@ -168,22 +184,6 @@ static inline void lru_set_gen_flags(unsigned long=
 *flags, int gen)
> >       *flags |=3D (gen + 1UL) << LRU_GEN_PGOFF;
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
> > -     int gen =3D ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > -
> > -     /* Exclude the legal -1 from the unsigned MAX_NR_GENS comparison =
*/
> > -     VM_WARN_ON_ONCE(gen !=3D -1 && gen >=3D MAX_NR_GENS);
> > -     return gen;
> > -}
> > -
> >  static inline int folio_lru_gen(const struct folio *folio)
> >  {
> >       return lru_get_gen_flags(READ_ONCE(*const_folio_flags(folio, 0)))=
;
> > @@ -483,6 +483,36 @@ static inline bool lru_gen_del_folio(struct lruvec=
 *lruvec, struct folio *folio,
> >  }
> >  #endif /* CONFIG_LRU_GEN */
> >
> > +/**
> > + * folio_inc_lru_refs_fast - Bump folio refs count without promotion.
> > + * @folio: the folio
>
> It's unclear when this function should be used and why it should be used.
>
> For someone reading/writing GUP code it's completely unclear why this mag=
ic is
> required.

Right I think I can add the context here in commit message and kdoc,
MGLRU requires the user to avoid calling folio_set_referenced(), so
folio_set_referenced() callers should use folio_inc_lru_refs* instead,
and folio_inc_lru_refs_fast is a variant of that aim to be much
faster, avoiding RCU / CAS / Memcg Counter update.

CLRU still uses folio_set_referenced() though. We can get rid of
PG_referenced and helpers later to make it much cleaner (co-exist of
two LRU is making this looks ugly indeed, I we can fix this step by
step):
https://lore.kernel.org/linux-mm/20260502-mglru-fg-v1-32-913619b014d9@tence=
nt.com/

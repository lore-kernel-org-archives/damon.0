Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795191645;
	b=O3VWNOqBNnBkCynOx+VThF726vKWtdd7BIwPYuXmUZjOHgAuv5TuKaA6tzGasQqWEsAX
	 HZOcpDKCtqNqVU6PvV7cNPbuujB1vXysHVqBgzdynLlDskEHBiIXG6AxrhvaCjun8ig8Z
	 qKuk5x0kZDxzSwAZ3sSvEMPrn6clUQCCmYxv6edFprzCE6QuphqlLzM0TDuxoyotgimVw
	 DAVs1bt19eoMZA8yk49mjZegl4DWq1qAF/eqnhgQK0Qw+/UogGGGhChgIBplO+27wEJlB
	 cMPvTkHFzTMzMFo6ZMnNRdjRaohFEkpoaT1l8iuyxAYy3ezdeekOYqo5tqsFz9TjqOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nFviYrq5o1Aunl789XsU4c1vTFdvhxxqWOma4Om+z08=;
	b=Uiu3Ap340DHk0q25+Q8MKHTnI42GXNsamMp3LcKer87rSdDyZ7YqTHZbm7LYmLGLhuUZ
	 hHWyKXBBADO15RmkTmTUfDMTwfT5UIMRnkkNjTtuXVGwve6yf2Jo1lU1ykSFn6wLnljYl
	 U0QH92wIsHpCYVex05Ol9UfdUu7Rd6fKabiXla3APqkso4+ir2E1iYKmo5FT1tZzJ/56R
	 LLfCyc7QRFb+jlHuI6gqgGLJNxtFT5hx4Xh6CbFBJelj2jfm/iZt0VPz0743WUWLAlCor
	 n5J4QRuEo3zl9kil9w0DyJqpJ11kJeFjvn5y8lLbzFyKdQ5twHiIG4SkwwpKWbhG5uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F4bFJ4CR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA7606A320
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 16:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9AA7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F4bFJ4CR
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so17448145e9.1
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 08:20:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795191643; cv=none;
        d=google.com; s=arc-20260327;
        b=D5R0va4E43Sfw5OmJWXeQAbW9qg5kpZFaNoLWvA4oznVL/ZiI4c6USjaY0C2/2CgPz
         39pquXVIlESarro3eANn+XXlpabsoO+sM/0SlpkL4ZhI1K71Tv3J4IjQGG2ED3tEDWzJ
         WAj661eAxcsafO4yFYVsZBlBgsDfuAooty7GDr4FPZg3F8cdXkgkZ2QS/iHUzB7km8H1
         0hgUt0PjWMK9qOav0RclCcKZFygRVzoSLJneG0kYZesYUIUoHaiB/EDoFBmKQDbq8vBg
         7LSt/BZEdWclPv7q2eWlT6PsMrt8iJf79IRBHzW4GR4S1bHtJ8xG+VQSsrBdRCaOB+U9
         iriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nFviYrq5o1Aunl789XsU4c1vTFdvhxxqWOma4Om+z08=;
        fh=3DlOBEn0SkwTZbY18ROO/M9BUrB7/ZI2LLkRNg2mc84=;
        b=RInDcYgab9IB3Sprsxs0Ju5mayc++a09Xp6qkKHH0OP47pgveicNzz7b37cUCwP2xN
         WhjVNOPD72GtGSdbCSkZT6Mw6zo3Dx5HLMgeO/Ec7xA+sy+M51vBL/VRcXOUyBe3gtob
         /+MfkEVQ1J+Y6fhLudt3MP20Q27N7CZtPjmEJCAn0t9j4xwupRgdnZT5hkn2P47c/1Aj
         UqUgUaJht493fkN48cshKERRNv/z0iLfmkncHjuAmnVi5Yzk8+FfjMfNsepY5byvvEz5
         3pZ5v6f1KqokiXik6nviOWbJsRDl1jXTJHRHnnJHC4TxzJToskBmmQzrmVExVlEU8b3E
         naQA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795191643; x=1795796443; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nFviYrq5o1Aunl789XsU4c1vTFdvhxxqWOma4Om+z08=;
        b=F4bFJ4CRJnMs8wFkO0Z3wmg+w5L2hCH0GWMMKdGHFLDP/eQVdph96zPyXzdqY85nFj
         b2hP47Seg6XjNCNzvpFFHyrm2LeiGokqUBwAM5N6FE3qjJ0FxxqRey7wOG/wP/nQI37U
         wjtuVoHpsuNS8OSKatilSbrSc6HbZtvBcYrApKbMfI7smf4/gsdRJWlzJ5Fj/L6y2oxn
         0A18zNOl7lscJdUzxsFlbQzlcTwUV49NfckWTAewTo+YEJhc3iwTzsR9a7voadJ/QbQg
         4oBHhHiFcjHl0qQKheljyDog+rA15P0q47M5p0DxoSfEZWMM8uL+VTKs1QrxAmEdn+nG
         b5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191643; x=1795796443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFviYrq5o1Aunl789XsU4c1vTFdvhxxqWOma4Om+z08=;
        b=xWc6/CiKzYuPV85RBmcvsSRxzI6dQp1RwAt3PIDX78uXuQTXPWBmPV61Y3cpece9OI
         Hphlgq9EToNwuK+oNLV5P0z8kOMATcm8/fKwsqXMoSuV10kXysp4LHGA9W0N6ZK/c9H6
         4cSF1EdBoJVnOiSNeMn/FhYdNbb0j/Zy0jx7d5iv7vfCpJyWwhGIrd85XyjODf1hhs6p
         1PWZsBwdcBtwuD3NLqI8afvOgq2XWdMMWzTwZcGR1InqmbrBV+wuA1aZSYTeG8FVXTXs
         tXHXHDOBJuKJCZRMy9g4dnER/UFptcsbBsJfG8d4WoCkhEA1Pp5sGB6m+5sK7iPF2IMX
         fs9w==
X-Forwarded-Encrypted: i=1; AL+hErGwoS6OS+1nmp4DjtyLJiUaOVrmKRVCjdaOn+KnjFcYDNVFm6Ba+5rj5s55o3qKlI/k2FBckQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ZutBnpPQZDGEhohs0iJAl/prDOmGnJTGSYhSAmKfuNd9mcvoL
	7IZGXqU8h5oAHl55B1vhYVzofC76D7xFdiGdkeS2+Xjb2EwfMBrj71IouTg8AfIiJzfG5B6hekK
	P3elU18Uma80LOLk5/KkxMQGHvKR5eec=
X-Gm-Gg: AYBFou3Yb3PjGKS8iqByoiLu3CX8Wpi8gfIFapROI06opUHhXW3zv83u9U+WO/5fc7l
	ibi/xaHb9WdFNAeykwHJ1/EqupwXwy2H64JU4K6NakXYLP7XqzzN4nToL9xui2vvwjTmHWpPpXq
	2vaF0vY5Pi8eW6Vm87ZzvOr4llZTNOGeti4PUwMt1Ac766cwBoeKZ2eumVqXd/iUOGQalUnr9Tg
	ArGN/brsHV02AK8q0oSlFkK/tS2rKVnjsIuZ7R+6u58afSWbb0AfSjy1cPrZisc3bue5kb0xCuG
	AM+ZGVf+5pGYYrbqRQKLjZ7BpFATzDWmF2t1SAZCYRMUpQ8qpNuojF9IeJCuYgIfcjFUfjcBzY2
	LZEqs9h3wSsOVCDSgXgZYFDvPwDtX6C1lqpIaQjlqvFNqKBC4iIlq2zS1alNZLSLfBXJroQDi2T
	wtEldND4Q0z4IdsooBJM8=
X-Received: by 2002:a05:600c:37c6:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4bb88812a84mr79631575e9.13.1795191642448; Fri, 20 Nov 2026
 08:20:42 -0800 (PST)
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
 <20261119-mglru-fg-v5-6-9eee2fe97a2d@tencent.com> <CAN_Opa_jb1pN=-Z+4WRoXVDSe0YfppeY319iagMdQoMgtOQSSg@mail.gmail.com>
 <CAMgjq7DbK8sc7-0CTOj5iZBmkLmG7ggj75mdTxVkunGzmi=NWQ@mail.gmail.com>
In-Reply-To: <CAMgjq7DbK8sc7-0CTOj5iZBmkLmG7ggj75mdTxVkunGzmi=NWQ@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Sat, 21 Nov 2026 00:20:30 +0800
X-Gm-Features: Aa3M54pZxa4hRHw0Lgws3rEOfSeNigcJ3vp4dRWPeqYAT3KKSQ-I1gkfiyUitiM
Message-ID: <CAN_Opa93a7Z0wmPxLGFeKF+BssvZeioFHU6tcnBioXTQKWKP-g@mail.gmail.com>
Subject: Re: [PATCH v5 06/17] mm/mglru: frequency guided workingset promotion (MGLRU-FG)
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

On Fri, Nov 20, 2026 at 5:36=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Fri, Nov 20, 2026 at 4:09=E2=80=AFPM KunWu Chan <kunwu.chan@gmail.com>=
 wrote:
> > > +/**
> > > + * folio_inc_lru_refs - Update the folio's LRU refs and lazily promo=
te it.
> > > + * @folio: The folio being accessed.
> > > + * @flags: The type of ref: FD access, or mapped access optionally w=
ith
> > > + * executable access.
> > > + *
> > > + * Used by both cache access (flags =3D=3D 0) and page table access =
(flags =3D=3D
> > > + * LRU_REF_MAPPED, optionally with LRU_REF_EXEC).
> > > + * Context: The caller must keep the folio alive by a reference or t=
he page
> > > + * table lock of a mapped folio.
> > > + */
> > > +void folio_inc_lru_refs(struct folio *folio, unsigned int flags)
> > > +{
> > > +       int max_gen;
> > > +       int type, refs, old_gen, gen;
> > > +       unsigned long new_flags, old_flags, max_seq;
> > > +       struct lru_gen_folio *lrugen;
> > > +       struct lruvec *lruvec =3D NULL;
> > > +
> > > +       type =3D folio_is_file_lru(folio);
> > > +       old_flags =3D READ_ONCE(*folio_flags(folio, 0));
> > > +       do {
> > > +               new_flags =3D old_flags;
> > > +               old_gen =3D lru_get_gen_flags(old_flags);
> > > +               refs =3D lru_get_refs_flags(old_flags) + 1;
> > > +               gen =3D old_gen;
> > > +               if (old_gen < 0)
> > > +                       goto out;
> > > +               /*
> > > +                * Lock the lruvec if the folio is on-list. We are al=
ready
> > > +                * doing lazy promotion so in theory we don't need th=
is,
> > > +                * but for now, concurrent aging would still corrupt =
the
> > > +                * size counters.  This is a temporary limitation and
> > > +                * will be lifted very soon, so the lock here is not =
a
> > > +                * performance concern.
> > > +                */
> > > +               if (!lruvec) {
> > > +                       lruvec =3D lruvec_live_lock_irq(folio_lruvec(=
folio));
> > > +                       lrugen =3D &lruvec->lrugen;
> > >                 }
> >
> > Can we do the lookup under RCU and preserve IRQ state here?
> > filemap_read() can reach folio_lruvec() without RCU held. On non-RT,
> > lruvec_unlock_irq() can re-enable IRQs while KVM's hva_to_pfn_retry()
> > still holds gpc->lock.
>
> Thanks for the careful review!
>
> We can, but not in this commit, and in a later patch we did convert to
> RCU convention, so this lock is just an intermediate state because it
> may race with aging hence race with the active / inactive number
> update. In a later commit we changed how inactive/active is reported
> for MGLRU so this is no longer needed. We are basically lockless after
> this whole series (I mean, RCU lock only).
>
> Perhaps I should add a TODO in the comment here so reviewers won't got co=
nfused.

Thanks, Kairui. Keeping the temporary lock for the accounting
makes sense to me.

Kunwu

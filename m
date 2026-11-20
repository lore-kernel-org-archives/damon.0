Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167374;
	b=WZ/yWZZ+RJEj8rxQG87ad8zCKEp3edd5AZrUWZga6HxtS+Oi+2M4I3v9Xqs4xglRhcca
	 CARk6B8hH2SJpB0l6Sf5W+r3te+6mhQokYNRXwrxNQN3TF7PhUD3hzU0yqoRjW+g66TgR
	 oq+aiX8VKD1GZ8EcaU0lfue9moDRuxpAAycJZaWSCrs0VzDhOFydzL4G71ABCLwltAgTs
	 eSQoHsQpoy7NxSe2TPCfqB6fWjR+W9b7R+3Ghoo19KXgc2qpxqv8qJK85xFnI21UnpqU6
	 v9G6I/Wz8WrgCc9LqL/YnW4NaHb+k3KzeOL2/cPlm1S6iXAGYaBuOTg2M/PAHtllkew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wSiOMe0tD0Y2SxFczJlUDeasF0l1x/LWEx9aDUyyir8=;
	b=SKwsqDH7+KLd2mLA6ytSKlHSfnNiDe2EJeYlryswWy528PDX97eHbwzvy82vk2Q6lmF9
	 pebQSeld5yPsFdBoBRNWlMdxJyANUmBQ+fjPyKagil9MU1v8uB1JvblIJdkWVcDKozB1J
	 Sy55o4vKGMrMnB+FYU7wo+BIAmxrrFExM9KRxIqd6HYLvF+hzMjHtj1Ibum4djyBrmXXh
	 1kc8H0tBGlsAQeyeeW/dAa5sVtRtafGQWnBzOInNG0hVMf5H0IUo68FkIM6vDT4Log79A
	 FvFrRnUWVXO4C2qCLN7oTcs/Y5T4L+AfY8iBjuB6KWhHXupjkQkVCsaUQQSG41M4BDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqegT+cu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182B606A32A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 09:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7182B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqegT+cu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c506a231b88so102147266b.3
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 01:36:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795167373; cv=none;
        d=google.com; s=arc-20260327;
        b=oKfI+u6gkM+V4iDvhFOigPnSXOvYpFsYCHJq1Dup9vDQBcmvzNzbWeOUTYHbwGzEl7
         sueCEGk8c60SwhxhyV/wUjmY3xiuANrjx0IaZ1vNVv6hnAkZ3PXxX6utyMw+QDgTzSdI
         5ZWPObFK26MlLQJglBbyIpNrpj7k3FweJA1Ji7AUtk+2lP3YcsIoMqWTwM84IMHN90Hw
         BFekKdFEmW2CZyFD0uamG+4Li4+o7oyV1RDItbtpcxO41iMWK4qkHkw7KYexyl5SAWr3
         bZTY1DLrHu/0ayl2k7AiP/cFea6pzycDPTRtux829ZkvULIMxUse4x17HLVcJOQ9FpIc
         IrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wSiOMe0tD0Y2SxFczJlUDeasF0l1x/LWEx9aDUyyir8=;
        fh=dXXEhFedUQBCIaps6TlTDGknIwrZknZU9nD0Av7ZxjY=;
        b=SR7h3THyfsCyv9gs24TjHAR97s47k9Hm2YZmEeCiyvsDO6Axfz/LhM7khUa1NtA93k
         S4CHsHIDGun/rlUBzzD1/I99Fol53uI2V47hmTQ7BY+NFmm42ZnWfOG//API+15IqALz
         28P+BhpleQXYg5sMhLwV0r71uyRC6JAtGPPKqYpDWJNraBB2IgdhMGWTyGA6nbSDB16f
         7f+NXtkEyz9R8+isdHuk7ZUelweq+x1mn0s9ucX2RTEYTn8dsY/ZCiu6LU834vB1AIec
         s3jsjSs5wN3hMMRT4tMw9B2hfTlG3G6OOmnt+tv6pgLXNVH9YxSCa1VuBs/vnsR9zY0E
         M35Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795167373; x=1795772173; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wSiOMe0tD0Y2SxFczJlUDeasF0l1x/LWEx9aDUyyir8=;
        b=qqegT+cusiAQ/CcK22Ml2kAjbgxJ3QRpDDsLbFw53ZF5CCcGYj/8S2q3B81xgV4bJw
         7uly8PStRmY5QSzppjcrX2+7Rvu+318WhOeC4lt7q2zHFc1R/bBoHpah3MfYtjqnCStE
         I7MdiQTdHsiVmPOHphM+UcZCI84s8XzFLqCmVRf3ncV0i+78mBVzEtcCVf2z50Qji2O7
         PUHmmsWHHiR8bB4lxrwTy++s7xtcQOiihHLNHxridtaLXVZgsxWiXGY08MQIlFNb4fr/
         2EKWLE2dfwqsy6Lo5ajWwQ1S2qHY8lw4H8FYPr3QZqRiW0rr8Kj759ufA9c8v/hEHzqL
         7ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795167373; x=1795772173;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wSiOMe0tD0Y2SxFczJlUDeasF0l1x/LWEx9aDUyyir8=;
        b=PAsKZOANrjlA7oaAbBLdWEZIri/4VRX3ulyVdZ7VqPQU9HIA6eJ7hmh2GLN1vjZFLO
         FrCniAcRmBpUWgUxzwQ4I0fuTxzBLWgBUcp5CinKGTdwH4GoBDAB/RlFEYi4+JeCYhf+
         EgeDVuycZrfmaYzouwq2ChGhCFB9VtuzintEFgBQGxbXKCcW4L3qSw9L1AknI37ipVdd
         H4BAjvMaj0m0cRDHKqMVLMaGMx8+NPE/vAguuLbnZUXMNu2YpselG3OvRtTb97YpaeNJ
         BwTDAU+tf/r/+8eM6FLcO3QgL+oSKJqz7w4OHsglVQ/PjRlutFnES50gsoUdCoMCBVJL
         PAqQ==
X-Forwarded-Encrypted: i=1; AL+hErGkvUwDynAjCzyE4kmbYGqzD/XM6fodkFm1brbeCnPiIY9fhsGjQX+8E9SpGwkRbtx6zwr9HQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z90zIi+ktYis0vc8Jlmib7ZPogIqQ9td91t5aaGnnuStWyPoiy+
	iZwjnFQ//AydTkm+iEJllyNKqWHinJu0RMqwj+kTgMkJHOpvcMlrVRjNSWN3wlEquLhdEX3+nci
	KxzhJZAhNkBm1k44Lwq2OgLsFodIJX/Y=
X-Gm-Gg: AYBFou2+HBUYRPI3xsnvClgQ0/WN3vz516warvtVQTeoSpaVRhL4ythfaITowGW37tB
	PAKXJxKLclxkBrf4xDG+rq9rO7wfxd+Vt1NF0wNngYLQnMsvgQxCtyLzR/WHuLymX954jQAQY4q
	CizF+niOjTgmawJuiN06/DFOYncOG+S32vhTlJzKMAfjD1qu0+vdLGNp/QK4jiPI7DNJiwu5ywr
	usP4lBj9D99S3qCnL+LS447NzfZnJTKKpTyhSvWLwwHsxUsyP5Czm7cn5ele5YPFNgv7O/LH/NK
	Q6ElO2UWZWAFwKq2gMYZlmBqTaqspB0fw5HhX2wMm44jBnsNHxISCOMCuEZvgzSYegNN9Y464+b
	zm8qzCwBKhUyZhr89KHA7UolCwABsv7frV/nkn3GQJe8REZ3XBffJjHc=
X-Received: by 2002:a17:907:6c17:b0:c51:3cb6:5b11 with SMTP id
 a640c23a62f3a-c513cb65d73mr206830066b.49.1795167372628; Fri, 20 Nov 2026
 01:36:12 -0800 (PST)
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
In-Reply-To: <CAN_Opa_jb1pN=-Z+4WRoXVDSe0YfppeY319iagMdQoMgtOQSSg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 20 Nov 2026 17:35:35 +0800
X-Gm-Features: Aa3M54pbohOCQbswSkwv-YDHDqEuETdr2HZyOy_eh_9wY3LvfDu8zJdBWDbyUx8
Message-ID: <CAMgjq7DbK8sc7-0CTOj5iZBmkLmG7ggj75mdTxVkunGzmi=NWQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/17] mm/mglru: frequency guided workingset promotion (MGLRU-FG)
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

On Fri, Nov 20, 2026 at 4:09=E2=80=AFPM KunWu Chan <kunwu.chan@gmail.com> w=
rote:
> > +/**
> > + * folio_inc_lru_refs - Update the folio's LRU refs and lazily promote=
 it.
> > + * @folio: The folio being accessed.
> > + * @flags: The type of ref: FD access, or mapped access optionally wit=
h
> > + * executable access.
> > + *
> > + * Used by both cache access (flags =3D=3D 0) and page table access (f=
lags =3D=3D
> > + * LRU_REF_MAPPED, optionally with LRU_REF_EXEC).
> > + * Context: The caller must keep the folio alive by a reference or the=
 page
> > + * table lock of a mapped folio.
> > + */
> > +void folio_inc_lru_refs(struct folio *folio, unsigned int flags)
> > +{
> > +       int max_gen;
> > +       int type, refs, old_gen, gen;
> > +       unsigned long new_flags, old_flags, max_seq;
> > +       struct lru_gen_folio *lrugen;
> > +       struct lruvec *lruvec =3D NULL;
> > +
> > +       type =3D folio_is_file_lru(folio);
> > +       old_flags =3D READ_ONCE(*folio_flags(folio, 0));
> > +       do {
> > +               new_flags =3D old_flags;
> > +               old_gen =3D lru_get_gen_flags(old_flags);
> > +               refs =3D lru_get_refs_flags(old_flags) + 1;
> > +               gen =3D old_gen;
> > +               if (old_gen < 0)
> > +                       goto out;
> > +               /*
> > +                * Lock the lruvec if the folio is on-list. We are alre=
ady
> > +                * doing lazy promotion so in theory we don't need this=
,
> > +                * but for now, concurrent aging would still corrupt th=
e
> > +                * size counters.  This is a temporary limitation and
> > +                * will be lifted very soon, so the lock here is not a
> > +                * performance concern.
> > +                */
> > +               if (!lruvec) {
> > +                       lruvec =3D lruvec_live_lock_irq(folio_lruvec(fo=
lio));
> > +                       lrugen =3D &lruvec->lrugen;
> >                 }
>
> Can we do the lookup under RCU and preserve IRQ state here?
> filemap_read() can reach folio_lruvec() without RCU held. On non-RT,
> lruvec_unlock_irq() can re-enable IRQs while KVM's hva_to_pfn_retry()
> still holds gpc->lock.

Thanks for the careful review!

We can, but not in this commit, and in a later patch we did convert to
RCU convention, so this lock is just an intermediate state because it
may race with aging hence race with the active / inactive number
update. In a later commit we changed how inactive/active is reported
for MGLRU so this is no longer needed. We are basically lockless after
this whole series (I mean, RCU lock only).

Perhaps I should add a TODO in the comment here so reviewers won't got conf=
used.

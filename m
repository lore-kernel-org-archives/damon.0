Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794194444;
	b=bSEktuLV/oH+cjHF9EjpAnY1+055DSZZSYviJCuINetT6B/UYb2oVzZnOnFoDcnvpX01
	 al59Dg0oUQiJMLGTWN3hurq32/WeNLUyEULEwWnyBTDy3LVdG7luSiRonDhUJ6XuIbVNR
	 0uGKswYsBbVwrLOMkQO50bTVVot15avBPc7Vq2BdwCLbiUjdGu2ZZFfOesfp33Rr/6TUR
	 oheu2oaxWWgZKXxiF3i7V4p9dOdBzuGlEc+KXT0Qvk+UCxeKu6owg09qSmXy9ndUyUScg
	 Q2Gxfm77hqIJbBii/vSde78JXMLcZkHr6HdM+OaS8GcFE5a7EW2nYKc8JKCbeQn0+bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sE/fNcXhZCFYoGckzt8mvo4VUCyVdxTAKOyI+l9fVSA=;
	b=HKlWp4VrQqeXmE9cf6X76MTxfeE04LWytUsJn/s3VzymCFaXJMZFyra3ZPZ3jtLR4sxc
	 Vf9subWoKtPx93InQWglPhByicY2QZoD5JMZnwxTmJQvYE3A3agb5UJQp6Vd7MxT5189h
	 6bJWFKkQkNWCeOxdlF17GpycwASjJuqSk0dLlfl3cAoMyUFsE2ekJYRp5zD9YoIaaUG30
	 0NwTI+wmYkIlcfooRCEF6PsxS7qetJ1UGOgXxVzV4aKqx7FkeeoSiG6lvjwqilg3pj+Q3
	 nPOm9iGl4nEhQIWvj3XaAsg5LhmV0mNYf5eBTJ4dAn/5DZ+foxUryHra7t4KxaiYCZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zf2ixuWf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B69606A320
	for <damon@lists.linux.dev>; Mon,  9 Nov 2026 03:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24B69606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zf2ixuWf
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c434376dbebso71103666b.1
        for <damon@lists.linux.dev>; Sun, 08 Nov 2026 19:20:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794194442; cv=none;
        d=google.com; s=arc-20260327;
        b=Rk1cum+yq8ZxvYNYbDezveaNacaZy6Ovhz6y13vzAxVav3wd27A3GyYqGIppoFySzg
         8CpkDIjA4/MP+24IR1yNcIVvtKoAw52SUiKfTYrq6CPYoLBrmFOY2PglfgXXlVeqjnrz
         XZ/jZayh/t+OtjWPUWNy1/4HHQacnF2FiDfROrDW/r6Vnaq1D/kvIJRMHcOasqUldci+
         Jy7cJEOTMw++CGNtb++K2kAU5GYrGcsoSdJTbot+TuBLxODHArattxhKGrQz04//netX
         YKRmpYGmybYQNaFV6sqmyopLJblw4yP6G3tizKWy5bjqEKD3WBB6aXnnKdmBFqcLVe2e
         qqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sE/fNcXhZCFYoGckzt8mvo4VUCyVdxTAKOyI+l9fVSA=;
        fh=NdDhkqXeKaEQVt98zc4Sbafk8NPygXup3ub86FFStaA=;
        b=mkP4+f26v2E7d3iwmUHiIeDAXiNbaXuctS7GuZQhxWvc92htuumue32L1+xERgucfq
         PX38JDLJE/Ovi0/UQ3UzCXJi0DylIvgdHtH+yb2yLQJM+VGot4un+YH3n2DXakHUvPBE
         Kw7idJXaIUmPhZbnntfgHaPfEBQE2GCPfVi3i9X98KNftaMCs9eN/5w9RZtw+33OrXSY
         Qk8t+UfguWmOpUKmY6c188NSA4gecqH+pBsdh9lMxm61deyBVDYihWi38MwJw5uYCVDs
         A/F1jJ0CRVtZ0+MFPs0BHzmnvBqg52luT4ZjPZcCPeZ4Rx9qMXxfPnnTfMz58eEyd/rT
         7Lpg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794194442; x=1794799242; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sE/fNcXhZCFYoGckzt8mvo4VUCyVdxTAKOyI+l9fVSA=;
        b=zf2ixuWfGRj9wEHQO/p6haxDCZlDllCLCzv/rx9AZswV8KBb2i30GgMacCVMmn13mP
         QN/qr57Xc/0G8/rskWw6LsXZD/BKtyLmCYu/SbvzPRbnzKmr9VFBKNmDvQIXVZL3mXA7
         NmJevqQz8IzuwExNyvpQQapyq7rjHizVf/krMNAaUbreN4XJw7BgdcziuqczY3bkX8U5
         fmyyof7pjCwMqCW5H0wcxouOeMj62LOItg9XGOBxCV1v11RnixZRIO7OcOuvk0b4g7UE
         2coEyj+xAz22U7Kw5Z1S8b6K+6sZ3kdChFRgDbg0+nd12YmPOEhaW8+RilctsvVFRRyk
         zQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794194442; x=1794799242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sE/fNcXhZCFYoGckzt8mvo4VUCyVdxTAKOyI+l9fVSA=;
        b=04vcXCCSf9SyFL15Chc3J1MVSLN9gQQ+72DBcVHEP0iOKMGsiE8rxB2LC8hkFvn/mH
         JKm8jKYC3rCaDGtV5hqAivnkl+RJ32VeGP3O9iSgo4MWXlTcj2sEbn5KwgwaYetA8Zp8
         MjE5g1gK7T6aGn6eFFANAWZ6cmUj1tjAQICdNk7nPghWf1jzJ2cLLngmcuJV443aTcbr
         eVSIWHmwVir1Wzx4Es6jQlwBsbEDepjr/daN5ezhr5JF55vxfsOERHNkmXjK2TtvRC0A
         rDfxn5r+8yqNogP4h6GhDnxexon8z3VVu66ac70ncBRbtpipXGsGHSpayvs4rCebEoMq
         ZCWA==
X-Forwarded-Encrypted: i=1; AL+hErGm0AI1nGHXLMuXaj+pYMfT3q0R5laUtaAP/Uh8isGR3xKFotXEzlyHUpWi0ze0Mu81PBJusg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8jYHjH4qdveZ+b4DIHx/Sp99bePliMFctAVrSaO5eOOx0DAMZa
	dbcUwGpih5YPNPI/rNJ94kzZ+GWL0zrqPacHgS3KSLzy3l3I1whC4BltwciB9aDtqGM69513N9T
	isIKvwKT8V8maEoQrvGRE1EMLV50iqM8=
X-Gm-Gg: AYBFou1UVxiR9Xh6Jszz3PHFnXhZdlG0ROAJQaZ3vG060zXhkjKMQxnQDCZX+yVzAah
	DFvTkaqaTgVerr6DkkegoNK75P6Gyz//JEvS0N5w/6E0N2BZzqS7AOLtGJ+5GKWGFjp5/4EsSdG
	V/aIx17H1LogZC0c7IcyVOAeTnX+hCRj8a3TaykMB2SL5ZQMJnlKwQw/qBHZMo+dMhXP9dR3JUR
	cKake2newctULu3AvOXhY9QwJqLZvASd5NsB78od3Ct7Lhg+2+Hjp0bPis4KCyy6mNDN3oX+VuD
	kbkL5nVNAkCpnmXtAl7VL7A/+/XbonxG6rB2aYizWzak7aPqUVom7l8jYjNNgxvQNNYl+heGkKW
	zaSgmn3vL6wTVnKXzmEFENllmhiSZaC8VBQcPGXZ88dtHscECjpxpYKuAzm61k9LyfNNF
X-Received: by 2002:a17:907:94c9:b0:c26:1cfd:4244 with SMTP id
 a640c23a62f3a-c4d525794f8mr366547266b.11.1794194442101; Sun, 08 Nov 2026
 19:20:42 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-12-2106750c0bfa@tencent.com> <CAGsJ_4y-7R07wFJTY2a8tMQ1xvG2kjuG0Q1rLjx8DOg4u3UwZA@mail.gmail.com>
In-Reply-To: <CAGsJ_4y-7R07wFJTY2a8tMQ1xvG2kjuG0Q1rLjx8DOg4u3UwZA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 9 Nov 2026 11:20:04 +0800
X-Gm-Features: AclHuK8iUb9Dq3WsbSIlLK65gh2Lc8G5m0UCp-qFnn41-FIR3YsEFvqlSwVsNTk
Message-ID: <CAMgjq7Cj3dvJf8JCkLacGP0=2bPv6WR1sjOD4Ese7XeGP5VhAA@mail.gmail.com>
Subject: Re: [PATCH v4 12/17] mm/huge_memory: mark folio as accessed more
 accurately on split
To: Barry Song <baohua@kernel.org>
Cc: linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, SJ Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Nico Pache <nico.pache@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Chen Ridong <chenridong@xiaomi.com>, Tal Zussman <tz2294@columbia.edu>, 
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	zhaozhengzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 6:15=E2=80=AFAM Barry Song <baohua@kernel.org> wrote=
:
>
> On Fri, Oct 16, 2026 at 2:16=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > The behavior of updating the folio's access info isn't consistent for
> > huge mapping splitting or ordinary unmapping. The page table's young
> > flag has to be translated into folio's access info.
> >
> > Right now it only check and set folio's referenced flag, which isn't
> > enough since folio flags update on access have its rules. Ordinary
> > unmapping (zapping) calls folio_mark_accessed(), and it also checks
> > if the VMA has recency to avoid false updates.
>
> This might be a bit off-topic, but I once proposed
> recency fading for the zapping case in Android workloads:
>
> https://lore.kernel.org/linux-mm/20250514070820.51793-1-21cnbao@gmail.com=
/
>
> folio_mark_accessed() might not be ideal for Android
> apps that are being killed, as we expect them to be
> relaunched only after a long period of time.
>
> But for the splitting case, I guess there is no doubt
> that the accessed state should be set.

Hi Barry,

Thanks for the review.

I agree with these points. BTW that recency fading patch seems
interesting too, but perhaps we need something stronger than
folio_maybe_mapped_shared, maybe folio_maybe_shared, and do that when
"current's cgroup matches the folio's cgroup and have a ref count ~=3D
1"?

> > @@ -3216,8 +3216,8 @@ static void __split_huge_pmd_locked(struct vm_are=
a_struct *vma, pmd_t *pmd,
> >                         folio =3D page_folio(page);
> >                         if (!folio_test_dirty(folio) && pmd_dirty(old_p=
md))
> >                                 folio_mark_dirty(folio);
> > -                       if (!folio_test_referenced(folio) && pmd_young(=
old_pmd))
> > -                               folio_set_referenced(folio);
> > +                       if (pmd_young(old_pmd) && vma_has_recency(vma))
> > +                               folio_mark_accessed(folio);
>
> We now have two inc_refs paths:
>
> - folio_inc_lru_refs_walk() for mapped folios;
> - folio_inc_lru_refs() for syscall accesses, or possibly
>   mapped folios with the appropriate flags such as
>   LRU_REF_MAPPED, LRU_REF_EXEC, LRU_REF_FORCE, etc.
>
> The interface is:
>
> void folio_inc_lru_refs(struct folio *folio, unsigned int flags);
>
> Here we call folio_mark_accessed(folio), which is the
> syscall path with flags =3D 0:
>
> folio_inc_lru_refs(folio, 0);
>
> Are we somehow applying the syscall access policy to
> folios accessed through the page table?

Right at this point I'm just trying to stick with the current upstream
behavior, and not promote these folios aggressively. The results are
looking OK for end to end benchmarks so far, maybe they can be tweaked
further like a LRU_REF_MEAN so it won't promote them, just inc the
ref, I didn't find any oberable differenence at this point as THP
alloc success rate is very low when under pressure so sticking with
the current behavior seems not a bad idea.

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795746083;
	b=LI+36tILaAvg7ESxVoP/VtM5e02ZXIZfAPXvjfRrALQvlGh9XRwfsleA4HRcFMRvQoJv
	 gh9yPIBHRal5Z5IKwJIc9bxvcNnZ22h3du22i3+MCjIGvrpEb5L9RFM80IgE1IjwQyY/z
	 fhTMAPTCc5a4XFzQ/hXetE8VTauMjYzqnfAOedlAmP8ZLUkuYTOQmx6LrqcPztIQkr5UA
	 KLbo3zm+3E2zpyykrRzRyMQGr5Lw1Ii1w4Zs/DOUDQn3jjB+u+su5/ysBQUxfbuphE/6Q
	 /oNCW3THOS45EZDmSyE5ABTmee0YXCcfM69a/LoDovNvyThP5BWjU8mfd4QRqxzW0+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795746083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q9O/QDigxPlmqtrzg+lI27H9LnqU5X97nUid93qpMQw=;
	b=BRfs2btihQfKaPAwmE5d0p/dmYoZlKdXKw2ihawOrLk0+bwWoHsaJasc31Gz8QSlIPdQ
	 UOb6iP7l36nCmhtmHgrNe/CfglAQCb3cMnV5HdzA9zfSocBThjzpbarbH6URFbqqGveFG
	 WFSRY/xdT501ppT0UyBbbHXNi0X0FLffToh+/92wIFGiHtoxe38ydRR+KdoWYeqzNyOHD
	 QC9dYTYOVRr1AQy5zs+6+NkMAINBHEEtT4GhtHYBcNUM0JsPTe2lyDDD+mjyj3hgs+7Ds
	 IGf9TD4WRuEtxaJenGphrZJHc1Y+iQC/IsTE27bNBli1IhBzhgAr42SvtvhJAfNk2JQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mWa+Xshc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE49606A31E
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 02:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE49606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mWa+Xshc
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c5118deebcfso1130892266b.1
        for <damon@lists.linux.dev>; Thu, 26 Nov 2026 18:21:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795746082; cv=none;
        d=google.com; s=arc-20260327;
        b=DqsWYIaQYN1Ru+2pJhj6WXc5n+gPrzaPxgjlFI2gL+mpXo/NsLn6/4p03EkI8URhrm
         XolczXksWRlbmaG8PRpFS3Yhh/EDHDq+krpU3UOnC9X+6rDulZs+bWh3dsAODj2Ifzua
         rtBOtWBBew1yqeYKf7Gsfl1hhvCTINnkjOVkFwMLfN3UxwW7T/1rm3DyC50BB8SKiZwc
         WgRAXifXCZ4rsFYnGyEAECVa37Pq0RPxhJYUFgAXhmBFuDVRPzbqZhghNbvbEstZiC7t
         Miyt9WUlixSMNuYtSL4tI50ydFOsERmE5Vsdam1MvebbwLkxVBBWPY8gOUuZf9QDMH05
         yGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q9O/QDigxPlmqtrzg+lI27H9LnqU5X97nUid93qpMQw=;
        fh=judXP1LNlikFHcvhGkB2d0vmczxqI6FFSgROmy49Q0w=;
        b=b/Yv0o+fn90Jyfj5OlRQCVSXXdU02jIIsGPk35FJBxt9BO4GOF7V4hz2NOOB+jW+SG
         JL7VYJQ2KZN4wfnFVx/apxTHiKUg3MbnuTzXmgkeyuKabm6SNB9iagrAYC5neCoT6Paj
         qcHGnjllnSeybL7//tYSe+7BdCRu3uG4JY+k0R+eO33F6kyQ2hwExShJwM+oYdh0oGfh
         lx8L0WhYmuNuM0N4Qr49cGtvR7uxEo1DYs34iSSOhXCFWrNgpeLETyiD5zVjC1AfvD97
         faFdA48fAVAB5NGFHlHoBd3zQYEKQOPIoSoN8zMuTkwUFmC0r/tcY7iDdBEbghHi1OS+
         0qVg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795746082; x=1796350882; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q9O/QDigxPlmqtrzg+lI27H9LnqU5X97nUid93qpMQw=;
        b=mWa+Xshc+6vjBNer7SIo1wySXu5LsC4/G8PglotTZD2+CZJp/Hua5ENjn2Ls1C0CR6
         NHDcQ+8GMLfb241j29Ql0V8fzwqCNhBQzjSVUUDswATBj670mKcLpczotLWFuseXhtjz
         bNVpC+5b07xLTfUl8K691kwL5mYNosFEwEW6puiRn5D9w+WZEp0qRil2bWrAZUa+hdsx
         Hfh2pTME2IDWe3awgfI768sjoe73nd3mW0nxRRhUpHV0FN8ES07+HLh5XXHo2Yn98APZ
         IvRx5bZgFoCCBaTuf6TJZQZo9+vREyna05US3gMiuWvKAIocLHGgf1CjrMq33wXeTKg+
         /v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795746082; x=1796350882;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q9O/QDigxPlmqtrzg+lI27H9LnqU5X97nUid93qpMQw=;
        b=oGXF7jaGloMM2oJO9OczHi6e5oUT844dy0Mnth/W0nYxClAkytcVJ7nKAInMDurK1q
         SPeqEY5of+pWvGfWgqIpgkmVJ4WPq/4pVDHuOF8AlQEiO6XbAXL2bGSwY1tJerm3Fx/A
         SRA8Lb3A/hOwV7ah8BfHNADvmrjLPiBfS3e45Nf5t9tD9d8bV1Gc3zXdK78gd+KXpO4C
         EKBb17Mv23ZnOJCHgynH9B/nXZ+9iSL8Sx+UMapwKcR3qkhknRXCSrCPi6MDDd5Rc313
         0DZNjbXhJ9sr6Ii/ERmzdPZsTzFc4LYIS2vOony7iJGU5ewCviya0yyQ4YzRZsjygSHl
         IH4w==
X-Forwarded-Encrypted: i=1; AL+hErHE0JmfWSbvM7saOfFXqUwHDP1SGa+Tz30rrcEKCMTPOOrV/F34heHeC1lY4aQC80ljeuWbQw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/f8QAFWauPhinX8mDsk6S9Lr5EQ4NQP4AMspgg4mp6XF3zhKms
	21S/lLfsX7pS9EH71LQtE+oUKzijQ85rsSZr8vtdYYTJFrY6FNgKvS2JuEnkT2hO40U1qElsC6s
	qY45DaElROzSr/CNIiMgxC0Xz19bphTI=
X-Gm-Gg: AZFdTZfEgFai8q02GfwlhRWAhE+NIZYeguiMCrWedr4vTEJJkGnT5Zw8UbfZ5vLXJ3N
	jD8xiaqTZmC3BL4W89tqZTwnipclhLq3kxLEV1/Hc2v8V56FeU34Jymy41GtYAFp0SINkDitDhk
	HJNq89NHOlyHrIoq3HVWHA0Xct3V3KS5f95oyFUzvZX7f0OoA9VZaLOvpfNRjOMOFbRRlPulyDV
	o/StalG3cpd8jquWEW0xEwGwXKyid44pVPL1r58G2fYH5IaAemrZ9FgHJlkgUf1jxKlgJOy62DV
	kZ2vK+1maJxB4pHrjqnWKGPwG2t4SODgbGH5bpg/b1zDBn12rIrIFzAV/gEdPUycybsypIU+qig
	rGdtCDh6v4WOP1QQH7G7KueRaVuVlvw9xq/HSV2tKPqAezlmpBx9lHpkvkpUMZEyEuJHVPzIgRk
	dS2fIhgqnC9jQc0gw=
X-Received: by 2002:a17:907:9693:b0:c4c:ddd1:d006 with SMTP id
 a640c23a62f3a-c513ab47f40mr1740039266b.38.1795746081722; Thu, 26 Nov 2026
 18:21:21 -0800 (PST)
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
 <20261124-mglru-fg-v6-8-8ffea39934a6@tencent.com> <e85a2666-9722-420b-9a60-9d4251fc3d4c@kernel.org>
 <awa30hwg6x82REoo@KASONG-MC4> <8ec3f3e2-5d3a-4bed-a571-88f7ba473b00@linux.dev>
 <CAMgjq7Ayu9H85wurRAUdmXEPWYi9BdLJW13BhK+LMYoBX_7fuw@mail.gmail.com>
In-Reply-To: <CAMgjq7Ayu9H85wurRAUdmXEPWYi9BdLJW13BhK+LMYoBX_7fuw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 27 Nov 2026 10:20:45 +0800
X-Gm-Features: Aa3M54ocIHnij2wxU5gTqMYt2uMcyjdRvBBfxBalbs5FgV17e07SNTVEtRtEE6E
Message-ID: <CAMgjq7DwCNbke2G25Bxfj3bi5aRp3_qkGeYmCTGVGv+Y5XzKTw@mail.gmail.com>
Subject: Re: [PATCH v6 08/18] mm/mglru: make folio lru referenced times count
 a generic API
To: Ridong Chen <ridong.chen@linux.dev>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Nico Pache <nico.pache@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
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
	Tal Zussman <tz2294@columbia.edu>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 10:01=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Fri, Nov 27, 2026 at 9:48=E2=80=AFAM Ridong Chen <ridong.chen@linux.de=
v> wrote:
> >
> > On 11/25/2026 8:36 PM, Kairui Song wrote:
> > >> On 11/23/26 19:53, Kairui Song via B4 Relay wrote:
> > >>> From: Kairui Song<kasong@tencent.com>
> > >>>
> > >>> Pure code shuffle, no behavior change.
> > >>>
> > >>> Make the folio LRU refs helpers available regardless of CONFIG_LRU_=
GEN.
> > >>> Without MGLRU the extra bits are never set, so they are inert. Move=
 the
> > >>> lru_gen_* helpers into the CONFIG_LRU_GEN section.  This prepares f=
or
> > >>> unifying the API for checking folio referenced and workingset statu=
s.
> > >>>
> > >>> folio_migrate_lru_refs() now migrates the complete refs count,
> > >>> including PG_workingset (bit 1 of the encoding), bitwise identical =
to
> > >>> the direct copy dropped from folio_migrate_flags().
> > >>>
> > >>> lru_set_refs_flags() skips the nonexistent mask bits when
> > >>> LRU_REFS_WIDTH collapses to 0, preserving the two independent flags=
 for
> > >>> !CONFIG_LRU_GEN builds.
> > >>>
> > >>> Tested-by: Zhao Zhenzhuo<zhaozhengzhuo@uniontech.com>
> > >>> Reviewed-by: Kunwu Chan<kunwu.chan@gmail.com>
> > >>> Tested-by: Andrew Morton<akpm@linux-foundation.org>
> > >>> Signed-off-by: Kairui Song<kasong@tencent.com>
> > >>> ---
> > >>>   include/linux/mm_inline.h | 55 ++++++++++++++++++++++++----------=
-------------
> > >> I'm starting to feel like all of these mglru/reclaim thingies should=
 go into a
> > >> dedicated helper.
> > > Hi David
> > >
> > > I saw your comment on other patches too, about the header mm_inline.h=
,
> > > about ~690 / 860 lines of code in it is for MGLRU / CLRU only. The
> > > rest ~200 are for VMA / TLB / MMU.
> > >
> > >> Can you do that as a prio cleanup in this series, so we don't have t=
o mess with
> > >> mm_inline.h in later patches anymore?
> > > Perhaps we can instead move the non LRU helpers in it?
> > > These helpers:
> > >
> > >    - anon_vma_name_get
> > >    - anon_vma_name_put
> > >    - anon_vma_name_reuse
> > >    - dup_anon_vma_name
> > >    - free_anon_vma_name
> > >    - anon_vma_name_eq
> > >    - pfnmap_track_ctx_release
> > >    - init_tlb_flush_pending
> > >    - inc_tlb_flush_pending
> > >    - dec_tlb_flush_pending
> > >    - mm_tlb_flush_pending
> > >    - mm_tlb_flush_nested
> > >    - copy_pte_marker
> > >    - num_pages_contiguous
> > >
> > > All other helper in mm_inline.h are for LRU. So we rename mm_inline.h
> > > to mm_lru.h?
> >
> > Moving the VMA/TLB helpers out looks good to me as a first step.
> >
> > For the LRU part, there is already mm/vmscan.h, added by "mm/vmscan:
> > move struct scan_control to a dedicated header" in mm-new. Most LRU
> > helpers are only used inside mm/, e.g. lruvec_add_folio(),
> > lruvec_add_folio_tail(), lru_gen_add_folio() and the refs encoding
> > helpers, so they could move there instead of staying in a public
> > header. Barry also suggested moving lruvec_add_folio() and friends
> > to mm/vmscan.h in another thread.
> >
> > A few are used outside mm/ and need to stay public:
> > folio_lru_list() in include/trace/events/pagemap.h, and
> > folio_test_workingset() in fs/btrfs and fs/erofs after patch 16. So
> > maybe keep a small public header for those, and move the rest to
> > mm/vmscan.h, or to a separate mm/mglru.h if it gets too large, as
> > David mentioned.
> >
> > I can help with the mm/vmscan.h part if that works for you.
>
> Good idea! Maybe you can send a series to do that which I'll rebase on
> top of. Feel free to take the first renaming patch too since they
> should all be zero-feature-change :-D
>
> But please help keep some helpers in a public helper so when we are
> able to get rid of folio_*_referenced and folio_*_workingset, there
> wron't be some strange header inclusion issues. FS users quite often
> need to call them, especially the folio refs related ones.
>
> (Considering MGLRU even used to try to completely ignore anon reclaim
> at swappiness 200 about a year ago, maybe that isn't too much of a
> problem, but it's still a problem).

Sorry my mistake, I meant file reclaim, got it wrong in the opposite way :P

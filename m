Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795055669;
	b=sZ+BTRZ+CDZW20kHfK6FvBPVIiO6zHgJb9vfQCqqFP4qJUFh0HcSnp1YYI3FP62ues2H
	 wW0ZmWyiUdRvvS/RwIn12IaWl2HZjeEt7H5CuzvIWrhupMPn14HkGQQQJ/QhGw3b0jFsw
	 58XczrkRoz6e7tNdborwCE8sbQK9qlxGue7BqOVX93osYThmY0cexuR4XD5/O0TBzJ/LI
	 CQDdu1CNwzQPHMM4sTVLYtr8zwbS0DM6JBs0tXn3hTjNhDPMbz7BOT8cNlUDUI113U8yb
	 eroau1KRMWmXsSg3ne1X/XLehLjZPxxNXTzYA2bRr5bAy+0H/AbtzBCLCkxnz4Kw5Qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uM0JN8VUfPH6oC5vWX2xf2IB4+IT358j1Ch/z79GA5E=;
	b=Odc9o8fvFUyo49eM0Kq8DihhFvhS6s9Mb8iY9vpiNQ35C3clpnE3xPi9U3QP+xshc7Ch
	 gIa5WV7Nx+H5qWTjAwmuuMxchhasFAd2eKePY3mZAth/LSSbvVr2aF6zxLIKfVc7+tyLm
	 znwMsqO58QxAy6ICgegFNVzyCFAFxyQwPZ6WQnAkX7VPQSmTL1xdooJV/2asHqY/Ol/RH
	 PGhYR+xZU5S4qO9ciiaZioVlxLRLER6U/N7sAxOLO1dlqT+fs4NH22Xe9vNwkuu1hTW4F
	 s6DFhzTbSLqnQiUo3+a76D+ezASucW5c+18LDmCSvjWzmBPHkdy/0cfqwU9pqxr+W4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VypQyj/B";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8672606A31C
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 02:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8672606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VypQyj/B
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d427836e9so233453266b.1
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 18:34:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795055667; cv=none;
        d=google.com; s=arc-20260327;
        b=UbB5ga4RyIJky3qJlaBcy8cxvsX/R30TyV5Ap8pNmZmRTDcV8TEPmwdEUOFuBKa6EW
         8mEPAMzoF83oMfjig3nTUYA2zUn5iekQn973ByT9pr+ZjLXRxOn0ravj0FgfFU1zJUox
         6MGLpDX51xLA+DKtcll6EnJJ8tQZegQYmIPBsMDMUa5p8wxPSVANjm57NTHGw+UaiIYy
         rdOeKRVcekng5O/FP5ULe36Ocvf4dhr/EpatS3+h+4GGmzjzY2uI2sJB562Wv64tZjb9
         amTi6GQm2339eF72LZiK6bO8UysVXeWfrertRKfRSU+me/2Zx3fzR1ZNgXT8W1NOSwvq
         2LBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uM0JN8VUfPH6oC5vWX2xf2IB4+IT358j1Ch/z79GA5E=;
        fh=WbHb8TSzWUZ9DGUn0UNMIcayMj30V2eF3cFESepn2B4=;
        b=azqzumE0U6VmovGAtWtM6J5ldfBuTuBfsdkO9P79ZTnTrjXXvUl0A9UZsrDCi5JQMq
         KNRMcxwkkSudDyHtYMMiWZvzC0Rifjhn9lK12+ED/XBgRoiv+epF4yvVzbtT91jPV9uT
         pGY9XBNnG+AzpGKfFAEJ9YrhnoJIoWwVm+uIsrgEW7/sL8CBi+fHNXdIY3Bm4VbgM3om
         nIQHa3ytTG1UU2DipYw8SjFw4OVnNpJvX41jYx6D7n9Ev97CE8qpGi+zHl8euQb9h8tE
         GA+2dGvhQXnrYKzmfLwgH902eeELI9EvjC+swywjgIcw9yz1lYRM23tjnTLGU5OguiZj
         EOhQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795055667; x=1795660467; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uM0JN8VUfPH6oC5vWX2xf2IB4+IT358j1Ch/z79GA5E=;
        b=VypQyj/BSujW868wRTkeH2QG0p5PTymOQJdYsSvzP8ZsCO1BF3Eit1iLPO7pCnwYPb
         HdZGPBf+r+qC4nIh1YDjAm8kDrhYP4nCPrLs3DUCndUDyABCHfWFFxzFvoCQSLiqh+gk
         8CBFUXAcjkyKMQ2aZ5MTyZh0t5PCMsKX04piKziH0mJSWpPMtApY12l9iz2VGPUHx3NP
         nl1TP8IMUN+zLSIp0sb2uQ2QWtKjmoq3Q1lybXCFx0dJemPF5cNulFQ+05cyWxInlsmE
         u8Wivn5ppMSxccb2evKVq27BolV3A9uWN03MCHKg9hDDYXNpmmm+KYykykztvi4jeOcq
         odwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795055667; x=1795660467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uM0JN8VUfPH6oC5vWX2xf2IB4+IT358j1Ch/z79GA5E=;
        b=vLt8aXa3Uyy4pw+Dw8is4KlSamWocgbKIuq1GUP7DlPJsgAU+B+B8NKH+TY4vKUggA
         2z/rB36Ye/iJmPqednxGpDUFMEkf2lb4pcw2jYOsWVKUR08uyHFr5e93XySFliWHcDtv
         tw/ABmkMqF3HufLwMcgApPx4kVrvXUC4NlY0wZI7PhUPlaJnb4RCI0cmTS3OWcOJuekW
         ThXBDLRk/LgWaAgX5HWYOCAPGOQf6mHDgidiRBO3T5cNXtlK2tVdqigMmGJHgAtC8a6q
         GCsYu+H1tqByCu27IN5mFmjFz4REwwOl18pTGq9TY8cPkDKqs7g56eIGnPYEwgUtKuis
         1HdQ==
X-Forwarded-Encrypted: i=1; AL+hErHsZYtBSxUTHmBDmEpZP0ZjmyP2a7YtABGCHIlWHoOfgMQR2cfx7FR//dHw0PaKadAlbgqWhA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+gVHff1mB+sOppLdp0Dpq6ZOQmhIbsAIcHe/tpGsJSvsoFSPxK
	x7irOnInbrxeGs3B/hoc5+wcVbMT/S4sWLX2gGmzFLfOAP0ivqiRpNeWuk1QBZdF1W2VNDKbKyU
	q8z1RBtqSbP59HRc05PW7NKCLXx0UHOQ=
X-Gm-Gg: AYBFou3iKa0UaGGgjl0n+wVmiXjgi6vlNx+nDcMV9rE2GCsOgYtwSHva4M3JBBowGr5
	Oy+PzFAV7y08QFcCOV6WLbjaX0jRrZmPga64s9VQbDY+pIESndsieqajWo173RG38tvK+dJOa2p
	7QyDaQbg0gqgoTl3bsFTWyuFu5ykETXIgMuhhejQCC7QRwEYeSuDydpGX86S2vSNpNhBOsbCz7n
	/eGMS6/ysEDAS6cT1RP8kciXlixua+UqWnQTabKnt34+nn9wYIIQGuv4PRQYJPsNMvZPC2kSLHA
	hjmzIu4ia1QTjcnsUGd3dYzacQpTYwtgQJ9Y+0pikbuWdQzy+Jp6niIsbNudlR/f0Az99Tvx/mq
	mW+KSZDhCmYP/nVvkJ/fepkIKjqDWbBKldsVizin++IVuw/tdHghqCi4GrKDnv/wSt8chcQ==
X-Received: by 2002:a17:906:8358:b0:c51:282b:5489 with SMTP id
 a640c23a62f3a-c51282b56e9mr57464466b.3.1795055667022; Wed, 18 Nov 2026
 18:34:27 -0800 (PST)
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
 <20261119-mglru-fg-v5-15-9eee2fe97a2d@tencent.com> <sashiko-outbox-221996@kernel.org>
In-Reply-To: <sashiko-outbox-221996@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 19 Nov 2026 10:33:50 +0800
X-Gm-Features: AclHuK9Yac_j-zeuFnMHQ2zFU_qaUoG-2sXXeJATZdyMK3cX3pLJ77pbVaVCnZE
Message-ID: <CAMgjq7DctjL5Mo3q7qmVTRTi0JNqYxfEynDE6z1qqp6MH+RnFg@mail.gmail.com>
Subject: Re: [PATCH v5 15/17] mm/mglru: folio LRU refs based active/inactive
 number accounting
To: sashiko-reviews@lists.linux.dev
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
	Joanne Koong <joannelkoong@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, 
	Hui Zhu <hui.zhu@linux.dev>, damon@lists.linux.dev, tj@kernel.org, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 5:29=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm/mglru: raw folio_clear_referenced() in lru_deactivate()
>   paths

This is the only issue from sashiko this time, and looks trivial,
which is a good sign.

> --
>
> commit b8ed2e873fb1f3b844c7ba1fec4ae00c0c04fb88
> Author: Kairui Song <kasong@tencent.com>
>
> mm/mglru: folio LRU refs based active/inactive number accounting
>
> This commit switches MGLRU active/inactive LRU size accounting from
> generation-window tracking to per-folio reference count thresholds
> (LRU_REFS_ACTIVATED).
>
> > diff --git a/mm/folio.c b/mm/folio.c
> > index 06c9cde834f76..3b5ae5b516504 100644
> > --- a/mm/folio.c
> > +++ b/mm/folio.c
>
> [ ... ]
>
> > @@ -552,10 +523,12 @@ static void lru_lazyfree(struct lruvec *lruvec, s=
truct folio *folio)
> >           folio_test_swapcache(folio) || folio_test_unevictable(folio))
> >               return;
> >
> > -     lru_gen_clear_refs(folio);
> >       lruvec_del_folio(lruvec, folio);
> >       folio_clear_active(folio);
> > -     folio_clear_referenced(folio);
> > +     if (lru_gen_enabled())
> > +             __folio_set_lru_refs(folio, 0);
> > +     else
> > +             folio_clear_referenced(folio);
>
> [Severity: Medium]
> Should lru_deactivate_file() and lru_deactivate() also call
> __folio_set_lru_refs(folio, 0) when lru_gen_enabled() is true, like
> lru_lazyfree() does here?

It's very trivial, the folio passed to lru_deactivate_file should
already have their refs cleaned befoing arriving the folio batch.
There is a tiny time window they could get referenced again, in that
case, keeping the new ref or dropping the new refs both make sense.

Oh and since the folio is offlist, it won't cause any statistical or
counter issues either.

So it's not really a problem, it's fine either way.

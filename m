Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794216847;
	b=Hmg6qqgcQiLW81Fz6UNHblYDnzdu3P9moFEu6bz4WqcLiQBrGfxR0Qt4xPlXs7xY5CmX
	 vAnuMFKEqPiUE840srYBd+KPSCjltOpDvXcfxDPcIykMIfZbkAvb827whx94qjh33Dno+
	 vZvtZREIcAEqbn1LeuI3USRP+RwIAkGpjrwLckMloNIr1B+aNE+Sv+cIhPSHOz0szkjFx
	 kDTnVPmfSEqM+DKPHQqMyhecYfvQCitDxNttT3yHy5RmVXZn+L7QYV2XpumLsqAg37pXQ
	 y6wzkVtMbkxbbZQYa9epA4p6Bl0IRN8drVQp/CciK/ZUEIkE5y6vcRNypmwJNxa0ugg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mu/oofPDsfg+LaVc2a1HnbHK3ydvC97UTzMxPHDp3UE=;
	b=SZ0VB3W6jmVOZ+UW4nydLhhWmgGW3LwlAEuW1b9cLYzzN28rmJM/2jllV7wZ/4qhliZY
	 fd8bqgTzGm5ZH9O9a2Gwv0PfPti/ahgN2DdNF0a34BjV1A7ZsmJsVUgvGfqt1AH3eE5yO
	 Q4eFHZwTsbq4rQPSHYT5pDC5/3okAv0xRX5xY5adeacGw5mRHn6CHV19nFgXvx+cMY+4k
	 1AmXzny2D06icCqbW055XSNFIdNaXPsqAIW1rjkXKw0Hbjzd+e9dIx7TR4ya31t02ftG3
	 RAtwuhwwYifdT/23gJ1Dz14xGFI2M4vNUBCGmxIt5Hq9JFW5vZ2mr7vYj/IDTH8cozw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGcNIUnC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961B606A322
	for <damon@lists.linux.dev>; Mon,  9 Nov 2026 09:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5961B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGcNIUnC
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso112216866b.0
        for <damon@lists.linux.dev>; Mon, 09 Nov 2026 01:34:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794216846; cv=none;
        d=google.com; s=arc-20260327;
        b=jCSbVD1TtKzIv9GxQ8aO2z71zglK39/otd7EEBCTDiFvNgYIEK0cJAwFmKScbeCYpN
         mhq2td88gM7vE2jmadpdz34Rme27FfWyn5rfNNhw24EZeCZ2f7vMVZKGG8oBafUzaMob
         cjhy8WqkRUcBxSh6rLjIn+/t57n4HKoN3imbxHGddS36qgyg9DEH8hWmP+AuK74QT4GY
         8y1KoKOwIBnmMY13GHBHg1WCLS+ACCHnF9mm0nxrmorZ11boD4376eeGY7ORUjf0Uua5
         5C5fkWAnQAAfJgHr9niJ3eTwqqa/J5TWk9td7jPwQk12N6XBFTNSahMHYNHRxSFVuoZT
         CYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mu/oofPDsfg+LaVc2a1HnbHK3ydvC97UTzMxPHDp3UE=;
        fh=wcWc6hqFfKpktiv86AZqmp4z6d3558Vwume5zCAoVhM=;
        b=jxzBH8JiQ0OP6ULdSJ/2SOzyqq3yiKqvtoBAs32oH8K2rYwpHhrlu45iiS77GE9Ruo
         14LBnWNPN1qyGsM9fd+ykpwdXRyhsXiCyGWLzu3FcHIengJgqrmhIsVVFksCukA/GziW
         scIckfY52qj4RbW7LLbWD/HZ3qN4xfft3ZjtjZw7jhGAi8FdcC0SGxdTZQwc4TEPisdx
         kcafVpghI2cngsGVibLF3VNhlGuVcISWeclLv4oUaowVUTU66wKG/pG45jCYC2JRqtet
         nUqF4BkN4X4J22j8XLMq0zpHzYLGTYJITbxnEaPNcfOtY1givxDntYilIjmsUECfID3C
         Rdjg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794216846; x=1794821646; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mu/oofPDsfg+LaVc2a1HnbHK3ydvC97UTzMxPHDp3UE=;
        b=sGcNIUnCRnulw8W3p5ZqLRPo2JORn00Ss+YjsplTEEv/DX7BgOVeHC9tc0MkuBxdmm
         W8Frjz9fn7Sjn3JLtoUcXcLTo7+6kzpwtf+FbGFXPzajF1/Y5hllEt+9sFgFS8PJbXln
         ZD2VmQCyLLjYFSWJ0cALGS4ubbJE4P8pDV+x3qdXUnBbcqwl5CcIMDkTFI7MFWfRxFYB
         zGeqm99CpplEs9+8+o286h5Mx1ps0J0ILJioOXeV2c9PdC2SMFPtc+8fy7Gb3A+4CeRB
         W9V5dCQWoeJ+Z8x2qynHhpYHN5gdAy4QRDcqpbpba0fAwt0MYj/HVzBTlZ5CmNDChUjT
         BYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216846; x=1794821646;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mu/oofPDsfg+LaVc2a1HnbHK3ydvC97UTzMxPHDp3UE=;
        b=W2OAL2630PkmiyyErXQvllbbhl3t3i/4TS2JF7aQI7SBCz8/pzX2xw5fnt04btLSd6
         nN1AyjKzGf/6G9ty9LjiD0HjaJxbAJ4ixsdQ+AIypouYhK6OnVUJ6m9qrvgZqnSCLm91
         pw6PuLkn4Bl1A+aupzLLqWvUPvxYBN7pXVQOCjBidwNfQgoTFNvDEzPh59XcLbtOX+zN
         9VzQkyon+gt++0AvUXAkHUR6wo197XW4B6O3d0IjUazfQT2cYzlEUqBDxSlhOZLPCyP7
         tmANbHKuP3Z2mdWcaz6tnB+X59ES22wRsZPiLIX54CLe0Jlx0SC6/EMd4TK1elIfCUQM
         cEtw==
X-Forwarded-Encrypted: i=1; AL+hErENnrvIaYdYj8darvdRKccSV1U9GvXUc+kbRoLgSty2vQaedxzYGzY5jUSINPkL3ezoY8Lhiw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8p+3z8WfOCYtmOH8AJx294q8oRbAkXUOHuhic+OEg+mkmZhvW/
	DqdsX27987IlUH2xqGvENID8cFH4nJwSTpWENJE0PEfYB80EhplF0/vJQGq062D24NcD089350F
	l6cDCLtoWoxZwMioK/hMpDWECNTW9IcM=
X-Gm-Gg: AYBFou0XaZGwnbmSrO3YLy8dPPVlBeJAMjs1zMHwAGLVNfJfelZLScdfPpkR5iC0dqN
	xbMoqwpYa7EBV1xdBhk8TzUyMhuFmt/hqNQvofkmOTXmeFYdfUfRixU9+ZQ+I33T5w//YHU3lau
	EM/B4VJxOYBKE72rpCoghi+PlaAUSGNjgAChLyb7SLgliytHo75QWaUdz3TEWIsD941ASQAmQS1
	GZrbHfxmpEN4ipdZbFwQ0IV0E8EiUDQyIu1rf3iywGdZWHia2XT4Mqv2Uy5Edn+mZ2V+8IUleJ1
	Y47c7aN5uYo6ej2ScVQIjZlJ8RMO4G+DZ/2Lef/Eorwg7XgyS425Zc+mTZb5fr7xVr6Gqjvu6Ia
	iO/h3JrfMD5U87GirkZ6gFRYOYQRolY9VJp5P/BV+3IKWqTgJ6TTG4/QkKP9XcK4XYPr6
X-Received: by 2002:a17:907:1609:b0:c46:78af:6150 with SMTP id
 a640c23a62f3a-c4d523bbb99mr398017966b.2.1794216845494; Mon, 09 Nov 2026
 01:34:05 -0800 (PST)
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
 <20261016-mglru-fg-v4-6-2106750c0bfa@tencent.com> <CAGsJ_4zQh0TnAxifWPo2+DcyFFOtpXM+2QW91A07oumfyrqVYg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zQh0TnAxifWPo2+DcyFFOtpXM+2QW91A07oumfyrqVYg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 9 Nov 2026 17:33:28 +0800
X-Gm-Features: AclHuK8oJGBgOQDKpdCDCogHbVwnPnC6cKJNTKD1XErUqqMirF8-gtHajt-txqQ
Message-ID: <CAMgjq7DeC23zak6Xur=E29qo7JPNvQUMtbbO34Y62jrQjQgStA@mail.gmail.com>
Subject: Re: [PATCH v4 06/17] mm/mglru: move add/del LRU size accounting out
 of lru_gen_update_size()
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

On Mon, Nov 9, 2026 at 4:48=E2=80=AFAM Barry Song <baohua@kernel.org> wrote=
:
>
> On Fri, Oct 16, 2026 at 2:15=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Pure code shuffle, no behavior change.  lru_gen_update_size() now only
> > updates the per-generation counters plus the promotion move; the
> > addition and deletion active/inactive accounting move to
> > lru_gen_add_folio() and lru_gen_del_folio(), which know the generation
> > and can apply the active-window test directly.
> >
> > The unevictable case is untouched: unevictable folios never enter
> > lru_gen_add_folio() and keep being accounted by lruvec_add_folio() as
> > before.
> >
> > Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
>
> The patch looks good to me.
>
> Meanwhile, I've been struggling with the names of
> __update_lru_size() and lru_gen_update_size() for a long
> time.
>
> Given that lru_gen_update_size() now only updates
> nr_pages:
> static inline void lru_gen_update_size(struct lruvec *lruvec, int type,
>                 struct folio *folio, int old_gen, int new_gen)
> {
>        ...
>
>         if (old_gen >=3D 0)
>                 atomic_long_sub(delta, &lrugen->nr_pages[old_gen][type][z=
one]);
>         if (new_gen >=3D 0)
>                 atomic_long_add(delta, &lrugen->nr_pages[new_gen][type][z=
one]);
> }
>
> while __update_lru_size() only handles
> active/inactive accounting, could we rename them to make
> their roles clearer? For example:
>
> lru_gen_update_nr_pages()
> lru_gen_update_active_inactive_size()

Hmm but __update_lru_size is also used by CLRU, so it's not a
"lru_gen" specific helper. If we can merge CLRU/MGLRU, then maybe we
can rename them?

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015529;
	b=WcQyAg4+l66pzNRqOUrMZCOOPTLK5IWTLt7KCOt+T1FTPWm6qjanr/Gt9K7ekNiD/IUA
	 ++Xz2AdDbhbpUN62AHOCOJQ8BFes7plm62JDmuT2mNkXwtbMtXlPnrXPQVoHzonO9H8oC
	 KwWEtauQbWUY18wxfhDLZVuzorOjA89fWXs89fgQ555u2ZnV+XLF8lT9yCqvrBUQ6C5QE
	 jexKAG4H/i9WhuiOG9T92pJnOKbqPT12HinJ8jNuJx+Pf+tmNLSMHbDbcVJJ/awFJedGA
	 MD9DGfgZxlknQhkt06B6Ca1vHmGiALvgiwWzOKuSzbV0v0c2UxyO+3ErsqN00mdDpoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=MhtDXpbRWCIEhu50xIx6ItwVhQLsPfY15TO/C9JpkIY=;
	b=vHN48PGW56HmGNa/QfN9KKUMtddInnnF0lDtyvjNB2Ju2x8TDYDFWBfN9j/lL5yon3dB
	 xm4Fbk7cxH8dKMChsjEWDGGPKtJoGz4NIhS7Hrnc2wIbS+Qrmjy/e4yYDW6q06yNCfCY+
	 w/v/4lWdJAcJ7m/9/524iMxMEdhJh4fPesfk/b1SPnpRFC95fKLKVYSs2RY65bifZuL6L
	 dvX2c1i49lYXJmpgyatRxq+NhpY0JLHocBbouuIbZoUCIVyWyrh/s/YbGFolXDDjp3CPs
	 koaxAm79DZGUX3Cf0HPoj3Y1T72omaQcCACp67b2QK5nodB0I0O3a94QVQpebajdM3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=n1M5ngXu;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA660A263D
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 15:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7AA660A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=n1M5ngXu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9211bbce3abso4282256d6.3
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795015526; x=1795620326; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MhtDXpbRWCIEhu50xIx6ItwVhQLsPfY15TO/C9JpkIY=;
        b=n1M5ngXu/y8iBcKuVYfXl4d+QC6L8dUv58v61qqjGoZwQNG2HUHm3oTEig7/FUv4ER
         jORQEP6OxpMrdt2RMyWZ2QSdzg3TsyjazcpqUOElbjlOABiEeSsdEjmzVUq1lKL/0hOm
         vlNd5SsjX+8r7aMrDoNXfco7NByq8lV7EOfdPaRgYyi4Xt6ozSRCFkTfJlW2a6xkoU2y
         OL1TnOylhn+qvMWIc/pydLxsdb25yEWqg0jYLVeS1Fuj2DalTEqJ7NX6mzlQ0m9bD6lT
         z4tD7tqCINsj+QbHeP74pLhANzfRXWQtNvctEgaKG31mAiOFua30c/wfaxMzwEfGh9ji
         gClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015526; x=1795620326;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MhtDXpbRWCIEhu50xIx6ItwVhQLsPfY15TO/C9JpkIY=;
        b=L6923oov5h/z5wUpmjdy1uLJFSeK1ivVFExdYjDdxHXm4rVxvTkxb4Y4qdycVOEkK7
         EJnd/ooFD6iBjFJi499GynTRaW2txSYgdUUbE2JP48qXlJ54KP2M1Mw6dvHCSKVoNevq
         I85p8ONFk4drPnZ6I37gntgg+afSSUZL9zLDlFHFzWuA3kbP3IEmJZgSIuWQ54/Pzz04
         klODQGxtsgG3fnFdGBGC+Ylc0jG9z6fv87gtPMHCSIyR7sH/ZzKniS7LjqhN1Vmn64BD
         qYh7MRZ/ppDyP9ozSsyrRmJ4qthV1u75d5631xkiEIeDTCgdjuBBOiP0R5leb1jxqavX
         3qBw==
X-Forwarded-Encrypted: i=1; AL+hErGlmDle6pdtbmokt/EAoaZu99206FdmZp4JFQXSlD3pQ6SXCVWHq0Bfhf5eX83mMTF+yLZVkw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+/0/zbf5Tge+V8gyAer9Gh2+lFW5KHWZb5PNBCba/JshaZ1m9w
	1iDYzCRI2eBv74J23g8PS6V96CXkDr8HqouFbXOtHeRt2ZWrvjlFyoxsOcVY3lgsmJ5zt2PUVwO
	8KOCK
X-Gm-Gg: AZFdTZcYRNn1iHgXX1ADegErtEWFMGEmztPYwuZ6GrkMl1bnMTuDU0QrAU8HVsJ3I92
	jrWkds1LtMhmn0MYfzOgGPva+FYHpSd20u/WQTcRAJ6q2ZDuea2otqokfwDwKz8R/SJC4tARQ1r
	aHbc13LvlUlBQ7PHNaU/roADYfLpIlc3E5cHZqM4qDXyjFRq7+M+bbvgrSJzkkTtqiaz43e/vKb
	QzYnLr/vzpOz0ojfHD3RKfo4cegyhQeYUs8eOfv9RBYjtsTwsP9/gyKGfCIJvRMatmYk/mLWwLs
	ZMW5QMLGim+uoq8w8Imb5WB8MUrJHzaaEmHHY957bYCRc2c6hTuN5k19Y9o0pxd4mPYMrel7q8B
	ZvsMX2bZtF+5fJ0vwoCMo9tldCoV0G9A3Rcc2qBjj4wwXbSXB5rr3KWExkxYsIBkVT7cRTgXBYJ
	aGSkLwmsCVZmA4xObFnp3xvNNF+4OxHQLtwc1sg/G+vk1NfbahbtN9mGboczMFpF8m6S2iyoCyQ
	iYwQuvyYehjpP6L7PSq4+FTo8Ge05WOgrkr+ie9zL9LZJCmJZDDbpR9tpz7k54MlT2Djnnl0GO7
	Rq1LB9ZpLhewJv4bEOdToG6rn4gwPp8iHVvSSCrRLORVVHNRQLHGBMAOQ1CM0F9Zon9ZIauqdna
	AvwbaCvQ=
X-Received: by 2002:a05:6214:240d:b0:91f:12a4:27f2 with SMTP id 6a1803df08f44-92114c4e8f8mr45557396d6.6.1795015525386;
        Wed, 18 Nov 2026 07:25:25 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921149f9c36sm24415306d6.5.2026.11.18.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:25:24 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 13/22] mm/hugetlb: restrict pool growth to common
 memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, 
 damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <av1PyBvUVJcy_Psd@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-14-gourry@gourry.net>
 <av1PyBvUVJcy_Psd@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:25:22 -0500
Message-Id: <179501552287.1206716.17381960047395782233.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 15:32 +0800, Richard Cheng wrote:
> > @@ -3802,23 +3801,21 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
> >  	unsigned long allocated;
> >  	struct folio *folio;
> >  	LIST_HEAD(page_list);
> > -	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
> > +	NODEMASK_ALLOC(struct nodemask_scratch, scratch, GFP_KERNEL);
> >  
> > -	/*
> > -	 * Bit mask controlling how hard we retry per-node allocations.
> > -	 * If we can not allocate the bit mask, do not attempt to allocate
> > -	 * the requested huge pages.
> > -	 */
> > -	if (node_alloc_noretry)
> > -		nodes_clear(*node_alloc_noretry);
> > -	else
> > +	/* Scratch masks for allocation eligibility and per-node retries. */
> > +	if (!scratch)
> >  		return -ENOMEM;
> > +	nodes_clear(scratch->mask2);
> >  
> >  	/*
> >  	 * resize_lock mutex prevents concurrent adjustments to number of
> >  	 * pages in hstate via the proc/sysfs interfaces.
> >  	 */
> >  	mutex_lock(&h->resize_lock);
> > +
> > +	/* Fresh pool pages come from the ordinary allocation domain. */
> > +	nodes_and(scratch->mask1, *nodes_allowed, node_states[N_MEMORY_COMMON]);
> 
> For a global request the caller passes &node_states[N_MEMORY], so before this patch
> the grow loop read the live mask on every alloc_pool_huge_folio().
> Now the mask is sampled once, before the loop.
> 
> The loop drops hugetlb_lock and can run for a long time. If a node gets its first
> memoroy in that window, the old code would start using it. The new code won't, until
> the next write to nr_hugepages.
> 
> So the pool can end up uneven, or smaller than requested if the other nodes are full.
> 
> I think the nodes_and() should be placed inside the loop to keep the old behavior ?

I can make the adjustment, but the concern is that previously we'd
start spreading the distribution of hugepages differently when there's a
race between hugetlb allocation and memory hotplug?

That seems like a pretty innocuous corner case to be worried about.

I can see about retaining the old behavior, but i'm not sure what you're
describing is reliable behavior already.

-- 
~Gregory


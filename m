Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017082;
	b=mEE8dL4Ppw/Z+BvBx5I2vT53d+HxoTIPtedkkrl0nEUEzukqOm0eLJ1n+teWx7U6RGS9
	 SYp0ABJ4SGcFr91EWnC85SGsu9iVXGbZu93jPmwXw4jfsepplFJuRNzErj46CJMR39YdT
	 aVcNfMo6zistCMA4DLQmgttVPlOM4aWFcrIvuaztloPwwlNHQplRiN/XjVnaDZ+4ft05Y
	 FCfASbVdqptTGD2RbC2KsnvE/iGIPiwTKIjlwb2AEwad4hy+ZngIZgVwsWe4INaGE7JQ0
	 X0G//ubRKrXEcQhzkPJW3ZEFhR7FheNMn4UScX7zWdk0Dm0O+LRqpgtJIjI1x/gCaVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=rtu+dm+kZUdeiLu+ztbJ6g6Gzpa+7bPUZ/F65mvaYZ4=;
	b=CWbcmP0qottB4MxesxcULBeMw6TnJghOsEaRq5mPrm/3emYK1IhgrmElh3Oed6nWfAx3
	 VqjLvvsnLMTGwtZJEqIYKvm3K+NBxUkJ7oQP9g/Z0RQCWYRa7MFxyIrjX6EZ5BBtKfmCA
	 gEpXD8bbpv2F1sebpnjPrCEPp3MVxP/olZgKLJmogrsWMF/BMJ5coJyjdiyZ5GYfK6lne
	 TEKkp6euisDPzEnyquB3Ocp0wnFEGFzqXvgspIoF8etlKJ4d5rn0l3NVGAE6b461maEdn
	 9jO6s37iWCWQdGCu0I59Ngo3o/85sytoDtdG69aOyVfwQYiRncCqHXPonYxLjiCEvxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="nk1drAx/";
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF360A2608
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 15:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15CF360A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=nk1drAx/
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9495f083657so142895185a.0
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795017081; x=1795621881; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rtu+dm+kZUdeiLu+ztbJ6g6Gzpa+7bPUZ/F65mvaYZ4=;
        b=nk1drAx/FkoeeOOf5cO6WSDy/W52HpDkTui7c7weLjLdXZgwhbuqmocFgaoxHoJFTn
         jTYkPHuMAbVwaWU6WTM2TC0WaC0GRp1rLBMvCMIQryDbcdXJY/h034M5Qddoi376BC8s
         H3kVArOPR0HP2/AQZco0NMae+ZH1ad5w+VPynTOVRRhTIQloayuVPMuQbJufy9CR9Rw8
         KpM7cHnfhi2ifp2+MeeoVuFW5EXsvIlN0xR8hpWHr1FmsBmhNchSWNidqNUYFCzsVIkG
         fhq5wiRZRJSsxlcltX5yptL3EGxpsk9CBgpNGFlo4A5JT7++qZBR3wigvolR9aRyy/6O
         qwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017081; x=1795621881;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtu+dm+kZUdeiLu+ztbJ6g6Gzpa+7bPUZ/F65mvaYZ4=;
        b=Rql2OpU1NGgN1XVjFcDJng0wspiblI9h0+Kltsam0pV1/4LQvu+phq74mg0qBDVvPp
         uSMkiPzGVo1LnJTB3/pG1zlTohSMyHOCGcmgEtd2XjBtWIc1/1Z0Tu8MY50xKZPvxFCi
         YGOFBD7lrMyWZ1mWUdDUD0P2QWQjQguPtb/nLHnGlBD9yCOAUndZXQV4ZB85hs9LYbcA
         jyYQAh6m0njshz7s03brCJDp4wG1pfwhUBekwMq2SK3GyYcJvqOKWnasI2b0KRmQKojB
         xuKSoL4ZVRIbc2uPKiv1TRiDYGlmrpWAUh2if1ZC6TuxXdga8caD5wQ2PdCuMdJDZjMF
         zESA==
X-Forwarded-Encrypted: i=1; AL+hErGHPsAImV22Olmrh8pCcGZ2/p2z3qlrd82RGGmUivShPmUtNj+7TzT+3nL/SE4U3SV2EcT6Ww==@lists.linux.dev
X-Gm-Message-State: APuU4Z8XzsjQj/R9Z7l1ICpOOXzF2OhZpyC7jbj9r7In38q//u/C6krT
	NMpnomQj9gpaF0m4dO+M1tGXfqtqKSb9IjiyVlr1pS443BcRndpZxy8/veirNlL+jzUd+n83VdG
	R5fup
X-Gm-Gg: AYBFou0JRDPSWfDcE5XvSEXftl2dDEYRx6ohg+b3Plvoygfp3KaI04n/pMvKpGT0/G0
	4RZPb8YNvpfJOWGB9hr2IltHVbnbqGC3bz7a8zoT6lgjxBJre5JzaWcQXeITsD9h31ntVn6bogT
	LGS23a6w3Sv3ZZqCmvP8di74gxrWxsVRqiu2DL5qwg9hQnri8M0+5PzHN7p3IVQjF9oCzPUU15I
	N6UJ5dNMKdIFlxZEYDdmxiRA94VmUsua5sQqf3loZTDrzzbspUhjBdAH4XSYYI9lTWfc5euA+Zy
	PW1nQICbvnjlog94SrTrbN27xaASU5W0btDGM4aQp0yeHzX7I1bnpTVtSQbg4VC5dyIgPBahQ1r
	CvXP2rJKaSS0rCmwjijgN7JWl/wc1hfOpRaNGhmszSg7pCtJdpDWO5z6UcWhiFPvHZM4raVBqae
	3Odne/IRGent6+Z/3ed06RLRKD0Tcv30ta2f+EZv9Q/Ai/Dnt0D3T/sQr7SvU5fH0ZLCDMBIlA5
	XQqdgD9z6cnLbSEnvRw0FhTafGtj+SNTSsNFJiYHpRVoCn0K2oaOFYaTiVCF9htql4lyEDxVGSD
	/3ji44DoG8ZhIca27blgM85I/gXl2qrMcrAXZ040Gcfi31b5HmSElXc77dHoZ1FLJQCovnzEVR0
	5DLYlRek=
X-Received: by 2002:a05:620a:8086:b0:93f:2938:48ba with SMTP id af79cd13be357-949997ac21amr514417285a.55.1795017080864;
        Wed, 18 Nov 2026 07:51:20 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b454facsm210842185a.5.2026.11.18.07.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:51:20 -0800 (PST)
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
Subject: Re: [PATCH 03/22] mm: introduce the common-memory node state
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
In-Reply-To: <av2_8Z2sdM_9zUEL@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-4-gourry@gourry.net> <av2_8Z2sdM_9zUEL@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:51:19 -0500
Message-Id: <179501707902.1206716.2408532904937875068.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 23:24 +0800, Richard Cheng wrote:
> On Sat, Nov 14, 2026 at 02:09:40AM +0800, Gregory Price (Meta) wrote:
> > N_MEMORY is overloaded with two meanings:
> >   1) a node has memory.
> >   2) a node's memory is reachable via ordinary allocation or
> >      an arbitrary MM service may use that memory.
> > 
> > Allow N_MEMORY to mean #1, and introduce N_MEMORY_COMMON to mean #2.
> > 
> > N_MEMORY_COMMON nodes contain "common memory" capable of being managed
> > arbitrarily by the kernel MM based solely on zone membership. Following
> > commits convert relevant N_MEMORY users to N_MEMORY_COMMON.
> > 
> > Add folio_is_common_memory() and page_is_common_memory() for MM services
> > that walk folios. Following commits convert folio_is_zone_device() and
> > page_is_zone_device() callers accordingly.
> > 
> > Expose the state via `has_common_memory` so userspace can identify
> > the memory available to ordinary allocations and common MM services.
> > 
> > Add has_memory to the docs while we're here.
> > 
> > Every node with memory is common, so N_MEMORY_COMMON equals N_MEMORY
> > and there is no behavioral change.
> >
> 
> This sentense kind of blurred me, you state that N_MEMORY_COMMON is meant
> to isolate the concept of #2 from N_MEMORY, I expect something
> making clear distinction between common memory and private memory ?
> 

Sorry, basically as of this set:
  node_state[N_MEMORY] == node_state[N_MEMORY_COMMON]

Later, we'll introduce N_MEMORY_PRIVATE and the sets become disjoint.

I realize posting this series in isolation was a mistake now, and I am
going to post the entire v6 of private nodes with the reworks you
suggested instead.

-- 
~Gregory


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014796;
	b=VkBwQvVt+z9W1JSp8552/R/Uulou2loqqetk3xApAz9ag5ZVfdL0C7wK63BFMltRDlMN
	 HWpooq3p0b/LlSd1gaMu8ad+Y1kvPmzR2kAJNYaAcqZr8qr1VxQBcMVQNFfoIFlxPe+sk
	 5RQLiMWTXBai85169nZZF9qIXHbY7scYIyRewBkR3G1YZQhI/v/R6r5G6+8vRiJsSUgL/
	 W20yWRDSMA8Dapirxr7m5b+3c2QJtXeaaMk58WNNzq6AUpd3kKTHJIn9q92QGsMbxjAkf
	 XSBvNKCjj4NudvnMieIdO8TWHG4HlM6v9sVQaan5qEwU+2TZmH/R1Vivuzgx+t6HWXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
	b=CbZWE2tw0lo/wbTg3v0o6CWjwICcgYf7PHSS2NvAkq2G0sF2kj1YF5T6uxVButUx20Hk
	 pBBxI9+WwT78qlLlGK463RjJXMCCh4nnQOlQu755F3lVSsu6HfmYnDuxjuGeL2639e+Vh
	 0GcSqF/qRTxG2M7rtBIZ1qrSRrhcVvrhv3CRDOFHz5Yx93gRxuujF+2UN56jkVnZm+S7H
	 kJWszke1YpyySl+7QGT8JZwmU8bl+9S1PbImpQFGN/0Wkoet0nbkzDBd/VZL492ds5Pot
	 xNCTD3DcacmiNueBikQver1cJtn0WBsfj5htDVJQegiEmn+G8DFvuOt+13fwnm9q2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TpfpoMul;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B254606A32F
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 15:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B254606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TpfpoMul
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f20c3aaa5so105860885a.2
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 07:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795014795; x=1795619595; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
        b=TpfpoMulRrnRIK1YCAb/W/aLXf+Gv4gZSW1XLMad1ji2f4dB8Ma+aaN7GLS4q98O2F
         cV8osBb91LUzXZpsJJItfx1Q2fEqi30Bif39fxpBvA7Ll80CeVT90ywwVyNwzGwO1+h+
         /IjFVRtw03pyemKVIG1nB1WDXEzQOcMTB0tI2zFOj9q878FDWWzh0lQ0A46jdLXCVSSm
         1XY2Ri7ilU67zotZ39tQM2Q3N4DKiZ1X4VwpujIsYqe1lLs5wLhpuHfYc4WzFpUY9nRo
         KsA/NMyWVoskrKjYEyxC6zSgSc1oDLB4MR02o/p9Q+1pT49PSzyf4s+LxmGfLasXroH1
         tuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795014795; x=1795619595;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
        b=CDG6F6UHYNy/oW8ZsP/dF4XwCCHGOmQo4GNUtLa/UcETAa5yDKMwtE/wbMMFn4h+el
         oB+/w4vWpwJY++DpifZ33YBEi6OJ1bajrulNpCIti+f/Q6kJZXO34VnKReCzLdPwpD/m
         SDS+MG5DGmMR5IqcgyeXsrhnnUENlSZxdd9PA7bCNCx+EAQHkBhL2u92rfyJua5/E+21
         xL7+2fZ0aF9xxja3qfnYjLc+k4++ReZRD2mNSpdgRc5iVvLJ1r6Z5xJVupHcDJCKfzig
         iaF5GC9Ei5UOSKkrUM+qqeJz83gSuvXItY1jx3hI4nToluDbqtey6IsZBwQ6VSDxSvFb
         dwjg==
X-Forwarded-Encrypted: i=1; AL+hErGhHq3SFItecX6LkQUfVwzK4XBl88b2o0UoaxpQhK5WVKNa59XRtWNJkrINAJfziu2LpgnYRg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+nRDOUONQWtTYDJgCrgQG+IImvfYQ0a68i4pE5OmdLZhUsLC5h
	ibCCCzwlOz+tTuopXoVQayeekfrauo+BLQjdSQZ8S2MXBlw3G0MwsBknPcSK/VEwGu/nGmtQJVu
	GgtEV
X-Gm-Gg: AYBFou2R/nX09rXfLwhPfzHNypkOPdHa4jcN90zRAgLsDxrV8wW8U2gXxVc5cTzyP8G
	LmFNI5gcnKsmldSuU77XXAz0UIdsGCJo0PERfoBjsuBQMd8X0pOh5t+ZWfxJSLG/Ch6zWSe52Ad
	27uNf2fIns9HlUC/GhUhrgtUrYgdQ5+CveefG4U1tou+QxGhsiqD5uVYpWh3SC3aRFAa6hB5mQM
	GvRb9I0+IPt2TSnSUUnYC13dzcIwbNHBJJT9ZtFH3G+Nx9ji80g+3VeB/1IesCnibloKQK6GqGQ
	i/tHCvL9+dUD4fAFADSSbpgatia90S+bm4ioOrOU7psujUwgbdMl3Zi8BIexKTADSW17OzD4uZ1
	r5GI5nSgvp/Me8AjW5uXpiqLE90gcaZ9D/HqkhCOjbB9S9Q/p+v6t/DG1QK81HKiQNnZRnfoX9g
	dsgk0LVcsGiD1h66ed8LggFlT5roMsgg/PcB5WziF72LzPJnplYMOyiuJBSY7CyWIK4gaYJ61EM
	04i0JIW5obSIepVI/9SeRb6c4R68vAobFwnyMq7olGM3RZbmMKi2xjxGK+tsJ67GkSUHbQJQwCE
	s4OCB1kStlqwmfyokfgidJff1l2rDuxh4ylaRWeHGX9Ev1voC8hNVp1e8U3Wk6ctiYY+1zWLApb
	VGA0aMFA=
X-Received: by 2002:a05:620a:444b:b0:949:6d95:f63a with SMTP id af79cd13be357-94999810096mr508584985a.78.1795014794676;
        Wed, 18 Nov 2026 07:13:14 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d70a8fsm23976506d6.30.2026.11.18.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:13:14 -0800 (PST)
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
Subject: Re: [PATCH 00/22] mm: introduce N_MEMORY_COMMON
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
In-Reply-To: <av1DvCQd_OvkGgLU@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <av1DvCQd_OvkGgLU@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:13:12 -0500
Message-Id: <179501479267.1206716.268867271510310543.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 15:01 +0800, Richard Cheng wrote:
> Hi Gregory,
> 
> I've browsed through the serie, I'll go into detail in each patch
> in the following days, for now I have one general question.
>

Thank you for the read and the feedback!

> I wonder how the "common memory only" rule is enforced ?
> 
> As far as I read it, there're 2 ways:
> 1. The zonelist, you build them from N_MEMORY_COMMON, so non-common
>    node isn't in any zonelist.
> 2. A check at the call site, e.g. node_state(nid, N_MEMORY_COMMON) or
>    folio_is_common_memory()
> 

Those are essentially the two cases, which are already present in the
code in one shape or another in the existing shape:

   node_state(nid, N_MEMORY);
        or
   folio_is_zone_device(folio)

With the exception of one or two places, the series largely modifies
these locations to use N_MEMORY_COMMON instead (or in addition, in the
case of zone device).  There are a few places we add common checks where
zone device checks were not already present (because they were missing
or did not apply, usually PMD scenarios).

> 
> Code reaches a node's memory in 3 ways: zonelist, node id, or by folio.
> I couldn't find a statement of which mechanism is responsible for which
> kind of path.
>

Being a bit more precise: How do we reach a node's folios/pages?

 1) through some kernel structure, obvious examples:
    - page tables
    - VMAs / pagemaps / xarrays
    - LRUs

 2) pfn walks
    - memory hot-unplug
    - contiguous allocation
    - DAMON

 3) page allocator
    - freelists (page allocator)
    Sort of its own category since you ask it for folios from a node

> I see some consistent issues,
> 1. zonelist paths are covered by way number 1. Some of them also carry
>    way number 2, some don't
> 2. node id and folio paths can only be covered by way number 2. Some entry
>    points have the check, and some do not.
> 
> I can't tell when a call site has no check is deliberate or missed.
> This matters once non-common node gets its own zonelist, as patch 4 metioned I think?
>
> Could you clarify the rule ? e.g. which zonelist users must filter on N_MEMORY_COMMON
> themselves? and why the zonelist alone is not enough for them ?

Some of this is obfuscated by the fact that the existing code already
does this filtering for you.

I suppose I have some premature changes to add additional filtering
where it isn't needed yet to reduce the complexity of later patches,
but I can see why this is confusing when introduced by itself.

Consider this:

-       for_each_zone_zonelist_nodemask(zone, z, zonelist,
-                                       gfp_zone(gfp_mask), nodemask) {
+       for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+                                nodemask, N_MEMORY_COMMON) {

This is a bit of a preparatory change to later convert this to:

+       for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+                                nodemask, N_MEMORY_RECLAIM) {

It looks like we're filtering by N_MEMORY_COMMON, but we're actually
iterating the fallback zonelist (constructed from N_MEMORY_COMMON)

  struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);

Later we update this node_zonelist() call to determine whether the
private nodelist should be walked, at which point you do have to filter
for service support.

> Whether every path that takes a node id or a folio must check N_MEMORY_COMMON, and
> which ones are left for the feature bits in phase 3 ?
> 
> Let's get the rule settled down and make it as the foundation as well as phase 2 and
> phase 3 ?

So:
  1) If you're walking the normal zonelists, you're already filtered

  2) If you're walking nodelists, you need to filter on N_MEMORY_COMMON

  3) If you're operating on folios, you need to check common_memory()

  4) If you're walking the private zonelist, filter on N_MEMORY_COMMON


So let me do this:
  1) i'll restructure this phase to omit premature changes like above
     (they'll move into N_MEMORY_PRIVATE and N_MEMORY_<FEATURE> commits).

  2) I'll restructure N_MEMORY_COMMON commits here to handle cases 1-3
     above in that order, and that'll hopefully clear up the confusion.

-- 
~Gregory


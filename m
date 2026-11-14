Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794642613;
	b=YCiQnl3NWoH8/gD8vqT52in7jvt5jznQWGjNOBWfuZzvscFimK9zVnfzFw3v3w+VoA22
	 7nV3hkj34lbe0EQzkS/ddSkWOg0F/u904hv7+Efy7cCoPmR7ow0cqFJbR2WqwVFb1dP53
	 SVVMZXvvbjs3uW/0WrJ0HFsbBLuLg/PSFroekoi6wzcKO6ajw1m2kVUqNTOeDmIctdlGC
	 KtvyvWxJc93vbJ4qw+cIgHgZTMgc9LoPEd8ujUy+NCEoguO5OET/Q9LPnwhUlUKGAijYm
	 CQHa7lfkhRs2z3dWSA4hOoYrJWCfmMLZ8fnuMs0wOEuDvcD2q4pW8SL0fiwgfj0Cebg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794642613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=cGbHDC4e4qa3gSIc5H3tZOXqH9VLSX3BMg1aP/6Q428=;
	b=qU+mqnzeta7lL+Xo4xlj7BaFRqQoJAn4ijyZor7b8epbhhXh9SCsQ7/IqfkBswPxBVSR
	 4aWUTEghj5k3XFMEFnR47bA1QDvJHh+C4/k1dglItJOsvnDiQj/15ZthluRV5iQjdAkyg
	 JT/Ag8U4XyWH/qXww+ZmKLAGXSIu3je0nv7x9jNFadUaO1EzEm+XhMCmVHKCI1j3HPJtT
	 Mb8x0UV+yqsfb6qSSR3rxEmUA+37tpYWgQtmTx5CVZRffZ5fncDi6ywUFI1yZ2ApamWXq
	 86aRIFX1WRD+jHyTOjb/aTiAAISPb4zSS0CtE0WSOlkmbb/IUwtjtPdUmOO1T4QesWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=KWBuS8ym;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24AA606A327
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D24AA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=KWBuS8ym
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5495d549924so28150011cf.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794642612; x=1795247412; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cGbHDC4e4qa3gSIc5H3tZOXqH9VLSX3BMg1aP/6Q428=;
        b=KWBuS8ymLgXMeowcI1ln8kTP/fjpRDBzRphtqoLoepiRZFzYj3a8MB16alM+Wm9SKm
         7LoqcYo36AZKsIld/Ponzjsfal8aL6plzpvWOSWRPzYLW0Vjsnohdu6jCjrapTXIxWH7
         D1bXMDUZZVB9ICGGcLvxjYZd/HF5kiWgrIZaja4WyvgIl+xCTLMLCb3637NoSxE59m24
         HZQoKeyfG0+Ip7hVtf2y1hpJ+7ExCN01lqnNrC0fXhmS/EE40M/dteDvKDFgAXSbVfNm
         8cwxlkmVc2M1z0yKGzbici/vRhXich/7BIoYvUUE+rpljKDtmrsF18Wg8Tjk8pkuBwT6
         mu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794642612; x=1795247412;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGbHDC4e4qa3gSIc5H3tZOXqH9VLSX3BMg1aP/6Q428=;
        b=ugxWPVPw3/P3NknI0HnKV9t85FoLrtdjIiUfAuSTNT1parqEok87Z0Can1wkZ61l4w
         pISyc0MIEFzS8VdFlUQ2QmTQ1k0fu5leKSMm06LFhOk9LY67X5CmUUVlH2LnbZOGvrYv
         4Pu6//WtO4qW6oorvWcj6pUjUMr9k8NnOtg/5jZZyf93vxSVuiDdVpGcM70f1/qE+gzG
         N8Pci+iX4esKoip8X23LO4/u4lEGo2jkWazkmuqKDXWFz0RghO2aurDaLjMTK6g6vml+
         1eaQ1CD7dYma+qJ8q7kwpHxGzGuoJhGyGWQb4eO7L0PNRTf7SvOvaMrgKHvQcbo5n22E
         k+Ew==
X-Forwarded-Encrypted: i=1; AL+hErEBv+NDFuOmXJP8Cy9J1ZNWek8MEVRJB8WPuzrHtwhQn+FtIH8u3CDn3V86haD5GcOzXSGjSw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9AkjFbAYZz95OUCYTz7no/oSidUwriOTQ8ms7mD0qKzN1jf9B/
	3nQsT5S9KzbO7TgkwNjTfJQrdUHYQjy9Zg790XVPJD/xpz2k26mj9svJioSaCASjuSs=
X-Gm-Gg: AYBFou3va2Wbz3yNTHEW2XTujtG4ShRUV5sFR0eHpQnn+cIAvmLQTvZg8ipNaHNKpmq
	jonN9/UntiHIVYlgBb1CeQOe+U7dKy0LhZPrrw/0XR1s0OOuk7XN62j4RPxfBHRdIjSwx0+E9ji
	gAM6WNW1lkvtKHF9y2ar86zOJWA/9JXyPPLnt6prXGAdZkAkYLdMcGsaWQaFWhSXSWQAo1fss7L
	9b3UVGJNXFgwVo9uRdCyPI6F2m2WYEbkYJOQEF53JhUsffLMw24BlYUMMb2sC7heZX13/7bTR9X
	r9oPQgXI1/2A7imV7RZuDIHtrrext5vAmQvh04qJWnnbCADwzbK3w0pQ8UWqpCQ24CGWwu74g6c
	+Fgt1cxFBlSsNYP8nUn3Nn2+91RkJFF8IX9OoTKxoOuVok6Lh+H5IgBPfqWx93QR1CvXIaVVPbm
	Hn4VUOitszmS1jioNBI2oN3MQjjp9+I/YR/DaJ00TGrdNk6q+X8yVsbCVsms1Nkm2PnMQ1thnEJ
	i7YKybTgEMl8FK1nLtrA+pv5WKciPEqE0T58V6Mb7+SCv7MVZp/m6OfHrBltV7JhF3X820q+yAG
	mkwkho9DfzHjgnz80QVGnLOLJ3eWGZoXFCASHnA2BibxPrvo1z9VEc3pCpXZ80ts5bpqAfSBvMW
	naksdOIA=
X-Received: by 2002:a05:622a:4890:b0:536:6378:c80d with SMTP id d75a77b69052e-55ac7d4f0e5mr76447071cf.32.1794642611571;
        Fri, 13 Nov 2026 23:50:11 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d445d1sm38109806d6.8.2026.11.13.23.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:50:11 -0800 (PST)
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
Subject: Re: [PATCH 20/22] PM: hibernate: size the image from common memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 kernel-team@meta.com, linux-serial@vger.kernel.org, damon@lists.linux.dev, 
 linux-cxl@vger.kernel.org, akpm@linux-foundation.org, david@kernel.org, 
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
 mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
 rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
 dakr@kernel.org, johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
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
In-Reply-To: <sashiko-outbox-214264@kernel.org>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-21-gourry@gourry.net>
 <sashiko-outbox-214264@kernel.org>
Date: Sat, 14 Nov 2026 02:50:09 -0500
Message-Id: <179464260972.482102.15351839494267219366.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-14 07:34 +0000, sashiko-bot@kernel.org wrote:
> > @@ -2011,9 +2013,10 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
> >  	struct zone *zone;
> >  	unsigned int free = alloc_normal;
> >  
> > -	for_each_populated_zone(zone)
> > +	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
> >  		if (!is_highmem(zone))
> >  			free += zone_page_state(zone, NR_FREE_PAGES);
> > +	}
> >  
> >  	nr_pages += count_pages_for_highmem(nr_highmem);
> >  	pr_debug("Normal pages needed: %u + %u, available pages: %u\n",
> 
> [Severity: Medium]
> Should count_free_highmem_pages() also iterate over N_MEMORY_COMMON zones?
> 
> On CONFIG_HIGHMEM systems, enough_free_mem() calls count_pages_for_highmem(),
> which calls count_free_highmem_pages():
> 
> kernel/power/snapshot.c:count_free_highmem_pages() {
> 	struct zone *zone;
> 	unsigned int cnt = 0;
> 
> 	for_each_populated_zone(zone)
> 		if (is_highmem(zone))
> 			cnt += zone_page_state(zone, NR_FREE_PAGES);
> 
> 	return cnt;
> }
> 
> Because count_free_highmem_pages() still sums all populated zones,
> enough_free_mem() continues to count free highmem pages on non-common nodes as
> available room for the image, undercounting the normal pages needed to back
> highmem copies.
> 
> In addition, alloc_highmem_pages() and prepare_highmem_image() use
> count_free_highmem_pages() to bound loops that call alloc_image_page() or
> alloc_page() with __GFP_HIGHMEM and pass the returned page directly to
> page_to_pfn() or swsusp_page_is_free() without a NULL check, which can
> dereference NULL when highmem on N_MEMORY_COMMON nodes is exhausted while
> non-common nodes still have free highmem pages.
> 

HIGHMEM can't exist on a private node.  Private nodes require NUMA which
require 64-bit.  As far as I know HIGHMEM is 32-bit only.

Trivial to update though, so for consistency i can add it. 

-- 

--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1291,16 +1291,17 @@ static void mark_free_pages(struct zone *zone)
 /**
  * count_free_highmem_pages - Compute the total number of free highmem pages.
  *
- * The returned number is system-wide.
+ * Only common memory counts, since image pages come from common memory.
  */
 static unsigned int count_free_highmem_pages(void)
 {
        struct zone *zone;
        unsigned int cnt = 0;

-       for_each_populated_zone(zone)
+       for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
                if (is_highmem(zone))
                        cnt += zone_page_state(zone, NR_FREE_PAGES);
+       }

        return cnt;
 }

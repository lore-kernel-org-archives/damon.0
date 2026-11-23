Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442546;
	b=sSRK1JfcksUiioqrbIHbZA6lrz05JtcBidm17gCVY4VWOU9FE55EhruX+ATvS8CzuIos
	 avQc8eM9nNfthFYRDBD10WYJTWfJCaKzuu21tb8mSj5RJY+nEMJ30+EmgkLojzHLAGGJV
	 pQceZcYjcJzUG2sNWGr5IMxqN7B7InWJ7I4dHECrE7bx1wZ8UJPktCxNbzX7jGu6gAW7g
	 sLylJISm2kc1dtqbzAqx2GRVuU1r7e8Jzcb6cFF6dHHmphuLajtr2+NAvqhw63jMBgpQP
	 Q/9TNvbmUxBqbHNchjes6bWYmw2jITfFOfpTlbUS6VfmgHF+y2HOKjmRytWxfFq9aww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=K3PKiWxJL5rA78k4RAfL19Ict6G9pZhcXRFYMUNqZcE=;
	b=BZeGS0gSsRfm66XgNgjxOOrC/bc8GQcQEa9ymv65sjhmGeTZcQs3ERDJkecbktuWs6tu
	 wi0BfqaAxrNDTIVfv8UHFCJB6DWm2PAZb0GJOqt13bN3WgpF3ZIMT5RBgDUVnjWBjhEBv
	 Hm2tqyKcKNCL3GBVFR+kNKxLqTGY4/OrRAcKyPkoV3DpEtRxmqX0rMElp9HrLma/LRBwL
	 ThCUr53CSXEPnIOX2L8vETYuDRGGAHABMec+2iN/czgrly/gk7lyZ8GGNrO9Dt2/KWIjP
	 JfDQLTmstMzwb+vKHTa9EFUg7zzeCXuISEYGh7DsjSoTWxTtKAx2hAWC/6puEaqs3kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="LTaa/hni";
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F87606A680
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 14:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F87606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LTaa/hni
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b502b9b702so36112687b3.3
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795442545; x=1796047345; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K3PKiWxJL5rA78k4RAfL19Ict6G9pZhcXRFYMUNqZcE=;
        b=LTaa/hnicT888v9SHEA5tGVCKN/z1DRTPjA4PbYn57zK1mAzsI2Gp/XK9LEY2cQx6k
         A8x1nF3+Eph9f8AGeyK30xpdqpr9SNV6LmmMYuCVOff78QtrhGrhZU5VxFt2RjLjzxiq
         5VU9Iha6qt+/0sBtVNExIvm837Yaf6G+aaKsVWv81KNHvTLp73W7WUie58esc4AOQ6tt
         twHyATo9XXBvOO72zI3cIMMRPes2jiIetO9o108JWTZE+LLTMU0gUgWgEgfJo6IVK1H8
         RnMPgRZZh5riqVbkR/nss2W2/CMGKLROw6mtVCmrpNsLrFK7TZJv5RAPvlpL1xhdhywb
         OgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442545; x=1796047345;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K3PKiWxJL5rA78k4RAfL19Ict6G9pZhcXRFYMUNqZcE=;
        b=Uefx05RNQL0KwRBkK49sw8VUOUn1d7vvuryWvQLieXwYvosO/owefqfcJVT7XN263b
         ceJAL6h5n+JRq4YSifPtnzFCxNfL6wx+vdYtztoMmVnZWgQHf5MUK2Q6OUq7Dd3+chWP
         yi9Y4sD3IaxBq7GZ1bHyyib7SOskOtXZK2zpgoSs1h6e2LxmT0bAvAVxBlcySYvEl1hD
         pqqtRP1Gszm6NywCufvtrPDw97J/KzIIlbqjqpRR7vLj/dA9Vx7ixpLP7Zs4/JsNCz0z
         lQVz3BfeDRDuouKs5tr3+Ib5r4BWkTwCDyubVKIHDx/5zBZRxXJbeHUQ4M3YkxX/ksA3
         kttA==
X-Forwarded-Encrypted: i=1; AL+hErEaJUc4wpWpey1f+tkB+Fc6X74Y+2k6gdovBfX94uGU5e5plZy/q/al7+j+AboEpfwZsBnxnQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9nu4ev0U/KE3zTLba3pCHGT6p/w70wsW2Hm3ukdgJshIGsKyXD
	sDmLMJoJcm4Nd7RYBzNVnFHRo2qxiSae8Jy1xxbgHZQfMymp00zGT/FXiMOC/E35qfw=
X-Gm-Gg: AZFdTZdu4WlbSnq3dF5/WDVb8yDVgsPkAlvuJ8uctElq6+xYnjTv0XwRq4bKl7sZmye
	vU30qQ1zDdR5dRV8v6qIfiLIgC95z18Czee4qhysGZQ2X1MrKosEO2ojg4s5JVayAqvmFnP0JdQ
	gxilFR19BfiSEcP2K9j8PdOa19yAt/GkTGjQbAeTCbnA8W7i7OfSBR9Bs2exy6IzESCes6AD3Af
	ZFp+rzOOXjfMiHfvJlwrxnUSXWeMpgnvyyl4c62/LQWv043tq7dw6PblVWfyu3R2YKK4J/nAxLn
	+RHdDHDXWGBwl8a1D7J2tACFzmjJXJJ/gyNFMSv+nVc2oBxunmZusvDaArwTTP3Lcm4Ct40hIcz
	8MA3GxyzBQkq85CHGMu8IE/+BfxUw2BwycDlL83Wpaqi/UvnQ15Voj9CrXosN2cbwsFM1eEU6tG
	8eT/SVfU20RPbT3HBdWycjXNVsyHp1VKAURHVpz/qzfFkwzxK8rsnYdBrndLQjBU8vBV4Nlj6dc
	vU1oSv54V9dCEsWVzJjs3qQX3iN8ELElBF/DAvFiSK7rNySU3/6M75VCei60WiStaAXHejTAFEn
	6F2u5UJIWxyuEIv5cW7EL+hToF3yMxHCiO7aKGzb511OObvpBmjQtmybAcO8k+OMQIb8rLgTR/K
	2TuRv64c=
X-Received: by 2002:a05:690e:1449:b0:67c:b95:6753 with SMTP id 956f58d0204a3-67df451a476mr4209002d50.146.1795442545280;
        Mon, 23 Nov 2026 06:02:25 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213515f467sm104854846d6.41.2026.11.23.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:02:24 -0800 (PST)
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
Subject: Re: [PATCH 18/60] mm/khugepaged: base the recommended
 min_free_kbytes on common memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: gourry@gourry.net, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, SJ Park <sj@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 Jann Horn <jannh@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Youngjun Park <youngjun.park@lge.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>, 
 Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 driver-core@lists.linux.dev, damon@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <awMbTMt2M876rTy9@yury>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-18-74f5f9a115c2@gourry.net>
 <awMbTMt2M876rTy9@yury>
Date: Mon, 23 Nov 2026 09:02:22 -0500
Message-Id: <179544254257.412063.6102711886866280853.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 11:41 -0500, Yury Norov wrote:
> On Fri, Nov 20, 2026 at 01:09:09PM -0500, Gregory Price via B4 Relay wrote:
> > From: "Gregory Price (Meta)" <gourry@gourry.net>
> > 
> > set_recommended_min_free_kbytes() reserves two pageblocks per populated
> > zone to help THP allocations avoid fragmentation. The reserve serves
> > ordinary allocations, which use only common memory, so count only the
> > zones on N_MEMORY_COMMON nodes.
> > 
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> > ---
> >  mm/khugepaged.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 2dc4245814df..a930d99f89da 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -3151,6 +3151,9 @@ void set_recommended_min_free_kbytes(void)
> >  	}
> >  
> >  	for_each_populated_zone(zone) {
> > +		if (!node_state(zone_to_nid(zone), N_MEMORY_COMMON))
> > +			continue;
> 
> This is the 2nd time you add this check. Maybe fold it into the
> for_each()? Assuming, you keep N_MEMORY meaning unchanged, that would
> look like:
> 
>  #define for_each_populated_zone_state(zone, state)            \
>          for (zone = (first_online_pgdat())->node_zones;       \
>               zone;                                            \
>               zone = next_zone(zone))                          \
>                  if (!populated_zone(zone) ||                  \
>                      !node_state(zone_to_nid(zone), state))    \
>                          ; /* do nothing */                    \
>                  else 
>  
>  #define for_each_populated_n_memory_zone(zone)                \
>             for_each_populated_zone_state(zone, N_MEMORY)
> 
> 

thats reasonable, thanks!

-- 
~Gregory


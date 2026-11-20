Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201009;
	b=fkrHUuPsKHy10KkAtlQ1EJ9WNXJ1aDxOkv7IzRDTKZyK7tNerfHH/AqqHmGx6Dji8RKZ
	 cRehioAkdmNGuMWy8UaNiHkBxWw/TYrcH2TfxD8CZdY1szxNRjRRSupmjSDQwCIpJKwNM
	 DmG+L7EktZoTTCXtCHGlnTzvoEI+waJqCbsxAGTw4U+tSMRRQiterDN+UYrxwfxn7Hy7k
	 BJjGpK859vHGyfUrI6evdp/NDK3k+xpHcHoTalyC0vWVwryPuz/kFT5VqIsMp3+VztDIZ
	 W0etFnQyU48UPzX74MF0ndFWptZrgEXl2F5XWRgyC+OwYlsEPG76ufL8zE4TaR3aiaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=CO2FmI+t47mxhoA5B32c/6+xEdoEj1zDOKWg0tAGKfI=;
	b=sRU835Lg+cLJ61sPQSHyFNIcPKeyaPuATGKk7/xhOy4hLrACHucFliszxhFhqCg/kfEE
	 6OXF7EsRTCEvWedu1KLLsLAMSCqK6Gp8CQhBI8e01Fz6z024yV6TRhduwrL2U6RKiOVQI
	 0q32t7ppPBgQ+GDl5CNJrTB/Sbj1TZo6dZQMETpLdQmpi19j4jmlRAmz5PUE+E3UcSdmb
	 eOghP4QOhaVW+DeLqsLcRUlmSOq5LMK0ZdkEQ87c8LMuTzxRlp8aRccZKx0O0oSVsVetJ
	 ISD8taoZgErn6bKINixgple+uojE8FVIf1hz89XL44TgEvpRnjsnx1tfbfTHF/SLDUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=AGhJLU+t;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF32606A33B
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF32606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=AGhJLU+t
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9212dac247aso14137286d6.1
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 10:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795201001; x=1795805801; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CO2FmI+t47mxhoA5B32c/6+xEdoEj1zDOKWg0tAGKfI=;
        b=AGhJLU+tNmaBotefAwAsP/4JhVGecbMpzeOCmKe1TyUr3nxYH8sgGzSTqekCalW0+F
         V9ELHmyXJSqLYJwz/O0ceEbCq2dsbth2v4PumuK8PEysxTghygmtBP1ClDUpzheUxr3s
         9kuMY1tr7tmafowBZ1xSVOLIyBiNKl8S+GsZ50wTuONd0S09/uKoCW0Sw3wKDtCZw9VD
         /7eUIqPscUDuC6hlZqdKzxUu6zsbBSt9eSmDE7gHsj80s0l/yZillsfJlf7xmWKrST/d
         iPLxUYHTlkBgtlieViNvWCJt2C+F7polVCN7pXr6ylG38hDyF1YiBngd8IWsRvUMcG3H
         ImAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201001; x=1795805801;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CO2FmI+t47mxhoA5B32c/6+xEdoEj1zDOKWg0tAGKfI=;
        b=1Y5xInwPodZdTdGxVyjQU6wcg0Wg8di2OMAhSFKh4NwMZR35ktpjTThlIz3wu6vsY+
         Lu/miym4mmmuTH1EOzcxVFeAG+jxGPaEtUl8OXcelHwJKASFG9XlRCcys52EZxXvVqn9
         9kqsS25JWGpU+k2Xxbm90d7Y+EdchIL1a/nSKEadfaqPk4pyiZpocWv/mLzbu4xqiZRa
         zfSmHdilTTpqZZucXHPaOiJtlOEHUZpzCbuxP2gd3b1okyWIkP4MJug08pkdz7wemF05
         8etG2bZP9ecBAzID6nWyG6D837jUGoYT18TIUvFEa3fZxxlzQ07vpAaRDUBggYd/IVV3
         B2Lg==
X-Forwarded-Encrypted: i=1; AL+hErGjqMGVd6g4EA43me3sStUbIOaGYCWIi/svj1tCxRc7MtZIj3sTVSA7rXDQerELEunl9tUbIQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+xSHZUyfcGUU9EHwkhGjJVbH1g0NHEkdd/g0hqDekFFAomy8nl
	AGNRHulEhpXYZUE7/aC30MFdBKmImm4sQuv+GiopbXSeliWheGke8MIDqrlUbbJnoEA=
X-Gm-Gg: AZFdTZf9X9W8bKrBfBBDOWt3pdT3X1Tmtd0/wvsBVo5Lxh+eLHQuFYdE0xzRBHzkiFU
	nL4DgB5DfNukrhR3QkfUV2Wq9uTuO9NSkSwQucQ2Peru48PCGOTAk07WLYyvem1Q1/w3x7q/hY3
	F/IL7gFQtjCw78upwx0tgDCxybs8oCPB6bvHo/87UBKE8IGI2LZt1pQXn2ohA2P0h4iJKN9x3lf
	NbsEaJzfwx1kHlj9saeyjGAULxqCasTsO9EjxihHHbu4NgOhL7lYiVKXUWnExZSkxcg6Y6pC0mE
	9+ByEl5xNk4ShCXHs7WbUu1M/Z56HlKT7almG77YTKR3SPhYQDvDeGXraj4CN0a2SpWKQ15dzgY
	3/o3EJFL1ROc1b0wXiqwt8MQHcMzfeWejPqH4vWmWEXNdFq/gr0/8jpEVf4BefNkWXBfZggqZvw
	NnrOC2asMjzYcqLQLKEwiCDuXl6gr4dmVe2oO/1YbfnD79/YOqaroomTMx7eqZwINs3CiVJmkXo
	bNDqu/0Yb2UlYRTE9Jw/P+wv3T1IrSb0WxIeqXii6Dk8pmpUhnMa5jyIoZVLyZFLR4YybKx01TX
	ZqA3s7wafjvM5piTtiA5LzkobxG1PVfjOHPsNdxGd7mxpMgvj5v1SRvIeWOCGDbsI35YaJuUeT5
	bOqS+81E=
X-Received: by 2002:a05:6214:320f:b0:921:3541:ed1a with SMTP id 6a1803df08f44-9213541f3eemr56576466d6.32.1795201000560;
        Fri, 20 Nov 2026 10:56:40 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921366d853esm26687146d6.27.2026.11.20.10.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:56:40 -0800 (PST)
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
Subject: Re: [PATCH 54/60] mm/migrate: route explicit NUMA migration to
 private nodes
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, 
 Yury Norov <yury.norov@gmail.com>, 
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
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, damon@lists.linux.dev, nvdimm@lists.linux.dev
In-Reply-To: <sashiko-outbox-225861@kernel.org>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-54-74f5f9a115c2@gourry.net>
 <sashiko-outbox-225861@kernel.org>
Date: Fri, 20 Nov 2026 13:56:34 -0500
Message-Id: <179520099481.412063.3035407964761903218.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-20 18:42 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] mm/migrate: call to undeclared __folio_alloc_flags() in
>   alloc_migration_target()
> --
> 
> commit ca3cf1708bab40e7c2c443ad00cbc882e2163cee
> Author: Gregory Price (Meta) <gourry@gourry.net>
> 
> mm/migrate: route explicit NUMA migration to private nodes
> 
> This commit routes move_pages(2) and migrate_pages(2) allocations for
> N_MEMORY_MEMPOLICY private destination nodes through the node's private
> zonelist by passing ALLOC_ZONELIST_PRIVATE via migration_target_control.
> 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 6791834f14fe1..eda961d43df0e 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2250,6 +2250,9 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
> >  	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
> >  		gfp_mask |= __GFP_HIGHMEM;
> >  
> > +	if (mtc->alloc_flags)
> > +		return __folio_alloc_flags(gfp_mask, order, nid, mtc->nmask,
> > +					   mtc->alloc_flags);
> >  	return __folio_alloc(gfp_mask, order, nid, mtc->nmask);
> >  }
> 
> [Severity: High]
> Where is __folio_alloc_flags() declared?  Neither include/linux/gfp.h nor
> mm/page_alloc.c defines __folio_alloc_flags() or
> __folio_alloc_flags_noprof(), so building mm/migrate.c with
> CONFIG_MIGRATION=y fails with an implicit function declaration error.
>

b4 dropped a commit on me when i made the prep branch because it
it was tagged Author: Brendan Jackman and I filtered on myself.

this commit should have immediately preceded this one:

https://lore.kernel.org/linux-mm/20260923211041.3127588-4-gourry@gourry.net/

the branch in the cover letter has everything

I will respin this again, but i'll address the sashiko reports and
let this sit for a bit.  The first 2 chunks are still largely
reviewable.

-- 
~Gregory


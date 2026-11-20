Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200120;
	b=TB4k3F1Kg8TEC5AjPSaaSNAx7XdmzvV5m7K2SIZFK09VhkeN+25G/RPW2/ZqwPegdZ+I
	 gq9uFDr50IB4EOPrMNy2cyQrqmdUGlN606Q1WObQL0qfpb+ZhBtW1jN3QCPd4tikRHlor
	 SOt0xoGimivzn5LJffpO894bzlYvJ18Q/g6o2wSW4vqdC/uSJzfsTe6wWFhLmInrkCE/m
	 S+9g5jlu7Pd/4BqUT4UsPaktJBS5nIaagf6/FiDdmxtG2WTnrzKo83YNLEQ6uW1skY9wz
	 7gA746CGu9jbeAFYytoEE6dB8ylDpGqTvQTraP/orkznOduSgUC93b1b9ShO4QGXpSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=ZZVKFrUy8TyPqGvyWghVYdubKdFhARMdxJahZ4dEGHE=;
	b=GPCWWG717jsYYni3AJ4dJIJOua7wWNG/FyDQ27NbmkowcF4Z5rgkx3ovqZ4qIg/V4mmm
	 umKj7FLaIE+wwTADnz4UCmtY2e7wSl9W9GiTj0ToRJ0XPIcguXAhuYrWNjK7ZWeuKLAlQ
	 H2UAVxub0FFXiSPwA9SJokEhEzpYpqG3y23oo06sSoikuPds9GEHkLhWPPGAiD4ib8PHO
	 unZqfDuS5bGTYMjn5TQjJs9UBmx7wGHt9ZdPEuRVCOrQrNweyZKJob+Q20bFw7ECvBjzC
	 6G1a6qHtl5P87IRXB+F5PHkGZPlQGuvIgUH4S4OebqyFAxcg7m0L4deLo4hGrWLjYUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=S85FuChe;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671A60A2609
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1671A60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=S85FuChe
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-921365696d9so8657096d6.1
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 10:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795200117; x=1795804917; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZZVKFrUy8TyPqGvyWghVYdubKdFhARMdxJahZ4dEGHE=;
        b=S85FuChedWCSpx/4vvUIgmAvfPfZ9YCrPEfHA3jgJRHFW4tsKpklFtQZ/3k5lBLcD3
         Rwnod4+lZMuNQHGt49eKI6RZpRK2Abk6LQIJ1hOZqk8ZUj4ZBhX0ZwmIs/ZNd5dti70H
         tWf/qYyIgzHJ7zhlZYlRz8Xz3JlERKfjNIiKJhPKG8yTWNxP3U4ZTam+KbqbBJdisQc3
         RE3m/dizk/8uE4dXCfwJyouEVAHbrQIUII/OHTg8xKZUANYLGTdQFR8CQ39umhedHILK
         JwnmI65vRuX2MWZi//NR5w6s7ice7kSDh5dA9GfZxFIaGxtpMKu3MOVt+lLQBggHJMGG
         Oesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795200117; x=1795804917;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZVKFrUy8TyPqGvyWghVYdubKdFhARMdxJahZ4dEGHE=;
        b=rJ3VthSOQz043p7zrBpa1055A1r+/LKrWvm21bWsVSCdTG1SSRFf5d3aLT4NkU2k9W
         +LQU3q6UW3b3pY3pIY8aj33wKZAxLBLU63Hiz5sUSQKuQUrI1P6bNVdPtbhXPYEgfCtn
         4ewp9Cd11eVeopwQkEkUlPqSSUjjW2hDIJKi8TD6r+VSWbnerL3V30HcgrlPpcvhGcXY
         70ZxIC7liwkFEZExTGfBhvT4h9hISO6hmUZ4/6iO6pCcvwQzvAO069l98oCbTRrSD1vg
         gO44Bp2fzjsw8dx0RRFr0duH/Q6h/tIXcaC54/nL1U03TNqkC3EARuuEZBB5ODWbJbcm
         qe6g==
X-Forwarded-Encrypted: i=1; AL+hErHH7bsZy8ZHaztDNK0jVZBhjaXGfHoBXVqJ0AFgN4ydZ9+CHxAAOlcvZr6SS9yxO/Ysidd5Pw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+VfDlKjC3KMuGCfqddHfFzz9dbCT5Xs+B92soO+gF2NM47zC7O
	Gwr2Dby6ahvtsVwwlEhZFnnSKi/1b7ptkudCo0Uslc3Nqhmdlor54WNdP7GPgYGYGdI=
X-Gm-Gg: AZFdTZcBx0dr+Sc9sEgqLmCBJY0D1vd4vse1DbSYgIaZ85bINeISGA8UZhyD7KaShLV
	QhfCNJ0BpzeRE9961/m5qsd4v+dXOTsVlUDF8HykYKIuM1KX+fJr5nENr9Mq+yRf0SxAb06CliK
	ULCT7dBgITj7eniID5msuzukd84SbLPi31K+eVd/cjtZvJuPMI/eN9zH34ybN6yKH++4+LgLTlG
	A4QFqAHBJq/ooI6DXbuy2KzgmUZaUDVQQtR2hZbgoUDp+OOQjzGdpiT7FwZWa8SrhZzHhTWb/SX
	Dvi1DMng/WSWVzFYPVPSLqv9TKQ1VC7AEgrJTMeXVN8o9fuJEuniwkWtPTs0itaioCbm3++BSZ5
	TGyZTvUFWUAmpZO9FFEZyFamiduuMIaEpc0b3/dF1oYD+e0UkIPJlMp3p8x2mtXA27NalgpFpvl
	3hLWx43/1BgMXnbNVfIlAM5lI/FBVEcxZkPEMTFNCpxPZEv/dTTk4CqH1BkFEnHp3fjMJcZxw35
	gI42oDILTxHYNtAXB59cgkffAgS1Gz3txEN1Ky9YscvhkdcU21YFf205Bd6lhyrIYa6q7IGlwxJ
	7QLe25QAccLm5wCDm3X+ekPx1h36SXMGAIN5OtakqSjsWKLB/tOPMYPusCo88VlJ+JtnOSl5wfy
	BugpkDd4gYrLjlw4gqMw0FAXvW0Ik
X-Received: by 2002:a05:6214:8207:20b0:921:33f6:8a51 with SMTP id 6a1803df08f44-92134b3e14cmr55307796d6.49.1795200116964;
        Fri, 20 Nov 2026 10:41:56 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm33275916d6.18.2026.11.20.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:41:56 -0800 (PST)
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
Subject: Re: [PATCH 47/60] mm/vmscan: restrict reclaim to N_MEMORY_RECLAIM
 instead of N_MEMORY_COMMON
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
In-Reply-To: <sashiko-outbox-225854@kernel.org>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-47-74f5f9a115c2@gourry.net>
 <sashiko-outbox-225854@kernel.org>
Date: Fri, 20 Nov 2026 13:41:54 -0500
Message-Id: <179520011480.412063.14337787866519317378.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-20 18:38 +0000, sashiko-bot@kernel.org wrote:
> > @@ -7907,7 +7907,7 @@ static int __init kswapd_init(void)
> >  {
> >  	int nid;
> >  
> > -	for_each_node_state(nid, N_MEMORY_COMMON)
> > +	for_each_node_state(nid, N_MEMORY_RECLAIM)
> >   		kswapd_run(nid);
> >  	register_sysctl_init("vm", vmscan_sysctl_table);
> >  	return 0;
> 
> [Severity: High]
> Can starting kswapd on a private N_MEMORY_RECLAIM node trigger a global
> OOM kill when MGLRU min_ttl_ms is set?
> 
> When kswapd runs balance_pgdat() -> kswapd_age_node() ->
> lru_gen_age_node() and every generation on the private node is younger
> than lru_gen_min_ttl (or all lruvecs on the node are too small or below
> memory.min), lru_gen_age_node() invokes out_of_memory() with an
> unconstrained oom_control:
> 
> mm/vmscan.c:lru_gen_age_node() {
> 	...
> 	if (!reclaimable && mutex_trylock(&oom_lock)) {
> 		struct oom_control oc = {
> 			.gfp_mask = sc->gfp_mask,
> 		};
> 
> 		out_of_memory(&oc);
> 
> 		mutex_unlock(&oom_lock);
> 	}
> }
> 
> Because oc.zonelist and oc.nodemask are NULL, out_of_memory() selects the
> highest-scoring process across the entire system, even if that process
> only uses common memory and holds no pages on the private node.  Should
> the out_of_memory() block in lru_gen_age_node() be restricted to
> N_MEMORY_COMMON nodes?
>

I haven't been able to generate this condition, but I can adjust the oom
control here accordingly.  This should be trivial to adjust.

-- 
~Gregory


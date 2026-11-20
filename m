Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201152;
	b=C4JfEwKVKOEtBU72uj3SY+kp3S4AxRnIEcYxH/yqYoBiN0CmEPzRZo88Sz4Pn5f0s8SQ
	 Z5/yliouWoq2C+z/RbRVyRgevnrM6mOepg74QGAwjX9xpkGkjPMf0/xSz4DLCvxaTaZti
	 SEOJqz9+BxoAiflJbW2bniyfTwKENNy7eW3zQmfcuZkdiQJ2gn9WdBkBHOTYZXfKUveaX
	 J9lo8JF0tBIFLq2GQcpWzkeYCyaFxyZZJGSmA/llIYYIyjlkMcqKK7rzALzzMvWl8BELb
	 oz/vFPjfkhOiEpMjXY+yIsgR+jjW9DnRm0/2uUm5T5VHBI1GnOi4AZNHeddVo6vaHOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=QpjWV7nVPK4jNL88HvKbtHJ/44FkOvQPFo/KHrxl1Aw=;
	b=3la9mF6d2L/9B8amGfQhdzhU1pQEZsQ3BxNzITTme4VqVd3tTfHBZgSiEL0k22kw3onw
	 tv9u5cnhVnqX6ITDlbyPckvmRivDtfaHZqv3s51BmrGa9pIE9/fFYCj3Jw/rv9sOTYWyU
	 1PZ+hKuKAXjPpjwKdNqUFOsitszUmpaIWK/aPbcLeNoQjks08vKJ3hRP4FRkd5KhHjzp7
	 kzMdubKem6Rgb22+JzBoZf0zhrSzF5SoosZS0uMRPGENbI/ZI5pQpurAkJOEcjFu+d6UQ
	 RuA17TQJZgQC/5/kme1xnTIIgFFxA2bphNvfRF7sK+eQ25PgvKmzqthp82c2zh4sFiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=QSB+ifTl;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF360A261A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFAF360A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=QSB+ifTl
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5365d26ccbdso15102671cf.0
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 10:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795201146; x=1795805946; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QpjWV7nVPK4jNL88HvKbtHJ/44FkOvQPFo/KHrxl1Aw=;
        b=QSB+ifTl1rJjRm8Fm4z4DJKCqYBQcvNzHl1jAHry1Ys/rGn/dab6x27R79oaTdNkxQ
         U1cZpNe8gzrJSNHSWrxFh7Z9kxBCnjg0wgNfn3AuePe+JsDIB7Bm7qCQh142XZY/j6SV
         E4NjWA4BMdi5S0nuwMZhvTBreVpSLmTIZdKRRo8ytZz2JaPS8kxGAmifPTiVp7nxHeu2
         I2PH326j3ygUyyyTIH5dv265oi33aOkcwpeoxhT4o6g2evsYuT4JSv8zJb+5IQYsjagV
         A8WUvoRwdiDCJAvE5mO3zyKyBh2kV0rXrm0o0d11tuiiaWg7S+ZH2N1DKfhPX+bgVvSn
         kHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201146; x=1795805946;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QpjWV7nVPK4jNL88HvKbtHJ/44FkOvQPFo/KHrxl1Aw=;
        b=G+UtDw104QnrTPtnlhs35Cl12ml4CuXTPu05DucUEB/mcFIA0RnYf4L9wMZrsqvhjV
         ER5rngLzQBZ7jthmPojbH5KDzDFxrjDTNssObWcRGcYOUyLiz7RN5eVu5VxDGx28eOjg
         4KTKwJ9F06AyKy7lDGpMP+afgTN86ZTLyour5wS6uaM7CAFzmWtXfBgPfLKE/m+Nd0cd
         cI24taaRMCODPhYGf4IUMii/uy/XxDdcooTK/DZjGlDr9bNcesV3Awpiu+QEY6kc57ec
         Jy/8BWHrp43XOpeG1CVeTfUSADuYcXuVcZB1jkyse/Ic2PnBGy27r2jROgxtR1ukVqoI
         skPw==
X-Forwarded-Encrypted: i=1; AL+hErGSKKkTEZqg/1Rb52KfjilRFybynTSHRgbzJtTsXNRcmj0xkZRB9G4VqfzgUrr5eTZ4sfIIKA==@lists.linux.dev
X-Gm-Message-State: APuU4Z964M5WbvPiWx/3L5fJhZewvBaEPXUGxvRgYzhC2LNaba+HJTd7
	YdDyBME5FaT4XRNxO8Rx+TvVngDbuNl1Qc2ambU0xO9twKwzHeYsPsk7WM1wJ7HB4DY=
X-Gm-Gg: AYBFou2vpOCGorfRc87D2vJtRrD02ZO1CpYYMZGGVLJFns6nDqsd4GZkNDVa73Iuggr
	YYAO4foCI/88tfRaqNxtC/30G6wato9g3XU6usvv/3RZbIogHujsmJ9qF6iskNu0j2gY2NwhvRg
	yUN3NDeWbn492G54Zw7ZJQIEO041QMD4Q45VFLhg0FS5k/zTddNHpHzfsGLCxOSpNq5MxISyj65
	FDHUnbicLFoKpK4ipHx+iMCX17J6aLaeaMHEBne/t0zji+0tN7oUUNX9YEDM1W/OMOgoAea0SoB
	bsyPDok05eS1Be6We++zUZf0UZsyHvKKseByNRMJBndPl3ZxkToLG4fjq+tRZjvViWeck5ySDQZ
	VP4kok0SM/o6pGPhMBz9N9r15KIk6rKjvVIq0DiahamgMRSN5z1of7JCRbcEQfox56+Ki2CiWtR
	CcrHWYXW0/BUzaa/zavKacF3NMkei4p3p73cms5ZuKbGROYXKpLQiQlkhduzEWq6oD6UL+XN+0g
	izqGbmc8MGePgSuzhu+0AWAcvR+RGxGlMSl6bLeey3mCwjJSZ5Z98x6itV+rb6AbR7ARi5Q2WmG
	j+jlVpoaLrK4GjEa6K33BEs4iYnr2Dj61xmUguhDpmz4IRGXj0PgQZ+/hE2tatPq7LWqQ3VqQKE
	T/MTi1NY=
X-Received: by 2002:a05:622a:1a89:b0:55d:2c9a:3776 with SMTP id d75a77b69052e-55d76a811c8mr74428711cf.65.1795201145651;
        Fri, 20 Nov 2026 10:59:05 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7884d01csm30305771cf.21.2026.11.20.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:59:05 -0800 (PST)
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
Subject: Re: [PATCH 00/60] Private NUMA nodes
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: Yury Norov <yury.norov@gmail.com>, 
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
In-Reply-To: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
Date: Fri, 20 Nov 2026 13:59:03 -0500
Message-Id: <179520114342.412063.6068641130948664600.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-20 13:08 -0500, Gregory Price (Meta) wrote:
> This is v6 of the Private NUMA node series. The series falls into four
> parts, each building on the one before:
> 
>    1-18  mm: introduce N_MEMORY_COMMON
>   19-26  restrict folio-walking MM services to common memory
>   27-44  N_MEMORY_PRIVATE, kept out of cpusets, mempolicy, accounting
>          and the page allocator's ordinary paths
>   45-61  private node features, memory hotplug of private memory,
>          dax/kmem private mode, selftests and documentation
> 
> Patches 1-26 change no behavior on any system and can be reviewed and
> merged on their own. Without private nodes, every path in patches 27-61
> behaves as before.
> 
> The full stack is also available at:
> https://github.com/gourryinverse/linux/tree/scratch/gourry/managed_nodes/private_nodes_v6
>

Apologies - my b4 prep dropped a commit from the stack because I made
the mistake of filtering on author (myself) and it stripped out this
commit:

https://lore.kernel.org/linux-mm/20260923211041.3127588-4-gourry@gourry.net/

The commit is one the branch listed above, and should be otherwise
indepedent of the series (can be pulled in ahead of everything else).

Sorry for the noise / compilation error, won't happen again.

-- 
~Gregory


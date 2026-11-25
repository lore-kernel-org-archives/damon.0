Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601241;
	b=Id85M/D62s89IvBkI2kEKUsXBLW0A4J47S9LuKR5PVrB+L416ehitiiFNn5bpmphImVo
	 VPrkMY+uJR/QWuV2X99mh4/td3Lm5090qQNeeAimWW/hbZo+n0xZYDOQIejT9nPVLdwOp
	 odYRX6stZ/0DtOb7wHfU0y/W9qp+6tXuCED6vmi6WG8vGQi9FDBcX1+P16GkiCvekeABz
	 GX8hSRBgXFIFRNmGKR0w3S8AUJAAj8vp74A/QTAcDEXf2ZqevC7lzDNFtmBIFFEw+9qME
	 PSv+h9MO4OTCTYMsRZLbhBWo/a8iTo8CGf6C+SILA+5jDl8OLoK18ZjL5YfsNablMqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mWx4O9IoqBZXrSxXrPMmLZ9d1NpcNUKfMxyf4VNB2/k=;
	b=k1p1zKwTer9dNlD0eocfkJTF8xAvKWlKpPAw5BZuZcK87PXV7DGftUuR99ORllxHA+wN
	 THAB9AfKNnwgBVl+qQbn3buYhsfxg6DvzfFIlc7z8lpX7QXqoOgMeYjriVf7hICRuuaYi
	 iYAmW/vJC4BxSZU2OmNfaz4udf18gU5Nvw57pBsiaHP2hE3GGIIJWyoZnT0k0TXIXv9tw
	 LPInii2jylPhzqWFPC9lKvu7zIsL3GL9gZOmZhY/t+GVmh5o26PNwK80D372/+pWMbxLO
	 CDoPgXKPIYS8qw+i5Uqzk7RXaRSZPc4/c9whbXsFUPbLes0LbRdTsQg+udbgTyS/59g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FiKp88xP;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C7606A31E
	for <damon@lists.linux.dev>; Wed, 25 Nov 2026 10:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 102C7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FiKp88xP
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so2897359a91.0
        for <damon@lists.linux.dev>; Wed, 25 Nov 2026 02:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795601239; x=1796206039; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mWx4O9IoqBZXrSxXrPMmLZ9d1NpcNUKfMxyf4VNB2/k=;
        b=FiKp88xP8a6xpRBQjjM5GUs+ZdUb+ez7pqeDQTmecEzuPL7sqPwGSwcoBnmq9W+2WL
         O3lcU5SN6ARnXJWQCNOeRFDGL/mU6O9tve6vdL9ySLvNMaImFp1NyA/Ew5DyFx3qMffN
         wNC3LAAWuJYTRK0XXwadjnoybNVeIkF7KfOYnZzNtqBHtOXwVbeguc8DwdblxNkBc02v
         3hvAlk8ljHa5GUdluZne/Ja3c2Jq85JxsGezKFa0mzXeKfT6TtiW3F9IQH3OqOYo1QOB
         N/jdK1Mk6ktNH7pe65fZGY0itFUVApglLU7Fq9vSAwks2V8ka0MKamC0T0tTmFy+BM9D
         ZRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601239; x=1796206039;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mWx4O9IoqBZXrSxXrPMmLZ9d1NpcNUKfMxyf4VNB2/k=;
        b=IIZx1qenlWUIOTTo1F+LjT05D5XQQH9+ntzc4VJ++NnRTb27J+05Jn+nnUlpa9vpwj
         HOEoUQAhZPhIGLb4dsLzWbobYXchZJYqfZ9yAYAcUcNOQhLw1b2+WpBcTK3XfILG6GLv
         Ugh6bziCzesZGuYLPv2Qw84Xyhc1vftWpxSlKMYPY15paKq85GaHu1yzdLcPogEqZwE3
         UHq3ZEofL5egpXTgFzPERrh1r1q0kjMArm5S5w/n+TG870k6ro9edjFelUjbTJ+6PpFw
         Ku55hMj6BUX47MsETQfRI8iwoNdkz7eI7bk7xA7eLAQogFKsjzEjz+ls5ZPWTf4qIczf
         qn1g==
X-Forwarded-Encrypted: i=1; AL+hErFuqru022LNV4FdWl9K5fld9uSDtlP0DQmcTKrS8gFlEh4QHhQRDhJcrVrBwll5vMatIjBB7A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/GYwu0qytq7UW+zV2ZjzU1g1mlkpU04KFfmdGt01EDxnnVXQXs
	vpq+Og5KDbC7v2AOIPlzkOcPzfTeXD4g4rTh15t+dN2SJDr9d7KvZ/2U
X-Gm-Gg: AZFdTZeGHWYlDjXLfwPawNm3ufdTy9jl6NJSZBDFcCSQ4B3y9B+sG7JmTxzCdQ5VpLi
	W5SK6j1tc15FRo9gklwYldry2KOsAUm2SXwFHekvHglauCqX7L6SgpWJnCujKpFRiXrPCYk2rT4
	x7UKquT/Y32VrP1ho1//fb3V6o6dnXV8H5z5g6sHoNoKLdANVKORhOhEDHkn9taop6ewblUKZW9
	LFlaqOTScb7nv0W4h2O7ACGouZxD0W+RreAHkFLPk6DQiNs/V+Al3YnkMn7GhqyenHgkjD0MLfq
	f1l7mmplIGVHpCYo+sOZSBmfmQ8jKXfR294et/oJwx7hZmYG/TKTmqt/j+qTZ1xjHGlVjQygtTf
	5z3DVJ4FZsWobxvSjqPsjE7a8hyybwQ2iM3Hw0HzatYWC9mNuSKC847jl0286DDg+i3Mbep2S1B
	rqdlC70ZOGgNmv4iokKP4Xq1cSeNDluz62/nGPc7wvoe0rh73a24uqupeSe9UWAJmFcyzg6TEMu
	woA47iIlO74r8srZjYr4qdF1coorPik3mp+6KIAb5U4rvaT43wVY+f0wGVqtOsZptfB1coRvV/R
	BDhlRIxe/e5vjU99jvTbaXPyuYE93IoCdOI5ggMYEjWM
X-Received: by 2002:a17:90b:2ecb:b0:3b0:e2a9:3466 with SMTP id 98e67ed59e1d1-3b41c98a1d1mr14557905a91.16.1795601239179;
        Wed, 25 Nov 2026 02:07:19 -0800 (PST)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm26804572a91.4.2026.11.25.02.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:07:18 -0800 (PST)
Date: Wed, 25 Nov 2026 18:07:00 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, Gregory Price <gourry@gourry.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Hugh Dickins <hughd@google.com>, SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, 
	Yu Zhao <yuzhao@google.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Tal Zussman <tz2294@columbia.edu>, Kairui Song <ryncsn@gmail.com>, 
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>, 
	Ridong Chen <ridong.chen@linux.dev>
Subject: Re: [PATCH v6 06/18] mm/mglru: skip the flags cmpxchg when nothing
 changes
Message-ID: <627ebddc-87b8-468b-b0c3-0503494f357d@gmail.com>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-6-8ffea39934a6@tencent.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-mglru-fg-v6-6-8ffea39934a6@tencent.com>

On Tue, Nov 24, 2026 at 02:52:58AM +0800, Kairui Song via B4 Relay wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
>
> folio_update_gen() and folio_set_lru_refs() always end with a
> try_cmpxchg() on folio->flags, even when the new value equals the old
> one. The locked instruction still takes the struct page cacheline in
> exclusive state.
>
> That is common in practice: a folio mapped by many processes is visited
> once per mm during a page table walk, and after the first visit it is
> already in the youngest generation with refs cleared and PG_workingset
> set. isolate_folio() and the eviction paths also call
> folio_set_lru_refs(folio, 0) on folios whose refs are already zero.
>
> Break out of the loop when the flags would not change. The update is
> complete at the point of that read: the flags already hold the target
> value, and a concurrent change to them is ordered after it. When the
> cmpxchg would have succeeded, the value written is the same, so no new
> state becomes reachable.
>
> What the patch drops is the retry. A retry re-reads the flags and
> recomputes new_flags from the newer value, so it overwrites a concurrent
> update with what this CPU wanted. For folio_update_gen(), a walker that
> read an older max_seq can lose the cmpxchg against a promotion done by
> another CPU, and then write its older generation back on the retry.
> folio_set_lru_refs() can likewise clear a refs increment that raced with
> it. Breaking out keeps the newer state.
>
> No caller relies on the full barrier that the locked instruction
> implied on the skipped path: the eviction and isolation callers run
> under the LRU lock, and the others (page table walks,
> folio_mark_accessed(), lru_gen_clear_refs()) only care about the
> resulting flags value, which is already in place. Note that
> lru_gen_inc_refs() already returns without any atomic when refs is at
> LRU_REFS_MAX and the folio is in the workingset.
>
> Tested on an i7-13700HX with turbo disabled and the performance
> governor. N processes map the same 2GiB tmpfs file (huge=never) and
> read every page, then one aging pass is triggered on their memcg
> through /sys/kernel/debug/lru_gen ("+ <memcg_id> 0 <max_seq> 200 1").
> Time per aging pass in ms, median of 5 runs of 10 passes each, averaged
> over 2 boots of each kernel:
>
>   processes    base   patched
>           1    32.9      31.7   -3.5%
>           8   195.1     160.2  -17.9%
>          32   755.8     592.2  -21.7%
>          64  1597.2    1260.6  -21.1%
>
> With one process, every visit changes the generation, so there is
> nothing to skip. Before the patch, perf annotate attributes 53-58% of
> the walk_update_folio() samples to the lock cmpxchg in the inlined
> folio_update_gen() in this test.
>
> Reviewed-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> [kasong: adapted and rebased for the series]
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Tested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/mm_inline.h | 2 ++
>  mm/vmscan.c               | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 46beded51c7d..2571b3f01226 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -233,6 +233,8 @@ static inline void folio_set_lru_refs(struct folio *folio, unsigned int refs)
>  	do {
>  		new_flags = old_flags;
>  		lru_set_refs_flags(&new_flags, refs);
> +		if (new_flags == old_flags)
> +			break;
>  	} while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));
>  }
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 202e0f874b23..15df5618a3cf 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3274,6 +3274,8 @@ static int folio_update_gen(struct folio *folio, int new_gen, int *type,
>  		lru_set_gen_flags(&new_flags, new_gen);
>  		lru_set_refs_flags(&new_flags, 0);
>  		new_flags |= BIT(PG_workingset);
> +		if (new_flags == old_flags)
> +			break;
>  	} while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));
>
>  	*type = folio_flags_is_file_lru(&old_flags);
>
> --
> 2.56.1
>
>
>

I have done similar tests before, simply skipping the identical old/new
flags, and was able to get very good results.

Makes sense to me.

Reviewed-by: Vernon Yang <vernon2gm@gmail.com>

--
Cheers,
Vernon

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.67
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594691;
	b=hODVLWgMj64OoKpuAtF/y3o3KaYVTEzb+YYehVu9RB23iP/3CFpEfsn9/eAQYteIjtBr
	 Hgrl3n9UZQQ8UMZxDJ11LjbPTjZ8U96KYuwnO8Ss85ZPn4seg/czt7p6H4bCtY5YoC811
	 zOmfUp8RDi8KCnRA7Z6HSCRBGZqw/bWU4YowmLImvC6oGqWiyAgs7o+6iaKOmytJe8RtX
	 ClDsacf7grMt7PO6u3OuikpbZc+3Qc4RUEN74DWU28ps2ieVoB+FBOGzOlU2eIOlNwe67
	 jVNajuTXVSGhdVs85/WfTbyUbOZs0DNWPCJj779Y1xjWhGOGNqBwIkT16OhubvGgshw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594691;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zQ4PDN/+IecVCHWBDQ0v0hwYyubU4Qhpq8q9f1QbpYY=;
	b=lHU4KccQCa9Eq8aTjOGFgjfUstq7tXsSm4ohcWJWZqnAW5v/eKgXseT6eyak3WmjejnB
	 BUqqDZLu3AQPP4csgav7b6hAPaAzlKlhXbS6jCoX7tT9enxQThpY2u1ewWrn/VC4LCO7m
	 n983xDaGhuHX6o7K9edlRqbMBGPuwx42M4NFql8z+uaOilSu2NAHMNEd3y2urxBQYqzW3
	 3xImdyZdojRo3o0glVCZwmFBjcJP3kXxnx4FsS6IfB399J8jvWHEtrPPPAsB6UqTR0Nz9
	 N8NTqlHibkubp7uLicTG/0D8HZGjrgTUrTAlDEPd5O+xPLI5EzCyh8uOMAcoUaiWdqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JL3SfCjV;
	arc=none smtp.remote-ip=91.218.175.67
Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74C606A32A
	for <damon@lists.linux.dev>; Wed, 25 Nov 2026 08:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D74C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JL3SfCjV
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Hnn1Upm6og0+ZrW88GDMEcGJ/ZGLLay+qcflC5gxlL0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795594688; v=1; x=1796199488;
 b=JL3SfCjV4080nOi9CL2Q+K936t6S+au5atuKD6XAd3apiOOESRAHmZ0x4F4NXgGc98kRpCxq
 bwK9DlYtw/+U5IMNNX+628MFduzZMqzlSkJYE/Ma8ZgafwvwYunoQzceNShRRKkN5A4TWWH81Ab
 uERyIbgFjLMa6/H3/tiucj8o=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id eba729f2d53511cd;
	Wed, 25 Nov 2026 08:18:08 +0000
X-Mizu-Trace-ID: eba729f2d53511cd
X-Migadu-Flow: FLOW_OUT
Message-ID: <195d7fbd-5538-41ee-828a-92e5f400917c@linux.dev>
Date: Wed, 25 Nov 2026 16:17:49 +0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/18] mm/memcontrol: allow update of LRU statistic
 without holding LRU lock
To: kasong@tencent.com, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>,
 Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>,
 Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
 Zi Yan <ziy@nvidia.com>, Gregory Price <gourry@gourry.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
 SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>,
 Yu Zhao <yuzhao@google.com>, Vernon Yang <vernon2gm@gmail.com>,
 Zicheng Wang <wangzicheng@honor.com>, Tal Zussman <tz2294@columbia.edu>,
 Kairui Song <ryncsn@gmail.com>, Xiang Liu <liuxiang.277@bytedance.com>,
 Ehab Ababneh <ehab.ababneh@intel.com>,
 Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang
 <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
 Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>,
 Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, damon@lists.linux.dev, linux-doc@vger.kernel.org,
 Tianyi Chen <hi@tychen.cc>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-2-8ffea39934a6@tencent.com>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20261124-mglru-fg-v6-2-8ffea39934a6@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/24/2026 2:52 AM, Kairui Song via B4 Relay wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> To enable moving file pages in folio_mark_accessed directly and lazily
> for MGLRU, allow updating the LRU statistic atomically without holding a
> lock. It may cause temporary counter underflow, which should be fine as
> the counter is eventually consistent and only serves as an estimate.
> 
> Reviewed-by: Barry Song <baohua@kernel.org>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Tested-by: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: Muchun Song (ByteDance) <muchun.song@linux.dev>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>   include/linux/mm_inline.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 2395ca8ee305..2edb9beef6d3 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -47,12 +47,11 @@ static __always_inline void __update_lru_size(struct lruvec *lruvec,
>   {
>   	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>   
> -	lockdep_assert_held(&lruvec->lru_lock);
>   	WARN_ON_ONCE(nr_pages != (int)nr_pages);
>   
>   	mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
> -	__mod_zone_page_state(&pgdat->node_zones[zid],
> -				NR_ZONE_LRU_BASE + lru, nr_pages);
> +	mod_zone_page_state(&pgdat->node_zones[zid],
> +			    NR_ZONE_LRU_BASE + lru, nr_pages);
>   }
>   
>   static __always_inline void update_lru_size(struct lruvec *lruvec,
> 

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
Thanks.

-- 
Best regards
Ridong


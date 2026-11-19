Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.215
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048090;
	b=f12PkHya9rbMRsOcThMBkohCdy+B3pWp9utzXb+4mP2H+so5a5e5CPYtZZkRRM5JUqez
	 SbBRDkB/9sv8A+UGcSrJy6QSkyY8ge050wNv3mQu7u26NbJyR9C3tXDVOp5QduJDgR8MH
	 iPlU8Ixkhv+y3j5ndYsUa864m7n1PrSRHRXTZzx4Qc/YQuwVOSTb9Djf6RnKh7K45HCtd
	 2aWDowM1yFtZOKongYCdhdVWgB87NVO8xvtFfC41KuZXbOpK7uNnAyVckCaKH/zrj+L4y
	 p7HIV5DO5JRYynU51IXOEn5PgBNdDG28yCb3vKB5uUhqWNhyzK3A6JcKmXOuqQG+w3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048090;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qo523NBLwX8TKAi0GfmUCyFFt+JFHooaYZ5WinHIM7k=;
	b=o0pK2RthKIN42qNUABnblgy/z2/BQrmKkpgOg/6j8nELC3nByUe/R4ZGXROSTktkuW4Y
	 AQFIogdSQrXDb2GrAI8ngfSikU/m/rbrapkubMN1gQRsGDA46I+KicttiONHPAzilhvd8
	 OkA784AGTdgpHdt6WRMd8aSaOEc+kTKs6Pvkkmz8OzsW2lM1qG5HUyYkLwcFnTTA4R5hW
	 Pg2uLLFP6aK/YhgryrJdEPvnk5m5/WKs6E8krZC0Jr7xrE+iBUZVkFctKdkJkWwrBYj3d
	 MR48RIaZ8FLCah5IH2Oxy+9VNnfRWr1KuW481g+8aDMeA5C4u65PSsGocwMTyWyzHUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XDFqOaV8;
	arc=none smtp.remote-ip=95.215.58.215
Received: from mta1.migadu.com (out-215.mta1.migadu.com [95.215.58.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E77606A331
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 00:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1E77606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XDFqOaV8
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=lG/MGcmIGjodLXXmJpU9eLIP6wDLe2Yzh9mLwW1eU78=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795048086; v=1; x=1795652886;
 b=XDFqOaV8aEHSIXVlfKMnKN4sv//zRuvJTprQ2zaMwZFcbKOzWaHSbCWGnmoKm7f6Jh2wwMxs
 aKFKI94mfPhUFeNTCu429vGBOp0KvQNYMJHS/a/IWRfQsD0f7TqjpMYv2GnEW1dsxYcUbmdOauS
 3U8jqa6DDNYMau5W2Ig7yR7o=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id e3a7dfbf43199f02;
	Thu, 19 Nov 2026 00:28:05 +0000
X-Mizu-Trace-ID: e3a7dfbf43199f02
X-Migadu-Flow: FLOW_OUT
Message-ID: <1c13674a-6203-403e-91b6-7579e4d5c2d0@linux.dev>
Date: Thu, 19 Nov 2026 08:27:50 +0800
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
Subject: Re: [PATCH v5 01/17] mm/mglru: rename the generation offset in
 lru_gen_folio_seq()
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
 Zicheng Wang <wangzicheng@honor.com>, Chen Ridong <chenridong@xiaomi.com>,
 Tal Zussman <tz2294@columbia.edu>, Kairui Song <ryncsn@gmail.com>,
 Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh
 <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>,
 Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
 Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 damon@lists.linux.dev, linux-doc@vger.kernel.org
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-1-9eee2fe97a2d@tencent.com>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20261119-mglru-fg-v5-1-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/19/2026 5:03 AM, Kairui Song via B4 Relay wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> lru_gen_folio_seq() computes how many generations below max_seq a folio
> should be added to, but stores it in a variable named "gen". Elsewhere in
> MGLRU "gen" means an index into lrugen->folios[], i.e. seq % MAX_NR_GENS,
> so reusing the name for a relative offset is confusing.
> 
> Rename it to "age", which matches what the value means: the newest
> generation is age 1, and a larger age is an older generation.
> 
> No functional change.
> 
> [kasong: dropped the comment table part, the series rewrites it]
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>   include/linux/mm_inline.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index f6f4bc9a704f..2395ca8ee305 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -302,7 +302,7 @@ static inline unsigned long lru_gen_folio_seq(const struct lruvec *lruvec,
>   					      const struct folio *folio,
>   					      bool reclaiming)
>   {
> -	int gen;
> +	int age;
>   	int type = folio_is_file_lru(folio);
>   	const struct lru_gen_folio *lrugen = &lruvec->lrugen;
>   
> @@ -319,17 +319,17 @@ static inline unsigned long lru_gen_folio_seq(const struct lruvec *lruvec,
>   	 * |<---------------------------- MAX_NR_GENS ---------------------------->|
>   	 */
>   	if (folio_test_active(folio))
> -		gen = MIN_NR_GENS - folio_test_workingset(folio);
> +		age = MIN_NR_GENS - folio_test_workingset(folio);
>   	else if (reclaiming)
> -		gen = MAX_NR_GENS;
> +		age = MAX_NR_GENS;
>   	else if ((!folio_is_file_lru(folio) && !folio_test_swapcache(folio)) ||
>   		 (folio_test_reclaim(folio) &&
>   		  (folio_test_dirty(folio) || folio_test_writeback(folio))))
> -		gen = MIN_NR_GENS;
> +		age = MIN_NR_GENS;
>   	else
> -		gen = MAX_NR_GENS - (folio_test_workingset(folio) || folio_test_referenced(folio));
> +		age = MAX_NR_GENS - (folio_test_workingset(folio) || folio_test_referenced(folio));
>   
> -	return max(READ_ONCE(lrugen->max_seq) - gen + 1, READ_ONCE(lrugen->min_seq[type]));
> +	return max(READ_ONCE(lrugen->max_seq) - age + 1, READ_ONCE(lrugen->min_seq[type]));
>   }
>   
>   static inline bool __lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
> 

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
Thanks.
-- 
Best regards
Ridong


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459992;
	b=rk+DoAeLqBkbG5FVvo6Tq+PZAIkNlxSwcOr7RHfHZZSZUcEWluP5yk1tNHJ0EBK2VbhN
	 9gG+grbKXpxIGXegOPTZ8QO5pGKt8KfVFpIjXSAYThvYGXSHg9uJIwpZVm3mJYa/kkOCL
	 8j2W1SF7MagSDXlaQckgXYFe58Fh9md3tyTIJqqjcH5s16DHSr4M6nDbki/j4+VvAyjvZ
	 vGJcJkC7XIPauTI4Cv4xsr7UFlcFE82JVO/Vg3iOefkk9NNuggC4mzIRKLoYL/P98lVb+
	 nb63UPJav++B/eXE75nePaRFZLeukXftrO0USc3sellNAQMXlaxucFdtJsMZOeuVzgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459992;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=asmN6q2HefJieUr+/zgw0602de6l9KxgRm2+Pk/d8bI=;
	b=DCC9XwwDsR0nIGejI3z+zLkJY29QBGDgkcIhH3wgIzZV5/2UwdXKVYRI6xbuSsiqEFBv
	 +uodNlnTdJdmowL8+YpPuEIY/K4O+N//xzhW5aWS6BglpHEtAzpEv7NlaZdhdQXR0OaLo
	 7NyVPgvs6c/W7KDg5qSHtfO7QQZBiOLOcZhsFsv74G/NHn4RN62lubzXai5dxD+yNhRtU
	 moGCAd6OGpk3iH5h9L6CrElo72POKqo0czgUUMoL71V7JDl4Xil8IOfqdjSsyT1Z6/xY0
	 W9q3+6XRYJFEw5sN66MU1aoqvHHwu5CiMHas0NoRGyp4xaOTqldUK/Vbi6+ESS4ptpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij2vQusM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C90606A31F
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij2vQusM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459991;
	b=ViE7+Y9J79ybUg3vFucirNU33s05Excg6q07imM82lnVOeFusNCkha0c/EqADUcBwi09
	 vyCQXWEQcGP/n5US8ZobJVCVpmd8mhnnZ8e/9oHK4z6cCitNpflRg07dO6P0eNygHEppE
	 OIBFhISwIytwYKtNCutMAll+eUMiFEObimSF8pkYPF6pofJ0vw+Z9zM/V2oy4bciWi3Hf
	 YAogCYNEBob5Y6pxYXM3aQHeifYQbOrRcDHLXYQqW4EYUounQS3MQj9VK5+Dd7QJbpSj5
	 e2bHrFnrNU9JVIEPsqpFDD6SdjNXLAvO2L6t+Hs5JZujRuhOua+R5F5MA8e82hons7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459991;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=asmN6q2HefJieUr+/zgw0602de6l9KxgRm2+Pk/d8bI=;
	b=VW/N6zwng1OrgZJM/pRrGoNrxGOwC8AVmMTwUbGLXhtbDy6LT0ViMPpPOZEc8RDzOeKJ
	 xqrqFZa4+fE5He1hCqoiqPFFbu2kGhKCk0rD0HDZJjk6ASjVtGN/7Vs068OgXBE/MgWYY
	 JUIVNLDLCCBalkUc7g4v/xQJhlKzl5wgeD59/rOmbKoDojpcF7yGxPgq2uGgYezT7gY/4
	 y5CnEVzXmBJ+JIGVk+3wf3G/tXw4tWTrnupnu6+WbcLPb4UGRdjia7n4bhwetPjPWdR4/
	 ZrNumN4ebvNl5qqjfMZnnX1MHg5Pk2uA5YjErbliBNuWSWB6mm7JY5i3+uKANq0psgA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ACB0E1F000EB;
	Mon, 23 Nov 2026 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459991;
	bh=asmN6q2HefJieUr+/zgw0602de6l9KxgRm2+Pk/d8bI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ij2vQusMe3Qdf3aQGCdCxhwJ91oiAMrxHvuW0Hf01GR9vIm58GZza4T/Fxsus3tW5
	 9LSt5X9tEMbTiVP0PZc0NYNLp7eVFWDYqmCpPUsk3t6QbJZnqDkGnKVjOX9hH5EJ5C
	 ewXRtZVxaSVue0hWMciN5QIEsJRr+Gcp3yQNQschm8UPbUFHURAzVDjGCQGI6TqVFf
	 2twdpVpwdSU8nIHb1eUeerg7/TCIr8UkmtRWzrwToKD+Q/W9m/lQAErzli5nF8Fs1q
	 Hox05J5TUex+YlwFDD1bLK3Elv7TzoxDoRokV3yEVKRz2Vm3ElPNuh50RK1mOIZjee
	 x05T4mrGi0EUw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3A66A4C631;
	Mon, 23 Nov 2026 18:53:00 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 24 Nov 2026 02:52:54 +0800
Subject: [PATCH v6 02/18] mm/memcontrol: allow update of LRU statistic
 without holding LRU lock
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
Message-Id: <20261124-mglru-fg-v6-2-8ffea39934a6@tencent.com>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
In-Reply-To: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
To: linux-mm@kvack.org
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
 Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
 Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
 Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
 Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, damon@lists.linux.dev, linux-doc@vger.kernel.org, 
 Tianyi Chen <hi@tychen.cc>, Kairui Song <kasong@tencent.com>, 
 Ridong Chen <ridong.chen@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459977; l=1434;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=uwS4fBCD5iPVACjO21QQfl2NP0AqWyZwBPx9Plu/+9U=;
 b=2pyXTqy8HzStaaOCjTzObU1npNvY6ZTpilr+RXfXelh2BoV3pXDzkQDh7YtNKuBinOgbf7HIr
 Mou6SAdaUjTCLlAY7r+pWaP7/QlkLcjr09/iTRLHgrkUcRHYDfXKH4T
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

To enable moving file pages in folio_mark_accessed directly and lazily
for MGLRU, allow updating the LRU statistic atomically without holding a
lock. It may cause temporary counter underflow, which should be fine as
the counter is eventually consistent and only serves as an estimate.

Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Muchun Song (ByteDance) <muchun.song@linux.dev>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm_inline.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 2395ca8ee305..2edb9beef6d3 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -47,12 +47,11 @@ static __always_inline void __update_lru_size(struct lruvec *lruvec,
 {
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	lockdep_assert_held(&lruvec->lru_lock);
 	WARN_ON_ONCE(nr_pages != (int)nr_pages);
 
 	mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
-	__mod_zone_page_state(&pgdat->node_zones[zid],
-				NR_ZONE_LRU_BASE + lru, nr_pages);
+	mod_zone_page_state(&pgdat->node_zones[zid],
+			    NR_ZONE_LRU_BASE + lru, nr_pages);
 }
 
 static __always_inline void update_lru_size(struct lruvec *lruvec,

-- 
2.56.1



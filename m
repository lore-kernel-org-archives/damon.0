Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795460020;
	b=I1ayTNjA6UFL1cn0O6m7CtHmQ/uIsz4vwDfqQyGMJ0s6i57df1FpTkI7Ehww6f3ghqsh
	 +W8dkTTkaPtSPoeJkBVYc5/nXc1UY6qQV2VsKR0C9HiACVfYDTyW4lAqw3KGIDjOwgQTF
	 N0AiVnzf7fim5C7lQRAMF+cy2heO5uc0ujTZF3Lc66cy6eHrBfKNIRIvySgZC/J5Pc2ls
	 d9oIam/87831yMiz5kY1K/kMCf4zwWIFDBYWLE5R+VejzfA0UwDWB1Bz96loQMXolF9RW
	 4TkIWXOHp/6HzeUNLGhnArCJE83agZDL2SDmuUGiLx+tUM5c1xbvmLQin9Og6UaFWoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460020;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=S0g05G9qZGx4poDmgO7lZ71KlplbuRcjeb30J2se0iw=;
	b=jJQJptzKn1hVUyzbAhDIzSzkOcSedT+WzQ9JXk1/ZuStjJfidxRtktjLCPBBFnv1PhAy
	 Q5hc4+U39MiXV49B6dWCgXc4zsOGjd8SZp+dKFlOlFv8J0RCJqUebEwjXe0CBZ07zfnqE
	 CJSpwjXa6+670hEvW2Rvo4NNhWOCzMdvHRN7eA2byUknAo4Guv1Pf2cV8JVC6KdcKS150
	 76/8nB3utA6zkmDORKdKgjSpmnZ0z/rTjQugMYAu4e3kzFreq1YmSZTalb8uZxl18QUgW
	 yrik4QVJOjyiByBKFn52jvLbh42/DCRNNmUMnJ2AQ2rztOo68klQ6mY0U1YI3SnJgAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OI4LOAcN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605D3606A697
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OI4LOAcN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795460019;
	b=XlZNcG1eQ8UO3gM8pVnzANPdqacQycBHowY5SGrdhkfXgN3mGRJqGcgzXWWwZPbjV+k0
	 P5/SwKN+oPOGNN8mAxK577W2KYQUC4trJIORxfyNlESSpoWNJr22tun4Vxsb8O1+wk+8y
	 2A46zDGs0V9LZ5IsnUma65vaq3rhs+tReJwUU8M+G0wXh3kxehj3VJH5LK4YDQW+nDReW
	 jcuaSlD8ekp9MsM65F8FBmjGwLgZWUqgnt24ZIbys2vC5mhA0MVHs8UVTiMgmgCCA1gJv
	 42c+C4OORrmFrs1+A1lP+AGKSADkr7URFBBbKTNDgYUfwwDmQQ+wnp9Q2kjbRo8DnBA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795460019;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=S0g05G9qZGx4poDmgO7lZ71KlplbuRcjeb30J2se0iw=;
	b=grp95qAAe8ok1C1VsANNaBMj6dQFGNEgLp9N4A62wiDqUIHQtH3p7PnfPV1DngYZ/ept
	 ddyFhTiC3lzky3qqRgDoW9Q1aVNPZn5J2ZDDS3pQivtXqOr9GddP1Wq2bKRdjtt70NG/8
	 tpbcbrxxmYZifrheH6AtSfUUXhkAcTTopdQXco+71ayyxLkb0UOYw0j6IodS9SyuO0m4S
	 zxr9h+ATB97DwSDBXoGEtX/2R6R++JZ2EhRJ/frGi0xc0E/l7MXjyALAQIKcbFtjp0NTW
	 SMnnYGUNeaTnfydTqeoiFZq5N7YZ7O63DLy7b4wk9ZkFUqOXTiTVmvUEjipvt/06vQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 515341F0089E;
	Mon, 23 Nov 2026 18:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460019;
	bh=S0g05G9qZGx4poDmgO7lZ71KlplbuRcjeb30J2se0iw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OI4LOAcN4E/4zVyXqI2A61Tlme4Iy4E3rNCQ7ChWI15doWpkJiblS4VzWnkHDKcMH
	 feh+nHj6jU5xw275gQGTxXx/p6m4DT2uM+Uhka39Cm+gLsMp1V7wtUdsrpVIbG2dOV
	 3XDNoQT9Cf3EcTlIsjW9Qt28hE4eO4sxQ00stEM3/FRKWb6HrMKB4jpQrhph5f15Uf
	 QOn2VcGUZ3rDLa5/vIotCHclUtYgkSHVfmoh/ccX03+CzoPOVYVehqV/bWTeYo78s5
	 OyZ+cm2A3CkhY3Zzp7kwzSTxqy2mbYJIX8m/qIZTWe851LkSVBEWnfIoos0yRUJbD6
	 dDfZZwkHX/q2w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9B9F14C65D;
	Mon, 23 Nov 2026 18:53:01 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 24 Nov 2026 02:53:05 +0800
Subject: [PATCH v6 13/18] mm/khugepaged: convert to LRU refs based
 operations for MGLRU
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
Message-Id: <20261124-mglru-fg-v6-13-8ffea39934a6@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459977; l=1410;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=ylGSrEczLifu/DdmhwMoGhk6njBmtr2EJO7xuMx10kQ=;
 b=pXXLUep3I/vltYX0L1UH0GTTRjdiy0b3iBc9jWcCRdtT3cKw00OaEvGBk3uaweRY+TaoRFVrh
 ZG6rFxHmKKzBv05zdRFuW60YLUnIX7HDic9FG8ptG6NTl5y6QM0dqWa
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

For MGLRU, PG_referenced is only the lowest bit of the folio LRU refs
count, so folios with nonzero even refs no longer have the bit set.
folio_pte_referenced() testing the raw bit misses hot folios at
refs 2, 4 or 6, under-counting the referenced folios of a candidate range
and aborting otherwise good collapses with SCAN_LACK_REFERENCED_PAGE.

Test the refs count directly when MGLRU is enabled, mirroring the
smaps conversion.  The classical LRU keeps the plain bit test.

Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/khugepaged.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2dc4245814df..5e768481ac22 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -579,7 +579,9 @@ static bool folio_pte_referenced(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr, pte_t pteval)
 {
 	/* The folio was referenced previously ... */
-	if (folio_test_young(folio) || folio_test_referenced(folio))
+	if (folio_test_young(folio))
+		return true;
+	if (folio_check_lru_refs(folio))
 		return true;
 	/* ... or the PTE mapping was recently used */
 	return pte_young(pteval) || mmu_notifier_test_young(vma->vm_mm, addr);

-- 
2.56.1



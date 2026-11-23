Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795460027;
	b=CB92zkXzGDVAm68HHw/88slo96Y2mplAH9pHpzbBihjreTvPods9B9rGyagJiszSQ3yJ
	 kExWixzIPEYBEUG3oN/sqcK0kmVYYwdyL+Gu96JWmihgi/77F0QHbsitA4BiLiKhSjDCZ
	 bzM7rTUSQZb42PO/FMPdoiwuY7BYqSEidy/6TWqPgMCo9uycmstOx6Ur4roX+ubBpMPJI
	 6bGU4XbD1OU8gpQ4NypnsLC4b7/2mgU9LkNII18tLqL/x6ej2+0+VVQZwmTG7izaxYC/h
	 DHYZU33n93XgRxZxC2uYee2IOf9K9KQLv/faBvqYoSVVJWLXGbadE/Jm5m1JcM22ZMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460027;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mw7v666B0O0bXEelFGMEGNGOC4m5brM448d+fEgwE4Q=;
	b=x3HstVMHyB4CKfs+KkhwomMzFtamedZX6sItIyCE/9F7kpRSfWQJ7WBNcsizKQrQXYr0
	 DgJkCg7VtC72xqcjifx4B9J4pWCEC93EYKYY3BQnvB5vcZCGr2SnUeVHEXHWl4/Dbk1/R
	 yFBk8PPzgJk6Jq8m6VixWBKifZ7qLGWiiVuogajHbs+2IcAF0FhqQatWFYSfl9cDa+npQ
	 pbOL3vwDQQDa9N38p1LQ12iwJO4kENhpgz+xJBSf3DfMi4TH+mFxcBr0m5mXS21qGmSKK
	 ahGLrrj52zmjkMG4VN0qb+Heqqib55iVi5pfxBbkB1LApTeaz+GlX5fMx4VVqxxIuAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kvn2eKj2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C8606A335
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kvn2eKj2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795460027;
	b=s9m8yAcxxNEfbnbupQJ/Kap8lXhNHE9Xj/CDHgO6ZuktYW7bG8P/AmD7cZtSltU3Qozu
	 xN9GfgMnN9FOldIn/x5Z41YINVZsbsXUdsgYQHtfyXG84D/gcqBPZkog8+e86HfD9heqq
	 wXHwpetXKRHZQl5rLPDtiHPgDcDpoMW/5/FJisZEIPIOgxneCFWEePMiVjr3r0XvSYNaC
	 zeBa8BxksbaLcVtMR9CzzrW0kWsNpfMsSKenu2GY0cBnG46j73m51j0xnONhfvDVPQgND
	 hZZrBw4jgqw/UGHpDOmDHNw7IkjNoUasUE9+EvRw8XMIuJMO9i0AyyP7WMBEwuyAugQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795460027;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mw7v666B0O0bXEelFGMEGNGOC4m5brM448d+fEgwE4Q=;
	b=nE113oW2+S/0/bma8RU8z+GPlzjKgHNRvOKbTFuYwozuGcn1D9PS6OyUUrwbITi/NFwW
	 OG8k2KlHXwJbuF+m2hAsnH3K6vWfcf3eWSoFNDfaiyzb+VoPsk31Fds/Pd6EFY5eyoKVg
	 GVSoEJ8XWZEzQOvxxVAFISn7WnDNdHyrC1XocUvdEMcNMDhA2s1KqmewSWnJHJjuRaRD1
	 8QSsU/KHP20mGZVu2TCY8zu/jRtZb1FvLwH5wszoFR7DRpTe/qOXgq+HY4HtwhWI1f/j6
	 CZVGk+2PaRW1RyBIRSh3mr0k/unyxPVKR0gNnOTgTIJZ5uld8/c7wZyxYZxnuicbyjw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5983D1F01571;
	Mon, 23 Nov 2026 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460027;
	bh=mw7v666B0O0bXEelFGMEGNGOC4m5brM448d+fEgwE4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Kvn2eKj27hFMPgJVtAc5d2208LouSMNPLAWPJ+1RLOZsBkB9ZOPuC9KmqTlMtF4Ph
	 PWnFZkkNgKZ9EGPdTTPSDDEaR/HpQu41qc4SJesFWCdOF3TERCnHDOwpSKzHxKKRSZ
	 AG1N/06f+cF+G1K2k1LEh3G7MDZcDC+bSfJnf+AuabRx7FLRPrQ4uVPxG+3yUGqIqG
	 lPbuesoiNS3Rz4AnZHCjutNrurN/FKP6gSf5VmxbHk4jas3ivINnT+TVqGVVyJnzkS
	 FkFbwkcGvTUk2dqtZRrYkIKxTqoXZORj5Gq1g+xG2mMMk4XJAer6M/0Qsb6K7LtQF2
	 yk+gA2mwUDqUA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D6E814C665;
	Mon, 23 Nov 2026 18:53:01 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 24 Nov 2026 02:53:07 +0800
Subject: [PATCH v6 15/18] mm/huge_memory: mark folio as accessed more
 accurately on split
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
Message-Id: <20261124-mglru-fg-v6-15-8ffea39934a6@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459977; l=2081;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=svKswWLQsOqCODPXI2P9d3ZShVpGHldhUm7oZl8WLHs=;
 b=uGyjbdLY9Xmj/REU9NlfpO+n2XY34DVfiQMG2A8ErYXhlavxnUkdesLKD0RF2+NCUWBfn8wnX
 n5ET/23+qQAD8v/x6lWvWEUPWgb1QREe0OKsx1v+54gfQ08nLyRKQjZ
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

The behavior of updating the folio's access info isn't consistent for
huge mapping splitting or ordinary unmapping. The page table's young
flag has to be translated into folio's access info.

Right now it only checks and sets the folio's referenced flag, which isn't
enough since folio flag updates on access have their own rules. Ordinary
unmapping (zapping) calls folio_mark_accessed(), and it also checks
if the VMA has recency to avoid false updates.

So first just use the right helper here to be more consistent. Keep
accounting the young PTE as a cache access, sticking to the current
behavior.

Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 75e8641bf9ff..fa9f6d21e786 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3122,8 +3122,8 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 
 	if (!folio_test_dirty(folio) && pud_dirty(old_pud))
 		folio_mark_dirty(folio);
-	if (!folio_test_referenced(folio) && pud_young(old_pud))
-		folio_set_referenced(folio);
+	if (pud_young(old_pud) && vma_has_recency(vma))
+		folio_mark_accessed(folio);
 	folio_remove_rmap_pud(folio, page, vma);
 	add_mm_counter(vma->vm_mm, mm_counter_file(folio),
 		-HPAGE_PUD_NR);
@@ -3245,8 +3245,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			folio = page_folio(page);
 			if (!folio_test_dirty(folio) && pmd_dirty(old_pmd))
 				folio_mark_dirty(folio);
-			if (!folio_test_referenced(folio) && pmd_young(old_pmd))
-				folio_set_referenced(folio);
+			if (pmd_young(old_pmd) && vma_has_recency(vma))
+				folio_mark_accessed(folio);
 			folio_remove_rmap_pmd(folio, page, vma);
 			add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
 			folio_put(folio);

-- 
2.56.1



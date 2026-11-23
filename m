Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795459992;
	b=dxgvCoz1SgBposG+85GNsBYglC5bIxs6z8w/7PJYx8Qrhz6wQvdRY0mJfuffQb+dCFYw
	 /B7KT1aesbCYm98rSmkRiHlWTByQyZKQLrageC46nrjFNRP5R2fgQyTvJRQtcqc7NZQJM
	 BzYt06git8fGvoW+xtDRopOipIWlNpV4/M2qVJG/Yv9MpWqhMNcz0dNuy2rHUXryg6GLB
	 /XJ/lM19uwuLDillT5hUg2FFkNlz4xqVRVjyd1ydVZ3SD7TLYC5IwRKrUwVsblHPQBTgs
	 ZVgoa4euygY3vCBbziq+AF104+m4sO46VqQitIFn6hWz25U34ZTG+wovEQ0lz6QypUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459992;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=1rCE3K77C597tnpDa8DpHCzRg0yY18+BUyGptbSaO8M=;
	b=otQMPJ7VmzM5IufE/b60EDGg1CKPmH30aeHJThNvnJcY67ynHUr2e0vw+kiqBXfSJKiI
	 HPA1qmI2JFTSQg9AFfBuolK2XbHoEWknJw0+xYxDtIiWVXYivfkKUzDIhSZ4HmGvRjEBu
	 vatLNlvDP8Q+7JqRrZ8BzpS6L1L/giVm5j90TCnLtlyMBXgul+EjgnUY2TlgYsoG+IZiT
	 T3c8/2XMizR1r/dUWR67wJUTfxR+pvjGljaQfpfNWLqgA0+1DlHkk4+neHQH5f09xy8Gu
	 CGDWJIs99J9DLPSpbgov33yUqbCn4KMHghoGsvaO1O19Y7aletPgXkzeAb4f7Qj5NKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxHGNC5s;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CEC606A331
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxHGNC5s
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459991;
	b=VqrtkzsZpwbBWdhobgxDRWyp670zpJGkumwwk9EkRViasRFZj/SOs9LZPlpZD6s0mHl1
	 H+guxh9tTBSmp4OC2H/b26bIreOqyw2zBkFpZCocSjBoOECEgg23HZgqTew9a3vZQCBYd
	 YjQ/aEAspcZyABlkU6m4wY6aJKA9fuP41/V8720kRCei6IG8U6fdNQ6Y/4/P1/l8TnXPo
	 F2QoHBsq7ll4hNpTxtFOQXoCScXB3Eg/uvW24C2stiWoHtz1VlN+tZQU7lbIvvPOoQ5ex
	 ZG3OwO6+x+pmpBtRtUF9GHKgiPYbrkt3SkK9djjv+QKkW0mRR/RgHgErzIj+A3nrobw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459991;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=1rCE3K77C597tnpDa8DpHCzRg0yY18+BUyGptbSaO8M=;
	b=OZA4yKs9aDhaFmswPuvdqx3O+nSR0PQLYo8887N3jlpJy987Z16FHdeQeaVihwSci4Ui
	 NoSJtPOiupvBBIFAmoNZfL//PrhvQJCmG7hMcF8IamJxEsnrBMwsJ/1n0lEV85sSomVVh
	 0LtIQbfk4EkwdEv8JtC3mAEVJlLYJsc3YrmIMFxu+7FHItVdH1Il+fOBaEDbU4JKogUxJ
	 yHhXvxDZ22H8QI8wY4uLeJ3Yld5LsnyEKODvQGs3VXBkGewuPv7e+ixLt5O26+MUOggp6
	 qeFp0gf0Yf4qEO/fGad/IwUKgRQN9qymlmVvU1UWl70s99/CBOuKantZbJac1jqGRIw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 93F8E1F000E6;
	Mon, 23 Nov 2026 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459991;
	bh=1rCE3K77C597tnpDa8DpHCzRg0yY18+BUyGptbSaO8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IxHGNC5sragwBh5QGX0PyWQuWy0XARSCfuo41VfVYkmms46RobvrXqnAAqQ9QixYw
	 qvt7/43qhMi/9mtQnROfskTRnxYqKZJW0jwgRnSlnlDTGVxg16RYNDwB03Z7vPRuqZ
	 TiFzMuECZtVh7BzryNWZKFaBFrEgSf9SeI9X+wFA+zvPxI1nZiJNirD3vOQi99zvYv
	 5XuQYw/H/RPpXWrnLSIjYFCstERC52wkBcx8VLhxEaLFDp/ARAhyYk0zwlnAGkX4AY
	 dRPNtDnVSJ2bBEVx5vGiAgAuklHnzOWGqRnevLZ80AgSUlQycmtCUR74AHpVbghkwu
	 xX7BfYkkghwlQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 19F304C61E;
	Mon, 23 Nov 2026 18:53:00 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 24 Nov 2026 02:52:53 +0800
Subject: [PATCH v6 01/18] mm/mglru: rename the generation offset in
 lru_gen_folio_seq()
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
Message-Id: <20261124-mglru-fg-v6-1-8ffea39934a6@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459977; l=2457;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=on9PEefPrnrWULo5N6A+huTmLVTp8DOK4KQGDrtfCuk=;
 b=k5w2EsjoX/bzOEsAS9dWQMREbqipjNq4MTFKSvXR62sapovupL7OAfzxXHx/FEdKFSDvVsq/m
 LPR3LW9KAAICkw7ayuMLIbGlQoHMlZd+Jb96r6pjoa0gTwy/SGGSIPh
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com

From: Ridong Chen <chenridong@xiaomi.com>

lru_gen_folio_seq() computes how many generations below max_seq a folio
should be added to, but stores it in a variable named "gen". Elsewhere in
MGLRU "gen" means an index into lrugen->folios[], i.e. seq % MAX_NR_GENS,
so reusing the name for a relative offset is confusing.

Rename it to "age", which matches what the value means: the newest
generation is age 1, and a larger age is an older generation.

No functional change.

Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
[kasong: dropped the comment table part, the series rewrites it]
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm_inline.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f6f4bc9a704f..2395ca8ee305 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -302,7 +302,7 @@ static inline unsigned long lru_gen_folio_seq(const struct lruvec *lruvec,
 					      const struct folio *folio,
 					      bool reclaiming)
 {
-	int gen;
+	int age;
 	int type = folio_is_file_lru(folio);
 	const struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
@@ -319,17 +319,17 @@ static inline unsigned long lru_gen_folio_seq(const struct lruvec *lruvec,
 	 * |<---------------------------- MAX_NR_GENS ---------------------------->|
 	 */
 	if (folio_test_active(folio))
-		gen = MIN_NR_GENS - folio_test_workingset(folio);
+		age = MIN_NR_GENS - folio_test_workingset(folio);
 	else if (reclaiming)
-		gen = MAX_NR_GENS;
+		age = MAX_NR_GENS;
 	else if ((!folio_is_file_lru(folio) && !folio_test_swapcache(folio)) ||
 		 (folio_test_reclaim(folio) &&
 		  (folio_test_dirty(folio) || folio_test_writeback(folio))))
-		gen = MIN_NR_GENS;
+		age = MIN_NR_GENS;
 	else
-		gen = MAX_NR_GENS - (folio_test_workingset(folio) || folio_test_referenced(folio));
+		age = MAX_NR_GENS - (folio_test_workingset(folio) || folio_test_referenced(folio));
 
-	return max(READ_ONCE(lrugen->max_seq) - gen + 1, READ_ONCE(lrugen->min_seq[type]));
+	return max(READ_ONCE(lrugen->max_seq) - age + 1, READ_ONCE(lrugen->min_seq[type]));
 }
 
 static inline bool __lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,

-- 
2.56.1



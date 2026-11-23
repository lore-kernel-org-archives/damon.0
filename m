Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795460018;
	b=VnDODa8AAdWGvHsUjt9H7jCetlMq4uaoif54xiJat2oaWMgGBYCW/Rg3yaEOdQBFkkga
	 bG2CW6C1Aj/TwTIHodL/i7Tswo8nik+PQbc7JZngdrJl1lcDD4utYFuRMAI6NL9Tkxh4Y
	 y9jzsNHoRcrGw8u4B4kyx/JZezM77NbQZKGxBamur4bs883ZFdEp+3Cp5gHxy5yayxq3J
	 oKspoZnR9pBdwbH/d84cIrpB9faEG0szmb5mZuW/13w16dETghHPRrm2GUs4GE6x7oG4h
	 W+zFAVmpIGQlW4MqURmakkaTxUIr374Cr3GgvhKPedfSAwdXZkF9JfsOMbqLHHI78ZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460018;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Fy4iqtyOKVldxfrRoRe9ktEnWMk4sYM46noWj6UrSRw=;
	b=ICqbSaUNlIO4YnrO3p6BOe+I5Jp7V6hOTwdrQgz0flQb5TZDwupR+Mg2+uR6icTwJhTG
	 vRtmQdFWltnMyoYWCwxalRNXvF4UmclLhwYvYkGOIcII8UQSD5QuSKm6QSfn8N3Gd4Nw+
	 AqQ5zAl9MqGiat4BuAyCGWE5cNeW2CPG6123tUyo4C2PVTzbgzZizrJOZSiYGBkRNAMg3
	 kOM23jzluc+4fNfy5CpW0VtzKfUtqgzDOYVKKUR/QveYeX3ycXzfFRpXmiNFBwIBTj2z3
	 lgRAjEmJog3aUKhWGMiTOh73kZ80GjRs2S7PtXHlXflU04eSRdjCK8UiArqUOLcvsgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDdFSan7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53E606A338
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDdFSan7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795460017;
	b=Jjom/3pXj9tQ4Zp3RY6f1pRLFSFi1elnVZHOHB16wOhnCgzztlKtRhds8GqKWoTbFEh7
	 FfyFpocQ8gnZXG11ZMWH0dKXcBRs+B1NQ6x2dOwzudNvipDxD8r8ORv8sY7alkGQsyRaM
	 xHw7fmarnOqgfcJrJh5iXpORnzg+WlxaaWDqqPQuLaHlg7QE7eXZXb63d8pWM75CGE6Sp
	 GNNeQk6qJOA3RbjOAgLudIryPmgPkgzyLuIoEbtWmyEVWVhWRBvKFAX9aWHCev5dG353a
	 dZhr6uCSMMdmGgTpiUo9Z9jGuUt9ox/7HZaVYiXqP0SREdR+Wo9EpqYacfrovf81V5Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795460017;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Fy4iqtyOKVldxfrRoRe9ktEnWMk4sYM46noWj6UrSRw=;
	b=tRGxDVjH8MG4m8kIQshdLIlAYSkuobghJlZyhEOJRFnchk5NMEm1ZuL+cNRaBTMSHB+v
	 ZzCrqNeCOC9oL8+eBJwOhx5obY4uuaAeU24F9RWRSYLzunqyjXg4tct3cb7r6Nv2595Tj
	 9S9chC2aPBehcCUuFKQ4N/spZVS3zNJGiBAy4ewHWy0TDb0XPcOgb9ypo3JDQQXnDot03
	 WIAOMrgCMO5I/oNHdWaAcWHsfaGdj/pXSTgOpf0HkhREeaAqU0yLHhJ1bh29S4NfVSzot
	 NnuU3VKDVDIip+n9LhxM/AuLw3QoX8Lv6ZN4FfLkFcTs3nFUSIZaEz2cYcHjoHpczWw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 05F841F00A01;
	Mon, 23 Nov 2026 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460017;
	bh=Fy4iqtyOKVldxfrRoRe9ktEnWMk4sYM46noWj6UrSRw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HDdFSan784ZY1na1QkuZrD95OJiWZSBxW9gq0IStIhqhG0yjn0dpGPLLGatoic2DP
	 Py7ZCCqX5utH+eeLqYyOdGxXmcWhNWPFhzmDDMoHwmXyzb0BPwiitlD84JT8t3ocM9
	 3fF85JwREouTYeQn0DrSMgA+MCpvbj5GgMG6chRw/nS+zWCb1B31mtQjRv//RVYdwI
	 Y8dUXCa2xCVsKHSNpuYZfMD1ckgK1ZXwVEP/viCzLZZe47PMjmHamNIAE5XE/EVBqF
	 kfkLTE6Xb2npiprm7It0dl0ROQvEbq60eDfb/z8FrZooitk5uC4vvYoTKkeoIJTlTK
	 Vzw7roGeXf40w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7F6304C659;
	Mon, 23 Nov 2026 18:53:01 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 24 Nov 2026 02:53:04 +0800
Subject: [PATCH v6 12/18] mm/damon: convert to LRU refs based operations
 for MGLRU
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
Message-Id: <20261124-mglru-fg-v6-12-8ffea39934a6@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459977; l=1016;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=ofT3DkXyC3h7ptCQPZjIa/LhrvPGmBU9+3gfY2rFnss=;
 b=o6eHIETcJuwaJUc97SH5F7SQ/kGVMK/yHu942m9yR9l+9EVkcSYS7fRXRI9yRCIPDg6wTwp7x
 /7/d/ERJJiaCtmPfVXmihoibf7n0JZz3OuQL/SSmum1iHaht3PhdLNZ
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

damon_pa_pageout() cleared PG_referenced directly, which under MGLRU
corrupts the folio's refs count. That flag is now
bit 0 of the count (LRU_REFS_FLAGS).

Reset the count instead under MGLRU.

Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/damon/paddr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index e89cb14ee17b..411e1d557ba3 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -279,7 +279,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 		else
 			*sz_filter_passed += folio_size(folio) / addr_unit;
 
-		folio_clear_referenced(folio);
+		/* The region is cold, better drop the hotness info. */
+		folio_clear_lru_refs(folio);
 		folio_test_clear_young(folio);
 		if (!folio_isolate_lru(folio))
 			goto put_folio;

-- 
2.56.1



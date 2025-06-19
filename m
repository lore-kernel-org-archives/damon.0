Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BFD23F431
	for <damon@lists.linux.dev>; Thu, 19 Jun 2025 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309408; cv=none; b=GsOQD8EyCk/MnXMEmZa+OVh7oIoL/vmC+V4TNxk9Y1Y0qWy5XntYBjrvirEehoeLjj9gnu41XgIHxxf69YH6Y0+iRGI+k4y28R+sToJbYogPEeXE5qnAiVsLxxUtR/JJSdldi4QkGKKY2nCSSWnrOP+pOQyOSvfp1/uPQ7XBl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309408; c=relaxed/simple;
	bh=lpOfr6TnWhI+T1uO2nBTYytTQnHCKRyCvzte8mL3CNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4gzA3lIaqYxA7zKPuGKC987yAM0z4LIro5C2HdquWhD62aXKAzUFVbktkKRgyW52AYmM4JNgGc9C37NM9ISNaxlfqs/yUypCcWZCaVV7KtBiy04dA86kuFzH5ZT87AAcOg0ZezaRlIc2RzTxwDe79M0bSi4c8RrDdmfOFApiUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-a2-68539a14f200
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH] samples/damon: add parameters for node0 memory usage
Date: Thu, 19 Jun 2025 14:03:12 +0900
Message-ID: <20250619050313.1535-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsXC9ZZnoa7IrOAMg1tzuCye/P/NanF51xw2
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7vNg8k9Hj8ya5AJYoLpuU1JzMstQifbsEroyZ+y+w
	FHznqZhxaQ5zA+M3ri5GTg4JAROJaScOMsPYjROvsoLYbAIaEgcPnQSLiwgISvQ/ngEU5+Jg
	FuhjlFh26S5YkbCAq0RPw0wWEJtFQFXi7ZJmNhCbV8BcovXDWTaIoZoSDZfuMUHEBSVOznwC
	Vs8sIC/RvHU2M8hQCYG3rBLzb/WxQDRIShxccYNlAiPvLCQ9s5D0LGBkWsUolJlXlpuYmWOi
	l1GZl1mhl5yfu4kRGFjLav9E72D8dCH4EKMAB6MSD6/DqqAMIdbEsuLK3EOMEhzMSiK8i0/4
	ZQjxpiRWVqUW5ccXleakFh9ilOZgURLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpg1Po86+e+
	wmM7fFRcZAt0bn/+06ZumOuhYjPxixuniuJceWGGVxsMFLOrXrG1HXitIPMpunrJBO9Le/Oc
	roQLlvAu2P9rW9nqxRedP6v85uUvc1WZWhFzienHOi+rSdE3lp5MYE6QunO+UJG9WsLj3gKp
	OQJz9j/YPv/rbL+Uqu47Ww2tBE8XKbEUZyQaajEXFScCANi7s4coAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplluLIzCtJLcpLzFFi42LhmiGroysyKzjD4NsBJosn/3+zWnx+9prZ
	4vDck6wWl3fNYbO4t+Y/q8Xhr2+YHNg8Nq3qBBKfJrF7vNg8k9Hj220Pj8UvPjB5fN4kF8AW
	xWWTkpqTWZZapG+XwJUxc/8FloLvPBUzLs1hbmD8xtXFyMkhIWAi0TjxKiuIzSagIXHw0Elm
	EFtEQFCi//EMoDgXB7NAH6PEskt3wYqEBVwlehpmsoDYLAKqEm+XNLOB2LwC5hKtH86yQQzV
	lGi4dI8JIi4ocXLmE7B6ZgF5ieats5knMHLNQpKahSS1gJFpFaNIZl5ZbmJmjqlecXZGZV5m
	hV5yfu4mRmDgLKv9M3EH45fL7ocYBTgYlXh4HVYFZQixJpYVV+YeYpTgYFYS4V18wi9DiDcl
	sbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgdH28r1vzzrs5rHc
	aCgyfPl8SYy8yBKj8O+BcxhdL+n/ufOA8XtdziO/fUt8v0fsPNyx2DbMITfn1/RvHR7r1+tW
	t+y25K7ud5aVuv4nvSfeP+LAlpccLQfWrhFfIn9lxtNpUUc311vXrJz99eUmobtJB059MhY1
	et7pktHrLjJ/qX5tV+v16MlKLMUZiYZazEXFiQByhXApGAIAAA==
X-CFilter-Loop: Reflected

This patch changes the hard-coded quota goal metric values into sysfs
knobs: `node0_mem_used_bp` and `node0_mem_free_bp`. These knobs
represent the used and free memory ratio of node0 in basis points
(bp, where 1 bp = 0.01%). As mentioned in [1], this patch is developed
under the assumption that node0 is always the fast-tier in a two-tiers
memory setup.

[1] https://lore.kernel.org/linux-mm/20250420194030.75838-8-sj@kernel.org/

Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
---
 samples/damon/mtier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 36d2cd933f5a..f3220d6e6739 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -24,6 +24,12 @@ module_param(node1_start_addr, ulong, 0600);
 static unsigned long node1_end_addr __read_mostly;
 module_param(node1_end_addr, ulong, 0600);
 
+static unsigned long node0_mem_used_bp __read_mostly = 9970;
+module_param(node0_mem_used_bp, ulong, 0600);
+
+static unsigned long node0_mem_free_bp __read_mostly = 50;
+module_param(node0_mem_free_bp, ulong, 0600);
+
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp);
 
@@ -112,7 +118,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	quota_goal = damos_new_quota_goal(
 			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
 			DAMOS_QUOTA_NODE_MEM_FREE_BP,
-			promote ? 9970 : 50);
+			promote ? node0_mem_used_bp : node0_mem_free_bp);
 	if (!quota_goal)
 		goto free_out;
 	quota_goal->nid = 0;
-- 
2.34.1


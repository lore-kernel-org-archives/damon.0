Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D63C3F48
	for <damon@lists.linux.dev>; Thu, 23 Jul 2026 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787195; cv=none; b=Qk5eVgaOTI0a2++nYEOi2btJnEwN5jn0zz3J8sd7i+hPb0meRGmTbumOtyksWx7fprfJ/6BMwcehcYa9haiGaCAjzm9DNhzaID/Czi49UYZmvP4qSfGAO2FersQJ13PY9iXnRJ28dtCpVlCSfP+BlsSAPHGE1KpS4b5AkBc2SrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787195; c=relaxed/simple;
	bh=5lvlcd6M06+auujvL18k+BuVsMBdfYp3bHT48RdT5a4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QyNNv567oGnJFej258P7QC3dO/zdCnQrxamyCgVy8gPEBQlwICF+kkOdjMTYT5wdKmkier7l6mbyAYffCqc2FBN47NX+kjZ+g2ioyr8Rd/N+Q/l8/ieB+MtvtEyb+NC4kiVKd8l5ZwevQlSYq3bXqvOHaK4aF5ga6yCPtZm/d5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eC+sWYgL; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eC+sWYgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CF
	WW1kQl/BzMbf8zLdicJKvPhiSATHZScWc+71S+thg=; b=eC+sWYgLx2LF/4lHHp
	bDmnwvjuAxRjx72SNn2kL9hyErIAAeDGkQ1ZSQjKuJhd33VfeajRZA4C/N4zcpyh
	tqp+gz/UbpxLxTWbVR9lqn6vVr31R0SOV5xzK7Y1cgPTBEqEfteb75X+F6o80X6c
	ctmn4M6025QQVxhv3IlK/xTv8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXvfLgsGFqjxyiIg--.19865S2;
	Thu, 23 Jul 2026 14:12:48 +0800 (CST)
From: dayou5941@163.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>
Subject: [PATCH] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Thu, 23 Jul 2026 14:12:46 +0800
Message-Id: <20260723061246.1878435-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXvfLgsGFqjxyiIg--.19865S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1xXr17WryrGF13AF4fZrb_yoW5GrW5pF
	4rKas8X3yUtryI93W3ZFZ5Zr1YyrW3Xr1UAFZxGFs3AFs8Xw409F9rJa40qFW5Jry7Gr1r
	ZF1kAa4Y9F47JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1rWrUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+QBXBmphsOACewAA3K

From: liyouhong <liyouhong@kylinos.cn>

damon_pa_migrate() and damos_va_migrate() isolate folios into a local list
and then call damon_migrate_pages().  When target_nid is invalid (including
the scheme default NUMA_NO_NODE / -1), damon_migrate_pages() returns early
without putting the folios back to the LRU.

Callers then discard the list head while those folios remain isolated with
an extra reference taken by folio_isolate_lru().  The pages stay off the
LRU for as long as the mapping exists (anon active+inactive counts drop
while RSS does not), and the leftover references can pin the pages after
the mapping is gone.

Factor the existing putback loop into damon_putback_folio_list() and use it
on the invalid-nid path as well, so ignored migration requests still return
folios to the LRU.

Fixes: 7e6c3130690a ("mm/damon/ops-common: ignore migration request to invalid nodes")
Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
 mm/damon/ops-common.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d1842e2b00ef..9a1e8aec5444 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -331,12 +331,22 @@ static unsigned int __damon_migrate_folio_list(
 	return nr_succeeded;
 }
 
+static void damon_putback_folio_list(struct list_head *folio_list)
+{
+	struct folio *folio;
+
+	while (!list_empty(folio_list)) {
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+		folio_putback_lru(folio);
+	}
+}
+
 static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
 						struct pglist_data *pgdat,
 						int target_nid)
 {
 	unsigned int nr_migrated = 0;
-	struct folio *folio;
 	LIST_HEAD(ret_folios);
 	LIST_HEAD(migrate_folios);
 
@@ -374,11 +384,7 @@ static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
 
 	list_splice(&ret_folios, folio_list);
 
-	while (!list_empty(folio_list)) {
-		folio = lru_to_folio(folio_list);
-		list_del(&folio->lru);
-		folio_putback_lru(folio);
-	}
+	damon_putback_folio_list(folio_list);
 
 	return nr_migrated;
 }
@@ -394,8 +400,10 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 		return nr_migrated;
 
 	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
-			!node_state(target_nid, N_MEMORY))
+	    !node_state(target_nid, N_MEMORY)) {
+		damon_putback_folio_list(folio_list);
 		return nr_migrated;
+	}
 
 	noreclaim_flag = memalloc_noreclaim_save();
 


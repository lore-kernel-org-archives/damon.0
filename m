Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295918DB1F
	for <damon@lists.linux.dev>; Mon, 17 Aug 2026 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948532; cv=none; b=sHMe9HM3kQJpJtAGgY1US+0reI1+E+Y9OhIk9zZ1zzQELID/xMVD9fe3/9OZsDRCNnKA2962Ezltqbtuz/hwKa6faPnk9Nz0ZtUHix8c4PG64mP9G4e/gV1QIbUXSDhPsQWNP+TfRTFDM4B09IuSda541e+U0mTk6r9Vf0Y4YBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948532; c=relaxed/simple;
	bh=v0sLb/3UMZYBOrv0Oj8Vg8y5bik4sqgkWPA7DYKqooU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VHizphzRgedouFOn21xb86+aZQO2BNhuFf2p3ImazMz0VQAPp9N2O5WaIJwYyaIV7zx3LbXHEUf+vWMqLx8cWbReoeErCfvosv47SiqVPGxav9in8Iqe9f5ps/LS9Ht7VbiPiXCOysoiRygwWUv6dK0oeI1twwApMbuf7WO47i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VDVBVLwe; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VDVBVLwe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qe
	zoCS2ziGjtWkqM8pbHJLsnHGsxauHDbElYinBqGZo=; b=VDVBVLweoGeVPKnK/D
	3FA+4FjN4gPb5ocX72mBVCbPcPoqsHapuV8EkKZ4sNT7Pk/BU/sI23HFAehXjrwl
	OSZTShDza+ohL1GWDVOIpe26VRaDKt3rf3A4DWxxE3Z5Aa/0bT5iVHmx3Jc+GCAf
	fjTTe5gOwunj/Ktz3aSY5YLYc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCn4qCTq4Jqh_v+QA--.26911S2;
	Mon, 17 Aug 2026 14:35:01 +0800 (CST)
From: dayou5941@163.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH] mm/damon/ops-common: factor out damon_putback_folio_list()
Date: Mon, 17 Aug 2026 14:34:58 +0800
Message-Id: <20260817063458.351063-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn4qCTq4Jqh_v+QA--.26911S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1xWF1kXF4UZw48GF43Awb_yoW5GFWUpF
	4rK398XrWUJr17ur13ZFZ5Zr1FyrW3Xr17uFy3GrZ3JFn0qw409FyxJa40qayrJryUJF10
	vF18Aa45uF47XFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uy6wtUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+hZL+WqCq5YUjAAA3T

From: Li Youhong <liyouhong@kylinos.cn>

The putback loop is duplicated in damon_migrate_folio_list() and on the
invalid-nid path of damon_migrate_pages().  Factor it into a small helper
for readability.  No functional change.

Signed-off-by: Li Youhong <liyouhong@kylinos.cn>

---
Note:
As previously pointed out by the AI regarding whether removing the local
variable struct folio *folio in the damon_migrate_folio_list()function
would introduce build-time issues: no build failure will actually occur.
This is because struct folio *folio is only used inside the while-loop.
link: https://lore.kernel.org/all/20260724060707.CE1F81F000E9@smtp.kernel.org/

---
 mm/damon/ops-common.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 0bcad6b1e5b9..5c0c941b7f75 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -329,12 +329,24 @@ static unsigned int __damon_migrate_folio_list(
 	return nr_succeeded;
 }
 
+static void damon_putback_folio_list(struct list_head *folio_list)
+{
+	struct folio *folio;
+
+	while (!list_empty(folio_list)) {
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+		node_stat_sub_folio(folio, NR_ISOLATED_ANON +
+				folio_is_file_lru(folio));
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
 
@@ -372,13 +384,7 @@ static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
 
 	list_splice(&ret_folios, folio_list);
 
-	while (!list_empty(folio_list)) {
-		folio = lru_to_folio(folio_list);
-		list_del(&folio->lru);
-		node_stat_sub_folio(folio, NR_ISOLATED_ANON +
-				folio_is_file_lru(folio));
-		folio_putback_lru(folio);
-	}
+	damon_putback_folio_list(folio_list);
 
 	return nr_migrated;
 }
@@ -395,14 +401,7 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
 	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
 			!node_state(target_nid, N_MEMORY)) {
-		while (!list_empty(folio_list)) {
-			struct folio *folio = lru_to_folio(folio_list);
-
-			list_del(&folio->lru);
-			node_stat_sub_folio(folio, NR_ISOLATED_ANON +
-					folio_is_file_lru(folio));
-			folio_putback_lru(folio);
-		}
+		damon_putback_folio_list(folio_list);
 		return nr_migrated;
 	}
 
-- 
2.25.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B1F49F124;
	Mon, 31 Aug 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186388; cv=none; b=e5SJnM1bBCMLnfJjG4kFqhKLiITxltvXDm+42GlFDCY104SORbBM6/YGTiwoY2jBiS3nmMM97ivs2/vMVQhZpCwJ0NF13h8grG0G+JX+VxbjpX8Mtr1ypaBot6w0Iz9xXJD5SX610NBq9gOMU6uFSmZgKxku1Pi7SOU50QBz2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186388; c=relaxed/simple;
	bh=cAxH+FQImjIHhDQ4CddMNt7r1x1NdRpj8H2hlk8EDEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQvPHl6568fiqKwiiHJWEPruht9emy2bIJt2lsIbbqflI38xeZWXnljxjarOJBqOEAONrJKGKb7Dag0S+ur9FetapaccR9kK8fsWYAj/IYAlQgyvrD94Z/jNuwrjM18GSDQ/kb9/h2WL1dqc7bnf6EJgsjz1aV8hMmrGwQONP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxBtxJIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxBtxJIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875591F00A3E;
	Mon, 31 Aug 2026 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186384;
	bh=+x+8VzAIyEFRtjjppXXd0Fa0HpYfRCyX/dog/XxHT84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxBtxJIO003RZUnygIKZ3OXt7NF5DiVsifsOtcqU97JTvnoq/g5TI693DWnBLJa7A
	 E0FKTpCHFsU5xOUHCOjccOYZgan1zMZo4q1B+Se9DZhFiBRcQ/SMjqz0IdGU9jeItq
	 82aUnOVfFkFjag3u1oF4GHzTc1zb7PfkuD3MI5BKOnzy+DpKgTQ9oODbMgmxU+jf32
	 x7Y8wQ9eqA/STpjnWIalK/UIW1h8lFksVA93fYyKTMWjyJ3kXDfn2KiGsau2Avlq4S
	 n+QwiTDN68KSS1lTtYy5NOZls55eMVxiVhbpr12wprl2tIgEl1CleCn02PF9q7lypo
	 +pafQn6JFqaIA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Li Youhong <liyouhong@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/7] mm/damon/ops-common: factor out damon_putback_folio_list()
Date: Mon, 31 Aug 2026 07:26:05 -0700
Message-ID: <20260831142611.77572-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831142611.77572-1-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Youhong <liyouhong@kylinos.cn>

The putback loop is duplicated in damon_migrate_folio_list() and on the
invalid-nid path of damon_migrate_pages().  Factor it into a small helper
for readability.  No functional change.

Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260818020650.2844354-1-dayou5941@163.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 mm/damon/ops-common.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index fbda70d8ea4d0..7a2e40bc7baed 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -330,6 +330,19 @@ static unsigned int __damon_migrate_folio_list(
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
@@ -371,13 +384,7 @@ static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
 
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
@@ -394,14 +401,7 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
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
2.47.3

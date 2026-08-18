Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A91390224
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787018849; cv=none; b=PmDyeGJxj5YAQrBaWwQtMQt/Vyfzn0yTEYUsAl/3TgQMOJA99caHfwW6FpbcCPaYYSfctGjh3+u6ud8aVj9I9hZhvxJZqBgptn0Rdet8UrNCwy1uRvVIR8zsFbmXFOULFaf1HyhhgKWFxCsNdlufusPuEH7/3EDeVmPlJ8gFhgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787018849; c=relaxed/simple;
	bh=lNhCtJBVvbbUnVZH9vQcHGtxZq3S87C4c6ogdt4SQKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XAOhSuzFlIM8YQXcoV/HBXEmfPJDIeN5kWTt/Rn9zyXZd4dursWw2tjHoWf0Z9t8TL4CnbcG3PIlDP1IZkfK6MOVKIJjM/ccV+B5PzBK+JIfhosh/TPKyUda+syoaBJ2hD+rNzsbCdJxI4YdQIht3p4HfBcjSL2KhHzXBeLpeV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K6i98u2M; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K6i98u2M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=B6
	44okUDm2DMJVNSvynKKl1Dx1fxHI+pke8x/2dBvEQ=; b=K6i98u2MXth5BbPKZr
	n49+CWGQp5aMApCQtRICDo/6mJbV4tiM+Jx1xZqYYQTqyVUAZOVJFpVAAet0eBAQ
	5+1Dv6s3mTJRk6yLPO7vGvM0Z09poRQdK0ustN6M81z5Fbjq6bChzEZoG4lp9/S4
	bgvycgEnagA6EwPJ5yIiRBqTg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCn2Ns8voNq82tgMw--.11657S2;
	Tue, 18 Aug 2026 10:06:54 +0800 (CST)
From: dayou5941@163.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH v2] mm/damon/ops-common: factor out damon_putback_folio_list()
Date: Tue, 18 Aug 2026 10:06:50 +0800
Message-Id: <20260818020650.2844354-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCn2Ns8voNq82tgMw--.11657S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry5Zw1kXrWxCw4rAFykAFb_yoW8Kw45pF
	1rG3s8XrWUJr1xur13XFZ5Ar1rtrW3Xr17JFy3Gws3JFn0qw10gas7Ja4IqFyrJryUJr18
	Z3W8Aa4Y9F4UJFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGg4DUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3QA76WqDvkBsEwAA3n

From: Li Youhong <liyouhong@kylinos.cn>

The putback loop is duplicated in damon_migrate_folio_list() and on the
invalid-nid path of damon_migrate_pages().  Factor it into a small helper
for readability.  No functional change.

Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v2:
- Restore the removed "struct folio *folio" local variable to fix build error.
- Use get_maintainer.pl to include linux-mm@kvack.org, linux-kernel@vger.kernel.org and relevant DAMON maintainers.
  v1: https://lore.kernel.org/all/20260817063458.351063-1-dayou5941@163.com/

---
 mm/damon/ops-common.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 0bcad6b1e5b9..ae101689612b 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -329,6 +329,19 @@ static unsigned int __damon_migrate_folio_list(
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
@@ -372,13 +385,7 @@ static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
 
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
@@ -395,14 +402,7 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
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


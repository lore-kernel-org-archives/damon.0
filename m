Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CDC1D4606
	for <damon@lists.linux.dev>; Fri, 24 Jul 2026 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872930; cv=none; b=kvTFHOGoGMeszJ0eeA+zpFLMFE1n0KraxijHCIrBLVx0gvXWRVrvrm0dgMhilF6PD1OGyJXcNpDsH5elXrK6FT0mVJfB3/50TWCuHv2+8O/lo99CK9JGUGBvYRrTBjKTO7Ymx8RO+piAJY6MGUbSgi1O6MI3jMkpM9WdCNqk8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872930; c=relaxed/simple;
	bh=mkWfsdASMKj7+jYWucz/GqNc6q/mA0IQHtKUdjecazU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s2BjmsEGAsrPPzqzdyGp35QWX7HPa0NMdkDtMhKH18iVf2IeAC1kqa1OD2y4Q1k0Hr/UhONdVGWtPyp6ch+24wC8/hldftqDW0YCdqjCfkXlkKQqDGkv2gQmmsy8rcQlQYADzqFXQUR7ZmY4oRD2rRIy7qdr2tYj5xMnsJTC1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VSXhx7mI; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VSXhx7mI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Jh
	breerLhHAwgm7kB+iWDalJVkVusITV82om/XI/fSQ=; b=VSXhx7mIu+Qn7wLpOd
	7kT91ddxhjTi3hTE+aVFl9U0AWi+3IkcGDagiKOcg7c+6QTb5O3JaMVYcaR3QdSH
	cnDB2uiQVvrAv27h/1FW6Y2zLAPiGa7LG7fUnRnN9OMBm83luA7e6lxNzkxN15Iv
	ygMXey4zkdsCBDZqwuAx0KyUs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCH5tPD_2Jqww8QIw--.45032S2;
	Fri, 24 Jul 2026 14:01:39 +0800 (CST)
From: dayou5941@163.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Fri, 24 Jul 2026 14:01:34 +0800
Message-Id: <20260724060135.3014676-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCH5tPD_2Jqww8QIw--.45032S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4UGF4kZryfJry3KF48Zwb_yoW8ZryUpF
	1rKa4rC39xtryI93WfZFZYvr10yrW3Jr15GasxGFs7A3Z8X340k347t3W2vay5Jry5Gr4f
	C3Wqyas09F47JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jozuXUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3QNjEmpi-8OmOwAA3G

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

Put the folios back on the invalid-nid path so ignored migration requests
still return them to the LRU.

Fixes: 7e6c3130690a ("mm/damon/ops-common: ignore migration request to invalid nodes")
Cc: <stable@vger.kernel.org>
Assisted-by: Cursor:grok-4.5
Signed-off-by: liyouhong <liyouhong@kylinos.cn>

---
v2:
- Drop the putback helper for easier stable backport
- Open-code putback only on the invalid-nid path
- Keep the original indentation and Cc stable@
- Add a separate cleanup as 2/2 (factor out damon_putback_folio_list)

---
 mm/damon/ops-common.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d1842e2b00ef..f5ded45fabd1 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -394,8 +394,15 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 		return nr_migrated;
 
 	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
-			!node_state(target_nid, N_MEMORY))
+			!node_state(target_nid, N_MEMORY)) {
+		while (!list_empty(folio_list)) {
+			struct folio *folio = lru_to_folio(folio_list);
+
+			list_del(&folio->lru);
+			folio_putback_lru(folio);
+		}
 		return nr_migrated;
+	}
 
 	noreclaim_flag = memalloc_noreclaim_save();
 
-- 
2.25.1


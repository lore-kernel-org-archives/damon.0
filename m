Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31712DECC2
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785030541; cv=none; b=Kfy+NJv4VJxkW3bzW4YBJlHAL+3+KqsGmzEORnQHROfmuFkENFEB7YM/K/cUXyDN0GZt6BCj5RDpW7NIm8Pn1/tZRb7bYDsoAjmGZRQTRljlGKSaROUngy7xrRvUPIdFE5pg7IjcsZT6mn7awajIPf4bbYJR06TyawusTymGZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785030541; c=relaxed/simple;
	bh=ZZ7c3YxLtFpn9nqUbIQV4rYg6vKaCjoCv6lpfU3WKv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=db1HLB/WXk7AhFXmvtWCghiXxvrh3rf+DE9r89tKEcQgPJZqIEOYfn+X/ve3WAdYqUnUD8CQ4hFMge5itWdbayFL436TYfM6M6QyU4pyTyecAiY+Ueyx3ia8gyyF9lLV54thu6txSlItqT0H/70fYt8dzJntxCZb5J9kihpjHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KXqdHSQH; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KXqdHSQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ad
	ku3ZUyolT1/aAV+9p6y7s5z/CUYnjGXtUnLeZtGPk=; b=KXqdHSQH3dSnhciUEx
	O1Yo8IFYTnfrT3VJb5lvl/yioTCFqgrLGm1toOfLLOE8bu5Q5lnU0Atrcgn3xqCs
	kaLSn7c2BmTCOaFxWZPZp84iTNAxf+/6SpdXMrwv88HAsyA3+D7qyOV6Hbzkjl2P
	YCToDhIDdT1NWi+jPBPO/Su5g=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXbRJhZ2VqI91GKQ--.1854S2;
	Sun, 26 Jul 2026 09:48:18 +0800 (CST)
From: dayou5941@163.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	liyouhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Sun, 26 Jul 2026 09:48:15 +0800
Message-Id: <20260726014815.1280757-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXbRJhZ2VqI91GKQ--.1854S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4UGF4kZryfJry3KF48Zwb_yoW8ur43pr
	1rKa4rC39xtryI93WfXFZYvry0yrW3Jr15GF9xGFs7A3Z8X3409347t3ZF9ay5Jry5Kr4f
	Aa1qyas09F47JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwID7UUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3QPllGplZ2PVYQAA3Q

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
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>

---
v3:
- Drop the 2/2 cleanup patch as suggested; keep open-coded putback only

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


Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1A176238
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 03:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782357890; cv=none; b=sefJomVamKWkPlutDOr+hRBzoFuM++XoMiYunGiBmC4FCSKT3wBhdyK4MILLv6vs2aapASNqfYT4SEi5tebX1ri/9IjS5tduimGSfcRw9nG1laWHaJwcDrYqm7x0oxRat/FCa66ZKGCdcZtyqZ1fmyFTKpUlVQDkXPLWk3RwA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782357890; c=relaxed/simple;
	bh=14BXS0/FqM3eU/x6BWt6LK9VultrxnPE4ayE+M55jdU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ntAYNYuYoROYaYfRed02vZ9YWD7UUoyW9yGuIviHXGuvIF03TSjFGAuwolqlmTXPoerR3IDm1GCA5XQrsAMyb/6CiSHlOoli6ZxMC/bkQSsqAWd7pibod6kjVST3DXq90J9Y/3b1CTSsVQnn2+3uHedeykRf5HrQZh9DDmJcVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
	by h3cspam02-ex.h3c.com with ESMTP id 65P1NFOg072750
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 09:23:15 +0800 (+08)
	(envelope-from qin.yuA@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 65P1MNJA069473;
	Thu, 25 Jun 2026 09:22:23 +0800 (+08)
	(envelope-from qin.yuA@h3c.com)
Received: from DAG6EX08-BJD.srv.huawei-3com.com (unknown [10.153.34.10])
	by mail.maildlp.com (Postfix) with ESMTP id 7965E20045BF;
	Thu, 25 Jun 2026 09:35:23 +0800 (CST)
Received: from localhost.localdomain (10.142.164.51) by
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Thu, 25 Jun 2026 09:22:21 +0800
From: Yu Qin <qin.yuA@h3c.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>, <linux-mm@kvack.org>,
        Yu Qin <qin.yuA@h3c.com>
Subject: [PATCH] mm/damon/paddr: remove folio_put from damon_pa_invalid_damos_folio
Date: Thu, 25 Jun 2026 09:22:01 +0800
Message-ID: <20260625012201.2937854-1-qin.yuA@h3c.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 65P1NFOg072750

This boolean function called folio_put() implicitly. Remove the put and let
callers handle it explicitly, making the get/put pair more clear.

Signed-off-by: Yu Qin <qin.yuA@h3c.com>
---
 mm/damon/paddr.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 85cd64a55..f45c7939a 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -313,15 +313,12 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	return scheme->ops_filters_default_reject;
 }
 
-static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
+static inline bool damon_pa_invalid_damos_folio(struct folio *folio,
+		struct damos *s)
 {
 	if (!folio)
 		return true;
-	if (folio == s->last_applied) {
-		folio_put(folio);
-		return true;
-	}
-	return false;
+	return folio == s->last_applied;
 }
 
 static unsigned long damon_pa_pageout(struct damon_region *r,
@@ -353,6 +350,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
+			if (folio)
+				folio_put(folio);
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -394,6 +393,8 @@ static inline unsigned long damon_pa_de_activate(
 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
+			if (folio)
+				folio_put(folio);
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -442,6 +443,8 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
+			if (folio)
+				folio_put(folio);
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -478,6 +481,8 @@ static unsigned long damon_pa_stat(struct damon_region *r,
 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
+			if (folio)
+				folio_put(folio);
 			addr += PAGE_SIZE;
 			continue;
 		}
-- 
2.43.0


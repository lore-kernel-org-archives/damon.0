Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415D4D8CE
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784334119; cv=none; b=Bg7dweLWvET8a3YFxJNyFMBin2ZZWLbUQAbtM6s6Jj16hZCxFaB8vSftBp81KidvfL6DIv3HN8Lu/zdyeb39RWgBaARQaMR4cVGNq2mZph44j4BpRRWDWClpVAIyU+Cck5CmW4xj0xjc/5WlH97L9pjcyri5ue05Ut4OP53LJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784334119; c=relaxed/simple;
	bh=JQspUxOtuw0uee1blkjsaub2pIo6Z64wZdr+vZue1Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4kLJRD00MLfajxoHnaOKQpMFUboim3DeliRQi7IhqLaq/siE1X6WEYZ/YIbQdlIeqOX+anl7cGtJay6bHq/Q2Osm4hEzZtYUBWTZvinceLDjiwn73+YXv0iruZy+1yUwCkvtxZ6hUNZKlgquebgLB0HzGxlMxrAQEREiWXO2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aa19a4de823e11f1aa26b74ffac11d73-20260718
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:80970e74-c171-4c61-a9d4-aeb85d044d43,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:80970e74-c171-4c61-a9d4-aeb85d044d43,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:b73bf3d1b5b3b8f522fdafe3a7203f49,BulkI
	D:26071717541216H8SQ0C,BulkQuantity:2,Recheck:0,SF:17|19|38|66|78|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa19a4de823e11f1aa26b74ffac11d73-20260718
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(61.48.211.50)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 197839938; Sat, 18 Jul 2026 08:21:47 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] mm/damon/ops-common: remove redundant local variable in damon_migrate_folio_list()
Date: Sat, 18 Jul 2026 08:21:25 +0800
Message-ID: <20260718002125.637104-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In damon_migrate_folio_list(), we're redeclaring folio inside the first
while loop, but it just shadows the outer one.  Since the second loop
uses the outer folio anyway, the inner declaration is pointless.

Remove it to consistently reuse the same variable throughout the
function and improve readability.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/ops-common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 89c694f6e4fa..e59f5268d503 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -339,8 +339,6 @@ static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
 	LIST_HEAD(migrate_folios);
 
 	while (!list_empty(folio_list)) {
-		struct folio *folio;
-
 		cond_resched();
 
 		folio = lru_to_folio(folio_list);

base-commit: 5093dba1014c1d7f7e247fd118f0fa8f22136046
-- 
2.43.0


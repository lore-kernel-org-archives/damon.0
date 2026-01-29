Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799F2FF675
	for <damon@lists.linux.dev>; Thu, 29 Jan 2026 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681355; cv=none; b=Y8SjNgUY/8tLDjfkP2MoEIG6DAFOyh1VnC2dEFzQTBSgMdFPSEAs+SFT64kbx1JcTlxtH/66YDLDT55f7nNJQ6HzSz03+DD3h6k1+iabzCdV+xPzd+H4Yl7Fn9ujA3r1yNJ+WssdiTRJfYeuIaj8dlLh0/gLhmdAO9JmIZVgwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681355; c=relaxed/simple;
	bh=2xfODMBkdjGhNrQo/hSgogTO0Pb5hPeX71Cvchk4RtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1VK2mZYIBR88+yi+qrxBoQXlO9zEs59pl1pBqjtw0F8TonZu6LSmwpVRK8PcLooZsDjkcPbNLXteaEJGdulqAMsAiKzr76WTYrFZcLAHtFP3QNI8ekYOPAgCHqUXT+4PfPjgeoVVLYyjBKGLy04nksK5MHGIcBbD3k7gT6S/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8b8f8a7afcfa11f0b0f03b4cfa9209d1-20260129
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2ec3349f-6695-4d8a-89aa-7a815a0d107d,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:2ec3349f-6695-4d8a-89aa-7a815a0d107d,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:19b08d9f6453e99ff74c5d1cf405e70d,BulkI
	D:260129180423GNAAQXYD,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8b8f8a7afcfa11f0b0f03b4cfa9209d1-20260129
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(183.242.174.23)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1600268495; Thu, 29 Jan 2026 18:09:06 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] mm/damon: unify address range representation with damon_addr_range
Date: Thu, 29 Jan 2026 18:08:45 +0800
Message-ID: <20260129100845.281734-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, DAMON defines two identical structures for representing
address ranges: damon_system_ram_region and damon_addr_range.  Both
structures share the same semantic interpretation of a half-open
interval [start, end), where the start address is inclusive and the end
address is exclusive.

This duplication adds unnecessary redundancy and increases maintenance
overhead.  This patch replaces all uses of damon_system_ram_region with
the more generic damon_addr_range structure, ensuring a unified type
representation for address ranges within the DAMON subsystem.  The
change simplifies the codebase, improves readability, and avoids
potential inconsistencies in future modifications.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/core.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 70efbf22a2b4..5e2724a4f285 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2856,20 +2856,9 @@ static int kdamond_fn(void *data)
 	return 0;
 }
 
-/*
- * struct damon_system_ram_region - System RAM resource address region of
- *				    [@start, @end).
- * @start:	Start address of the region (inclusive).
- * @end:	End address of the region (exclusive).
- */
-struct damon_system_ram_region {
-	unsigned long start;
-	unsigned long end;
-};
-
 static int walk_system_ram(struct resource *res, void *arg)
 {
-	struct damon_system_ram_region *a = arg;
+	struct damon_addr_range *a = arg;
 
 	if (a->end - a->start < resource_size(res)) {
 		a->start = res->start;
@@ -2886,7 +2875,7 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
 						unsigned long *end)
 
 {
-	struct damon_system_ram_region arg = {};
+	struct damon_addr_range arg = {};
 
 	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
 	if (arg.end <= arg.start)

base-commit: 0241748f8b68fc2bf637f4901b9d7ca660d177ca
-- 
2.52.0


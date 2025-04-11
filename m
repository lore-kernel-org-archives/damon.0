Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A831A293472
	for <damon@lists.linux.dev>; Fri, 11 Apr 2025 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357117; cv=none; b=aOo7pIvjhojlUZsoCBNfwaYYBuaKgnCcoR8WRU8a1YNSeN5/BbRblG4u/R0tV2VkeKVvsEQ29WqOfiHFCZ0e8/QTXjz9agpWZ5ydda/BynQIaN9EdxFNVEkvTusFITCdgTD1DeF5E3vbMvQoXydIEf/KEoFXEyLa6fRSNwmtysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357117; c=relaxed/simple;
	bh=lK+0YZblLQ54UMavFB3Xnnd+DgnfZjDVbvyppTON+og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UM2eKhEmB3oKaYxLENLhjX9eAelLLGerwL8TlRCJKu0mwPzAOfbMUOyPvaSIxYwPFSuaEda8eLkDOCa/pNZ3SCYezFTjU30XUI7vELQNpee9UuKP3JWarW25Hp8++/T3l3hUDhe+98V2n/x3fWzl2R6a6mGxchkZU2hZ2bzK6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f38858d016a711f0a216b1d71e6e1362-20250411
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2936d489-82c3-4fb2-b1c2-c23e1406acf2,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:2936d489-82c3-4fb2-b1c2-c23e1406acf2,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:9eb89e8829d66a8d056319cec9abff9b,BulkI
	D:250411153535IWC77CU0,BulkQuantity:1,Recheck:0,SF:19|24|44|66|72|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: f38858d016a711f0a216b1d71e6e1362-20250411
X-User: lienze@kylinos.cn
Received: from kylin.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1563693554; Fri, 11 Apr 2025 15:38:24 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	lienze@kylinos.cn
Subject: [PATCH] samples/damon/prcl: Fix a comment typo
Date: Fri, 11 Apr 2025 15:38:00 +0800
Message-ID: <20250411073800.1444481-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch just fixes a typo in the comment.

s/regiosn/regions

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 samples/damon/prcl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index c3acbdab7a62..056b1b21a0fe 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * proactive reclamation: monitor access pattern of a given process, find
- * regiosn that seems not accessed, and proactively page out the regions.
+ * regions that seems not accessed, and proactively page out the regions.
  */
 
 #define pr_fmt(fmt) "damon_sample_prcl: " fmt

base-commit: 900241a5cc15e6e0709a012051cc72d224cd6a6e
-- 
2.43.0


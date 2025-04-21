Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05C2AF11
	for <damon@lists.linux.dev>; Mon, 21 Apr 2025 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745206798; cv=none; b=eHFVbk8DGB5CuocxSJ19wZyqiweZGy7ByRj8VEL7MiJE3JNUMi1rLvOukV/vXVvE/toICSrM18I6DpEVv1LRX34zWAO2iotJcFVw02ipqfB1mm/ZkRuUSZARj0HFQk9Jalv9f1BXCSVa6KHR7vx22HM1eiQgl7bfFLLuvzridyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745206798; c=relaxed/simple;
	bh=ZAmyLgG3LVv+BdFP4hchKIxV67k2sP1hP3TBm8IDWJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k46TLdEvkeH1RZ10ucJE8KpVV6DchEy8lbUxCKHf+wyN2/Hc9tA7cQCkiMqgN0PNyRVxsJ3GJeqfNyBOe0nMN7YhHuG5Q3ZCTgGDHBLej3gp2uJkekdcm7busBNUP5f9rjIFbf7/CHOEvfP6fQHhrjlqF2AhhW/PFfwWILzhteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 42feea701e6211f0a216b1d71e6e1362-20250421
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c66b71ab-d77f-4138-8737-9e822d9ea381,IP:10,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-20
X-CID-INFO: VERSION:1.1.45,REQID:c66b71ab-d77f-4138-8737-9e822d9ea381,IP:10,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-20
X-CID-META: VersionHash:6493067,CLOUDID:044759a6212dce0c49472e340f5390d6,BulkI
	D:250421112558HE44CHEK,BulkQuantity:1,Recheck:0,SF:19|24|38|44|66|72|78|10
	2,TC:nil,Content:0|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:41,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 42feea701e6211f0a216b1d71e6e1362-20250421
X-User: lienze@kylinos.cn
Received: from kylin.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 547531557; Mon, 21 Apr 2025 11:39:42 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] mm/damon/core: Initialize sampling_addr in damon_new_region()
Date: Mon, 21 Apr 2025 11:39:19 +0800
Message-ID: <20250421033919.404013-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since sampling_addr is used across vaddr and paddr modules, initialize
it in damon_new_region().

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f0c1676f0599..d197a5e3901c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -128,6 +128,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 
 	region->ar.start = start;
 	region->ar.end = end;
+	region->sampling_addr = 0;
 	region->nr_accesses = 0;
 	region->nr_accesses_bp = 0;
 	INIT_LIST_HEAD(&region->list);

base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
-- 
2.43.0


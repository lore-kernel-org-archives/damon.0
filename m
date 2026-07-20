Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8D225775
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539473; cv=none; b=qy/lez/8OFzO3MlaGyvKZBMrXR2wj1pNreS7rcvjLvNAVrVWP4Y4vrvDN+sZ5kL4p6Ogpry+Urk6b/EdCgaoCXlr5SFBS5LbjPKHqUd3XU3lw3g9QNfyKpQNQVB56o7/2H2JmKtOzdDebNmASxaQ03O58nxUu84iRfsyXb8SBeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539473; c=relaxed/simple;
	bh=t3ZdQspZtRqOR7VVmNFXwmgw6qF69lv2mBUsuCzj1pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lc9EBpqKbrmwAu58y5PiQSxC/4QiTR+1rXjMbm1ws0RCwZh6v8WgFSjuN/+qZdh7hVkuy/eDTP9Oe7BkLUE8feuMbAe5CGsAllKmX3FEUygjeOg/S8N93K2gwCnqmZneqA4RL5qVeApOnzhsPo5yX7+aqFkefY40EMWuDppJHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c762971e841c11f1aa26b74ffac11d73-20260720
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:067bea3c-795b-47d9-b4ee-297a79d01cc8,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:067bea3c-795b-47d9-b4ee-297a79d01cc8,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:be2d59487f0c83131b6ccef6496139c7,BulkI
	D:260720172146CJUOA45I,BulkQuantity:1,Recheck:0,SF:17|19|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c762971e841c11f1aa26b74ffac11d73-20260720
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(39.156.73.11)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1126628943; Mon, 20 Jul 2026 17:24:16 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] samples/damon/mtier: use damon_addr_range consistently
Date: Mon, 20 Jul 2026 17:23:55 +0800
Message-ID: <20260720092355.237599-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAMON provides struct damon_addr_range for unified address range
management.  However, the mtier sample still defines a local struct
region_range with an identical layout (start and end as phys_addr_t) and
mixes its usage with struct damon_addr_range in
damon_sample_mtier_build_ctx().

This patch removes the local struct region_range and changes the
parameter type of nid_to_phys() to struct damon_addr_range.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 samples/damon/mtier.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index ac9c24b92ead..67f20b52dc7b 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -52,12 +52,7 @@ module_param(detect_node_addresses, bool, 0600);
 
 static struct damon_ctx *ctxs[2];
 
-struct region_range {
-	phys_addr_t start;
-	phys_addr_t end;
-};
-
-static int nid_to_phys(int target_node, struct region_range *range)
+static int nid_to_phys(int target_node, struct damon_addr_range *range)
 {
 	if (!node_online(target_node)) {
 		pr_err("NUMA node %d is not online\n", target_node);
@@ -78,8 +73,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	struct damos *scheme;
 	struct damos_quota_goal *quota_goal;
 	struct damos_filter *filter;
-	struct region_range addr;
-	struct damon_addr_range range;
+	struct damon_addr_range range, addr;
 	int ret;
 
 	ctx = damon_new_ctx();

base-commit: c872b70f5d6c742ad34b8e838c92af81c8920b3e
-- 
2.47.3


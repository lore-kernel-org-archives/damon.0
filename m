Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF84218B6
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552832; cv=none; b=DBmXPobw8nFEeEz7qDaA9A2sm6C7GYFUPiYxeHH4FQi4Fdtl1FJoPTK+so5W89JVyychLX/qauElWxHA20cAPbi/5TCxcbG7nGrhJ+Kam6M1kwhDJz2WXz8NfqA94LEx5sJ8Gekj0U6iExfQuMPGwVtGSko8tWn0h4H2T3YJrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552832; c=relaxed/simple;
	bh=Fuki6j+/YAJQSF9QIAUdpX79seRq4EZ2DaLy91jrQhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXLnWp79pK5vWi/JSPugqVkotJQRtkFD0YazGlqPjGy2Zy2g6SP7CyRuboQCB9yaMdDnUGbOYH4yph8TgeNYOYYwt9XkSgf+0HZ5knh7IT7Ko4ZGl49E+k3fBVfBiIAL0GSyzTHFGWZE8C/jNth2ZEZmHsuQp+jbZiwnGs8mwE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e4737b38843b11f1aa26b74ffac11d73-20260720
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_LOWREP, SRC_LOWREP
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a7d9821b-5224-4c18-86eb-e17116515eae,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:a7d9821b-5224-4c18-86eb-e17116515eae,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:2100e216361bce3249ee41bc74c42a17,BulkI
	D:260720205347EDB9HWME,BulkQuantity:1,Recheck:0,SF:17|19|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e4737b38843b11f1aa26b74ffac11d73-20260720
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(61.48.211.50)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1692005296; Mon, 20 Jul 2026 21:06:59 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH v2] samples/damon/mtier: use damon_addr_range consistently
Date: Mon, 20 Jul 2026 21:06:42 +0800
Message-ID: <20260720130642.508355-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAMON provides struct damon_addr_range for unified address range
management.  However, the mtier sample still defines a local struct
region_range and mixes its usage with struct damon_addr_range in
damon_sample_mtier_build_ctx().

This patch removes the local struct region_range and changes the
parameter type of nid_to_phys() to struct damon_addr_range.  It also
gets rid of the now-redundant local variable and pass the address range
directly to damon_set_regions().

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
v2:
- Fix inaccurate "identical layout" claim in commit message
- Remove redundant range variable and pass &addr directly to
  damon_set_regions()

 samples/damon/mtier.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index ac9c24b92ead..3712287f009c 100644
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
+	struct damon_addr_range addr;
 	int ret;
 
 	ctx = damon_new_ctx();
@@ -123,10 +117,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	if (addr.start >= addr.end)
 		goto free_out;
 
-	range.start = addr.start;
-	range.end = addr.end;
-
-	ret = damon_set_regions(target, &range, 1, DAMON_MIN_REGION_SZ);
+	ret = damon_set_regions(target, &addr, 1, DAMON_MIN_REGION_SZ);
 	if (ret)
 		goto free_out;
 

base-commit: c872b70f5d6c742ad34b8e838c92af81c8920b3e
-- 
2.43.0


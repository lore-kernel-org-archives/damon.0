Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ABE2C11E4
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617711; cv=none; b=akQlSL2KQ8FWiaTNMzwVOZZxewVbX7f2AWFMTxGK6yog6+GMOXFcbzsAmPfUYCeDd+U3KUEfjW1USMZW2ua0KHDRnnUhS5kcLaF82xbI2dfoAt59UN5s5Hd9kB9+qteVdgm8nzkaMSpdyh/VdiDwRqmgg3v2DXeYf2DgkdauLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617711; c=relaxed/simple;
	bh=DwtscmRxRuJHnDTiOUJbYGNgTTYCVFbzDNXl8Mflg/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=otd29zJoYykR+o/1XBDuZ8kKYrGE+yafVz2wfiFYdFXiL+YXpvuIHOmR1jjInD2i9L0bKnT8ovesWnDv007caygD4dLKuW5O/h6ESEphJhHeRwGxBUUq1PdPt6RCRK8i3riJ/cNZakXcfCiBl3gxu9oGnqwLNto++5hs8LxKYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f4786c2c84d211f1aa26b74ffac11d73-20260721
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1039956a-eda0-460d-8a04-ce272dcc0a8a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:1039956a-eda0-460d-8a04-ce272dcc0a8a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:9de877802313be25eca46f823632e7ba,BulkI
	D:260721150201BMQXQA8Q,BulkQuantity:1,Recheck:0,SF:17|19|66|78|102|127|136
	|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f4786c2c84d211f1aa26b74ffac11d73-20260721
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1449868546; Tue, 21 Jul 2026 15:08:20 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	lienze@kylinos.cn,
	enze.li@gmx.com
Subject: [PATCH] samples/damon/mtier: add comment for struct region_range
Date: Tue, 21 Jul 2026 15:07:56 +0800
Message-ID: <20260721070756.54435-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mtier sample defines a local struct region_range using phys_addr_t
instead of damon_addr_range which uses unsigned long.  Add a comment
explaining the rationale: on 32-bit systems with more than 4GiB memory,
phys_addr_t will be 64-bit while unsigned long is 32-bit.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 samples/damon/mtier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index ac9c24b92ead..27dc88bdf7a0 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -52,6 +52,11 @@ module_param(detect_node_addresses, bool, 0600);
 
 static struct damon_ctx *ctxs[2];
 
+/*
+ * Use phys_addr_t instead of damon_addr_range (unsigned long) for physical
+ * addresses.  On 32-bit systems with more than 4GB memory, phys_addr_t will
+ * be 64-bit while unsigned long is 32-bit.
+ */
 struct region_range {
 	phys_addr_t start;
 	phys_addr_t end;

base-commit: 3d18f3499c48ee94a49589500ce94e41c5acdf4b
-- 
2.55.0


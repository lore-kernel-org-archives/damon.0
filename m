Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A502F99B0
	for <damon@lists.linux.dev>; Thu, 14 Aug 2025 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173898; cv=none; b=NpIyW+L9CB6uMH3BKa7h1+CFAdQUN+Kpxm1S0x1P5GawmwY+8Hi3evO2j+daFefg1s33ABWKxWUQWG2qqBEVc1lYXoblmN3k3rOHPrTB/R9OJfJlSbmJ4+lNoLvm9Q1ZKyn3ZvW7gHv56tA8KzGsvaeWaP0yxa0jKJOvTwRedNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173898; c=relaxed/simple;
	bh=m11/Xs6zn6290g4I7vW9CA2eRLNbjBc785mO4WrMAlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kf0aNH/nnbkSSoE2XNIzYKX6HlBUm8ftNdYCnq/Nl0jPU7atZINJdRh7WD01GHsdz49LxrQW4Ar2F9TEi2Yj2S1EETvC3zUs038EfKhOSWt5vcfwcuOpSeILoLMNT5pySeWEtIS4E67i6ltJ1oOpmOoHVoxom/knEg962cBiBcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b863c1ea790811f0b29709d653e92f7d-20250814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:64577dd8-f7b9-4176-9b57-1fa45a86f7b8,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:64577dd8-f7b9-4176-9b57-1fa45a86f7b8,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:a33802a226fed93bfa7516bd949f81a1,BulkI
	D:2508142015263G0WGKY2,BulkQuantity:1,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: b863c1ea790811f0b29709d653e92f7d-20250814
X-User: lienze@kylinos.cn
Received: from kylin.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2007450188; Thu, 14 Aug 2025 20:18:00 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] mm/damon/Kconfig: enforce DAMON_STAT when DAMON_STAT_ENABLED_DEFAULT is selected
Date: Thu, 14 Aug 2025 20:17:03 +0800
Message-ID: <20250814121703.648925-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAMON_STAT_ENABLED_DEFAULT option is strongly tied to
DAMON_STAT -- enabling it alone is meaningless.  This patch modifies the
logic to automatically enable DAMON_STAT whenever
DAMON_STAT_ENABLED_DEFAULT is selected, ensuring functional consistency.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index b3171f9406c1..5bc71354e6f3 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -105,7 +105,7 @@ config DAMON_STAT
 config DAMON_STAT_ENABLED_DEFAULT
 	bool "Enable DAMON_STAT by default"
 	depends on DAMON_PADDR
-	default DAMON_STAT
+	select DAMON_STAT
 	help
 	  Whether to enable DAMON_STAT by default.  Users can disable it in
 	  boot or runtime using its 'enabled' parameter.

base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
-- 
2.43.0


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB485263F4A
	for <damon@lists.linux.dev>; Fri, 15 Aug 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249702; cv=none; b=qmkXmfj7/R7CE/h2KTfEDw2Vkm4QEdy5fk4h4r8nQfkujrA/nL4nHFFixfubzy4esZh/Mdsgg2+svbPkmClO3VhJIan9tMa8qVLdAskWzCdsyx/mS8G1Sqd7eXwZr8C76YypGHLxld954OKdxWp8Dto01TmUk/Hg8M0LvlwDPKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249702; c=relaxed/simple;
	bh=nZajyxZdU61vS1fo8zyPWV5JPqL9CVStilHDm2FkQ0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sR7giq9QhCZtS/sHGqnjVZLptEwtkiLxK3jyvUtseGUGaGqbHA5Wqp+M8x6d0FyA7ydm0WD75tfneYzXTlBYsst7abp/jMM68tuGxw9yL7smLImYj9vVNM+yHZA9uq/luh5XWbjikFO+joEIExGx424rdAOlJ7WfsIREbKtQUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 391f8c8279b911f0b29709d653e92f7d-20250815
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-CACHE: Type:Local,Time:202508151717+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:972d1f86-3388-4f2c-9a28-ef1168239777,IP:10,
	URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:972d1f86-3388-4f2c-9a28-ef1168239777,IP:10,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACT
	ION:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:ab7f1c49c2a63aa729cbabf1c15971fc,BulkI
	D:2508151717102HAXJBFB,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 391f8c8279b911f0b29709d653e92f7d-20250815
X-User: lienze@kylinos.cn
Received: from kylin.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2106063409; Fri, 15 Aug 2025 17:21:28 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH v2] mm/damon/Kconfig: make DAMON_STAT_ENABLED_DEFAULT depend on DAMON_STAT
Date: Fri, 15 Aug 2025 17:21:10 +0800
Message-ID: <20250815092110.811757-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAMON_STAT_ENABLED_DEFAULT option is strongly tied to DAMON_STAT
option -- enabling it alone is meaningless.  This patch makes
DAMON_STAT_ENABLED_DEFAULT depend on DAMON_STAT, ensuring functional
consistency.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
v2:
  - Change the subject as suggested by SJ.
  - Keep 'default DAMON_STAT' as before.
---
 mm/damon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index b3171f9406c1..8c868f7035fc 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -104,7 +104,7 @@ config DAMON_STAT
 
 config DAMON_STAT_ENABLED_DEFAULT
 	bool "Enable DAMON_STAT by default"
-	depends on DAMON_PADDR
+	depends on DAMON_STAT
 	default DAMON_STAT
 	help
 	  Whether to enable DAMON_STAT by default.  Users can disable it in

base-commit: d7ee5bdce7892643409dea7266c34977e651b479
-- 
2.43.0


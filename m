Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3226190692
	for <damon@lists.linux.dev>; Mon, 26 May 2025 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239766; cv=none; b=SeYiC+OCvbjA+O3yL23GeGIDUnIEn+0vxe+J20HvB2xC9XPFLfLR3LmY9WCiF0XjkD/vX8INts0r6catuTTJdWX2vmbDMa4/rL8LVsdTNs5RS8Ro3cWYhq8diQPawEHmARD40Of6Kw/OzV9TrMobqAsP2lagejx8Fcy/J3RZ6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239766; c=relaxed/simple;
	bh=gxyFqovdcDRVULMnmxWDXRuhBhms6WVlQ/3wNKHTs1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEBlTjguDQ+i0GH5Orql7XIAKN7F9KCKMGc2M4zB+7L3bKnfNdRcFQ7/LSglVG9DHGPbuiCLupakgLaJn5dZ5MXiaqq2p1d7ahVQricbFjwr8qYC9XdiR+59mA25zavsTvhqFPiCvZp1bCaRch7lm/BDUylnDSA2gncKhsHWhLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f2c182e639f711f0b29709d653e92f7d-20250526
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_AS_FROM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e8b275b7-5682-424a-888f-c5336134c0d4,IP:10,
	URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:e8b275b7-5682-424a-888f-c5336134c0d4,IP:10,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACT
	ION:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:06a8f47df9af94ba6624ebd8887afa8d,BulkI
	D:250526140914GYYMOMWJ,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: f2c182e639f711f0b29709d653e92f7d-20250526
X-User: lienze@kylinos.cn
Received: from kylin.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1716637761; Mon, 26 May 2025 14:09:14 +0800
From: Enze Li <lienze@kylinos.cn>
To: lienze@kylinos.cn
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	enze.li@gmx.com,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: [PATCH v2] mm/damon: fix outdated comments for monitoring primitives
Date: Mon, 26 May 2025 14:09:01 +0800
Message-ID: <20250526060901.78226-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524125536.13267-1-lienze@kylinos.cn>
References: <20250524125536.13267-1-lienze@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word 'primitive' is not explicit.  To make the code easier to be
understood, this commit renames 'primitives' to 'code' in header
comments of some source files.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
Changes in v2:
- Fixed commit message maintainer feedback.
- Use a more neutral term instead of 'primitive'.
---
 mm/damon/modules-common.c | 2 +-
 mm/damon/modules-common.h | 2 +-
 mm/damon/ops-common.c     | 2 +-
 mm/damon/ops-common.h     | 2 +-
 mm/damon/paddr.c          | 2 +-
 mm/damon/sysfs-common.c   | 2 +-
 mm/damon/sysfs-common.h   | 2 +-
 mm/damon/vaddr.c          | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
index 7cf96574cde7..86d58f8c4f63 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Common Primitives for DAMON Modules
+ * Common Code for DAMON Modules
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index f49cdb417005..f103ad556368 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Common Primitives for DAMON Modules
+ * Common Code for DAMON Modules
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 0db1fc70c84d..b43620fee6bb 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Common Primitives for Data Access Monitoring
+ * Common Code for Data Access Monitoring
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 18d837d11bce..cc9f5da9c012 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Common Primitives for Data Access Monitoring
+ * Common Code for Data Access Monitoring
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 1b70d3f36046..c9c338170603 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * DAMON Primitives for The Physical Address Space
+ * DAMON Code for The Physical Address Space
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
index 70edf45c2174..ffaf285e241a 100644
--- a/mm/damon/sysfs-common.c
+++ b/mm/damon/sysfs-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Common Primitives for DAMON Sysfs Interface
+ * Common Code for DAMON Sysfs Interface
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 70d84bdc9f5f..2099adee11d0 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Common Primitives for DAMON Sysfs Interface
+ * Common Code for DAMON Sysfs Interface
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index e6d99106a7f9..46554e49a478 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * DAMON Primitives for Virtual Address Spaces
+ * DAMON Code for Virtual Address Spaces
  *
  * Author: SeongJae Park <sj@kernel.org>
  */

base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
-- 
2.43.0


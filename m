Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DED23BE
	for <damon@lists.linux.dev>; Sat, 24 May 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748091394; cv=none; b=VKO6DIYZFsQHdh+DCtfJ4WXM5TzoDZxZw8KR0N5kVouq85se4085RecAwLoy+jGYtv4bcywt5057vqCTaYeq8zmBkygfOhLoGMvV+iavtfy1TOgF+3IM8z+WsIt0Y2n7RXG0TwHTA3eHr7hw5uV1m4roP0ZhXgPolZ8DpNWonKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748091394; c=relaxed/simple;
	bh=SsGr/o44lq/v0bIgi+fMXIcmyONw6jTF7Debtc1ze3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OhyoeGYdQ8ptiHvr7dYqn51VoPvMBxpod/adjihcKiWCzV8/Vagmjo5jT0IHppWeBWd1EUnym1MDl6PeZiJU0TM+VRRurfQcnzqHCnBLnPa4cP8s6bJDo+5J0/zAha/3XPVY5BPcu/J4lfNRfwdO9XwDf0bfD4yK99uKoq1QOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 798f20cc389e11f0b29709d653e92f7d-20250524
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:264cc842-81cf-4135-90f8-0375840537e5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:264cc842-81cf-4135-90f8-0375840537e5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:523e8f748453401ac8fb5d946d900cd8,BulkI
	D:250523181721S0Y3Y5BZ,BulkQuantity:2,Recheck:0,SF:17|19|23|38|43|66|74|78
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 798f20cc389e11f0b29709d653e92f7d-20250524
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(61.48.215.241)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1734238905; Sat, 24 May 2025 20:56:14 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] mm/damon: rename primitives to operations
Date: Sat, 24 May 2025 20:55:36 +0800
Message-ID: <20250524125536.13267-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word 'primitive' is not explicit and has been deprecated in DAMON's
context since commit f7d911c39cbb ("mm/damon: rename damon_primitives to
damon_operations").  To make the code easier to be understand, this
commit renames remaining 'primitives' to 'operations' in header comments
of DAMON source files.

Fixes: f7d911c39cbb ("mm/damon: rename damon_primitives to damon_operations")
Signed-off-by: Enze Li <lienze@kylinos.cn>
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
index 7cf96574cde7..61b38322a3aa 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Common Primitives for DAMON Modules
+ * Common Operations for DAMON Modules
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index f49cdb417005..f1ffcc80a7bd 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Common Primitives for DAMON Modules
+ * Common Operations for DAMON Modules
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 0db1fc70c84d..1da3932b6775 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Common Primitives for Data Access Monitoring
+ * Common Operations for Data Access Monitoring
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 18d837d11bce..1820945679b1 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Common Primitives for Data Access Monitoring
+ * Common Operations for Data Access Monitoring
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 1b70d3f36046..a299fdda26e4 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * DAMON Primitives for The Physical Address Space
+ * DAMON Operations for The Physical Address Space
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
index 70edf45c2174..107c4c20231d 100644
--- a/mm/damon/sysfs-common.c
+++ b/mm/damon/sysfs-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Common Primitives for DAMON Sysfs Interface
+ * Common Operations for DAMON Sysfs Interface
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 70d84bdc9f5f..d1c1b2e857f0 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Common Primitives for DAMON Sysfs Interface
+ * Common Operations for DAMON Sysfs Interface
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index e6d99106a7f9..d034e7b5ddb8 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * DAMON Primitives for Virtual Address Spaces
+ * DAMON Operations for Virtual Address Spaces
  *
  * Author: SeongJae Park <sj@kernel.org>
  */
-- 
2.49.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795892443;
	b=aj+fIJ6l1nK+jO9Zjff8LNERDhUHtKKO9elsiWmR0b/JanHLTNuvvkNBjhTRZurydCVt
	 N2BS6+ADPhMn6aUSJRVEs2rdvw+jQ0Tbh8mvFfGWc7s7FHuJW915YHKAQn+VnLX1bAaRt
	 ld6Fd4GySaxmO4nJeCtXLXh/UVppxPW0/8X6aH5uVwoNDEClTaqd8HSYQaOc9nnn9VgfP
	 /fBBdmoucn7IjYj0hRwuftEC5Y8XQSyvz3BhAK9J68rDnRPr9atFRHBOR6MI0ZHkSjwG9
	 T0tanPV6IOSo1oWK0Ues9cDXETV+dJcvTVLgojIh3WIi2PHeaUQaqpTIsgDHCmn/pyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795892443;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9U9C62lmOkyzoqlQRfq1910+hM/DPzph/zq/GHK+ls0=;
	b=d9bXmx9Whs/Nu/v2QmSVzudeokVFgc5YrrJFTEM6G5Wgj9ZFzGMZHy8eY1s8++FOkvp8
	 MF7yNDKn2hLmbh3JrnHh7OMhPPVXY2N9LTYjDEXTtYwBAwH59yEEQhhejIvcn/MEcROSn
	 pcyt7dTPuxwVuuaRp2hi19MaPgBkihjy0sjQV3gBJh7v294KZKW5y7LE/ybLaaEqQkgG3
	 Vp2MD7DzsDtPMI9vBn9HmWUwNa3yoG+aGrZkpYTMLrJ+a2JRI5cVInmD7KhQsaCyZvHQo
	 +XeSlvzAmIANHvhqAfYZFDBDvCDWz03zDLYFj4l3otiyf4Gk8HfaPD3Kmfno6peGp3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZypFNHP8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46637606A323
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZypFNHP8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C071F00897;
	Sat, 28 Nov 2026 19:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795892442;
	bh=9U9C62lmOkyzoqlQRfq1910+hM/DPzph/zq/GHK+ls0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZypFNHP8baaBWJLByYKfEiC2xPS9489ZxO2ss64YtRBk+rvDFGKvuE4zx9l/fMN/E
	 LtxUPZL+Wjx74NMJc9FGrTGllX43zlJJNReCFcH4JG/gLOF3P05hLgyv0eqKXraxis
	 FVi+o1N4OA78Tr5QUPVDPqRPTqexqNCt1SLuvNmR4Ij8tvHAk6qNMTTgXv8LU1WOQN
	 NE3CDRhHLR/vYxjqVXnBnnJNDAjC6fO4+jrrzxARzy+u+6pIhw9z+wycVMRavI9yd5
	 d0UGYL/EhVYGFEMEbKQtqskJwipTL3oLIhztGUUqsEjp6FqOWNEWJtnDqtjZdVuJ3i
	 eaYEkULYS/SDg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 7/7] mm/damon: update file intro comments to call DAMON just DAMON
Date: Sat, 28 Nov 2026 11:00:32 -0800
Message-ID: <20261128190033.164440-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261128190033.164440-1-sj@kernel.org>
References: <20261128190033.164440-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON source file intro comments call DAMON as Data Access Monitor.
Since the introduction of DAMOS, DAMON has been somewhat more than a
Data Access Monitor.  Update the comments to call it just DAMON.  Also
some of the comments are not appropriate.  Update those together.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c              | 2 +-
 mm/damon/ops-common.c        | 2 +-
 mm/damon/ops-common.h        | 2 +-
 mm/damon/tests/core-kunit.h  | 2 +-
 mm/damon/tests/paddr-kunit.h | 2 +-
 mm/damon/tests/sysfs-kunit.h | 2 +-
 mm/damon/tests/vaddr-kunit.h | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b791a2621bd6..fa32ebf7ad09 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Data Access Monitor
+ * DAMON Core
  */
 
 #define pr_fmt(fmt) "damon: " fmt
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 2216a0023154..38720794c9fc 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Common Code for Data Access Monitoring
+ * Common Code for DAMON Operation Set
  */
 
 #include <linux/hugetlb.h>
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index ee2705825100..aabcf09ff501 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Common Code for Data Access Monitoring
+ * Common Code for DAMON Operation Set
  */
 
 #include <linux/damon.h>
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 4446574a3565..73c3bd6a9612 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Data Access Monitor Unit Tests
+ * DAMON Core Unit Tests
  */
 
 #ifdef CONFIG_DAMON_KUNIT_TEST
diff --git a/mm/damon/tests/paddr-kunit.h b/mm/damon/tests/paddr-kunit.h
index 2b11f0e67a12..547e1b3c989f 100644
--- a/mm/damon/tests/paddr-kunit.h
+++ b/mm/damon/tests/paddr-kunit.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Data Access Monitor Unit Tests
+ * DAMON Physical Address Space Operation Set Unit Tests
  */
 
 #ifdef CONFIG_DAMON_PADDR_KUNIT_TEST
diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
index 16373ba751db..c2bba2e01301 100644
--- a/mm/damon/tests/sysfs-kunit.h
+++ b/mm/damon/tests/sysfs-kunit.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Data Access Monitor Unit Tests
+ * DAMON sysfs Interface Unit Tests
  */
 
 #ifdef CONFIG_DAMON_SYSFS_KUNIT_TEST
diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index d61b503e319a..979e459327bf 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Data Access Monitor Unit Tests
+ * DAMON Virtual Address Space Operation Set Unit Tests
  */
 
 #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
-- 
2.47.3

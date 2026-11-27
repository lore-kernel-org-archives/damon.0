Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818449;
	b=Locdl4GEo9dNyIgaz89Lb9XQ5E6B87lzB5Df5DHzSQvQHTxHQ13YqEJT6fq0qRFnk/I7
	 dXHaCO0GzYR4xZhpEkAwCKqJYc3mXhvAWeg2bgqdb9t3IjXATICce/8SzDdO9a838acGA
	 U+WNzEE2tz5gkgZLeW0lrfbvqwCzUJQtTRVGU2bWBTZ3/abY5rgJTNw/xaMbQrTbUU14m
	 cL02OsUCn+hBbr0rj9qvc2TMnN2ej4S+dYRPLqJrsHvZzyxdLs2prD0PtBWQ1i/5dDK/9
	 XxX9h6uZ2N10OLh5+d8aotCVvt8uKgFQOxSueJUJIIQV67FRju9HEzZt/4kPG9U9rEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818449;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9U9C62lmOkyzoqlQRfq1910+hM/DPzph/zq/GHK+ls0=;
	b=eafMCb6SsFG7EHIoOOwDtxPHjReS3Pij498LGOrzlYpPOkU+Die4WG/Us5iJ4++7Wc/I
	 aLqk12sIqzMWbwhox/fgeMPpMzp+k4wXQ6krEKajsoJpvzDq5KTXEdCjF/7qqmfUORJuo
	 xAumbq36XUrdkWKKcoG43q3Ns6WkbybLZhHv9vk7CzG9F9o6QhjZidnvnuwacbJsTySXD
	 YSvZV1WRPVt8sHkyP9Pr5nOovZANoqRZpdzi/B1KZ8Ojy+lf3rkXQEVPkoCJlgXu3BmlE
	 SvGDYkPARC48DHoljOs+HPeXRY/cM+43zwKSvNUNTiMJ6XYKk18GqyiJ+M4sVHIn5Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7pQveaP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA2606A31E
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7pQveaP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4600C1F0089C;
	Fri, 27 Nov 2026 22:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795818449;
	bh=9U9C62lmOkyzoqlQRfq1910+hM/DPzph/zq/GHK+ls0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q7pQveaPaBSfL9S6J+8BQmtrAmR86ZMcuZRcKjFcpv+QfeRUECO/QBJAQAFiu+Xz6
	 mLoNevfWWOOGHOt+pdreZxdi9bxO8U4BjBYnppQySDVp+MEFpZzzw+FJWERFb+VD8w
	 QRocZFnv3pWs3nwavMpzKvMDZK+spex291P6FDTKUr1VSXtz6KUZcnOtxBcWcTVpOS
	 PVGJM4BLTwWsgE7p822OGF0zqugfSc6M7G2pynZIUHucdgp7KWADcH9plMLk5ow7JE
	 A+pfzaO0f0Cruy4abZ72JySf+BVKwxVLbE/jOtMJs7x6PbhRDBno7Ve/n22Ntjwtcg
	 xneTEDjx1MhpA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 7/7] mm/damon: update file intro comments to call DAMON just DAMON
Date: Fri, 27 Nov 2026 14:27:18 -0800
Message-ID: <20261127222719.105510-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127222719.105510-1-sj@kernel.org>
References: <20261127222719.105510-1-sj@kernel.org>
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

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7ED2DB7BE;
	Wed, 15 Apr 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216057; cv=none; b=Q+w9ZsK92UIXFl8j036QArgCz8wEGgvM5A+rCWtjD0FDBnsMBXR2OohPP1BN2jVW+Fddv2LBg/i9CCTBAXqxPsEzywiGLnmAhoRWwrRAVLAeWr0FCi33jNQqPycGueI8HoknAqc0wfmYgrcKJWy6ZwiQbFthDpGDgpWef/38KkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216057; c=relaxed/simple;
	bh=d7zJukuGsoRpeCy4tkwyJwYBmFc6TkPv6uDC4T8m6EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzUoDtDTYZ7U2jSSs6tVoBqF1E8th85WvSps2zdz5eFi8Kpy2NVJvTcBAJhjFZrySl6UfpQLU+jaKgtA1CrzSF3D8uF/CAG4jZZXmGViKqh/w7UaE9As2nzqqnT4uW+igCi0ChiNWXZBmXHO/aAIEoeDCKy5ak5R198TO1DWhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zuqu7Ybr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zuqu7Ybr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79892C19425;
	Wed, 15 Apr 2026 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776216057;
	bh=d7zJukuGsoRpeCy4tkwyJwYBmFc6TkPv6uDC4T8m6EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zuqu7YbrOifqoHzSY082nxiqYcDO/tBge91J9GrdcWoRwoXkGeQ+IdioKg/uFdhVC
	 Xw5IkdfhzRbLL0QuUQSeCTDI1STf4I3rQTG4DVoGdQP6Q2/HDQca7pXzAG075Lt0Fc
	 hTIva8vcI3ZgBAbV7aZ6xuPpLRSYcFx/LpNUsKE7+iR8X4FpHVAYWlOFQJNbmXwGNP
	 8efYV/WT7rBKYs7BNNlmLw2iFodhCBc9nIKpA2pnhjuXxVYsOCikiRmKCAvUr3EEUW
	 y2jbBC31jEJqRWuVOrGWNLPbASVU2+GGqnDJEPGHCIeX9YMJsA1hmoJxcptzLUaMB2
	 1te8pUaaWPvog==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/7] mm/damon/lru_sort: cover all system rams
Date: Tue, 14 Apr 2026 18:20:31 -0700
Message-ID: <20260415012048.76508-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415012048.76508-1-sj@kernel.org>
References: <20260415012048.76508-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT allows users to set the physical address range to monitor
and do the work on.  When users don't explicitly set the range, the
biggest system ram resource of the system is selected as the monitoring
target address range.  The intention was to reduce the overhead from
monitoring non-System RAM areas because monitoring non-System RAM may be
meaningless.  However, because of the sampling based access check and
adaptive regions adjustment, the overhead should be negligible.  It
makes more sense to just cover all system rams of the system.  Do so.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 641af42cc2d1a..48ddfa6369c93 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -139,7 +139,8 @@ DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_lru_sort_mon_attrs);
  * Start of the target memory region in physical address.
  *
  * The start physical address of memory region that DAMON_LRU_SORT will do work
- * against.  By default, biggest System RAM is used as the region.
+ * against.  By default, the system's entire phyiscal memory is used as the
+ * region.
  */
 static unsigned long monitor_region_start __read_mostly;
 module_param(monitor_region_start, ulong, 0600);
@@ -148,7 +149,8 @@ module_param(monitor_region_start, ulong, 0600);
  * End of the target memory region in physical address.
  *
  * The end physical address of memory region that DAMON_LRU_SORT will do work
- * against.  By default, biggest System RAM is used as the region.
+ * against.  By default, the system's entire phyiscal memory is used as the
+ * region.
  */
 static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
@@ -335,7 +337,7 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		goto out;
 
-	err = damon_set_region_biggest_system_ram_default(param_target,
+	err = damon_set_region_system_rams_default(param_target,
 					&monitor_region_start,
 					&monitor_region_end,
 					param_ctx->addr_unit,
-- 
2.47.3

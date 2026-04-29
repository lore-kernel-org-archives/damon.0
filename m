Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9046378D7B;
	Wed, 29 Apr 2026 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777435957; cv=none; b=kzk5qJsDyiSZ8UIW3Uo+Dbxt8dH95fUHE35D4ri7Yd66EVGNJrIAK/DaI8otK5eczij+TIXBhzp8Bh/D+US0s5NDO+emsulbXIPoHOeFniBFL5yOetD8diRV20CnHqjS+OexP/M0m3uDeRMIaOKcCXQXnP8Ji2WTcbX1Yp1qKGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777435957; c=relaxed/simple;
	bh=t9Rr9ycMseYm87fA5FNyb+eYDvT/K9z7TWRb2DuqipQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJWmRiBl7KLCri8W0iDmv9hg3kS34DF0nqAnnx68xiFQA2gXmHk75krLWb307vKI+P6gJaeezE0r0JBq+pIIpt3xVXmSFVXzEOy1FPh/VB1ms6JES67PCM07T820I0OR49iQ7w/d7/8VZ9VC6EvfUGpsdYd6DelvpZNR2r+P2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6fEh0o4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6fEh0o4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905CDC2BCB4;
	Wed, 29 Apr 2026 04:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777435957;
	bh=t9Rr9ycMseYm87fA5FNyb+eYDvT/K9z7TWRb2DuqipQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6fEh0o41yEc+4ITmIpOW2AlL/IMvgwSy9Mp/yEficOXCLiG/2jPhfzFDwUd3cxh/
	 /PLdDOriqj6CMab+2VyDo4U3ynVmdvHYAcOFD9LnLVPM5EA4qm95Z506x8aiaO9h4L
	 bnSUEzEgf9T4foy0Wo4LE/gAUmiOhsCG4hLoW1EvAl2Oc8zq/hS8npjcdz+xb+C4lE
	 vfa5+9IVo3t3+W0bgzbgXq2MsMbDyZ1WQzyK3QeieEEoCuqzog2um6xRbHZNbIEUlC
	 /1td3NePQkTJWXZSULinnNb+YXdd3R+ldYuJodf+cBmeWOsqumMAXX1oeo1y8VTZFA
	 u/jcHgDqxDfYA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/7] mm/damon/reclaim: cover all system rams
Date: Tue, 28 Apr 2026 21:12:24 -0700
Message-ID: <20260429041232.90257-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429041232.90257-1-sj@kernel.org>
References: <20260429041232.90257-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM allows users to set the physical address range to monitor
and do the work on.  When users don't explicitly set the range, the
biggest System RAM resource of the system is selected as the monitoring
target address range.  The intention was to reduce the overhead from
monitoring non-System RAM areas because monitoring of non-System RAM may
be meaningless.  However, because of the sampling based access check and
adaptive regions adjustment, the overhead should be negligible.  It
makes more sense to just cover all system rams of the system.  Do so.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index b330ff1695907..a60ee800d63e9 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -113,7 +113,8 @@ DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_reclaim_mon_attrs);
  * Start of the target memory region in physical address.
  *
  * The start physical address of memory region that DAMON_RECLAIM will do work
- * against.  By default, biggest System RAM is used as the region.
+ * against.  By default, the system's entire physical memory is used as the
+ * region.
  */
 static unsigned long monitor_region_start __read_mostly;
 module_param(monitor_region_start, ulong, 0600);
@@ -122,7 +123,8 @@ module_param(monitor_region_start, ulong, 0600);
  * End of the target memory region in physical address.
  *
  * The end physical address of memory region that DAMON_RECLAIM will do work
- * against.  By default, biggest System RAM is used as the region.
+ * against.  By default, the system's entire physical memory is used as the
+ * region.
  */
 static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
@@ -232,11 +234,9 @@ static int damon_reclaim_apply_parameters(void)
 		damos_add_filter(scheme, filter);
 	}
 
-	err = damon_set_region_biggest_system_ram_default(param_target,
-					&monitor_region_start,
-					&monitor_region_end,
-					param_ctx->addr_unit,
-					param_ctx->min_region_sz);
+	err = damon_set_region_system_rams_default(param_target,
+			&monitor_region_start, &monitor_region_end,
+			param_ctx->addr_unit, param_ctx->min_region_sz);
 	if (err)
 		goto out;
 	err = damon_commit_ctx(ctx, param_ctx);
-- 
2.47.3

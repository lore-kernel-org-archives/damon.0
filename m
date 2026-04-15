Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9042D73B6;
	Wed, 15 Apr 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216057; cv=none; b=QX3SEDoocux4kx8zZJvkxcXjQsGr4O2WjP9Mskem6JYdokXo1J6xCqJ7Bep7bf1gewGOliKkQJEwjeHmnGMySgDvMffWvxVbgEs3XdV6X17l1rCELNQvXoL7gMDPVYWmNwpOLN7HvgadZpCZqckhcZ/Y/tn7kRL3V4Ko2upSjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216057; c=relaxed/simple;
	bh=jusaHabcDbQG2msd5Ko6TcArzh+c8u/ACR+D/XNuFA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=draiy4EOYLCLov7snPa/mqfO+gi1a8FjlJ82g9n9+6GlvWXmQQTN8pRKtv6xOof8rGdeOxEiLGyiQhijTJRiScp7iPbKloXPjf2wKnsj9QTGUZgO5m6xyd0cPLngfDBinpBYwyFi5pp/sDUHE6IIAchKztonL0ve6CoP1czqrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4YEOuW3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4YEOuW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AA8C2BCB6;
	Wed, 15 Apr 2026 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776216057;
	bh=jusaHabcDbQG2msd5Ko6TcArzh+c8u/ACR+D/XNuFA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4YEOuW3v6TayFitmmPN1KXvhRyqJNLlBeiZr6uJv0SIZTjQXNY9G+5hS/pPRT/Pf
	 032qZ9MuhlNV8BEM+oO3RGijzwIVVvhxeWRWHe/uTBFAP2ENXqBNfhSOD+s/8pjVcx
	 ibUlN43hxTJ0pME0M2I8qZ1RCIdfDa0YJ8m1+MgjhUkStI1nNE0PFEkqE06rUJ/Iuf
	 Omndah1zQpByfZBAIsRcajFnuZyzxCtQPjYlcgPA1PZIwia2vV9gptv4NRTtgnzKLN
	 m9a/8Kz3KAEM9gVVQXBJwc2laVm/hbB24KVlHdM+t/lksqNaLcYLXQETCgF9aSZdcy
	 DVtudT8vLYUbA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/7] mm/damon/reclaim: cover all system rams
Date: Tue, 14 Apr 2026 18:20:30 -0700
Message-ID: <20260415012048.76508-3-sj@kernel.org>
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
index 89998d28628c4..ecfc6b58d07d2 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -127,7 +127,8 @@ DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_reclaim_mon_attrs);
  * Start of the target memory region in physical address.
  *
  * The start physical address of memory region that DAMON_RECLAIM will do work
- * against.  By default, biggest System RAM is used as the region.
+ * against.  By default, the system's entire physical memory is used as the
+ * region.
  */
 static unsigned long monitor_region_start __read_mostly;
 module_param(monitor_region_start, ulong, 0600);
@@ -136,7 +137,8 @@ module_param(monitor_region_start, ulong, 0600);
  * End of the target memory region in physical address.
  *
  * The end physical address of memory region that DAMON_RECLAIM will do work
- * against.  By default, biggest System RAM is used as the region.
+ * against.  By default, the system's entire physical memory is used as the
+ * region.
  */
 static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
@@ -264,11 +266,9 @@ static int damon_reclaim_apply_parameters(void)
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

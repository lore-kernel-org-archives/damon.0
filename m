Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82B382F27;
	Wed, 29 Apr 2026 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777435958; cv=none; b=f12OAZCo8L9X5bRM44BpJeCoNuZH1CX7whn9eA3yH2yv6NSIzVDs9jSt+/S/Eb5JvJ7GKVcXkoenQZlarXiIBLHULlI8iLJuZ/vUZ0lI6T/zLZse2duJ5h5KSszn68ifklLR2QUyc2ivHV6dm68JVPWtC/WFHxJRiKpo+o2VY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777435958; c=relaxed/simple;
	bh=xMqq3xpXSyg1zeBbUMUMZmxc1oat68q5ZzAMINfxXRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpQ8dmJqBLLjTJMaBsPZw6M1TROP3IFMn1+D/soMZHLAa2iPGkzWkTDtoLCNBt3xQsnnQEgzvKh6v1UqV4rXFCS8Zap89yd0yDDNnZ2Xq/ceIqUROPZkQajRQvISIq6GFK2+gyiQvi08j8SQOngp0SazhggnwJWGG+F52iJiHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrFQKhs8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrFQKhs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37B8C2BCC6;
	Wed, 29 Apr 2026 04:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777435958;
	bh=xMqq3xpXSyg1zeBbUMUMZmxc1oat68q5ZzAMINfxXRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrFQKhs8TpgSxmgq6oc2QBSOSpUfh6QnY0mq3KvhaNsnUkeb+vFvkzhrYL4Q5zmlP
	 fMaHEh8kNJH+Ry43zgBsmVjjbr36lZ37MsoI/PGqHtZS5Z/kkbQ++AU8x8uyJwB/ly
	 JT3araYWCHuo2N2R3qd96lw4CyPn4QTvUfFyFGEn/CSznJL01umPYDjvRKO4d3kpdu
	 GuzVlGyfCQHOhZRtR0SOiTZMiQ8qBwEJHQwUv8ZY8c4/oixWDZRfhS25C1Ed2pkrGW
	 abvpKBtVRPSpnYbxg62tHXUNRbWnHE4zxnOgDsAZQfa6nSmsBz50OqGPtTLs12FtDI
	 BcVijjgXikl/A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/7] mm/damon/lru_sort: cover all system rams
Date: Tue, 28 Apr 2026 21:12:25 -0700
Message-ID: <20260429041232.90257-4-sj@kernel.org>
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
index 7569e471160a0..2eb559d913b62 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -139,7 +139,8 @@ DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_lru_sort_mon_attrs);
  * Start of the target memory region in physical address.
  *
  * The start physical address of memory region that DAMON_LRU_SORT will do work
- * against.  By default, biggest System RAM is used as the region.
+ * against.  By default, the system's entire physical memory is used as the
+ * region.
  */
 static unsigned long monitor_region_start __read_mostly;
 module_param(monitor_region_start, ulong, 0600);
@@ -148,7 +149,8 @@ module_param(monitor_region_start, ulong, 0600);
  * End of the target memory region in physical address.
  *
  * The end physical address of memory region that DAMON_LRU_SORT will do work
- * against.  By default, biggest System RAM is used as the region.
+ * against.  By default, the system's entire physical memory is used as the
+ * region.
  */
 static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
@@ -326,7 +328,7 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		goto out;
 
-	err = damon_set_region_biggest_system_ram_default(param_target,
+	err = damon_set_region_system_rams_default(param_target,
 					&monitor_region_start,
 					&monitor_region_end,
 					param_ctx->addr_unit,
-- 
2.47.3

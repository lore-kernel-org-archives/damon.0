Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E72DFA4A;
	Sun, 21 Jun 2026 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057468; cv=none; b=YMUPjRFx9l3MpSAYxESrsqXud2KcR/w30MtMUYLkR1Y/2ZEROrhrETQ9YDDBGWMTBCgHaqaMwdQqHtMVNPd0DWaU56ZrWYFY70yo+uwi1nTd/B3CIncuQbgEGOv3cgXOEhx08Xp1ExxFvQ7fqAEaqKJxE08dNtsf505LDJc1G6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057468; c=relaxed/simple;
	bh=7ja7d4c4JvmVfIcI30Xst4gQ11HDWLV4AIqpnCw/FLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOYZWQWMXX5kGeTHNFq0EwJ3nUCs3e5+0iJLLvExNjxu3owqumQw7bFgHWJBsrdakermM4Y3VYWiO5MuUY2rNoLbzTEv8LfGDNOoCmuUJiw0dVPN3LJT9xontsmc+q9SfZ5f852oCsIDvhmZ8HnST5izloBgN7dKlTUdnqeVlMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edHHNkAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edHHNkAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C021F00A3D;
	Sun, 21 Jun 2026 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057465;
	bh=azqsIyPcBSXEM0jexqRTWeoPRmDH/XuigFj32Ye/QlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=edHHNkAlFNSvSaPLtTiXE7cecwcR4T2dh7V8JGEnT9YrHTRXcVklh362/8j99fclX
	 ddEyALknb/I7emPxDA3QomMcJIZuzI85Eg2uCGCYHNsXy7JmL/guNFnz+IUOBnzrgo
	 CKGm7MtgbxtgUc8/QAIfao9HtfsOATQXkIZEzKZeCqTjf6FxAkixRFXisWm1do5ya1
	 F1kgmG2pGuyx7SJnB5dW4IYzlOERZYly61Ag0xjUWzIvg6RUr3VOu24okIr1F5Z/9c
	 6dKV/j6MQNet8YNlniDbPWy3xRnSpW5N7nieA/7B7DGDApyLnTmGDFzu3nRp69KaF6
	 +4yxILtuEzInw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 17/17] mm/damon: remove damon_region->nr_accesses_bp
Date: Sun, 21 Jun 2026 08:57:13 -0700
Message-ID: <20260621155715.87932-18-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621155715.87932-1-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No code touches damon_region->nr_accesses_bp field.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 10 ----------
 mm/damon/core.c       |  3 +--
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a09ee8a09b5af..fc3d467dc2e34 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -47,8 +47,6 @@ struct damon_size_range {
  * @ar:			The address range of the region.
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
- * @nr_accesses_bp:	@nr_accesses in basis point (0.01%) that updated for
- *			each sampling interval.
  * @probe_hits:		Number of probe-positive region samples.
  * @list:		List head for siblings.
  * @age:		Age of this region.
@@ -61,13 +59,6 @@ struct damon_size_range {
  * not be done with direct access but with the helper function,
  * damon_update_region_access_rate().
  *
- * @nr_accesses_bp is another representation of @nr_accesses in basis point
- * (1 in 10,000) that updated for every &damon_attrs->sample_interval in a
- * manner similar to moving sum.  By the algorithm, this value becomes
- * @nr_accesses * 10000 for every &struct damon_attrs->aggr_interval.  This can
- * be used when the aggregation interval is too huge and therefore cannot wait
- * for it before getting the access monitoring results.
- *
  * @age is initially zero, increased for each aggregation interval, and reset
  * to zero again if the access frequency is significantly changed.  If two
  * regions are merged into a new region, both @nr_accesses and @age of the new
@@ -77,7 +68,6 @@ struct damon_region {
 	struct damon_addr_range ar;
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
-	unsigned int nr_accesses_bp;
 	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6542ebf13d4d8..8d3b720f774f6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3584,8 +3584,7 @@ static int kdamond_fn(void *data)
 				 * aggregation, and make aggregation
 				 * information reset for all regions.  Then,
 				 * following kdamond_reset_aggregated() call
-				 * will make the region information invalid,
-				 * particularly for ->nr_accesses_bp.
+				 * will make the region information invalid.
 				 *
 				 * Reset ->next_aggregation_sis to avoid that.
 				 * It will anyway correctly updated after this
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E4E5381A;
	Sun, 12 May 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715542624; cv=none; b=Wr+e4uC2qI5Vc6DLHm0F+aVDNyy0KV7M0xeHJljU1xQ7gpDJE5CelVG7LmpMOQIqetOU3ijYgpYiqbAA6G/M+Y2QxRYrMvlVFnxR9LCnBnN1FVZkQVKxB45Ip2fCl2WBMYSVpyiiYbkaXzyswFU16fajeEhWClWnZ25fX2g1a0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715542624; c=relaxed/simple;
	bh=CqpUnQlsaA0hxF2A02w+ec82+zmgruebmlsoPX119nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=in6AqSIiCCfX7fYcyR7VoPd4fMwDzKCXY0WYoZTL/JpVpcdGnlwLY0XGS+k7BiOc+96uD5PVFxGQcX4l+xNw88UZhUvDsKRgWrmQB4GYJ/xz6f6B3JnnYosR589ADoFiPJ/KfXYXZgqBqvqsozlShPiPW9O2LOgGZgAoyZkGq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOw5DjkQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOw5DjkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748F6C32781;
	Sun, 12 May 2024 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715542622;
	bh=CqpUnQlsaA0hxF2A02w+ec82+zmgruebmlsoPX119nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOw5DjkQimingooso9+sMyhUkYjNrrGwHTOQzKKRi9slOdfRzmBV4kv15dQtm9n+L
	 ntn0NyHd/3Odq6AAio3VWqBxu+XxFZM+zH8EDolJr5ljMQlge3osuqPtAaF0XA7m+V
	 kNQV8xGZQtIa1BzslABKrJ/U6jmURBT4kDcbAxhcWpTU0WX9SFeoe6E+8VObLOqr3L
	 cOENEqMwjc1kHFXboPh1TdciQO2gNDieBnTXvMH8uBZAA8fQq6Ie4RpWuuYWWTkQnZ
	 SGvWbLMe2qfIvfoTqfNaKvQrZQgsShfh42TmHSqpdsfptCIwQoXlx+9plOBnkZjnkP
	 9/QIdYHVe3Mpg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC IDEA v2 1/6] mm/damon: implement DAMOS actions for access-aware contiguous memory allocation
Date: Sun, 12 May 2024 12:36:52 -0700
Message-Id: <20240512193657.79298-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512193657.79298-1-sj@kernel.org>
References: <20240512193657.79298-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement two DAMOS actions, namely DAMOS_ALLOC and DAMOS_FREE.  As the
name says, the actions allocate/de-allocate given DAMOS target memory in
user-defined base granularity.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    | 37 ++++++++++++++++
 mm/damon/paddr.c         | 93 ++++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs-schemes.c |  4 ++
 3 files changed, 134 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c3f93374e8d..933bc7777f2d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -107,6 +107,11 @@ struct damon_target {
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
  * @DAMOS_MIGRATE_HOT:  Migrate the regions prioritizing warmer regions.
  * @DAMOS_MIGRATE_COLD:	Migrate the regions prioritizing colder regions.
+#ifdef CONFIG_ACMA
+ * @DAMOS_ALLOC:	Allocate pages in the region,
+ *			&struct damos->alloc_order pages at once.
+ * @DAMOS_FREE:		Return DAMOS_ALLOC-ed pages back to the system.
+#endif
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  *
@@ -126,6 +131,10 @@ enum damos_action {
 	DAMOS_LRU_DEPRIO,
 	DAMOS_MIGRATE_HOT,
 	DAMOS_MIGRATE_COLD,
+#ifdef CONFIG_ACMA
+	DAMOS_ALLOC,
+	DAMOS_FREE,
+#endif
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
 };
@@ -375,6 +384,11 @@ struct damos_access_pattern {
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @pattern:		Access pattern of target regions.
  * @action:		&damo_action to be applied to the target regions.
+#ifdef CONFIG_ACMA
+ * @alloc_order:	DAMOS_ALLOC/FREE applying granularity.
+ * @alloc_callback:	DAMOS_ALLOC success callback.
+ * @free_callback:	DAMOS_FREE callback.
+#endif
  * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
@@ -388,6 +402,18 @@ struct damos_access_pattern {
  * CPU time or IO resources for the &action, &quota is used.
  *
  * If @apply_interval_us is zero, &damon_attrs->aggr_interval is used instead.
+#ifdef CONFIG_ACMA
+ *
+ * If @action is CONFIG_ALLOC or CONFIG_FREE, the action is applied to
+ * @alloc_order pages of the region at once.  For example, if the region has
+ * 1024 pages, and @alloc_order is 9, DAMOS tries to allocate or free first 512
+ * (2^9) contiguous pages at once, and then next 512 pages.
+ *
+ * For each success of such allocation attemp, @alloc_callback is called back.
+ * For each attempt of deallocation, @free_callback is called back first,
+ * before trying the deallocation.  If @free_callback returns non-zero, the
+ * deallocation attempt is aborted.
+#endif
  *
  * To do the work only when needed, schemes can be activated for specific
  * system situations using &wmarks.  If all schemes that registered to the
@@ -409,6 +435,11 @@ struct damos_access_pattern {
 struct damos {
 	struct damos_access_pattern pattern;
 	enum damos_action action;
+#ifdef CONFIG_ACMA
+	unsigned int alloc_order;
+	int (*alloc_callback)(unsigned long start_addr);
+	int (*free_callback)(unsigned long start_addr);
+#endif
 	unsigned long apply_interval_us;
 /* private: internal use only */
 	/*
@@ -784,6 +815,12 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end);
 
+#ifdef CONFIG_ACMA
+
+unsigned long damon_alloced_bytes(void);
+
+#endif
+
 #endif	/* CONFIG_DAMON */
 
 #endif	/* _DAMON_H */
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 81163206e70c..f66bd032c523 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -475,6 +475,93 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
 }
 
 
+#ifdef CONFIG_ACMA
+
+static bool damon_pa_preempted(unsigned long pfn)
+{
+	/* todo: implement */
+}
+
+/* always success for preempted=false */
+static int damon_pa_set_preempted(unsigned long pfn, bool preempted)
+{
+	/* todo: implement */
+}
+
+/*
+ * Return ownership of the memory to the system.  At the moment, only user of
+ * this function is virtio-balloon.  They could use page fault-based mechanisms
+ * to catch returned ownership.  Therefore this function doesn't notify this
+ * event to the report subscribers.  In future, we could add some notification
+ * system of this event for more users such as contig memory allocator.
+ */
+static int damon_pa_free(unsigned long pfn, struct damos *scheme)
+{
+	if (!damon_pa_preemted(pfn))
+		return -EINVAL;
+
+	free_contig_range(pfn, DAMON_MEM_PREEMPT_PAGES);
+	damon_pa_set_preempted(pfn, false);
+	/*
+	 * We intentionally do not report this event to the preempted memory
+	 * report subscriber.  They could use page fault handler like
+	 * mechanisms.
+	 */
+	return 0;
+}
+
+/*
+ * Pass ownership of the memory to page reporting subscribers.  The subscribers
+ * can use the reported memory for their purpose, e.g., letting Host
+ * re-allocate it to other guest, or use as contig allocation memory pool.
+ */
+static int damon_pa_alloc(unsigned long pfn, struct damos *scheme)
+{
+	int err;
+
+	if (damon_pa_preempted(pfn))
+		return -EINVAL;
+	if (alloc_contig_range(pfn, pfn + DAMON_MEM_PREEMPT_PAGES,
+				MIGRATE_MOVABLE, GFP_KERNEL))
+		return -ENOMEM;
+	err = damon_pa_set_preempted(pfn, true);
+	if (err) {
+		free_contig_range(pfn, DAMON_MEM_PREEMPT_PAGES);
+		return err;
+	}
+	if (!scheme->alloc_callback)
+		return 0;
+	err = scheme->alloc_callback(PFN_PHYS(pfn));
+	if (err) {
+		damon_pa_free(pfn);
+		return err;
+	}
+	return 0;
+}
+
+/* Preempt or yield memory regions from system */
+static unsigned long damon_pa_alloc_or_free(
+		struct damon_region *r, struct damos *s, bool alloc)
+{
+	unsigned long pfn;
+	unsigned long applied = 0;
+
+	for (pfn = PHYS_PFN(r->start); pfn < PHYS_PFN(r->end);
+			pfn += DAMON_MEM_PREEMPT_PAGES) {
+		if (alloc) {
+			if (damon_pa_alloc(pfn, s))
+				continue;
+		} else {
+			if (damon_pa_free(pfn, s))
+				continue;
+		}
+		applied += 1;
+	}
+	return applied * PAGE_SIZE * DAMON_MEM_PREEMPT_PAGES;
+}
+
+#endif
+
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme)
@@ -489,6 +576,12 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_MIGRATE_HOT:
 	case DAMOS_MIGRATE_COLD:
 		return damon_pa_migrate(r, scheme);
+#ifdef CONFIG_ACMA
+	case DAMOS_ALLOC:
+		return damon_pa_alloc_or_free(r, scheme, true);
+	case DAMOS_FREE:
+		return damon_pa_alloc_or_free(r, scheme, false);
+#endif
 	case DAMOS_STAT:
 		break;
 	default:
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 66fccfa776d7..54be4d661881 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1460,6 +1460,10 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"lru_deprio",
 	"migrate_hot",
 	"migrate_cold",
+#ifdef CONFIG_ACMA
+	"damos_alloc",
+	"damos_free",
+#endif
 	"stat",
 };
 
-- 
2.39.2


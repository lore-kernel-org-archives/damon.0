Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C40478849;
	Tue, 14 Jul 2026 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039758; cv=none; b=R5SLccQmaN/mpmFtAiV+US4cDz4yxEbiGOSLCSBl0aTAtCLgdJnsT8k86E7uRcGqZQ95lFFl0DHo9PQ7kCEmtXI/KiQpRdkFPmhhS+c54RcWC4IRHkLfqyOpZ/1XX/Pmj2ZxcEXcxc9rxGqjSDSceOZO4dRvTFbPCUN8rG7uUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039758; c=relaxed/simple;
	bh=4Wd0tKH5UL4Av18kcbzr9djImdMNZscBF/G9rg4s9JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6wTuEczMfYnmIuLcNhKCHe8AXTZhxFddg9TRj2X7ydrxKq/y2iahnvKbTZxGfH9juZGWUxJXE1VRx7hs5rH0DvkBBikotURJxb4tdnVOOIAy+bjgExPwFcMxKtqBy9ILu4ADt1Jt3cq45aWG0iweCI+AkrSpmQbGuoqiTkdBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNnaRYCq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNnaRYCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B231F00AC4;
	Tue, 14 Jul 2026 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039757;
	bh=49szHoBkn5sDldjM9+XsvM62mHHlAwosCDD8pFLfc3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mNnaRYCqgE7U6lYS6bSyjxtSvuEsadv2VVJrnzE/7TgdSJqK9gyBH4xG4QwU9BtPl
	 LKCkZV63bfPOyus0+zAJUK9r9sw2nXU51BNTc78xYRBcRw5ji7ZEFa8ffR+BYdIyFy
	 D7RzIfzTazgbFqoXZJ7XyGPNMLNxqohTged/0I02O2VJF20MoiQeMN23cMDi+ysb92
	 BZoKUMId8sOAqF/vpzXp2T6fgtrnY+OVRpIj1qVSn4mYFb6ShghfOgPTbXgsVhvn/T
	 qzbanAbEvoELUGPXyTEz+p8PwO2gOrxO6LfAHUuDc270TYEwi4T8Z7Le91/K5bYgDo
	 kB55s/e5ErRFQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/10] mm/damon/core: hide private damos fields
Date: Tue, 14 Jul 2026 07:35:39 -0700
Message-ID: <20260714143544.101305-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714143544.101305-1-sj@kernel.org>
References: <20260714143544.101305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'core_filters', 'ops_filters', 'last_applied' and 'list' fields of damos
are intended to be used by only the DAMON core layer.  However, those
are mistakenly not marked as private.  Mark as private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 52 ++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 15517be3e4960..907d65f03d083 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -522,12 +522,8 @@ struct damos_migrate_dests {
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
  * @migrate_dests:	Destination nodes if @action is "migrate_{hot,cold}".
  * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
- * @core_filters:	Additional set of &struct damos_filter for &action.
- * @ops_filters:	ops layer handling &struct damos_filter objects list.
- * @last_applied:	Last @action applied ops-managing entity.
  * @stat:		Statistics of this scheme.
  * @max_nr_snapshots:	Upper limit of nr_snapshots stat.
- * @list:		List head for siblings.
  *
  * For each @apply_interval_us, DAMON finds regions which fit in the
  * &pattern and applies &action to those. To avoid consuming too much
@@ -549,16 +545,7 @@ struct damos_migrate_dests {
  *
  * Before applying the &action to a memory region, &struct damon_operations
  * implementation could check pages of the region and skip &action to respect
- * &core_filters
- *
- * The minimum entity that @action can be applied depends on the underlying
- * &struct damon_operations.  Since it may not be aligned with the core layer
- * abstract, namely &struct damon_region, &struct damon_operations could apply
- * @action to same entity multiple times.  Large folios that underlying on
- * multiple &struct damon region objects could be such examples.  The &struct
- * damon_operations can use @last_applied to avoid that.  DAMOS core logic
- * unsets @last_applied when each regions walking for applying the scheme is
- * finished.
+ * &struct damos_filter.
  *
  * After applying the &action to each region, &stat is updated.
  *
@@ -569,6 +556,16 @@ struct damos {
 	struct damos_access_pattern pattern;
 	enum damos_action action;
 	unsigned long apply_interval_us;
+	struct damos_quota quota;
+	struct damos_watermarks wmarks;
+	union {
+		struct {
+			int target_nid;
+			struct damos_migrate_dests migrate_dests;
+		};
+	};
+	struct damos_stat stat;
+	unsigned long max_nr_snapshots;
 /* private: internal use only */
 	/*
 	 * number of sample intervals that should be passed before applying
@@ -585,20 +582,25 @@ struct damos {
 	/* whether to reject core/ops filters umatched regions */
 	bool core_filters_default_reject;
 	bool ops_filters_default_reject;
-/* public: */
-	struct damos_quota quota;
-	struct damos_watermarks wmarks;
-	union {
-		struct {
-			int target_nid;
-			struct damos_migrate_dests migrate_dests;
-		};
-	};
+	/* Additional set of &struct damos_filter for &action. */
 	struct list_head core_filters;
+	/* ops layer handling &struct damos_filter objects list. */
 	struct list_head ops_filters;
+	/*
+	 * Last @action applied ops-managing entity.
+	 *
+	 * The minimum entity that @action can be applied depends on the
+	 * underlying &struct damon_operations.  Since it may not be aligned
+	 * with the core layer abstract, namely &struct damon_region, &struct
+	 * damon_operations could apply @action to same entity multiple times.
+	 * Large folios that underlying on multiple &struct damon region
+	 * objects could be such examples.  The &struct damon_operations can
+	 * use @last_applied to avoid that.  DAMOS core logic unsets
+	 * @last_applied when each regions walking for applying the scheme is
+	 * finished.
+	 */
 	void *last_applied;
-	struct damos_stat stat;
-	unsigned long max_nr_snapshots;
+	/* List head for siblings. */
 	struct list_head list;
 };
 
-- 
2.47.3

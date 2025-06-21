Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC1267B07;
	Sat, 21 Jun 2025 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750527098; cv=none; b=jkwuVjZGNEE+G3AmDHxCyQEa8GM2Yr4dtLglrLNHl2G9myiAdRKLGcShsOaagtdeDjqEyCxzKBHdC3ITWbFxIhJftUKKyeLX5sVIfC/+R7CXor7oAapqhvNQtn0ZrinZV519stVCAW04+zavZE/75Q0qmeYrWpA7ve9XUBsQPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750527098; c=relaxed/simple;
	bh=XwUe6eyej2+X6VVhw6Bc1wVY5GDm97pjooComOJUL4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfg2CgFf1J33RVhR9C51URJF3eTZcnnnlxvKb0g/u6lnf3HmAYTV/F49M8Zz8MoVF97rc9alOhn8FuTXnNCsDgJv2cuW3TS0W9hfbpQLRPBJ4Wbx/sIQcP1VypVi4Bak/nT0UElZjnlhYlc7d7brm5Edvw9WD8lOG5TGaZ3TbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqlH/ax+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqlH/ax+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D20EC4CEF3;
	Sat, 21 Jun 2025 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750527096;
	bh=XwUe6eyej2+X6VVhw6Bc1wVY5GDm97pjooComOJUL4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kqlH/ax+l7Hdk7k4TXe6XwMHpEvU9xY2JmbGFidhk6efSzgCgu+HESiUXyFHodoEd
	 uw9H1+y2J5vm/qIuE8jUXm/RXr1BqG1pQ8lccaBqU/exfZOGlm7OB0IenzCcUMKjhK
	 CDuNStCShNel4RS4XJpgbCvM9me6VQoXyDKCLBNESAT7YPR6YKZ0MTowNxvyRMlKUi
	 9yl3l/kCD6z9kw0Oqyo3QnzhSNxthi7Pz7eXiPZJZt9+JVi823rqANZpLArRd6/aWX
	 f/IhcfJAFJiRPuAazufHnKp0XdBL5Dbp8X3geyQm6wRZhhVHebZPCsUyVKB1TXlbL6
	 2aKYH1TuUb3EA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] mm/damon/core: add damos->migrate_dest field
Date: Sat, 21 Jun 2025 10:31:29 -0700
Message-Id: <20250621173131.23917-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250621173131.23917-1-sj@kernel.org>
References: <20250621173131.23917-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new field to 'struct damos', namely migrate_dest, to allow DAMON
API callers specify multiple migration destination nodes and their
weights.  Also update 'struct damos' creation and destruction functions
accordingly to initialize the new field and free up the API
caller-allocated buffers on those, respectively.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 13 ++++++++++---
 mm/damon/core.c       |  4 ++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d60addd0b7c8..6370cf44486f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -470,6 +470,7 @@ struct damos_migrate_dest {
  * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
+ * @migrate_dest:	Destination nodes if @action is "migrate_{hot,cold}".
  * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
  * @filters:		Additional set of &struct damos_filter for &action.
  * @ops_filters:	ops layer handling &struct damos_filter objects list.
@@ -488,9 +489,12 @@ struct damos_migrate_dest {
  * monitoring context are inactive, DAMON stops monitoring either, and just
  * repeatedly checks the watermarks.
  *
+ * @migrate_dest specifies multiple migration target nodes with different
+ * weights for migrate_hot or migrate_cold actions.  @target_nid is ignored if
+ * this is set.
+ *
  * @target_nid is used to set the migration target node for migrate_hot or
- * migrate_cold actions, which means it's only meaningful when @action is either
- * "migrate_hot" or "migrate_cold".
+ * migrate_cold actions, and @migrate_dest is unset.
  *
  * Before applying the &action to a memory region, &struct damon_operations
  * implementation could check pages of the region and skip &action to respect
@@ -533,7 +537,10 @@ struct damos {
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
 	union {
-		int target_nid;
+		struct {
+			int target_nid;
+			struct damos_migrate_dest migrate_dest;
+		};
 	};
 	struct list_head filters;
 	struct list_head ops_filters;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b217e0120e09..ea2a17b2dee7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -407,6 +407,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
 
+	scheme->migrate_dest = (struct damos_migrate_dest){};
 	scheme->target_nid = target_nid;
 
 	return scheme;
@@ -449,6 +450,9 @@ void damon_destroy_scheme(struct damos *s)
 
 	damos_for_each_filter_safe(f, next, s)
 		damos_destroy_filter(f);
+
+	kfree(s->migrate_dest.node_id_arr);
+	kfree(s->migrate_dest.weight_arr);
 	damon_del_scheme(s);
 	damon_free_scheme(s);
 }
-- 
2.39.5

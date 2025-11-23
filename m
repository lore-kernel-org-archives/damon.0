Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293C2DE6E3;
	Sun, 23 Nov 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923426; cv=none; b=rkC/NzJ9+7WNSuLzubMOvWA0BPBeV7k8g/lR4aMg6oO3BbWcOGvVvLolgEwDAu6ia7t57R6MKrousbGtGDHVTaJu/kMTeFpmosMViA3NflQiVPSF4JCPZX8AfMZC6Xc/7v6XyyKSfjD/UveoC+a7KxMWKp+jW+i70RIh6X01BPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923426; c=relaxed/simple;
	bh=+PG482StoL/pY9Nmw7mtPv/d1GxHurtk722prWLmX44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doCiDwsZwBDZbN36f09n2JEwJHoKctrzk/ulGy4Ab2jamFS3YVKzjnmpXJng5wTfjTCHCm4kW3Q9CbG9ZnAzHwF9HsIWk2PUOyhMT07LFixC0+TQCHZSyKy/H+R0xxQ6EzKj0vNwJwRmdv5GYliauYqkkUHe/StLNG3Hq5sz6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFbyDXWf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFbyDXWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5155AC16AAE;
	Sun, 23 Nov 2025 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763923426;
	bh=+PG482StoL/pY9Nmw7mtPv/d1GxHurtk722prWLmX44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFbyDXWfQDCIBVZS6Wz1iiSWM8Bt7727WKNonqal+RCrAnXjIk6b9S+LnsPdqmXCc
	 pQa8L1UxoNUY+2fgFLTPXswxycWOqPmQbJl+Atyd1HWi/ycJaB659b96vzV9R/bTeO
	 kjBUJaXSDpE5F94qZWPxiVka8LJZUeBK1/y4rtVmKRsNw2NIxdgdU2hoZ3xqQypkJ6
	 LRDqKh75fYq2dZhIaIsK10Fhaos9L6Sz98Q1OS25PUU3D1qAAGR0nIAH8mRCwwEVXF
	 5EZmetyeh2Ix3Es4+cHqaEHCGWjaC44VHmxsstDIJtgBRpdlVxalq+WjTHgCTpYs2w
	 T+1sF7hgMa42Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/12] mm/damon/core: implement max_nr_snapshots
Date: Sun, 23 Nov 2025 10:43:21 -0800
Message-ID: <20251123184329.85287-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123184329.85287-1-sj@kernel.org>
References: <20251123184329.85287-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are DAMOS use cases that require user-space centric control of its
activation and deactivation.  Having the control plane on the
user-space, or using DAMOS as a way for monitoring results collection
are such examples.

DAMON parameters online commit, DAMOS quotas and watermarks can be
useful for this purpose.  However, those features work only at the
sub-DAMON-snapshot level.  In some use cases, the DAMON-snapshot level
control is required.  For example, in DAMOS-based monitoring results
collection use case, the user online-installs a DAMOS scheme with
DAMOS_STAT action, wait it be applied to whole regions of a single
DAMON-snapshot, retrieves the stats and tried regions information, and
online-uninstall the scheme.  It is efficient to ensure the lifetime of
the scheme as no more no less one snapshot consumption.

To support such use cases, introduce a new DAMOS core API per-scheme
parameter, namely max_nr_snapshots.  As the name implies, it is the
upper limit of nr_snapshots, which is a DAMOS stat that represents the
number of DAMON-snapshots that the scheme has fully applied.  If the
limit is set with a non-zero value and nr_snapshots reaches or exceeds
the limit, the scheme is deactivated.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  5 +++++
 mm/damon/core.c       | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 43dfbfe2292f..a67292a2f09d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -499,6 +499,7 @@ struct damos_migrate_dests {
  * @ops_filters:	ops layer handling &struct damos_filter objects list.
  * @last_applied:	Last @action applied ops-managing entity.
  * @stat:		Statistics of this scheme.
+ * @max_nr_snapshots:	Upper limit of nr_snapshots stat.
  * @list:		List head for siblings.
  *
  * For each @apply_interval_us, DAMON finds regions which fit in the
@@ -533,6 +534,9 @@ struct damos_migrate_dests {
  * finished.
  *
  * After applying the &action to each region, &stat is updated.
+ *
+ * If &max_nr_snapshots is set as non-zero and &stat.nr_snapshots be same to or
+ * greater than it, the scheme is deactivated.
  */
 struct damos {
 	struct damos_access_pattern pattern;
@@ -567,6 +571,7 @@ struct damos {
 	struct list_head ops_filters;
 	void *last_applied;
 	struct damos_stat stat;
+	unsigned long max_nr_snapshots;
 	struct list_head list;
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index af922d5e500c..36313cd1ff1c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -401,6 +401,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	INIT_LIST_HEAD(&scheme->core_filters);
 	INIT_LIST_HEAD(&scheme->ops_filters);
 	scheme->stat = (struct damos_stat){};
+	scheme->max_nr_snapshots = 0;
 	INIT_LIST_HEAD(&scheme->list);
 
 	scheme->quota = *(damos_quota_init(quota));
@@ -1078,7 +1079,11 @@ static int damos_commit(struct damos *dst, struct damos *src)
 		return err;
 
 	err = damos_commit_filters(dst, src);
-	return err;
+	if (err)
+		return err;
+
+	dst->max_nr_snapshots = src->max_nr_snapshots;
+	return 0;
 }
 
 static int damon_commit_schemes(struct damon_ctx *dst, struct damon_ctx *src)
@@ -1955,6 +1960,10 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (damos_skip_charged_region(t, &r, s, c->min_sz_region))
 			continue;
 
+		if (s->max_nr_snapshots &&
+				s->max_nr_snapshots <= s->stat.nr_snapshots)
+			continue;
+
 		if (damos_valid_target(c, t, r, s))
 			damos_apply_scheme(c, t, r, s);
 
-- 
2.47.3

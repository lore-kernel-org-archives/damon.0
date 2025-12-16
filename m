Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1213451C6;
	Tue, 16 Dec 2025 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872116; cv=none; b=PpLE1EoQekpAM1qJNbmBPmiWMpnO6r/untDdcjoLyRA9Tx4dSjfeBxJvZeT05kOLUAO3183+VY+6QfspYySXxtDquGgEofbCLK3BbAq5796a/1gkR6O+HHcuu9OGEK10oVUHcdSItIzN+kiOKwM6z6vx6BdwktXr/D4pofeWqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872116; c=relaxed/simple;
	bh=MUTEKMjwMQrPcHqNBgdPYYcf5dYcs6y7OQyOyiiLOLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeSUetwXtKdJgBAa928BXd5IaAZ03HtemE+nTpu75KqUncfrc5aEG37LBzLuXfjIfD7SX5K5GfG44bSif0vh6hr8ZxAdlCDX3b9ES28LmusVG2t/x9uyjf+nSjHllVsfVFXX66PR+2YeP4ig5y5JDdrZctFdOZBzVLnW84lJTTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfRsIXAj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfRsIXAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079CBC4CEF1;
	Tue, 16 Dec 2025 08:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872115;
	bh=MUTEKMjwMQrPcHqNBgdPYYcf5dYcs6y7OQyOyiiLOLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfRsIXAjQLY8IWW5+ZPMlEDxMgvzZhQYGXNtIlKrS0zjcik3mY0694lsIOPczk77+
	 rETP1V1kQdquYP+X7d2xVBiutGayjtXH5iaeYOL4LxLVOSHLLZEe4aQwyuHu0Vph5G
	 +R9zp/vC9U5pxzjGZ/OwHEoNFKwNcf/WXqVT/OHCOp3iIwUzn3/9cq3WOHqCJgDbtz
	 cSlrXe7BnthQsy1nE1l1H672yCkBggMoFbV1g94E741igyUoCmuSTiEgF39vLoenrA
	 VH1EqG36TRdbB5f1ZMm+0aKllIPbS8EN/TlSGwo4UaVdpHoYCJQTVZ9Jx5O3ClMKYx
	 S8s2G3UaNiaHQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/12] mm/damon/core: implement max_nr_snapshots
Date: Tue, 16 Dec 2025 00:01:20 -0800
Message-ID: <20251216080128.42991-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216080128.42991-1-sj@kernel.org>
References: <20251216080128.42991-1-sj@kernel.org>
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
index 6f3328b29a65..8908aec6670f 100644
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

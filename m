Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900E2D7804;
	Sun, 23 Nov 2025 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923424; cv=none; b=ShxeTs1AAD1T751GFpvMtajAUnRXkYWe72ClRlq2Gfzng9MrbjOOA1zVn3acU4VwDQsd5AAZ8fgpWmCm5o6NjPyZ26jEy8p/XXV7jBDRr2VJ18SUqG9A6a73gUr8H4FuGzhJ0cGzD3zEQ9g+e/8LeKwlvMru7Ag0l+d7QLILOuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923424; c=relaxed/simple;
	bh=flHCn1jzwJYbHp6Nyj2GAUs2tIfp0Jhpc5MXnsDhPc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHR2aGJVknlfyZlZtbQaDM7918meyEtItecg2h2wS1cTWNOACK1MI450Msk1DmPHEvWv/29kZes94/xV7i3xBG0qhxpRP+IfZNAom9YB7nGV4RijKlBZcAE2SY1pS/SqqZa8gTGeVd/xUwtHvpIe7iB7lCDmFjXgZ70REPgkGmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWcxawcm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWcxawcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98571C19422;
	Sun, 23 Nov 2025 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763923424;
	bh=flHCn1jzwJYbHp6Nyj2GAUs2tIfp0Jhpc5MXnsDhPc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWcxawcm3Wldt4q2Fk+N/iVtuR2wUJd4gie6Gwzx0wakwV72c2gYTNBoOY9FUhvXQ
	 8Mu3ZswD/pPPtgFMiCsEH9649+sKKLO7GguUAVZVLV8828LgjhI91u5ySL9IgQyySv
	 llMTWbih/na/Q/hlRpkYmE+dDbe4GVxyb+XSuqEcLWadebqsTtsheGIYeCGoeDXUrD
	 5hOpw9cBW7yESLVi2uxKTcCrE6zcpSYNDxkAsAU1JEvZyR1jVhy2NNLJd6dsD0Mqwt
	 dTEzcxzfhflNWP0FX1+XDXN6OW86t9yIVdoO6naM+m5ZzIQOImWSxpVKopwt/ifhv9
	 fPynkYljdoN3g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/12] mm/damon/sysfs-schemes: introduce nr_snapshots damos stat file
Date: Sun, 23 Nov 2025 10:43:16 -0800
Message-ID: <20251123184329.85287-3-sj@kernel.org>
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

Introduce a new DAMON sysfs interface file for exposing the newly added
DAMOS stat, nr_snapshots.  The file has the name same to the stat name
(nr_snapshots) and placed under the damos stat sysfs directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 30d20f5b3192..4d25469f957f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -204,6 +204,7 @@ struct damon_sysfs_stats {
 	unsigned long sz_applied;
 	unsigned long sz_ops_filter_passed;
 	unsigned long qt_exceeds;
+	unsigned long nr_snapshots;
 };
 
 static struct damon_sysfs_stats *damon_sysfs_stats_alloc(void)
@@ -265,6 +266,15 @@ static ssize_t qt_exceeds_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%lu\n", stats->qt_exceeds);
 }
 
+static ssize_t nr_snapshots_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->nr_snapshots);
+}
+
 static void damon_sysfs_stats_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_stats, kobj));
@@ -288,6 +298,9 @@ static struct kobj_attribute damon_sysfs_stats_sz_ops_filter_passed_attr =
 static struct kobj_attribute damon_sysfs_stats_qt_exceeds_attr =
 		__ATTR_RO_MODE(qt_exceeds, 0400);
 
+static struct kobj_attribute damon_sysfs_stats_nr_snapshots_attr =
+		__ATTR_RO_MODE(nr_snapshots, 0400);
+
 static struct attribute *damon_sysfs_stats_attrs[] = {
 	&damon_sysfs_stats_nr_tried_attr.attr,
 	&damon_sysfs_stats_sz_tried_attr.attr,
@@ -295,6 +308,7 @@ static struct attribute *damon_sysfs_stats_attrs[] = {
 	&damon_sysfs_stats_sz_applied_attr.attr,
 	&damon_sysfs_stats_sz_ops_filter_passed_attr.attr,
 	&damon_sysfs_stats_qt_exceeds_attr.attr,
+	&damon_sysfs_stats_nr_snapshots_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_stats);
@@ -2761,6 +2775,7 @@ void damon_sysfs_schemes_update_stats(
 		sysfs_stats->sz_ops_filter_passed =
 			scheme->stat.sz_ops_filter_passed;
 		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
+		sysfs_stats->nr_snapshots = scheme->stat.nr_snapshots;
 	}
 }
 
-- 
2.47.3

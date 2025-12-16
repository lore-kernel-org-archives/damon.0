Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E64342CB8;
	Tue, 16 Dec 2025 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872106; cv=none; b=VS5NoCp9exMnCijR8kxLz5gbbBSArpNQxH9QOxBHAewVzVQBKaMeU74nZfaPa9qGHr52Jt8MRZOAfSx4OI5I3ZXcdm4NaLyd10QBhFbi0uTJHkCwfIfv1M5ojKPvNvGMgjyg/rutCDTOJ6VVK/3Wv3ndfjKfjqyTHrJdxuNllnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872106; c=relaxed/simple;
	bh=EheTKTWNwlESlsGw3Z3YuTZbvfPyPa97pgV7/l/okj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmA6kYuYTHfrQnAO74tdsbOthSFxuhBqnOnR+/7YtfSVG6OqQr5u82vUc0Cc8b3E5+qEEY2ck/RmB2itIH1rzM8/YxwUa7yOR/ucxgBzvBfoUmrApP6jR9P2swz/3ALyg9r9pz3JmYHUMsp2u4ylKg6KmY6HlhhQNRNvTPPx9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtTftagF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtTftagF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93556C4CEF1;
	Tue, 16 Dec 2025 08:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872105;
	bh=EheTKTWNwlESlsGw3Z3YuTZbvfPyPa97pgV7/l/okj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtTftagFA6aDpibycmhBVk+mdFNBF0N5kixw4SIegT3Uk5eNoeKz8vtoXLTeZ+k5Y
	 klim1SnBtXXcyu0Twva67/CC+W9QK62Wgr4GNAzIdXXYEyMs/PZJfgy8IWrQZFAJ46
	 0eMnkH/nNRMGP9ES+CbFoWPT3emcFnpQbYxhrAv2ZtJQEV94SoLrON3OZvBbfx0aW9
	 3RUrK3v3UmPVb2/CBmWsjbb0QCE5MMaSES9M1SuUYJ9j0iBTkgKewWprEEYRdZun69
	 jdDoAIXYASZoWgGp7N90a0A6Jzq4sC2NNV5Amy2gF4jCEA/o2ewXfbWob1ebCJczjM
	 svBhe6cSBUouA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/12] mm/damon/sysfs-schemes: introduce nr_snapshots damos stat file
Date: Tue, 16 Dec 2025 00:01:15 -0800
Message-ID: <20251216080128.42991-3-sj@kernel.org>
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

Introduce a new DAMON sysfs interface file for exposing the newly added
DAMOS stat, nr_snapshots.  The file has the name same to the stat name
(nr_snapshots) and placed under the damos stat sysfs directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index a71059e65d34..a1f555e1125a 100644
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
@@ -2760,6 +2774,7 @@ void damon_sysfs_schemes_update_stats(
 		sysfs_stats->sz_ops_filter_passed =
 			scheme->stat.sz_ops_filter_passed;
 		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
+		sysfs_stats->nr_snapshots = scheme->stat.nr_snapshots;
 	}
 }
 
-- 
2.47.3

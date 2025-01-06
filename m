Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175911E1A17;
	Mon,  6 Jan 2025 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192057; cv=none; b=pN1SxQxLg5uVLScTvkQiwGY6wmv/n+o6TNqdiwS3YSzq7OU5FVMf8HYJW+DqZ+ZIe80532uPu9FtiDX0ZpZFywNsdQTe+X47SuggCk+CYS8/LemuBhNjrpJk/5bwXAtsh3tUQ6MSa8LzT5ZeQUpCKp0zmtKwDrLIyiZ+r5XiwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192057; c=relaxed/simple;
	bh=ftF2xdlxRC1hxynZygPWzsGSDwQOUYQsL2NA51xCWlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbmFI1npT2IiI5ByakyeHXPDWA2Ywdl7UpJMgjM92aLvcHM7/H1kv9mKOoK4aPXzJLafYniU//TFsLGxz7eBD+JyKp8LN8k6NTJl/sYaf+pt+TYRGm/v67jrZ2GNkThtdrSiq69soizUe0dN/dCdOgct8P4LCsCJLPmxc4C36Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaxbcO1N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaxbcO1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E02DC4CED2;
	Mon,  6 Jan 2025 19:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192056;
	bh=ftF2xdlxRC1hxynZygPWzsGSDwQOUYQsL2NA51xCWlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaxbcO1N74CCY8kGmY2WADbvphzHKKpytGuMvPR+8lLiwQOlrunTi2X5WMv8mkVzG
	 MLg4dKAmhV42dJUeoYrmpyEEFHWwH4mF2COFSKwS+2FCZTgnDRIgqNipLyjJSyILbP
	 CP6qSW5byI7JNIOoaTR3LSLiNLPhjLq2ky0gOcp7FimS5C4ttM/18Piv75DbSK44U9
	 4UqSZPGvVZV5I5rTJE4KWmziN/MC3hgZV1MwI6NTDDdJo4C/BBCNCD0ZKGFQaTV2VL
	 y64Bw8WUbCxqcI2O94lTR0AUQ/Kf6C5bLiyD+T1mWvpdcpgZmnQocTuL7F5MQzw6gp
	 oVSWWuDz05Xwg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/16] mm/damon/syfs-schemes: implement per-scheme filter-passed bytes stat
Date: Mon,  6 Jan 2025 11:33:53 -0800
Message-Id: <20250106193401.109161-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new DAMON sysfs interface file under scheme stat directory, namely
'sz_ops_filter_passed'.  It represents total bytes that passed
region-internal DAMOS filters of the scheme that handled by the DAMON
operations set layer.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5c4490b97258..b447c412b02c 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -188,6 +188,7 @@ struct damon_sysfs_stats {
 	unsigned long sz_tried;
 	unsigned long nr_applied;
 	unsigned long sz_applied;
+	unsigned long sz_ops_filter_passed;
 	unsigned long qt_exceeds;
 };
 
@@ -232,6 +233,15 @@ static ssize_t sz_applied_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%lu\n", stats->sz_applied);
 }
 
+static ssize_t sz_ops_filter_passed_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->sz_ops_filter_passed);
+}
+
 static ssize_t qt_exceeds_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -258,6 +268,9 @@ static struct kobj_attribute damon_sysfs_stats_nr_applied_attr =
 static struct kobj_attribute damon_sysfs_stats_sz_applied_attr =
 		__ATTR_RO_MODE(sz_applied, 0400);
 
+static struct kobj_attribute damon_sysfs_stats_sz_ops_filter_passed_attr =
+		__ATTR_RO_MODE(sz_ops_filter_passed, 0400);
+
 static struct kobj_attribute damon_sysfs_stats_qt_exceeds_attr =
 		__ATTR_RO_MODE(qt_exceeds, 0400);
 
@@ -266,6 +279,7 @@ static struct attribute *damon_sysfs_stats_attrs[] = {
 	&damon_sysfs_stats_sz_tried_attr.attr,
 	&damon_sysfs_stats_nr_applied_attr.attr,
 	&damon_sysfs_stats_sz_applied_attr.attr,
+	&damon_sysfs_stats_sz_ops_filter_passed_attr.attr,
 	&damon_sysfs_stats_qt_exceeds_attr.attr,
 	NULL,
 };
@@ -2077,6 +2091,8 @@ void damon_sysfs_schemes_update_stats(
 		sysfs_stats->sz_tried = scheme->stat.sz_tried;
 		sysfs_stats->nr_applied = scheme->stat.nr_applied;
 		sysfs_stats->sz_applied = scheme->stat.sz_applied;
+		sysfs_stats->sz_ops_filter_passed =
+			scheme->stat.sz_ops_filter_passed;
 		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
 	}
 }
-- 
2.39.5

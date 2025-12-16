Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CCC344045;
	Tue, 16 Dec 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872117; cv=none; b=nfe/aVJY2qx0hrtFdx7BQQJChoOp53zRjiQB6Jp1OfCa4kfdAsrKlnhHpKWGUPNFgu3yhCNsfyhJBes7wBa48BQD766MUIwdv7LP3F3HMNERP0+5GBpEn5/ZUFgMfeTsBZKixaLsPJiq1Hfu0tSzo+32+m6YsL5g7I+Cu7zF4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872117; c=relaxed/simple;
	bh=YYITYdIQPy/1vLOJqdtXYhiVVrg/s7bBHX4J5y9ZA3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbc25oaU24ulBUA8Gu0jJXVQT0ye6aQTpbfrP1MLhbuATMh1Q9EXckrJAxdvLcRX47DbtJlOIZA+fiWOQSvwqtNr5rm6/gwh8w58GLNY1Mvjny/QeX4u12keNrX2BKdzVIxFfM06zBeOxRsCXtLTSg6xXXXYJB6bHuoIpGML5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRkUz/Iu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRkUz/Iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5C8C16AAE;
	Tue, 16 Dec 2025 08:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872116;
	bh=YYITYdIQPy/1vLOJqdtXYhiVVrg/s7bBHX4J5y9ZA3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mRkUz/Iu/Pl0hqM6pdMSVBXMftjfKuqsByDORaWV2AND1xZ6h/4+982YgmU6QcQuH
	 g8jWIwjrT5Qkj4wjpk2dbujwRmExzpzk8QN8m4za8sWTXuPO2LawEe+71nJN9ihOAT
	 g8jWDOsAPshhen7ToCNMs7VnJ2HR+ZQ4GPiuYnuYYwnF8P2NCaKDQ7pg+LYmVmFWsc
	 Ch0p24kb89fzx8wpSlmPSt2NJ5wmQv/FUWpi4l2wlIVhS3w4rspfTcN8eLD5l9EQpR
	 Q8m79U5A3IM2M4ghD6qg7pg1Zf7Lv+KPTKrahpM2Oa9hvmacmPTWHslwU0QCSzD0H7
	 IkRNx9I1T0sag==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/12] mm/damon/sysfs-schemes: implement max_nr_snapshots file
Date: Tue, 16 Dec 2025 00:01:21 -0800
Message-ID: <20251216080128.42991-9-sj@kernel.org>
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

Add a new DAMON sysfs file for setting and getting the newly introduced
per-DAMON-snapshot level DAMOS deactivation control parameter,
max_nr_snapshots.  The file has a name same to the parameter and placed
under the damos stat directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index a1f555e1125a..e198234f0763 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -205,6 +205,7 @@ struct damon_sysfs_stats {
 	unsigned long sz_ops_filter_passed;
 	unsigned long qt_exceeds;
 	unsigned long nr_snapshots;
+	unsigned long max_nr_snapshots;
 };
 
 static struct damon_sysfs_stats *damon_sysfs_stats_alloc(void)
@@ -275,6 +276,28 @@ static ssize_t nr_snapshots_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%lu\n", stats->nr_snapshots);
 }
 
+static ssize_t max_nr_snapshots_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->max_nr_snapshots);
+}
+
+static ssize_t max_nr_snapshots_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+	unsigned long max_nr_snapshots, err = kstrtoul(buf, 0, &max_nr_snapshots);
+
+	if (err)
+		return err;
+	stats->max_nr_snapshots = max_nr_snapshots;
+	return count;
+}
+
 static void damon_sysfs_stats_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_stats, kobj));
@@ -301,6 +324,9 @@ static struct kobj_attribute damon_sysfs_stats_qt_exceeds_attr =
 static struct kobj_attribute damon_sysfs_stats_nr_snapshots_attr =
 		__ATTR_RO_MODE(nr_snapshots, 0400);
 
+static struct kobj_attribute damon_sysfs_stats_max_nr_snapshots_attr =
+		__ATTR_RW_MODE(max_nr_snapshots, 0600);
+
 static struct attribute *damon_sysfs_stats_attrs[] = {
 	&damon_sysfs_stats_nr_tried_attr.attr,
 	&damon_sysfs_stats_sz_tried_attr.attr,
@@ -309,6 +335,7 @@ static struct attribute *damon_sysfs_stats_attrs[] = {
 	&damon_sysfs_stats_sz_ops_filter_passed_attr.attr,
 	&damon_sysfs_stats_qt_exceeds_attr.attr,
 	&damon_sysfs_stats_nr_snapshots_attr.attr,
+	&damon_sysfs_stats_max_nr_snapshots_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_stats);
@@ -2730,6 +2757,7 @@ static struct damos *damon_sysfs_mk_scheme(
 		damon_destroy_scheme(scheme);
 		return NULL;
 	}
+	scheme->max_nr_snapshots = sysfs_scheme->stats->max_nr_snapshots;
 	return scheme;
 }
 
-- 
2.47.3

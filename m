Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FEC3CF1E6;
	Tue, 15 Sep 2026 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438183; cv=none; b=X0zsONOzbVNtfDLNV1cMiBfzUq4sI2Nej8Eu1JWDw44bZzhmgrktdfx/iivEnepx8TQbsUGD5ZMYbtAckTebZt+qf5SSMQ0AIQH+JU4y5dbC8ka49sCi0xQ4b5XTx1dKksqArCZ0RBwB2JAR3WLsUQlZy8MEhSJ8aaihE4NjMmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438183; c=relaxed/simple;
	bh=KW791MgCtRerwlblO2XlLUV0YVIRvjv/GWAiew+3j6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcNAwx0qbKBRJ4v90vsuF/HxX7yYr20ER9G9Tit5v92cc5xc17fgTkJ+sDoPKmobvjcvpieNkHgPItv6NX7RGFr2GVwpMh5vWl5yyAwyOohXB+Id+sE6HexutIQoTW0mdBvbUpJfGW/12/SHP1fZb/CXZY6Od/CVniEI1+NVGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok4/X9zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok4/X9zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6359A1F00899;
	Tue, 15 Sep 2026 02:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438179;
	bh=g5VdpOGRYXrXyCrSePa8puxBW/6Uq97itYKIwT0a6WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ok4/X9zrJPY6LPSYJUCoK93OZvdhLSXsy7mPxMMB4K2c7cRQ0IuvUNKw/Vbr6cuTQ
	 GGkNEW6AL1+4ZbpBIOk/d2/QMqrB2ocmnC8K9PuRvCM7J91yUiYFecvTrlyaIyJG3x
	 7dgrn0c3gGAQIfmVLQft+ZhvNKKNTl9Mi3AB2hoqRtEwqVAgiQYjPuoGPhBI9d7xf9
	 pnL+xZ4kY0Jbh2ni5f4T36uxHYBbwTwEUlnO7M0VwhXFMAJG/qOBBTjgMv0WKydYAJ
	 N5NzwGytky/w1QT08ya/feMA5Jg9Tq/4fP4b1inLHruKu9JNcTxrfPUF1ekLZUBlOh
	 HzkiAbBo8k2Ag==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 4/8] mm/damon/sysfs: add min,max files under probe filter directory
Date: Mon, 14 Sep 2026 19:09:23 -0700
Message-ID: <20260915020929.102953-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915020929.102953-1-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In future, DAMON sysfs interface will support data attribute probe
filter types that have range arguments like the newly added
hugepage_size type filter.  To prepare such supports, add two new DAMON
sysfs files, min and max, under the probe filter directory.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 51fa506c879b0..8e8d89b8ed981 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -975,6 +975,8 @@ struct damon_sysfs_filter {
 	bool matching;
 	bool allow;
 	char *path;
+	unsigned long range_min;
+	unsigned long range_max;
 };
 
 static struct damon_sysfs_filter *damon_sysfs_filter_alloc(void)
@@ -1127,6 +1129,44 @@ static ssize_t path_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t min_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+
+	return sysfs_emit(buf, "%lu\n", filter->range_min);
+}
+
+static ssize_t min_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+	int err = kstrtoul(buf, 0, &filter->range_min);
+
+	return err ? err : count;
+}
+
+static ssize_t max_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+
+	return sysfs_emit(buf, "%lu\n", filter->range_max);
+}
+
+static ssize_t max_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+	int err = kstrtoul(buf, 0, &filter->range_max);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_filter_release(struct kobject *kobj)
 {
 	struct damon_sysfs_filter *filter = container_of(kobj,
@@ -1148,11 +1188,19 @@ static struct kobj_attribute damon_sysfs_filter_allow_attr =
 static struct kobj_attribute damon_sysfs_filter_path_attr =
 		__ATTR_RW_MODE(path, 0600);
 
+static struct kobj_attribute damon_sysfs_filter_min_attr =
+		__ATTR_RW_MODE(min, 0600);
+
+static struct kobj_attribute damon_sysfs_filter_max_attr =
+		__ATTR_RW_MODE(max, 0600);
+
 static struct attribute *damon_sysfs_filter_attrs[] = {
 	&damon_sysfs_filter_type_attr.attr,
 	&damon_sysfs_filter_matching_attr.attr,
 	&damon_sysfs_filter_allow_attr.attr,
 	&damon_sysfs_filter_path_attr.attr,
+	&damon_sysfs_filter_min_attr.attr,
+	&damon_sysfs_filter_max_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_filter);
-- 
2.47.3

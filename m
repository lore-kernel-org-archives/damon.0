Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F137DAD5;
	Sun, 13 Sep 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319504; cv=none; b=A1dxxwNocreNNzXz2JErkf6OXBW75A830o5vCd0741SiQsaVCzxdC9NeSj7wG4N3Ylt+8pmlWhPSb7bu6lmlDXq0BayBOkuy2gVYJ74p4Z5gtPGH0gh/fBV7zqSdg7pCm7yPaBAIVUYdKPfroIHKAW61HHPvuu1e7tAGLpYiS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319504; c=relaxed/simple;
	bh=KW791MgCtRerwlblO2XlLUV0YVIRvjv/GWAiew+3j6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rB6SDlyKcQ1wd1Rav12X+Re6HTYDN+WDanxCGQQM69VeLFMIpCEydH/oFJU07hyzIVEdAtzTMqw1HDJIKYSdkVUlsC91SCxzw0as5yqcGqhJVVCB1dFTcAqjcC4wJVOdg0/QKbvBP3wzpeVMhe2kY13WJTXE/fkbv41kl7ZYgrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKMbsFDj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKMbsFDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395611F00899;
	Sun, 13 Sep 2026 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319503;
	bh=g5VdpOGRYXrXyCrSePa8puxBW/6Uq97itYKIwT0a6WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKMbsFDjsk0u/gctNgobRRhsNbFFlyhomMGdfqv5r6WhRQfy16vAkNgCzshYrdGic
	 YwMbXcfhEwCEUOt2A6dyc1oSTb7Jew697SjPC9FFAVAIT7q6Bv0cDmV1nFQT+hu5TZ
	 Ih0jq27BTVP25eEUy0I58dEiLrpB0iKpM0lnN9YZj2uoOI8CQ3TeLwA68erQ36KQzv
	 KYxAbt38lh8r7In1fxT9VTMZ05hgjJE0affBtB9FHR9g4I0Q1+KgU79UbKOPwsd59g
	 gyzWeGmkBBgMBcr4MH8WQunGxgryZsGqlW1sVaNoUl6c+STZBlGjrrx14Tqs3OJ7WU
	 7lpC0PxLUpocg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/8] mm/damon/sysfs: add min,max files under probe filter directory
Date: Sun, 13 Sep 2026 10:11:26 -0700
Message-ID: <20260913171133.102366-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171133.102366-1-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
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

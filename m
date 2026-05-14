Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E7F410D3E;
	Thu, 14 May 2026 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767768; cv=none; b=jCSb+ltUbuLA5x+JcYalwJpDdY9S+907oqk6AxTNhFByXz1Jz4MjIw+tzD9UYBEAqCIr/yZj3c7H5l/p5rku0pn85LRYhhuj3qGSiMnXN6tq7it/QxZEHmKE3KI9rBdNd8ArdIcx1dsB0zSaIRPet0fDjdXlgt5QfinLHURSN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767768; c=relaxed/simple;
	bh=GgqkpGLzfY3SpgNfpQk0ztstdYxBESX4HneypEejd9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fj0k1PpDP/xD33qBKQ3715aBjW/Ll21ixeMo0myAvm2ds7JHixAo+OQrMt32rIFVV+F1T61oJNhAPKBHg6a8ah8+1Wq/QeYgGuzZmy3Fp764o0iwfaqlvnTJkDxzIaHeZ4p/0+m9vokAWgAv5rN4mzfyw3LyunCipzQ8XcjM688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD5MmN9N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD5MmN9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0743EC2BCF7;
	Thu, 14 May 2026 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767767;
	bh=GgqkpGLzfY3SpgNfpQk0ztstdYxBESX4HneypEejd9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JD5MmN9NqvxSm1HWcET41QGb1GURGyLzoR0skUvSbJmPiEzw54mcxRdxsitUPlgHQ
	 W/n5JDH0gyA6wEhyYHJAzBW+Sc9Bt727+7r6q/PtJmQh2fI1i0Gj2rqWdF/zDqpbtD
	 yJVKNjGSTu2QIIs/PGaqurRg5Uo5ZzKnTj7N9y2U8Y5jhTdjijKDujsNzGx4iBVFlg
	 lxFBaiWdn9+hNzm9iVE9/WCCfgWRPCa+qkbxur/8HWJng6O48I0Oi2xgIZF0db9cwk
	 qQlJqtAWzKZxTBPC+LJ0L9RKCw7EUdRX7NXX7fQ7tIaEYg4VYFh/uDClsUg4tXrjzY
	 0qylZbQ3Jqkcw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 24/28] mm/damon/sysfs: add filters/<F>/path file
Date: Thu, 14 May 2026 07:08:57 -0700
Message-ID: <20260514140904.119781-25-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new DAMON sysfs file for letting users setup the target
memory cgroup of the belonging memory cgroup attribute monitoring.  The
file is named 'filter', located under the probe filter directory.  Users
can set the target memory cgroup by writing the path to the memory
cgroup from the cgroup mount point to the file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e4dbf85feadc2..2b68e1a7de451 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -756,6 +756,7 @@ struct damon_sysfs_filter {
 	enum damon_filter_type type;
 	bool matching;
 	bool allow;
+	char *path;
 };
 
 static struct damon_sysfs_filter *damon_sysfs_filter_alloc(void)
@@ -774,6 +775,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_ANON,
 		.name = "anon",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_MEMCG,
+		.name = "memcg",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -862,11 +867,46 @@ static ssize_t allow_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t path_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+	int len;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	len = sysfs_emit(buf, "%s\n", filter->path ? filter->path : "");
+	mutex_unlock(&damon_sysfs_lock);
+	return len;
+}
+
+static ssize_t path_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+	char *path = kmalloc_objs(*path, size_add(count, 1));
+
+	if (!path)
+		return -ENOMEM;
+	strscpy(path, buf, size_add(count, 1));
+	if (!mutex_trylock(&damon_sysfs_lock)) {
+		kfree(path);
+		return -EBUSY;
+	}
+	kfree(filter->path);
+	filter->path = path;
+	mutex_unlock(&damon_sysfs_lock);
+	return count;
+}
+
 static void damon_sysfs_filter_release(struct kobject *kobj)
 {
 	struct damon_sysfs_filter *filter = container_of(kobj,
 			struct damon_sysfs_filter, kobj);
 
+	kfree(filter->path);
 	kfree(filter);
 }
 
@@ -879,10 +919,14 @@ static struct kobj_attribute damon_sysfs_filter_matching_attr =
 static struct kobj_attribute damon_sysfs_filter_allow_attr =
 		__ATTR_RW_MODE(allow, 0600);
 
+static struct kobj_attribute damon_sysfs_filter_path_attr =
+		__ATTR_RW_MODE(path, 0600);
+
 static struct attribute *damon_sysfs_filter_attrs[] = {
 	&damon_sysfs_filter_type_attr.attr,
 	&damon_sysfs_filter_matching_attr.attr,
 	&damon_sysfs_filter_allow_attr.attr,
+	&damon_sysfs_filter_path_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_filter);
-- 
2.47.3

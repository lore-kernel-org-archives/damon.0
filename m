Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA30615CAE
	for <damon@lists.linux.dev>; Mon,  5 Dec 2022 23:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F026C433D6;
	Mon,  5 Dec 2022 23:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670281719;
	bh=KP45fkenUtVNkuekA5wpVSKSKg+M620wUBu7fatA2gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUkqaVKSH3C/skAJJU1XZFSGjNvz+JOJJWRnZ5XtjszTIzwOpUh4pjUCZTrrOwXAT
	 bFSmtLVDGZER/Az8C7PjezIHAT4JlOqfi9TAGN/0mcz3WDm8cmNVc4yBn4zNi3RAZ/
	 DmhCB1GIVkVEXGMHS/kH6CRjtTSn+1CatzHn8g/uKFjDRGEKMf9YqjFTpp2PT/qbDb
	 WlXPLxuGxYUXKKs59TePia0AkcOTAyJ2ZzOQSTjszfS0uAvBYQvkBM9m3rcuYZRrBc
	 AmkFiri3/8jsmiAzeSUpNskE/fX3fHK0/Ia3Uk2ZWJvdSMTsUclzavi9uMo8iK8GqP
	 L/IIAH/E655uQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 06/11] mm/damon/sysfs-schemes: implement filter directory
Date: Mon,  5 Dec 2022 23:08:25 +0000
Message-Id: <20221205230830.144349-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205230830.144349-1-sj@kernel.org>
References: <20221205230830.144349-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement DAMOS filter directory which will be located under the filters
directory.  The directory provides three files, namely type, matching,
and memcg_path.  'type' and 'matching' will be directly connected to the
fields of 'struct damos_filter' having same name.  'memcg_path' will
receive the path of the memory cgroup of the interest and later
converted to memcg id when it's committed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 128 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 50c8148cb474..afbfc55a8e84 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -258,6 +258,134 @@ static struct kobj_type damon_sysfs_stats_ktype = {
 	.default_groups = damon_sysfs_stats_groups,
 };
 
+/*
+ * filter directory
+ */
+
+struct damon_sysfs_scheme_filter {
+	struct kobject kobj;
+	enum damos_filter_type type;
+	bool matching;
+	char *memcg_path;
+};
+
+/* Should match with enum damos_filter_type */
+static const char * const damon_sysfs_scheme_filter_type_strs[] = {
+	"anon",
+	"memcg",
+};
+
+static ssize_t type_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%s\n",
+			damon_sysfs_scheme_filter_type_strs[filter->type]);
+}
+
+static ssize_t type_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	enum damos_filter_type type;
+	ssize_t ret = -EINVAL;
+
+	for (type = 0; type < NR_DAMOS_FILTER_TYPES; type++) {
+		if (sysfs_streq(buf, damon_sysfs_scheme_filter_type_strs[
+					type])) {
+			filter->type = type;
+			ret = count;
+			break;
+		}
+	}
+	return ret;
+}
+
+static ssize_t matching_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%c\n", filter->matching ? 'Y' : 'N');
+}
+
+static ssize_t matching_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	bool matching;
+	int err = kstrtobool(buf, &matching);
+
+	if (err)
+		return err;
+
+	filter->matching = matching;
+	return count;
+}
+
+static ssize_t memcg_path_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%s\n",
+			filter->memcg_path ? filter->memcg_path : "");
+}
+
+static ssize_t memcg_path_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
+
+	if (!path)
+		return -ENOMEM;
+
+	strncpy(path, buf, count);
+	path[count] = '\0';
+	filter->memcg_path = path;
+	return count;
+}
+
+static void damon_sysfs_scheme_filter_release(struct kobject *kobj)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	kfree(filter->memcg_path);
+	kfree(filter);
+}
+
+static struct kobj_attribute damon_sysfs_scheme_filter_type_attr =
+		__ATTR_RW_MODE(type, 0600);
+
+static struct kobj_attribute damon_sysfs_scheme_filter_matching_attr =
+		__ATTR_RW_MODE(matching, 0600);
+
+static struct kobj_attribute damon_sysfs_scheme_filter_memcg_path_attr =
+		__ATTR_RW_MODE(memcg_path, 0600);
+
+static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
+	&damon_sysfs_scheme_filter_type_attr.attr,
+	&damon_sysfs_scheme_filter_matching_attr.attr,
+	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_scheme_filter);
+
+static struct kobj_type damon_sysfs_scheme_filter_ktype = {
+	.release = damon_sysfs_scheme_filter_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_scheme_filter_groups,
+};
+
 /*
  * filters directory
  */
-- 
2.25.1


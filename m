Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0787D2BF006;
	Mon,  8 Dec 2025 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175422; cv=none; b=KpzTm+InPLzdXtYDD8h/OCKFIICKIXNMsCHg/nxtppTS/Ccm+DSyRLhbhwJNTGK6g2gYojkhLWU0gO72sKCHBvyiBCxi5O6RY+nELvpumBS6OG+tzRHI9vpKGZiZHjQmI995G+e+k82Zsr8fOrm+PSvD3yXUw8H2quHIZiKR23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175422; c=relaxed/simple;
	bh=XR7TB9uLErl/OwhdiQ9KeniuUlLpDcU/pwQSdNEDmO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzTYCMXey8tELWyCC4fmZ+CmdHQnjB4VQCaUEPG2ibcLqtNOvuCY9/Y0cKxEREYe2TvgeuvFvHhWG8yTZ0e2D606jwyJ9zDKeGo9jcIuQfWTj5ldIMhWOqgczR4oDIOU/pRGN8CjYMoPbs7f7c1qbMY83l4CrSCtF4pgejMckNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmWOxnCr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmWOxnCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79218C4CEF1;
	Mon,  8 Dec 2025 06:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175420;
	bh=XR7TB9uLErl/OwhdiQ9KeniuUlLpDcU/pwQSdNEDmO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VmWOxnCrqPZaZ0CQ3C+sAg9ZamAn3Pm5iZ8i2KGLyn4XeXa68XpbbzfhW3bCM8mMJ
	 Ug4LgYGuooQouVyQ1sGTUaX4wjszQi0q9r9w4UjIKuVBcx994Al7dov0KBTeUwnLl4
	 LxIvF60thKzawCoVYOQvmoFycP9F6E74Zp2JBE7jF+v4CiFm8L0p/DKgH38Z3/2AHp
	 fu1hJFMw+ziHHa2n9/vG/Eg+fQhRUQQrTma6+YK7lPntuRFeW/kyFxldT6aAhBH1cG
	 e7Lb6m9G1PkcJgi8VGQuviQhGUvSUyMzgtN2zrPF9ZRrDVPes/GnZ5c0FjCqR26mD8
	 xgJjjcw2rE9Pw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 21/37] mm/damon/sysfs: implement type, matching, allow files under sample filter dir
Date: Sun,  7 Dec 2025 22:29:25 -0800
Message-ID: <20251208062943.68824-22-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sample filter directory is not really having the file to set up for
the properties of the representing DAMON sample filter.  Implement files
for setting the properties.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ba0c76c1300c..74594e6e461c 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -755,6 +755,9 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 
 struct damon_sysfs_sample_filter {
 	struct kobject kobj;
+	enum damon_sample_filter_type type;
+	bool matching;
+	bool allow;
 };
 
 static struct damon_sysfs_sample_filter *damon_sysfs_sample_filter_alloc(void)
@@ -762,6 +765,92 @@ static struct damon_sysfs_sample_filter *damon_sysfs_sample_filter_alloc(void)
 	return kzalloc(sizeof(struct damon_sysfs_sample_filter), GFP_KERNEL);
 }
 
+static ssize_t type_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+	int i = 0;
+
+	for (; i < ARRAY_SIZE(damon_sysfs_sample_filter_type_names); i++) {
+		const struct damon_sysfs_sample_filter_type_name *type_name;
+
+		type_name = &damon_sysfs_sample_filter_type_names[i];
+		if (type_name->type == filter->type)
+			return sysfs_emit(buf, "%s\n", type_name->name);
+	}
+	return -EINVAL;
+}
+
+static ssize_t type_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+	ssize_t ret = -EINVAL;
+	int i = 0;
+
+	for (; i < ARRAY_SIZE(damon_sysfs_sample_filter_type_names); i++) {
+		const struct damon_sysfs_sample_filter_type_name *type_name;
+
+		type_name = &damon_sysfs_sample_filter_type_names[i];
+		if (sysfs_streq(buf, type_name->name)) {
+			filter->type = type_name->type;
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
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+
+	return sysfs_emit(buf, "%c\n", filter->matching ? 'Y' : 'N');
+}
+
+static ssize_t matching_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
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
+static ssize_t allow_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+
+	return sysfs_emit(buf, "%c\n", filter->allow ? 'Y' : 'N');
+}
+
+static ssize_t allow_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+	bool allow;
+	int err = kstrtobool(buf, &allow);
+
+	if (err)
+		return err;
+
+	filter->allow = allow;
+	return count;
+}
+
 static void damon_sysfs_sample_filter_release(struct kobject *kobj)
 {
 	struct damon_sysfs_sample_filter *filter = container_of(kobj,
@@ -770,7 +859,19 @@ static void damon_sysfs_sample_filter_release(struct kobject *kobj)
 	kfree(filter);
 }
 
+static struct kobj_attribute damon_sysfs_sample_filter_type_attr =
+		__ATTR_RW_MODE(type, 0600);
+
+static struct kobj_attribute damon_sysfs_sample_filter_matching_attr =
+		__ATTR_RW_MODE(matching, 0600);
+
+static struct kobj_attribute damon_sysfs_sample_filter_allow_attr =
+		__ATTR_RW_MODE(allow, 0600);
+
 static struct attribute *damon_sysfs_sample_filter_attrs[] = {
+	&damon_sysfs_sample_filter_type_attr.attr,
+	&damon_sysfs_sample_filter_matching_attr.attr,
+	&damon_sysfs_sample_filter_allow_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_sample_filter);
-- 
2.47.3

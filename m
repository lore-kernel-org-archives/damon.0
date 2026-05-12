Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C13C2B8C;
	Tue, 12 May 2026 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596622; cv=none; b=NYylMXBekkjaVr6i2rsLKKOmeL49MRkPuF4DrRBau0nRx9CVLyiofH4Mxj/2DN4uMjf/5vgDinI6o6djMLdWYbnxDhWV2jyrH6iKIW/mC0BblxUAcmaoeXuIuFNKgdFjSc7kAfAbEdNu3iLPsw9+M0O8lk04FfKTIdufOtn3iSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596622; c=relaxed/simple;
	bh=xxAnM/x521/ipQQKxInfDno6KUEv3MR4zVVk+LBGBIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etTmn7EReuwQJjExHLzOXeKz+OG2yXNogFjYjb9ysbcnUZlpHa+3gq+K0VdI/MeyV4ZTEqZJI/B1BuGRzhXSwn+IoLsJByhQi7GZOPL00jM/7XIkYssmtZeWqMQfF2OslTYaxNG0/jdGxffK83o0MtxX+w+baaE9zIqudsJ3QcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHMVRwn/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHMVRwn/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429F6C2BCF7;
	Tue, 12 May 2026 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596622;
	bh=xxAnM/x521/ipQQKxInfDno6KUEv3MR4zVVk+LBGBIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SHMVRwn/Zeq/e9kwvzPieilOrUAThIlto2cdeb1Wer75RXW9pVv2dxib7XoLbdgc5
	 uIpXH5vn+w6f32RZ5L3CAGnggs7C2n9ETWUc5zS0bLVydTu0Tr/Ur85iyS5LShlX01
	 mOOWrGz3izK4JkIh1JUioFtrExhQswzF+HgGD01eH/uhAaFW6amHiISOW9fTrRVh6C
	 sN6IdHSZ6oyr1zRnw394QDRqbn3a3MtgR4f64evB41gS39KxxIDm0qXyk8acpqiuS5
	 LTRZ+Av0JPyydd9OeE1QdmMCX3re8QTLuYkPN0SZwJVtsefkNSfwFjAWGNEjQUhctM
	 Mb30YvG80/3/g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 13/28] mm/damon/sysfs: implement filter dir files
Date: Tue, 12 May 2026 07:36:28 -0700
Message-ID: <20260512143645.113201-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement sysfs files under the data probe filter directory for letting
users to configure each filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 25487a0268cbe..ed7bb734a236b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -753,6 +753,9 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 
 struct damon_sysfs_filter {
 	struct kobject kobj;
+	enum damon_filter_type type;
+	bool matching;
+	bool allow;
 };
 
 static struct damon_sysfs_filter *damon_sysfs_filter_alloc(void)
@@ -760,6 +763,105 @@ static struct damon_sysfs_filter *damon_sysfs_filter_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_filter);
 }
 
+struct damon_sysfs_filter_type_name {
+	enum damon_filter_type type;
+	char *name;
+};
+
+static const struct damon_sysfs_filter_type_name
+damon_sysfs_filter_type_names[] = {
+	{
+		.type = DAMON_FILTER_TYPE_ANON,
+		.name = "anon",
+	},
+};
+
+static ssize_t type_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_filter_type_names); i++) {
+		const struct damon_sysfs_filter_type_name *type_name;
+
+		type_name = &damon_sysfs_filter_type_names[i];
+		if (type_name->type == filter->type)
+			return sysfs_emit(buf, "%s\n", type_name->name);
+	}
+	return -EINVAL;
+}
+
+static ssize_t type_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+	ssize_t ret = -EINVAL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_filter_type_names); i++) {
+		const struct damon_sysfs_filter_type_name *type_name;
+
+		type_name = &damon_sysfs_filter_type_names[i];
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
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+
+	return sysfs_emit(buf, "%c\n", filter->matching ? 'Y' : 'N');
+}
+
+static ssize_t matching_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
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
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+
+	return sysfs_emit(buf, "%c\n", filter->allow ? 'Y' : 'N');
+}
+
+static ssize_t allow_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
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
 static void damon_sysfs_filter_release(struct kobject *kobj)
 {
 	struct damon_sysfs_filter *filter = container_of(kobj,
@@ -768,7 +870,19 @@ static void damon_sysfs_filter_release(struct kobject *kobj)
 	kfree(filter);
 }
 
+static struct kobj_attribute damon_sysfs_filter_type_attr =
+		__ATTR_RW_MODE(type, 0600);
+
+static struct kobj_attribute damon_sysfs_filter_matching_attr =
+		__ATTR_RW_MODE(matching, 0600);
+
+static struct kobj_attribute damon_sysfs_filter_allow_attr =
+		__ATTR_RW_MODE(allow, 0600);
+
 static struct attribute *damon_sysfs_filter_attrs[] = {
+	&damon_sysfs_filter_type_attr.attr,
+	&damon_sysfs_filter_matching_attr.attr,
+	&damon_sysfs_filter_allow_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_filter);
-- 
2.47.3

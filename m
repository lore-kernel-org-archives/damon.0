Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3676D22C34A;
	Wed, 16 Apr 2025 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777564; cv=none; b=Z+Kz0iv2LStldLO0rqLhlZlinE/OUH/BdLwP7XQjqDKtmYIwlhSgVqGt78vrD03nruRfT/LyqfrDbNF7DxCEGMRHuHflMIsorm08m4p/wdC/GzehYKLvjKe4mIXIYth1Z5UX6paM1FU+PvbwJOewPrklMOhbS2jSGReF1FTA+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777564; c=relaxed/simple;
	bh=VVcSdVBTKKi06qwTl9rWSnXUumWlw7dYXO3OAlE/vPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZaIzd/hLZ9h8VLDyKgJkmzGNKujiCitzAcwaGxE0/vGx2YCWhe5EAwntgcCuqhxoj//lllNb+Ag0HsGRAUMpVdXbhNREEMuFnV+dQd5qRQcB8KcuyqXPvbuxIfEZ6x/+QMlmAqmqvYyvDPasEOs10sANm3LHvn7Rso32sRu3cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0ZGTJC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0ZGTJC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4794C4CEEA;
	Wed, 16 Apr 2025 04:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777564;
	bh=VVcSdVBTKKi06qwTl9rWSnXUumWlw7dYXO3OAlE/vPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0ZGTJC5AzEa0qRAeIbadf2/M4vCz6O0N4ey7KSAHYfBZUJzSAb6ty7X0H6b124i/
	 xc0gdbjgNzDVrwtg7TmFQiw4/5Cb/owsg+o8qW8MXn8uyLV1jpJCXDwX0yV0S7ld6O
	 amiIlfqX702lSDXcUqUX7w3w1p//t/TKcLwKOVfB88sRuOi6eZpnRYH56HDkC2JS5P
	 K6GTVV6rL1oqUcMjywOB/l3GDiMkjn5hxIQASwozEdIeHc1CIaAe+UJDxKSZnnbaUz
	 yurHm4e4rAeklyUz1zqDoEDbxCkoOyFlaU1d8PlP42eaopCzr33uowyaEW0kD/gQgw
	 HrAnmbR6MBwgQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ze Zuo <zuoze1@huawei.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/10] mm/damon/sysfs: implement addr_unit file under context dir
Date: Tue, 15 Apr 2025 21:25:48 -0700
Message-Id: <20250416042551.158131-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416042551.158131-1-sj@kernel.org>
References: <20250416042551.158131-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only DAMON kernel API callers can use addr_unit parameter.  Implement a
sysfs file to let DAMON sysfs ABI users use it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1af6aff35d84..ebd7cfa235b0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -821,6 +821,7 @@ static const char * const damon_sysfs_ops_strs[] = {
 struct damon_sysfs_context {
 	struct kobject kobj;
 	enum damon_ops_id ops_id;
+	unsigned long addr_unit;
 	struct damon_sysfs_attrs *attrs;
 	struct damon_sysfs_targets *targets;
 	struct damon_sysfs_schemes *schemes;
@@ -836,6 +837,7 @@ static struct damon_sysfs_context *damon_sysfs_context_alloc(
 		return NULL;
 	context->kobj = (struct kobject){};
 	context->ops_id = ops_id;
+	context->addr_unit = 1;
 	return context;
 }
 
@@ -971,6 +973,25 @@ static ssize_t operations_store(struct kobject *kobj,
 	return -EINVAL;
 }
 
+static ssize_t addr_unit_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+
+	return sysfs_emit(buf, "%lu\n", context->addr_unit);
+}
+
+static ssize_t addr_unit_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+	int err = kstrtoul(buf, 0, &context->addr_unit);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_context_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_context, kobj));
@@ -982,9 +1003,13 @@ static struct kobj_attribute damon_sysfs_context_avail_operations_attr =
 static struct kobj_attribute damon_sysfs_context_operations_attr =
 		__ATTR_RW_MODE(operations, 0600);
 
+static struct kobj_attribute damon_sysfs_context_addr_unit_attr =
+		__ATTR_RW_MODE(addr_unit, 0600);
+
 static struct attribute *damon_sysfs_context_attrs[] = {
 	&damon_sysfs_context_avail_operations_attr.attr,
 	&damon_sysfs_context_operations_attr.attr,
+	&damon_sysfs_context_addr_unit_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_context);
@@ -1414,6 +1439,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	err = damon_select_ops(ctx, sys_ctx->ops_id);
 	if (err)
 		return err;
+	ctx->addr_unit = sys_ctx->addr_unit;
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
-- 
2.39.5

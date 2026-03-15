Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22BC2F2914;
	Sun, 15 Mar 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608423; cv=none; b=iJfSkY19xnVXruerSp3s+IrEQDeOQJTe6JQ14FclJLCUiXUt1mV8nOjs9RVxkLZPl3JYRqblgNvvuBYdHQlhV7G3KC4LyAg64QNPqzLr2ImW2m7IVC3MfWu4MP519s6lzKFtMZfM1E0PmQb1Gtyt8guUfRVjsChD/OQrK3XEKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608423; c=relaxed/simple;
	bh=RJ+licMFiBy5Dj4RMj3fE1urGObz4KRM5FWga+atVco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lK4wtwzV7r/XnttknJUOsRsKJrZDkFUJtBjdqwKipxl1NjfFNye6THGInd2b48E077Fq2IMRJnEQyrXbctaY/SspxKBL8Ycps6BreTjpa4UHmwUo/id45Xsp1oRWC9JVCiqg+tkZv6QYnIaovFHUkXVQYj4SKN27AufzxU7oJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYUjacPb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYUjacPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621B9C2BCAF;
	Sun, 15 Mar 2026 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773608423;
	bh=RJ+licMFiBy5Dj4RMj3fE1urGObz4KRM5FWga+atVco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYUjacPbZZ/tHdeR4OPPRLF5Z2QcyEOaEeTGWM2oJ7nYrOPKap0koFyiotrZXwILb
	 7u7zHxR1nef6GALCZ/w3zkkdT3KNbwoxicynfl797ksVEQfx0iXlToZZ+qPsIyGdco
	 gem+LalKmO6ZYTqEkMsTm6jLr2mWZSCRG/JR3bQkP0annKIEYSRJeme69wlBp3JJlu
	 2jxqZ8g/tF2iYzOwuZ3NYZUwtFIaifMZCLKltuvx687FL1ns7SvgBHiuPVycndn4vD
	 /gjuld0e3Pu7zUrKVkN3dci6syDmqkw8vwH2SuaMtDR9jDIO9CqaJ/EHG7T0Lj7jck
	 3kp5/o67gFw9g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/10] mm/damon/sysfs: add pause file under context dir
Date: Sun, 15 Mar 2026 14:00:01 -0700
Message-ID: <20260315210012.94846-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-1-sj@kernel.org>
References: <20260315210012.94846-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pause DAMON sysfs file under the context directory.  It exposes the
damon_ctx->pause API parameter to the users so that they can use the
pause/resume feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 576d1ddd736bf..4cbb8b9aaba3c 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -866,6 +866,7 @@ struct damon_sysfs_context {
 	struct damon_sysfs_attrs *attrs;
 	struct damon_sysfs_targets *targets;
 	struct damon_sysfs_schemes *schemes;
+	bool pause;
 };
 
 static struct damon_sysfs_context *damon_sysfs_context_alloc(
@@ -1053,6 +1054,30 @@ static ssize_t addr_unit_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t pause_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+
+	return sysfs_emit(buf, "%c\n", context->pause ? 'Y' : 'N');
+}
+
+static ssize_t pause_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+	bool pause;
+	int err = kstrtobool(buf, &pause);
+
+	if (err)
+		return err;
+	context->pause = pause;
+	return count;
+}
+
+
 static void damon_sysfs_context_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_context, kobj));
@@ -1067,10 +1092,14 @@ static struct kobj_attribute damon_sysfs_context_operations_attr =
 static struct kobj_attribute damon_sysfs_context_addr_unit_attr =
 		__ATTR_RW_MODE(addr_unit, 0600);
 
+static struct kobj_attribute damon_sysfs_context_pause_attr =
+		__ATTR_RW_MODE(pause, 0600);
+
 static struct attribute *damon_sysfs_context_attrs[] = {
 	&damon_sysfs_context_avail_operations_attr.attr,
 	&damon_sysfs_context_operations_attr.attr,
 	&damon_sysfs_context_addr_unit_attr.attr,
+	&damon_sysfs_context_pause_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_context);
@@ -1470,6 +1499,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
 		ctx->min_region_sz = max(
 				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
+	ctx->pause = sys_ctx->pause;
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
-- 
2.47.3

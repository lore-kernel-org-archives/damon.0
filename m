Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3423845A7;
	Mon, 23 Mar 2026 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307743; cv=none; b=Q4pJdnjWl8WwS8IG/7LQ2jjwZZ1ZTyavCs6QHpmIdk9OBvxBU/dTaP5LzQctkWHjwLwwnViFhjM2mm5aasMnCA4Zm6CQqs6l0nnFVBZdDmlX0VWf41sjh/dMwENMewKw90KZ79UyhrrmmEiAsbvJ4hGgfwMphdJEjoKjBdhxQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307743; c=relaxed/simple;
	bh=4uaA+eem3fKB2uPWGLGeH18mf1wXB30aEUf0eMGJT00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptNZNzOmHsXY0wLOxw/lNgevFcO4VYRM/o3GagRGWEhTIaWcn9w1IRkRpVZJ0jyxSw92NggdjzeV6mY0ZKnE0inHSRkKZP7hQ2AB63IhS6UmbN6n9kJ45zdirVGesGBVAwMiuX0I5rx5KNa1IvodFwRVkgecsKo3Ghcer2zJqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2jOlGxK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2jOlGxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FB6C2BCB6;
	Mon, 23 Mar 2026 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774307743;
	bh=4uaA+eem3fKB2uPWGLGeH18mf1wXB30aEUf0eMGJT00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2jOlGxKZnItSh90/CHwHf/3n40YsKYeI9L/w7x5ASEzPnbBBSCpFKdwahiYgoVeO
	 xvqprGtmJD4jplV0wQSYLyL7jEFiGAvX8V832u8sVPSvnARMhUY023Nu/ls/MHlPZf
	 dt4o6t9+fTL4hXy1fm0pSNWIimu6iRrL79/YtqdWxViOExCq40k5Yt/kUwc9hLVdeC
	 WiuxaHWn5HQ3iING4xC5x89Wn7jnK53PZPg6OmGpq9BXywTInLRjTFCo7g0jNApELO
	 YA2mGnLf6Z1SuTzWoFU3/3If7etKf/7aHS4Kz1mTUfC8QtH0lGuEe3Uce4AmcvT3f6
	 joe+9vz2UYS4Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 02/10] mm/damon/sysfs: add pause file under context dir
Date: Mon, 23 Mar 2026 16:15:27 -0700
Message-ID: <20260323231538.84452-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231538.84452-1-sj@kernel.org>
References: <20260323231538.84452-1-sj@kernel.org>
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
 mm/damon/sysfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6a44a2f3d8fc9..51893abd09472 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -866,6 +866,7 @@ struct damon_sysfs_context {
 	struct damon_sysfs_attrs *attrs;
 	struct damon_sysfs_targets *targets;
 	struct damon_sysfs_schemes *schemes;
+	bool pause;
 };
 
 static struct damon_sysfs_context *damon_sysfs_context_alloc(
@@ -878,6 +879,7 @@ static struct damon_sysfs_context *damon_sysfs_context_alloc(
 	context->kobj = (struct kobject){};
 	context->ops_id = ops_id;
 	context->addr_unit = 1;
+	context->pause = false;
 	return context;
 }
 
@@ -1053,6 +1055,30 @@ static ssize_t addr_unit_store(struct kobject *kobj,
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
@@ -1067,10 +1093,14 @@ static struct kobj_attribute damon_sysfs_context_operations_attr =
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
@@ -1470,6 +1500,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
 		ctx->min_region_sz = max(
 				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
+	ctx->pause = sys_ctx->pause;
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
-- 
2.47.3

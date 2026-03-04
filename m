Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488337F8A2;
	Wed,  4 Mar 2026 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599288; cv=none; b=SawYouLy3FBY2i51BJGOmI6TvTF36GK8n3KIfgGWFhuO1Ue8S42ifi0ub3ZxwuUXZtYOGtZcs2Om+6GQEFTg8o+B+rOXe7QfL0Q4uC9RzQa62H0HufcswyGXEehvYvA3gYTAUnYjr6SCBEZy58MLtkgxWlPG0sJ+5sadPif+FIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599288; c=relaxed/simple;
	bh=Cz0dujDOIX0D2wsuyXTUh/TXx2EbdEyN7109tlsNnZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9/Uftb6npp65qIj4MC0idNl4Xh1FCGkVLDIf3iDj/OaKnMhKrV9ZT70erI7qgRtaMdHCI6z8AQvTMDGQlNezoTw0ey6KPBKSBCICRaQiTbJ10RZ7tfx6h+SQnoZF8NGs417ARxnVFdm7vJ54R8lhF5OxXVuLDbTxygplEgsl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqDXw3W0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqDXw3W0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2304C19423;
	Wed,  4 Mar 2026 04:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772599288;
	bh=Cz0dujDOIX0D2wsuyXTUh/TXx2EbdEyN7109tlsNnZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqDXw3W0NvWmeE+6mfw9826vhRUL+IYxvIT1g0hxflbTAQReC+zO17jRTJ/k70Dw3
	 vIRctIxYEcOgvqYKEfJgr8acdwqdA/k0jP7gAKpqj78BMscunzq3qn0HMZnI4/ACn/
	 9tuw20Eu7Zc0qIW8++W2aPzr0vqpQz9wG4M6rTHtjc78w4NcxJ2qW/HD9PrmSlJOkh
	 A4XoU/8/mehdTuAjY3mcl2cyb7JUKzoc7kLZrhFMTDvfQMkotsldejxe4TNjwFo+Bh
	 sQEUw4ZzMWlJqgFzX0chsvmojPt1qCpe4drrTBuAUri9CKDo3GayIeTM5u03R3hsGa
	 PN3VTPBFtzKXA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 04/10] mm/damon/sysfs-schemes: implement quotas->goal_tuner file
Date: Tue,  3 Mar 2026 20:41:13 -0800
Message-ID: <20260304044122.79394-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-1-sj@kernel.org>
References: <20260304044122.79394-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new DAMON sysfs interface file, namely 'goal_tuner' under the
DAMOS quotas directory.  It is connected to the damos_quota->goal_tuner
field.  Users can therefore select their favorite goal-based quotas
tuning algorithm by writing the name of the tuner to the file.  Reading
the file returns the name of the currently selected tuner.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3a0782e576fab..5186966dafb35 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1488,6 +1488,7 @@ struct damon_sysfs_quotas {
 	unsigned long sz;
 	unsigned long reset_interval_ms;
 	unsigned long effective_sz;	/* Effective size quota in bytes */
+	enum damos_quota_goal_tuner goal_tuner;
 };
 
 static struct damon_sysfs_quotas *damon_sysfs_quotas_alloc(void)
@@ -1610,6 +1611,58 @@ static ssize_t effective_bytes_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%lu\n", quotas->effective_sz);
 }
 
+struct damos_sysfs_qgoal_tuner_name {
+	enum damos_quota_goal_tuner tuner;
+	char *name;
+};
+
+static struct damos_sysfs_qgoal_tuner_name damos_sysfs_qgoal_tuner_names[] = {
+	{
+		.tuner = DAMOS_QUOTA_GOAL_TUNER_CONSIST,
+		.name = "consist",
+	},
+	{
+		.tuner = DAMOS_QUOTA_GOAL_TUNER_TEMPORAL,
+		.name = "temporal",
+	},
+};
+
+static ssize_t goal_tuner_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_qgoal_tuner_names); i++) {
+		struct damos_sysfs_qgoal_tuner_name *tuner_name;
+
+		tuner_name = &damos_sysfs_qgoal_tuner_names[i];
+		if (tuner_name->tuner == quotas->goal_tuner)
+			return sysfs_emit(buf, "%s\n", tuner_name->name);
+	}
+	return -EINVAL;
+}
+
+static ssize_t goal_tuner_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_qgoal_tuner_names); i++) {
+		struct damos_sysfs_qgoal_tuner_name *tuner_name;
+
+		tuner_name = &damos_sysfs_qgoal_tuner_names[i];
+		if (sysfs_streq(buf, tuner_name->name)) {
+			quotas->goal_tuner = tuner_name->tuner;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+
 static void damon_sysfs_quotas_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_quotas, kobj));
@@ -1627,11 +1680,15 @@ static struct kobj_attribute damon_sysfs_quotas_reset_interval_ms_attr =
 static struct kobj_attribute damon_sysfs_quotas_effective_bytes_attr =
 		__ATTR_RO_MODE(effective_bytes, 0400);
 
+static struct kobj_attribute damon_sysfs_quotas_goal_tuner_attr =
+		__ATTR_RW_MODE(goal_tuner, 0600);
+
 static struct attribute *damon_sysfs_quotas_attrs[] = {
 	&damon_sysfs_quotas_ms_attr.attr,
 	&damon_sysfs_quotas_sz_attr.attr,
 	&damon_sysfs_quotas_reset_interval_ms_attr.attr,
 	&damon_sysfs_quotas_effective_bytes_attr.attr,
+	&damon_sysfs_quotas_goal_tuner_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_quotas);
@@ -2718,6 +2775,7 @@ static struct damos *damon_sysfs_mk_scheme(
 		.weight_sz = sysfs_weights->sz,
 		.weight_nr_accesses = sysfs_weights->nr_accesses,
 		.weight_age = sysfs_weights->age,
+		.goal_tuner = sysfs_quotas->goal_tuner,
 	};
 	struct damos_watermarks wmarks = {
 		.metric = sysfs_wmarks->metric,
-- 
2.47.3

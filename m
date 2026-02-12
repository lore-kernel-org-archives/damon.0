Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337728BAB9;
	Thu, 12 Feb 2026 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877408; cv=none; b=ViAglT6CJxijlCo0YBNW4klmFbMS+WYBqY/FuPMz9xbojS9QSB+yqVLS21Fah7FSinp3sxd3uGncsMgftQJi+t+6a6YbdHY7Vgpan5fvbaCJ6vZ2pNrupqHwUPVIOUMUoO92r2hbamLRhPI4AyEnCrs1R81x7UpSOygbNXqxwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877408; c=relaxed/simple;
	bh=K7N0OnHx6SU/UFHKtEBzt5r26kfuQxAuPfXTSNUkEbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIVvzn6BMsA5zEMGRzSOHrq5xK+jC+BdpD3unUqAAKd9DNtJJYBxZc2lC2npvqa31Un9u/vOr0S8C9vdvejSlF+obMbfiUbLhdiexPgHkXG3eb9MDDPFEuw62AYyJuywyeetvfDGCzt9tFsIHHUqXGwF+UzYqAwuonLARhk+8Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6eqUhu5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6eqUhu5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9A0C19421;
	Thu, 12 Feb 2026 06:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770877408;
	bh=K7N0OnHx6SU/UFHKtEBzt5r26kfuQxAuPfXTSNUkEbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6eqUhu5Pb1SeEwzxPLxiEKY2W2TNF/CekmBWoPuOPMTVJQU/Ec2DulNPSiDhNalC
	 SaZDYe+AaGycq3IQAAi02BeHN/A67aygGAEdTb+dmqrMpEvZ5VrvdRmbjXb8dLzojZ
	 ooVm2TG/EC/kNr7CRvf8KWwTtCWsNk/M8TWnh5zbnfG5tKti9SIBTCphFarAeJMmjm
	 2fJS45jZfbf5yO51iajk27Vdid9mbM6Qnyzeazd28GGQGySaHqYAhvc9T5JcnV6k5D
	 r/VdZISAjGoDiLFmydism5dM8IhCivD+z/ynuVDqtQFRBI6kLxGY6VernWp6Mxepv/
	 M7GvRggOFAUwA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/5] mm/damon/sysfs-schemes: implement quotas->goal_tuner file
Date: Wed, 11 Feb 2026 22:23:10 -0800
Message-ID: <20260212062314.69961-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212062314.69961-1-sj@kernel.org>
References: <20260212062314.69961-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new DAMON sysfs interface file, namely goal_tuner under the DAMOS
quotas directory.  It is connected to the damos_quota->goal_tuner field.
Users can therefore select their favorite goal-based quotas tuning
algorithm by writing special keywords to the file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 2b05a64771884..b30d9139b1c23 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1492,6 +1492,7 @@ struct damon_sysfs_quotas {
 	unsigned long sz;
 	unsigned long reset_interval_ms;
 	unsigned long effective_sz;	/* Effective size quota in bytes */
+	enum damos_quota_goal_tuner goal_tuner;
 };
 
 static struct damon_sysfs_quotas *damon_sysfs_quotas_alloc(void)
@@ -1614,6 +1615,58 @@ static ssize_t effective_bytes_show(struct kobject *kobj,
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
@@ -1631,11 +1684,15 @@ static struct kobj_attribute damon_sysfs_quotas_reset_interval_ms_attr =
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
@@ -2726,6 +2783,7 @@ static struct damos *damon_sysfs_mk_scheme(
 		.weight_sz = sysfs_weights->sz,
 		.weight_nr_accesses = sysfs_weights->nr_accesses,
 		.weight_age = sysfs_weights->age,
+		.goal_tuner = sysfs_quotas->goal_tuner,
 	};
 	struct damos_watermarks wmarks = {
 		.metric = sysfs_wmarks->metric,
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7237037A839;
	Sat, 25 Jul 2026 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013360; cv=none; b=hI+5eGrXNS6sEj4riNCkUmdT76FTknD9U8tuiBsOwpxQ4WjIMUG3ci3ETrGZSXiGoGQo5jgwxxpPfzL5gkqqrpmwh8HJKO2RA63/h4jn47kE8WmcKRZgcFhYdOj7bSsf0i1dyWnOBmkI674021O+vf5XnJFGYXkeNtDzRto7EPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013360; c=relaxed/simple;
	bh=YbkvKHOwvK4XBBdmRShTWnqXPTWsN8VUuSnj03rvC44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPp1E7GRIqWea4xR2egv2tliZqW3GHsgOpiEUkZ6hk57wQfwa+cra8BPR7oiVigeB/qcsAYs3b4SHxj/ZabLp4Uehij7ZQV6zRdy4AGmggC0OyKwnQuKryDJ02INIkujtz48CXs1cKHjnMIAekepfORaa48xPjSa0M/IMbev2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx0j7pIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx0j7pIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B641F00A3D;
	Sat, 25 Jul 2026 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013358;
	bh=dF7Ex+634YBMzvQotb894Kf5fDsXB/EcytIewIXnnLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cx0j7pIQ1CGMQtYnYVEl0J+ohRFAAu+8Mb2jpW4GzqMUoR4qA2k1X1Qm0pB2Lqp4Z
	 zMUbb9SOteK3XgPqA9tjOSyvYvs5Xp0qC1xrimaFRB8dE5V30tJMKF754Sq//+hLdT
	 tyzwKp0kPndobOlYF+9NSlmlzTTlUAoLIE8eaKug7AHLIXJSQu8PyBMqu4AhDdbTXk
	 j4Aj6L3SoAbmmzCFzxtYxGeJG73fY4r/FZG7Jt8yOtxm51ef4ZRcATP9laS6OZueA3
	 jZYXTjk3lMgd57uSyI/ivs0qd1V6+WwAas6VsVevQ6PYc4fDl2Crr5/Nx2WuF+mOsL
	 bQ8ZCz7fOZGUQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 11/17] mm/damon/sysfs: implement probe prep directory
Date: Sat, 25 Jul 2026 14:02:15 -0700
Message-ID: <20260725210225.129944-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement DAMON sysfs directory and files for specifying each probe prep
action.  Introduce only preparatory data structure and functions.  The
files are not really being created under the sysfs.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6d3ed80fb2eb1..b15ec082109b7 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -750,6 +750,89 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * prep directory
+ */
+
+struct damon_sysfs_prep {
+	struct kobject kobj;
+	enum damon_prep_action action;
+};
+
+struct damon_sysfs_prep_action_name {
+	enum damon_prep_action action;
+	char *name;
+};
+
+static const struct damon_sysfs_prep_action_name
+damon_sysfs_prep_action_names[] = {
+	{
+		.action = DAMON_PREP_SET_PGIDLE,
+		.name = "set_pgidle",
+	},
+};
+
+static ssize_t prep_action_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_prep *prep = container_of(kobj,
+			struct damon_sysfs_prep, kobj);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_prep_action_names); i++) {
+		const struct damon_sysfs_prep_action_name *action_name;
+
+		action_name = &damon_sysfs_prep_action_names[i];
+		if (action_name->action == prep->action)
+			return sysfs_emit(buf, "%s\n", action_name->name);
+	}
+	return -EINVAL;
+}
+
+static ssize_t prep_action_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_prep *prep = container_of(kobj,
+			struct damon_sysfs_prep, kobj);
+	ssize_t ret = -EINVAL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_prep_action_names); i++) {
+		const struct damon_sysfs_prep_action_name *action_name;
+
+		action_name = &damon_sysfs_prep_action_names[i];
+		if (sysfs_streq(buf, action_name->name)) {
+			prep->action = action_name->action;
+			ret = count;
+			break;
+		}
+	}
+	return ret;
+}
+
+static void damon_sysfs_prep_release(struct kobject *kobj)
+{
+	struct damon_sysfs_prep *prep = container_of(kobj,
+			struct damon_sysfs_prep, kobj);
+
+	kfree(prep);
+}
+
+static struct kobj_attribute damon_sysfs_prep_prep_action_attr =
+		__ATTR_RW_MODE(prep_action, 0600);
+
+static struct attribute *damon_sysfs_prep_attrs[] = {
+	&damon_sysfs_prep_prep_action_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_prep);
+
+static const struct kobj_type damon_sysfs_prep_ktype = {
+	.release = damon_sysfs_prep_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_prep_groups,
+};
+
 /*
  * preps directory
  */
-- 
2.47.3

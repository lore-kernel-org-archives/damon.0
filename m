Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE493D6479;
	Sun, 26 Jul 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087590; cv=none; b=W4y/TXQTtmxK8jezeHy9Dmt95d+FvpqbhUJ/APyGhYrd9F6ZrnRLSY6ySQmWaOrs+yqIV9empBEcySrUtlr9MsrIOjDK/rQSbHHte33NlAyTCf1VVVrO8OIpnqLJnW+MUKYLJtf7rY3Tw4NcAUWpJRYA2gkCk0MHMj+rL/1ds1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087590; c=relaxed/simple;
	bh=70LV5BDGvfoeZHspdss1bW53IpFL2Pngp5HyNxvSbKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQigbL7E/xJpWH//VWdHgt09Q5W9HgH1ojv4eKCOPh4etPfyc82mPoNvbfzRkA6qgOJpQfZyqGe3GLw6tDUc/n/65VyfxikhiZpzCczsYOFFYzHkij83JVtVQtnD6vHceQR5paSth5YOL4LYi+zcg6NN8d6Xaqnz/4EI+/Asa3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMoqbUJr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMoqbUJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28101F00ACF;
	Sun, 26 Jul 2026 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087588;
	bh=+sG7v9QjVN/SIQic4/p3WnUFMpqViqsUPqy3peyL9No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JMoqbUJrzk2A7ET22ybfkRlQAv27xty8qK/utLpNogv4PXtneHfbWrkxHRqHp9rk7
	 mUb/95bx6TeZyekyAgb48ZXfybK55vmLlNyPgEfw6BJamenN8PpPWtGeYKGWbFRyDH
	 08Q9bMXLyO1a+lYqHAmnEAioLSqqwnnB4wuhLygYYIprlEzpccbCqpJOP35HkJG1vR
	 L7uZpADib/u15jNK5eOib7CH88T+Neo0FfAAoMkajX+sT6r6ZCkrnzkP7qORwgFMfw
	 ZiFSL2nSpVCoieHVPsx2VeJHcyKMhxJ26OZPiPioRqIzqv5DjGCvvNNAu/KG4UF5IF
	 wbbxrsg6eizmA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 11/17] mm/damon/sysfs: implement probe prep directory
Date: Sun, 26 Jul 2026 10:39:27 -0700
Message-ID: <20260726173935.94046-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
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
index 6d3ed80fb2eb1..e348c1feed1ad 100644
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
+const struct kobj_type damon_sysfs_prep_ktype = {
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

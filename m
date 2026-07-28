Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D359E385529;
	Tue, 28 Jul 2026 04:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211979; cv=none; b=o8VfLJOv3UFIzCtMzXR7msA5b9ZIa6Wy5bcEgq4Sozj3e6wcGXEpzFTYOR+D5Z0YtaTjzDIzIPzQDJ/d+TqqSGI9N/+qOP8F8YY6wJuisp20jiATYppS8HvYGn2UpISISgE5KUy9D6qPk5iKIYE8lGYuYc6D3QcdVYGxe+foomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211979; c=relaxed/simple;
	bh=1EiK4lGCfOTWE2dduqbBZ1pbR8E633AUsJhsmGzVCx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOcifENjEdbQQnv+48ap/+IJjNUqOLayhYyPhJSpMFCF5PAVUJQ3rea3BKFMrSc65taAuM9zLrDE5z/ChcvNZKekKPE6EvkGVjCNnYwBaYbeZ4Rh2Um/OS539gkdcsV2GqyRRpGDh0a0IVcHCi8JGMIJPUizzmcxlotsuCdeSiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMlE1Tsi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMlE1Tsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099361F000E9;
	Tue, 28 Jul 2026 04:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211976;
	bh=T5V8MjQrwRuDjd8BtOPEo73pYkdzDFHDiZ1CxZWMyKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MMlE1TsiVFs3PvMr4gCgcOJWrIA9UUOf7HMF/b4Mk6yEXreOkh7n1/Rw7VhpccWQj
	 KBN3ddQa4fQ176XoVxggxlqRC6IQmG281F8Ulg0vBL+gCKu3B5CXcAMi+AL3Iezo4U
	 MJJx4AGXsI7kkRJ5PK/ytG8JRhx0VT1JbomuT/YsAD+mTy+qWgAVenh9FPFZBR86IG
	 W/1e9AS1osWwDnrc2cb8jZJarkdCAxfd2wU/bUGPr7nOSXqbpJicd/oAMymsiNJ03l
	 fzRr5fM5gGXFV1ERz0avaoKO+lcKRBlTUH/DrJ0yvYOz8bRt/5G4BCu4tBfHaD/QIy
	 6U5TkzfC3j9cA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 12/17] mm/damon/sysfs: implement prep_action file
Date: Mon, 27 Jul 2026 21:12:33 -0700
Message-ID: <20260728041242.187380-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728041242.187380-1-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a file named prep_action under the prep directory.  It represents
the corresponding probe preparation action.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index afd39659d6b84..c0130843223d7 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -756,6 +756,7 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 
 struct damon_sysfs_prep {
 	struct kobject kobj;
+	enum damon_prep_action action;
 };
 
 static struct damon_sysfs_prep *damon_sysfs_prep_alloc(void)
@@ -765,9 +766,61 @@ static struct damon_sysfs_prep *damon_sysfs_prep_alloc(void)
 	prep = kzalloc_obj(struct damon_sysfs_prep);
 	if (!prep)
 		return prep;
+	prep->action = DAMON_PREP_SET_PGIDLE;
 	return prep;
 }
 
+struct damon_sysfs_prep_action_name {
+	const enum damon_prep_action action;
+	const char *name;
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
 static void damon_sysfs_prep_release(struct kobject *kobj)
 {
 	struct damon_sysfs_prep *prep = container_of(kobj,
@@ -776,7 +829,11 @@ static void damon_sysfs_prep_release(struct kobject *kobj)
 	kfree(prep);
 }
 
+static struct kobj_attribute damon_sysfs_prep_prep_action_attr =
+		__ATTR_RW_MODE(prep_action, 0600);
+
 static struct attribute *damon_sysfs_prep_attrs[] = {
+	&damon_sysfs_prep_prep_action_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_prep);
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359212E3B1C;
	Thu, 16 Oct 2025 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651263; cv=none; b=P33p3QRwXbn5ZGg8M7Mcgv47cXp2blYjzc1fEPtNdlo6iuto5wLcsNKjsKpl8yJPoXVwU429fmUCzos1tlA6aqwA/fvwQv2Px3hWQwHCghUQy+1WFQyM5UjCI7ChO2e+8x5ElBpaft5AWSv8oGFCQgHY7o+v/1aJd66k2S57XW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651263; c=relaxed/simple;
	bh=vMZBXyvhJMOl4zotXu1s1K9lxjxFnuvxDMlO/rfX+QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1BgLr2clVxoB8LlGG71urfwVdnhxTJ5SFwM2kDpH6vXHrmiowcwLZKmvC+3671QsYADOsK2mOBJR4a/pHKzA0OtVmHhdN0ZusQuEztIK8a2Z0PQ5tf8uNPRN7446fIes0UL30PrwpyDdaiL7jx3uiJaryIu2yBbp9Y5GkOp1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+qlOTdg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+qlOTdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2C8C4CEFE;
	Thu, 16 Oct 2025 21:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760651262;
	bh=vMZBXyvhJMOl4zotXu1s1K9lxjxFnuvxDMlO/rfX+QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+qlOTdgbh5bDWacdbxWIvxw6RJWy/D5L1w66Mtd4fYbY5YrDn1kUo6D6N6ndZ57B
	 LzfhIvEjiCBhKQXavJWD6QyH5rqegkT9wcNcd+WA7I9rO/0tNgLGllgsVpBEjrKQnU
	 bUJELxc7JiCROnqZhnY7YsgM1rOUUV8AzlIM4KDI6g8JIUQnqhxICysj6/YU9YQeMq
	 jZ/BnJQ+O6XlDMxnGjRfwOfMNmOb/S1VYAUH5s1cR/CntZ9P30cpdpzpa5uu4C0d6T
	 HqOEh3YrLUxiXJDwRFQnhEwLfCST0fhvgGlekr1lwIN3rHE/Rew+CE2gzrd39Yjl6R
	 ujaCfXVAsVjsA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	bijan311@gmail.com,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/5] mm/damon/sysfs: implement obsolete_target file
Date: Thu, 16 Oct 2025 14:47:30 -0700
Message-ID: <20251016214736.84286-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016214736.84286-1-sj@kernel.org>
References: <20251016214736.84286-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no good way to remove DAMON targets in the middle of existing
targets list.  It restricts efficient and flexible DAMON use cases.
Improve the usability by implementing a new DAMON sysfs interface file,
namely obsolete_target, under each target directory.  It is connected to
the obsolete field of parameters commit source targets, so allows
removing arbitrary targets in the middle of existing targets list.

Note that the sysfs files are not automatically updated.  For example,
let's suppose there are three targets in the running context, and a user
removes the third target using this feature.  If the user writes
'commit' to the kdamond 'state' file again, DAMON sysfs interface will
again try to remove the third target.  But because there is no matching
target in the running context, the commit will fail.  It is the user's
responsibility to understand resulting DAMON internal targets list
change, and construct sysfs files (using nr_targets and other sysfs
files) to correctly represent it.

Also note that this is arguably an improvement rather than a fix of a
broken things.

Reported-by: Bijan Tabatabai <bijan311@gmail.com>
Closes: https://github.com/damonitor/damo/issues/36
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6848437b86af..26bc658ad873 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -212,6 +212,7 @@ struct damon_sysfs_target {
 	struct kobject kobj;
 	struct damon_sysfs_regions *regions;
 	int pid;
+	bool obsolete;
 };
 
 static struct damon_sysfs_target *damon_sysfs_target_alloc(void)
@@ -263,6 +264,29 @@ static ssize_t pid_target_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t obsolete_target_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_target *target = container_of(kobj,
+			struct damon_sysfs_target, kobj);
+
+	return sysfs_emit(buf, "%c\n", target->obsolete ? 'Y' : 'N');
+}
+
+static ssize_t obsolete_target_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_target *target = container_of(kobj,
+			struct damon_sysfs_target, kobj);
+	bool obsolete;
+	int err = kstrtobool(buf, &obsolete);
+
+	if (err)
+		return err;
+	target->obsolete = obsolete;
+	return count;
+}
+
 static void damon_sysfs_target_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_target, kobj));
@@ -271,8 +295,12 @@ static void damon_sysfs_target_release(struct kobject *kobj)
 static struct kobj_attribute damon_sysfs_target_pid_attr =
 		__ATTR_RW_MODE(pid_target, 0600);
 
+static struct kobj_attribute damon_sysfs_target_obsolete_attr =
+		__ATTR_RW_MODE(obsolete_target, 0600);
+
 static struct attribute *damon_sysfs_target_attrs[] = {
 	&damon_sysfs_target_pid_attr.attr,
+	&damon_sysfs_target_obsolete_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_target);
@@ -1574,6 +1602,7 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 			/* caller will destroy targets */
 			return -EINVAL;
 	}
+	t->obsolete = sys_target->obsolete;
 	return damon_sysfs_set_regions(t, sys_target->regions, ctx->min_sz_region);
 }
 
-- 
2.47.3

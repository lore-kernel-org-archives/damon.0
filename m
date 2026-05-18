Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEA43A3826;
	Mon, 18 May 2026 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147692; cv=none; b=Oml7wcsHOmotmqAwaQEim+ndtAqA00JxIigt/P6ir2Ta4gbQ4Orv6jfVl39mkENbMC0+v7tnUmUxn+10QkfauD1yfBOn2OJfGsOYpATuO7EHRq6s81edc8C4Kc/MmBackqwMAUW+3JSqUEbiHMBEgmusL+F0zt8q3dSreCl5bpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147692; c=relaxed/simple;
	bh=AGpRYvO9ZCNPMYMckm0cAjHmLCwWdiWl6GwH6dhHuCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L87Aj2ZcXjtvM+nSf5QFpQ7reP2P4sFuKvOGVDJ2r/KTJC7/daZUKZy3xn6Ss9XwJu607UXXpLuXEHSNtDKpNZ9CMVP4sLzaw9lOaqSSHDpDKp7BKGyUL6KIQEwfFkVdmM1f+d4y8lso/j1yWRhLJ98LuwphQ/11FOHnUQ9UFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7sLBbkI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7sLBbkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97959C2BCB7;
	Mon, 18 May 2026 23:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147692;
	bh=AGpRYvO9ZCNPMYMckm0cAjHmLCwWdiWl6GwH6dhHuCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7sLBbkIOm43qO3O7T09C0xNfgkehYwnbWLABepbu5er81+Uv0T6aeWgA7jvDoG22
	 xnmmPma69N0hJG/ABB7sZ9bDgoVFB0BH95HkfjudigdbF0FCMcKmbA66EiggkXzZ7/
	 Df8rXsPrHeWTBCh6E1AxZhsf2RyRXZKyxXF3p0PrE/VuAOhLd8Ukk+pWt3xdgWuj9P
	 +/mi+D1mKP2jA4Y6ed2tAlXJiAIdxKJaKbfFMGQXTdGO+NeUNpW2mrXiS1iPr+SG7i
	 +tVR1A5gWWw0xsquh2zJe5KiYi95zvnd6rPEscl0nIBGPhwh4gh35jXHCIS+pZFhru
	 CVt8gTD4Ugzeg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 24/28] mm/damon/sysfs: add filters/<F>/path file
Date: Mon, 18 May 2026 16:41:12 -0700
Message-ID: <20260518234119.97569-25-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new DAMON sysfs file for letting users setup the target
memory cgroup of the belonging memory cgroup attribute monitoring.  The
file is named 'path', located under the probe filter directory.  Users
can set the target memory cgroup by writing the path to the memory
cgroup from the cgroup mount point to the file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index eeb7fdd030cf0..0f6379caf4816 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -756,6 +756,7 @@ struct damon_sysfs_filter {
 	enum damon_filter_type type;
 	bool matching;
 	bool allow;
+	char *path;
 };
 
 static struct damon_sysfs_filter *damon_sysfs_filter_alloc(void)
@@ -774,6 +775,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_ANON,
 		.name = "anon",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_MEMCG,
+		.name = "memcg",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -862,11 +867,46 @@ static ssize_t allow_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t path_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+	int len;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	len = sysfs_emit(buf, "%s\n", filter->path ? filter->path : "");
+	mutex_unlock(&damon_sysfs_lock);
+	return len;
+}
+
+static ssize_t path_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+	char *path = kmalloc_objs(*path, size_add(count, 1));
+
+	if (!path)
+		return -ENOMEM;
+	strscpy(path, buf, size_add(count, 1));
+	if (!mutex_trylock(&damon_sysfs_lock)) {
+		kfree(path);
+		return -EBUSY;
+	}
+	kfree(filter->path);
+	filter->path = path;
+	mutex_unlock(&damon_sysfs_lock);
+	return count;
+}
+
 static void damon_sysfs_filter_release(struct kobject *kobj)
 {
 	struct damon_sysfs_filter *filter = container_of(kobj,
 			struct damon_sysfs_filter, kobj);
 
+	kfree(filter->path);
 	kfree(filter);
 }
 
@@ -879,10 +919,14 @@ static struct kobj_attribute damon_sysfs_filter_matching_attr =
 static struct kobj_attribute damon_sysfs_filter_allow_attr =
 		__ATTR_RW_MODE(allow, 0600);
 
+static struct kobj_attribute damon_sysfs_filter_path_attr =
+		__ATTR_RW_MODE(path, 0600);
+
 static struct attribute *damon_sysfs_filter_attrs[] = {
 	&damon_sysfs_filter_type_attr.attr,
 	&damon_sysfs_filter_matching_attr.attr,
 	&damon_sysfs_filter_allow_attr.attr,
+	&damon_sysfs_filter_path_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_filter);
-- 
2.47.3

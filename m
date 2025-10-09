Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870D2853EF;
	Thu,  9 Oct 2025 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044852; cv=none; b=kcLsCMo670SuLuqfwmBH4tY31l3IjRai8GY/lPQUh5D1LVrrPaWbNjCsz7K9uHLxW/x9fg8fIF7X1gTKa1epWDepsem0oEfhhN7jFm2o85cWRUjZfbAmVXjZyhkER88ennjmlPFiTi9P5FAoGH4VtuvPjQjx3kHJ7AoRbKnpMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044852; c=relaxed/simple;
	bh=lWuxWajqY0wRfIc7Y8gXn7A3jSIMXiwp/Agt3iLR4VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXhMGnkS9AsaqT8DY8me4ozzfbPK4kLeLRaBVkUgST8heVT0FpNKqoBl9I+d0w9ea00+R2BtdCZKm6trnMdgm86Y69WAmnveUk6NJxjyMDy7xxo1Vy71FSUZFkxkU+xkXypg3gGzuyAoq3NDkj2FIgX/7IuVrn+2+Pasvi73I88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4s7+kv8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4s7+kv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5466AC116B1;
	Thu,  9 Oct 2025 21:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760044852;
	bh=lWuxWajqY0wRfIc7Y8gXn7A3jSIMXiwp/Agt3iLR4VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4s7+kv8TSItrEO/33Tty5z6jdTawVF4XjHqmKPEv748eygzP5rt46knLZjDqjSNq
	 9CjXV+5I0EkFy+mj/YSUJ1pMEdbw3hbijefv3pyYfmQ2lRT/mKomhuGb7keuaOLVnG
	 gEZX/KgthWsRjb+91b3zKHQbCfi/3Z+rq1wwEmCZb2f/dMOjqwX8vDf8Lq7I1SbbBN
	 nr3kHS+RcLRNnx95v/Uq15OAQrK34oPCVAAPCdsnFpRUvHo/M9KaLWDJa2i9skPz7H
	 slvKE12ysSoF2MAoOeX3vv1bH4kFDtlw12H6lQkeoAUt6X4VN0ZPG5bXmSQfD0O83Y
	 I7RyBduEJ9g2g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 04/10] mm/damon/sysfs-schemes: implement path file under quota goal directory
Date: Thu,  9 Oct 2025 14:20:36 -0700
Message-Id: <20251009212042.60084-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009212042.60084-1-sj@kernel.org>
References: <20251009212042.60084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a DAMOS sysfs file for specifying the cgroup of the interest for
DAMOS_QUOTA_NODE_MEMCG_USED_BP.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6536f16006c9..2c440a2b80e6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -999,6 +999,7 @@ struct damos_sysfs_quota_goal {
 	unsigned long target_value;
 	unsigned long current_value;
 	int nid;
+	char *path;
 };
 
 static struct damos_sysfs_quota_goal *damos_sysfs_quota_goal_alloc(void)
@@ -1128,10 +1129,39 @@ static ssize_t nid_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t path_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj,
+			struct damos_sysfs_quota_goal, kobj);
+
+	return sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
+}
+
+static ssize_t path_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj,
+			struct damos_sysfs_quota_goal, kobj);
+	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
+				   GFP_KERNEL);
+
+	if (!path)
+		return -ENOMEM;
+
+	strscpy(path, buf, count + 1);
+	kfree(goal->path);
+	goal->path = path;
+	return count;
+}
+
 static void damos_sysfs_quota_goal_release(struct kobject *kobj)
 {
-	/* or, notify this release to the feed callback */
-	kfree(container_of(kobj, struct damos_sysfs_quota_goal, kobj));
+	struct damos_sysfs_quota_goal *goal = container_of(kobj,
+			struct damos_sysfs_quota_goal, kobj);
+
+	kfree(goal->path);
+	kfree(goal);
 }
 
 static struct kobj_attribute damos_sysfs_quota_goal_target_metric_attr =
@@ -1146,11 +1176,15 @@ static struct kobj_attribute damos_sysfs_quota_goal_current_value_attr =
 static struct kobj_attribute damos_sysfs_quota_goal_nid_attr =
 		__ATTR_RW_MODE(nid, 0600);
 
+static struct kobj_attribute damos_sysfs_quota_goal_path_attr =
+		__ATTR_RW_MODE(path, 0600);
+
 static struct attribute *damos_sysfs_quota_goal_attrs[] = {
 	&damos_sysfs_quota_goal_target_metric_attr.attr,
 	&damos_sysfs_quota_goal_target_value_attr.attr,
 	&damos_sysfs_quota_goal_current_value_attr.attr,
 	&damos_sysfs_quota_goal_nid_attr.attr,
+	&damos_sysfs_quota_goal_path_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damos_sysfs_quota_goal);
-- 
2.39.5

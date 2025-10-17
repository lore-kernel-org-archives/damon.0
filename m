Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC09332EA4;
	Fri, 17 Oct 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736435; cv=none; b=PVE6SaEwDHFKNdy74jtctXOP56TLdpJnc3dEJZXsBg1IWAwwdSWnyAVDiBKxGkGgX+JBgSHaDo+eaMdrIFUSfAZ+1bt4pIAfbjUult9k+NGIyiU6f2ZkzzNbfMYVnyIY+r09uKJ6q+VgdxnU2GqsRSVGked+QNpKXiWe3tX07Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736435; c=relaxed/simple;
	bh=hA+t8CYRK0aSyhr9UylseKV/5BFcvUF8pBgfXixXY6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvoJgyPBeGdldL06xRNYJtRoHWYh+B7zMJOm9Vjbs9i/cR/SqxXH76uf7CRt4NwiccuVPdJJembrozWDe+aXt+8zPizLgNkR5hOfc2xJT6YmVBF5URCIOC5qzhMPBBVIcIy9F/sCtiQNbmGuEnL+jnRcizDi0HepEIPHflLN6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVRtgB+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVRtgB+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF333C116D0;
	Fri, 17 Oct 2025 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760736434;
	bh=hA+t8CYRK0aSyhr9UylseKV/5BFcvUF8pBgfXixXY6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVRtgB+ZiN4XfZsXsPLqj8yZhnIbqlQOLd2cgR5NKUfC0oQjnbpwIZZ/sFpRaaNpU
	 ImLNc7urtvZEttLUPx5rz3Dpa1Pw9nHvgZpOcLRG2vvhY7wvE/qT7cZJtaxnDs2j6c
	 FvgP1ZCyGkp0N1tRP96OQU0qYNSMKbhlsHGR1/5UO69FgkP6oMQ1UrCGaJzWQUmX7a
	 7cqNMb7TcykikRA9VWs8l+7FjUXarRT6aPKAL3F9GldVQOZ4wJJvohn/WCi6s450qX
	 LNsNVSOv4+zFHPPWl6jcrnLq9WfGxK7E8zeHeqZeeH3YohIkanM3Oe59m3nvzlxm6H
	 gMd3pR4QJQkUA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/10] mm/damon/sysfs-schemes: implement path file under quota goal directory
Date: Fri, 17 Oct 2025 14:26:56 -0700
Message-ID: <20251017212706.183502-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017212706.183502-1-sj@kernel.org>
References: <20251017212706.183502-1-sj@kernel.org>
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
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170F1C84BC;
	Sun, 20 Apr 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745178039; cv=none; b=tmuncb9StfYYKKxZQC2zfMbvsxoeQkoSH9lY8DDEcXSE5C+EHgSYBdCRtNoHbKrI1ReVAcc5q7yJFOVbQfHP2jHOnXK7pasyqOy0FCuOvqMlQs1SWKc0BPfZyDq6LwuIM7Rc7S27/NGJZAVXqs/584uVgaZgaziFKuZarDJHh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745178039; c=relaxed/simple;
	bh=YrnSVlsWWaNU8yWNre3Ssi6/DIgFSJQgBiB+f6Xdzok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udkkX56NpAbDfczJOO1H4g8DBk+yX2gqIb1SlPPhsYF6awaBk2zYWwx16s/awLGsgA/sF/Nwn2OGy9lMxfFUfmS9grjLfCbChOpjJzEZuAZ80fs7AzwFuKF8OuOUfoY1k/5JMZnZ7mXeoemQNJTNxpBfB823jfnonIy1tLXPasE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXMItcxk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXMItcxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0EBC4CEE2;
	Sun, 20 Apr 2025 19:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745178038;
	bh=YrnSVlsWWaNU8yWNre3Ssi6/DIgFSJQgBiB+f6Xdzok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UXMItcxkOIFjk5OK458tYbEGtY1gX/42/4ZGXGr/wA5pulJ+2NH3vzZ8fdB7AM6Yp
	 MAHbz3qV6kUE2tUn6ArpWR5aWvRmINKHWe6pVRa3GIutCrLlVdH4Prymjqq7+zK4Pl
	 R/bk/60BHJ1AWa51BCXtw/CTSAQeKE4YXR3jGCbYIK+omzf2OVUs5a0s8zqwhnT5YX
	 ApVrrplK1q9jHQi5xP/MYdNK/zq5XNDf9BjzBJkhd2alTGghoWJCylsbn7WJI/GH0O
	 d6D8UBT6rrd1005l+BquSXGxpwq5/OHN0dS+HJmmetRPvM6YnsP34Ym4NnNr2uHPXQ
	 teATEL+h9kItA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/7] mm/damon/sysfs-schemes: implement file for quota goal nid parameter
Date: Sun, 20 Apr 2025 12:40:25 -0700
Message-Id: <20250420194030.75838-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250420194030.75838-1-sj@kernel.org>
References: <20250420194030.75838-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_QUOTA_NODE_MEM_{USED,FREE}_BP DAMOS quota goal metrics require the
node id parameter.  However, there is no DAMON user ABI for setting it.
Implement a DAMON sysfs file for that with name 'nid', under the quota
goal directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 98108f082178..7681ed293b62 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -936,6 +936,7 @@ struct damos_sysfs_quota_goal {
 	enum damos_quota_goal_metric metric;
 	unsigned long target_value;
 	unsigned long current_value;
+	int nid;
 };
 
 /* This should match with enum damos_action */
@@ -1016,6 +1017,28 @@ static ssize_t current_value_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t nid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
+			damos_sysfs_quota_goal, kobj);
+
+	/* todo: return error if the goal is not using nid */
+
+	return sysfs_emit(buf, "%d\n", goal->nid);
+}
+
+static ssize_t nid_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
+			damos_sysfs_quota_goal, kobj);
+	int err = kstrtoint(buf, 0, &goal->nid);
+
+	/* feed callback should check existence of this file and read value */
+	return err ? err : count;
+}
+
 static void damos_sysfs_quota_goal_release(struct kobject *kobj)
 {
 	/* or, notify this release to the feed callback */
@@ -1031,10 +1054,14 @@ static struct kobj_attribute damos_sysfs_quota_goal_target_value_attr =
 static struct kobj_attribute damos_sysfs_quota_goal_current_value_attr =
 		__ATTR_RW_MODE(current_value, 0600);
 
+static struct kobj_attribute damos_sysfs_quota_goal_nid_attr =
+		__ATTR_RW_MODE(nid, 0600);
+
 static struct attribute *damos_sysfs_quota_goal_attrs[] = {
 	&damos_sysfs_quota_goal_target_metric_attr.attr,
 	&damos_sysfs_quota_goal_target_value_attr.attr,
 	&damos_sysfs_quota_goal_current_value_attr.attr,
+	&damos_sysfs_quota_goal_nid_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damos_sysfs_quota_goal);
-- 
2.39.5

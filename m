Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697228EA5A;
	Thu, 19 Jun 2025 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370433; cv=none; b=kY7aGxchp+hdhxdU1O2jGYiqpIvH15tBUwc0OTs7UTwWM0ga3TKqVkR0QNUalZnaU+n14rambdYLMkbY65D7CIMNB8vWg8orzF+eKx9ghVA06zeWKGAtsvIo0nsf1yhQw1aEYIV+2er82lOz+7bWbmmvCEk9AEqtP543NS/S0dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370433; c=relaxed/simple;
	bh=Dun+8Vi/DMwdzvUNXFdqjk12wLALbq7Ec1njVivI7r4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HMtU/++21x/qrMnI2QlEY297+XsR6/TcLQX3TyuJOvfy6B04rlLccr7RQB4MdrjUISy++tlqfpaJSFL4AkLnxfxKhCWb5wX/Z1pe/b4eF3QXVHnw9uhpltiHmiSlKwcIUdvBs/rPB2nIGkCFim415Il7d+7kF5qqNIcYiwSAYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIoivf4C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIoivf4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324B1C4CEEA;
	Thu, 19 Jun 2025 22:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370433;
	bh=Dun+8Vi/DMwdzvUNXFdqjk12wLALbq7Ec1njVivI7r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIoivf4CwD93oxJWrX+WLG0p+JKxKkSR3kRkADy1Vt2JJFx/ckAkAVhXpV3Ck7etV
	 RNni5Ecb6a8u4kHzhNk3jCAAXdejXbJsBOgahClUzoydn0YhcqISFfDmL6EvUTap59
	 iQ0VCK8/Hbb8bOvvrSOb3pvwiTESRpBWTPYFon1ZM9o6kBTM/hiX9SEswXA3rNm5L7
	 n46tFb1fZcf8zposGXhAkZ3BALNJ3EhaqiACOdTduPB76TSPz2ndPjMJ/xpiYc0YT8
	 hNPw9wRoiQpOvigJ2LKdzPwafUKjCCjQvr/wuFOPiK6SM56Pw2ozcV/eELuyQ5fM3y
	 LEahb4wirpCYg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/11] mm/damon/sysfs-schemes: implement path file under quota goal directory
Date: Thu, 19 Jun 2025 15:00:16 -0700
Message-Id: <20250619220023.24023-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619220023.24023-1-sj@kernel.org>
References: <20250619220023.24023-1-sj@kernel.org>
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
index 4805761d9127..4a340baa72a4 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -999,6 +999,7 @@ struct damos_sysfs_quota_goal {
 	unsigned long target_value;
 	unsigned long current_value;
 	int nid;
+	char *path;
 };
 
 static struct damos_sysfs_quota_goal *damos_sysfs_quota_goal_alloc(void)
@@ -1132,10 +1133,39 @@ static ssize_t nid_store(struct kobject *kobj,
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
@@ -1150,11 +1180,15 @@ static struct kobj_attribute damos_sysfs_quota_goal_current_value_attr =
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

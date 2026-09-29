Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C73DA7FF;
	Tue, 29 Sep 2026 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668887; cv=none; b=H8U1s0gym4NGwqeRcc7FOowSJEs4blGIhAD+3tUfLZve5GLrxD4B+As4KgSwIMTy1Y5mVNq7j17fHqBTtD3YxGL7B6dVkufW4tXAy4fv45ioQig9OdvUuBAugEt76nblGrLzUTW47iDnKMjNFy4VA3j00/ptJAl9M9+ELs6yv28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668887; c=relaxed/simple;
	bh=c79D70eyw1T2juEsK4YQjmcQoXzAL9pxRWlhbxUlMFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlC85vigsAAYAY3aww1qLHfPWU04YQl8N0Inao59OmHljs5X85yxe5g9vtfRKt0NBEgMXLjNeU++hF9KgSWIwLksqm+Lg2+uLCEoq1Dq7VYFKYTqrRzwQCm8Pw4BdQDizZzzsdqwru/h8Ip50Lp6H5SWvqc98KkiXGDeuj41MDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbeWfGyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbeWfGyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD281F00893;
	Tue, 29 Sep 2026 08:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790668885;
	bh=Vdshcv/mUOg+wTQtdfCd8vXc9tZN4VpaqOf6VvBPPR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MbeWfGyyGVmf9Nwf+IvIw+7uPBJ5WZ3hZKD+wZS01OSH2JFpEdz2T/OjeifbJziMt
	 im7QZ0pbfZCGkC4b88De+PFnUHo/1CFrCDJLjv0ORG0zkjE7nAwykPsZUpv4N7Yt6y
	 n1HqT0OjZu45FJbHiaYVPjutqRavasHqfu++cDGfwM/icx2udQSYkj+gFIaFVWnXP/
	 mb/REndkaF+QmMry9REVASASgrN7NQV5dMrWVOIl9UX024koN5ytSxXG+nfMjTN4t7
	 RbS97UkPfSWJ3sfrDMZLSqfsQhyZqxNj4R678BaCIMhVD9LoSmIzLF3nAfrqILoUoX
	 SbTAbLhR2hH7w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] mm/damon/sysfs-schemes: support quota goal complement flag
Date: Tue, 29 Sep 2026 01:01:06 -0700
Message-ID: <20260929080113.41708-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929080113.41708-1-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new sysfs file, complement, under the quota goal directory.  It
works for setting and getting the quota goal metric complement flag
value.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 06af417bc9a2..8f083611741f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1220,6 +1220,7 @@ static const struct kobj_type damon_sysfs_watermarks_ktype = {
 struct damos_sysfs_quota_goal {
 	struct kobject kobj;
 	enum damos_quota_goal_metric metric;
+	bool complement;
 	unsigned long target_value;
 	unsigned long current_value;
 	int nid;
@@ -1316,6 +1317,30 @@ static ssize_t target_metric_store(struct kobject *kobj,
 	return -EINVAL;
 }
 
+static ssize_t complement_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj,
+			struct damos_sysfs_quota_goal, kobj);
+
+	return sysfs_emit(buf, "%c\n", goal->complement ? 'Y' : 'N');
+}
+
+static ssize_t complement_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj,
+			struct damos_sysfs_quota_goal, kobj);
+	bool complement;
+	int err = kstrtobool(buf, &complement);
+
+	if (err)
+		return err;
+
+	goal->complement = complement;
+	return count;
+}
+
 static ssize_t target_value_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -1424,6 +1449,9 @@ static void damos_sysfs_quota_goal_release(struct kobject *kobj)
 static struct kobj_attribute damos_sysfs_quota_goal_target_metric_attr =
 		__ATTR_RW_MODE(target_metric, 0600);
 
+static struct kobj_attribute damos_sysfs_quota_goal_complement_attr =
+		__ATTR_RW_MODE(complement, 0600);
+
 static struct kobj_attribute damos_sysfs_quota_goal_target_value_attr =
 		__ATTR_RW_MODE(target_value, 0600);
 
@@ -1438,6 +1466,7 @@ static struct kobj_attribute damos_sysfs_quota_goal_path_attr =
 
 static struct attribute *damos_sysfs_quota_goal_attrs[] = {
 	&damos_sysfs_quota_goal_target_metric_attr.attr,
+	&damos_sysfs_quota_goal_complement_attr.attr,
 	&damos_sysfs_quota_goal_target_value_attr.attr,
 	&damos_sysfs_quota_goal_current_value_attr.attr,
 	&damos_sysfs_quota_goal_nid_attr.attr,
@@ -2869,7 +2898,8 @@ static int damos_sysfs_add_quota_score(
 		if (!sysfs_goal->target_value)
 			continue;
 
-		goal = damos_new_quota_goal(sysfs_goal->metric, false,
+		goal = damos_new_quota_goal(sysfs_goal->metric,
+				sysfs_goal->complement,
 				sysfs_goal->target_value);
 		if (!goal)
 			return -ENOMEM;
-- 
2.47.3

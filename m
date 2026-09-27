Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9D3E7621;
	Sun, 27 Sep 2026 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510751; cv=none; b=CdqLyZWc/xWhmL4WhBM/oH0aLgaT+QOoE4BLacVUY95GX6pnpj7f/OFcuu2s2PO14JAhCLwZ+U/K6EdxgYJHwOWMUrYv/y9BMDj9/hmHgioKr0e7XP7pr5fEKJIw7AlleOKV9Q2chz375RpXMPbl4vxbIx6nuKOg5fjnqLMRnbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510751; c=relaxed/simple;
	bh=c79D70eyw1T2juEsK4YQjmcQoXzAL9pxRWlhbxUlMFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqTv693n0CrjO2LuWwN9HLGF6rWFOLQwQgQO17MbX/JOZ2FbvmQDzPTiHJ22aTarnnSiBSXrk4epe4+RrAOvglvHuK/Ucg6fg2dtXyAHUXzp96qawzhTHY+6swoA3o6JgHhYcfb6s0Qo9/9PORZWzi1qpABeF613LaJAsGcjX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B41n/2Un; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B41n/2Un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1876D1F0089A;
	Sun, 27 Sep 2026 12:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790510750;
	bh=Vdshcv/mUOg+wTQtdfCd8vXc9tZN4VpaqOf6VvBPPR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B41n/2Unc9a6Pk/lnd5/fPIKAtj2AbHv1bjkX/IBG1vWxEugiJwc+hUw1s0wvezH9
	 uc0XOKzYZk7hTBPKo3+yBBu3WeAmQhHFdxyXapVZDGI2dW8bI3ThrY9l6jYCatavKv
	 zhh9kRQ2jRKxtTPpnWRCd6jP3SGLLsmXA96ddiX/NZepA+quvotd/Jk3TAb5rX0e+J
	 z0laur6Y8B9KezX1cX5sHlaAsRczKQ8JIm6LfmMbo5XGWAQfgymAVwwbWs8htg60+E
	 YxLLh91uqMvUqlpf/bf8FC1fBNWoPRXmhrfpDtxkuxFpdUKdhq7b34VWohvCInYd9P
	 emUSMb+DclfTQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 3/7] mm/damon/sysfs-schemes: support quota goal complement flag
Date: Sun, 27 Sep 2026 05:05:27 -0700
Message-ID: <20260927120533.50484-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927120533.50484-1-sj@kernel.org>
References: <20260927120533.50484-1-sj@kernel.org>
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

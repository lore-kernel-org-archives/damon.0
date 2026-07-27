Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E53EAC6D;
	Mon, 27 Jul 2026 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163118; cv=none; b=AXymvOs+PVtpuP61t3INlT68RCp277RSjCPOToozAUvIWWpllOas81Fb5JoLZs9qQVZ8SeeK6iP3SMLCgzl2vPjT7ogLo9C3UbbtQe7Rs6wyKe54OYgAtAVw3tVHhBKkqppBUZKUZczOGI6ag9G5EsMahvvR1FAXEiCmvMc6C7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163118; c=relaxed/simple;
	bh=slLlLF97BMq7dlERWT4MQXLVDYzM6mK0Vg1QmTuirxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhWg/EO5OqWrmfXw4ZuEM67YQdx1x0DxG7DByZ+DX+KO5Io/zcPb4PEyKuDu4itq1cLxl/JPnt+G3QlLuDVIRZUb6bXUOYVeBGHRHbezUK4rZbGK0VqFjjLYWHpucR6/57wrdeUSYFsIaS8YNNzVnAKE/4irdLkspVIqaCzEC0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc5OoafC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc5OoafC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363151F000E9;
	Mon, 27 Jul 2026 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163116;
	bh=Tov/Fab7A1jZyZTBVWD58q3Qyx5bqxY7CJkvmEqGIwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kc5OoafC0HBnbwusF3F2tLjAjZIAQ617eir2LikWBQf7pkQFXdyQe8crPMT6XJfOZ
	 o7G47I6wrq0f4CqGxQkD9WmeqqbNPp2U5cLafYXEh6Q3HzcSHvMDKUM7cZ+2VvKjpv
	 9qtz3vEHbYtny70kMBiqG5zG9VdcjLe6/meVpnRcOY67hzF6a+Aq7TlRQXmKKGdPF3
	 B5kjWUwZyDQsjX3fHVmb/0FxuydLSKHZpvCfQztzNY1RTgm2XP9q19HBtcmd5RbkB/
	 a5enDuHVq2MVuC8xx3qECAj7G2WxV/YRsbl/Lb/zs6gw14ELGrFzudFWqci4Xh6xJY
	 +vBFaVaCzlOzQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 11/17] mm/damon/sysfs: create directories for nr_preps writes
Date: Mon, 27 Jul 2026 07:38:20 -0700
Message-ID: <20260727143829.86236-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement nr_preps write action to actually create subdirectories of the
number.  Each of the directory will be evolved to represent each probe
preparation action.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6d3ed80fb2eb1..2ec33280a7a83 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -750,12 +750,50 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * prep directory
+ */
+
+struct damon_sysfs_prep {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_prep *damon_sysfs_prep_alloc(void)
+{
+	struct damon_sysfs_prep *prep;
+
+	prep = kzalloc_obj(struct damon_sysfs_prep);
+	if (!prep)
+		return prep;
+	return prep;
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
+static struct attribute *damon_sysfs_prep_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_prep);
+
+static const struct kobj_type damon_sysfs_prep_ktype = {
+	.release = damon_sysfs_prep_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_prep_groups,
+};
+
 /*
  * preps directory
  */
 
 struct damon_sysfs_preps {
 	struct kobject kobj;
+	struct damon_sysfs_prep **preps_arr;
 	int nr;
 };
 
@@ -766,13 +804,53 @@ static struct damon_sysfs_preps *damon_sysfs_preps_alloc(void)
 
 static void damon_sysfs_preps_rm_dirs(struct damon_sysfs_preps *preps)
 {
+	struct damon_sysfs_prep **preps_arr = preps->preps_arr;
+	int i;
+
+	for (i = 0; i < preps->nr; i++) {
+		kobject_del(&preps_arr[i]->kobj);
+		kobject_put(&preps_arr[i]->kobj);
+	}
 	preps->nr = 0;
+	kfree(preps_arr);
+	preps->preps_arr = NULL;
 }
 
 static int damon_sysfs_preps_add_dirs(struct damon_sysfs_preps *preps,
 		int nr_preps)
 {
-	preps->nr = nr_preps;
+	struct damon_sysfs_prep **preps_arr, *prep;
+	int err, i;
+
+	damon_sysfs_preps_rm_dirs(preps);
+	if (!nr_preps)
+		return 0;
+
+	preps_arr = kmalloc_objs(*preps_arr, nr_preps,
+				   GFP_KERNEL | __GFP_NOWARN);
+	if (!preps_arr)
+		return -ENOMEM;
+	preps->preps_arr = preps_arr;
+
+	for (i = 0; i < nr_preps; i++) {
+		prep = damon_sysfs_prep_alloc();
+		if (!prep) {
+			damon_sysfs_preps_rm_dirs(preps);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&prep->kobj,
+				&damon_sysfs_prep_ktype, &preps->kobj, "%d",
+				i);
+		if (err) {
+			kobject_put(&prep->kobj);
+			damon_sysfs_preps_rm_dirs(preps);
+			return err;
+		}
+
+		preps_arr[i] = prep;
+		preps->nr++;
+	}
 	return 0;
 }
 
-- 
2.47.3

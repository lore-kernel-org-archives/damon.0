Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7DA3D5C06;
	Sun, 26 Jul 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087591; cv=none; b=YYiEHNdTwVK11j2PhxUv8x9Cq7yUCr9ZRe13HY4DAOj6/HkQfgNflKlZyv9rJLh5Sbz4z/PZQL/PpeWj9FvGJgmFsSLjemKxZjFyPh44NXHESFGsapLTZ50gq87c7YSJx3JBBX6odqNXl6weWMZMXx0/wcvxDirQltTrjj7dAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087591; c=relaxed/simple;
	bh=zdAg2XCzb2p7bPsFPClMEKJZ7f8fhRWAaAM4CWjSe9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdFAOi9KBqUL74CpHy/Yt/uTMYYUQcNnNanIQxNQWVgOuDzEZloLo52wEkilKoWX0r6ng4fapHMOVf3Od41+oVHLM+v/eZdnJOSL4TQ4xauFjBhg6fc0zRb86TkfFwuVlNqC42t/UMNDYRYXLh+rZmlcOAwM+JJ8yj9DBHxPkr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp/eznQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp/eznQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5621F00ACA;
	Sun, 26 Jul 2026 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087588;
	bh=uNousysqLsJ6fyRgDH4abbL4+a0evZY6zs4U/XKn18k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dp/eznQTbrGx4uFd+xaUjo2TbfYpwQM2fjrEwgtMB2kP7L5Y7u+wtzynAivlU4alJ
	 a0q4sDIX4AAHPiuiqyrJ/Tjf/hvz7VGjsFkk7LefcI4B1bWaYDTYoKtmByd4Xz02PH
	 dWkIEOXKlsD2HDHdIRfUpp4wznVDeX5aw2L9kWehx1M05NSfaiepVqxRi342mjturk
	 C8YVj1tKvJ0KzQjRX0xBOJaufz4k/aFeWZfGYz0hCA1FdtgrX5dCBTkcWXPy+YZvS4
	 h3UhzyqN7iBxdi+1NZCHRYPlM+hQ7IhFnBMeQhcT5qVMdg8hV/UHX09iVqNcwxtj3b
	 /RTzG7d/4moIg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 12/17] mm/damon/sysfs: create probe prep files for preps/nr file write
Date: Sun, 26 Jul 2026 10:39:28 -0700
Message-ID: <20260726173935.94046-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement preps/nr file write operation to really create the probe prep
directories and their files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e348c1feed1ad..f275a6f73eee1 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -759,6 +759,17 @@ struct damon_sysfs_prep {
 	enum damon_prep_action action;
 };
 
+static struct damon_sysfs_prep *damon_sysfs_prep_alloc(void)
+{
+	struct damon_sysfs_prep *prep;
+
+	prep = kzalloc_obj(struct damon_sysfs_prep);
+	if (!prep)
+		return prep;
+	prep->action = DAMON_PREP_SET_PGIDLE;
+	return prep;
+}
+
 struct damon_sysfs_prep_action_name {
 	enum damon_prep_action action;
 	char *name;
@@ -827,7 +838,7 @@ static struct attribute *damon_sysfs_prep_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_prep);
 
-const struct kobj_type damon_sysfs_prep_ktype = {
+static const struct kobj_type damon_sysfs_prep_ktype = {
 	.release = damon_sysfs_prep_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_prep_groups,
@@ -839,6 +850,7 @@ const struct kobj_type damon_sysfs_prep_ktype = {
 
 struct damon_sysfs_preps {
 	struct kobject kobj;
+	struct damon_sysfs_prep **preps_arr;
 	int nr;
 };
 
@@ -849,13 +861,53 @@ static struct damon_sysfs_preps *damon_sysfs_preps_alloc(void)
 
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

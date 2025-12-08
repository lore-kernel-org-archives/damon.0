Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E52131A808;
	Mon,  8 Dec 2025 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175418; cv=none; b=YXczHs09oC+bglNRCGBJigbybdsEOU68/4JWFISgKxsVvvSdxaNvS/RIj/ftp7v+btUTfo/SMLacxpv0jASoLdVJ0fwONFtZfdH4T1ZNVXBO8TbLXdso4q1F1job/WOe/nN5h0vHOD6e+DyR4yOHNANFG4PYH9NhyYMqNsZy5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175418; c=relaxed/simple;
	bh=R9m1eSl/V//tH4nv+68KXrctOAqXsKHuChO2fV0643Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XElzzI6kah4QJkypF0f+UtlT48iIBUKok7v8owBWA5n2OJAOoKZQsmvrcAXFFxaBbt851CeyM2kmVjfNt7yK4Lf4C4VmmjiGCxjgAqZuolbnYuut+Uh1qaIv9k4WOzWiv67LTLFB4uVEByeMb4DjTm321/o/UxZpwN1UdUy2L64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBamaiLI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBamaiLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7B3C4CEF1;
	Mon,  8 Dec 2025 06:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175417;
	bh=R9m1eSl/V//tH4nv+68KXrctOAqXsKHuChO2fV0643Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBamaiLINXILpgvGkgCQPbnTIHWtwp2rObqcA/i3cCRUkLuYOUTyDUBNU0lqHPqWJ
	 gVbtbaaGI3dPObeMnBCW58NnnqLc707Oiqa7T8R3biwJ9nF94DTs0P6XVf6hOPpLQF
	 l1+UpWH3GBSnC0/rp1YEGAABhen7ltyKK3nHuk42tlZDfVzhbzsIWfG1pTwjDTW3pK
	 gmRChhrcxN7V406wIiciL5N7BlFleI+z6LkmuU00RUgoAr8vXhBFf6XLE0I6VadldR
	 X+di5Q5FhDiFvn5zl+dLDLPKZDnzLSJRp0shJ6RhRJ02fowl7VGccZra1NDAEqaNg9
	 DCh5eL0wV/IPQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 19/37] mm/damon/sysfs: implement sample/filters/ directory
Date: Sun,  7 Dec 2025 22:29:23 -0800
Message-ID: <20251208062943.68824-20-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a directory for letting DAMON ABI users install and uninstall DAMON
sample filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 16d58cde03e8..4208fed2b8df 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -749,6 +749,36 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * access check report filters directory
+ */
+
+struct damon_sysfs_sample_filters {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_sample_filters *
+damon_sysfs_sample_filters_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_sample_filters), GFP_KERNEL);
+}
+
+static void damon_sysfs_sample_filters_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_sample_filters, kobj));
+}
+
+static struct attribute *damon_sysfs_sample_filters_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_sample_filters);
+
+static const struct kobj_type damon_sysfs_sample_filters_ktype = {
+	.release = damon_sysfs_sample_filters_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_sample_filters_groups,
+};
+
 /*
  * access check primitives directory
  */
@@ -854,6 +884,7 @@ static const struct kobj_type damon_sysfs_primitives_ktype = {
 struct damon_sysfs_sample {
 	struct kobject kobj;
 	struct damon_sysfs_primitives *primitives;
+	struct damon_sysfs_sample_filters *filters;
 };
 
 static struct damon_sysfs_sample *damon_sysfs_sample_alloc(void)
@@ -871,6 +902,7 @@ static int damon_sysfs_sample_add_dirs(
 		struct damon_sysfs_sample *sample)
 {
 	struct damon_sysfs_primitives *primitives;
+	struct damon_sysfs_sample_filters *filters;
 	int err;
 
 	primitives = damon_sysfs_primitives_alloc(true, false);
@@ -883,6 +915,19 @@ static int damon_sysfs_sample_add_dirs(
 		goto put_primitives_out;
 	sample->primitives = primitives;
 
+	filters = damon_sysfs_sample_filters_alloc();
+	if (!filters)
+		return -ENOMEM;
+	err = kobject_init_and_add(&filters->kobj,
+			&damon_sysfs_sample_filters_ktype, &sample->kobj,
+			"filters");
+	if (err)
+		goto put_filters_out;
+	sample->filters = filters;
+	return 0;
+put_filters_out:
+	kobject_put(&filters->kobj);
+	sample->filters = NULL;
 put_primitives_out:
 	kobject_put(&primitives->kobj);
 	sample->primitives = NULL;
@@ -894,6 +939,9 @@ static void damon_sysfs_sample_rm_dirs(
 {
 	if (sample->primitives)
 		kobject_put(&sample->primitives->kobj);
+	if (sample->filters) {
+		kobject_put(&sample->filters->kobj);
+	}
 }
 
 static void damon_sysfs_sample_release(struct kobject *kobj)
-- 
2.47.3

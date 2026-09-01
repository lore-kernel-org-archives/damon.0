Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42703BB674;
	Tue,  1 Sep 2026 04:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237270; cv=none; b=tCKnp4tH6lEmbK8gvdkB15dqCbJkm8ylX1So4XbxC3Nb8O2U3/OVjyTHC7vnH29rBrC3EcYlBhwcwP7ePxBl9NPz8MTYWBJ/0DpYQl4jP8OT+Lt4jjBEGwpmJGujBLksVQL9xvn4g4wWx2ubFa4qV6ttEX1xNpWr9P79ErCrSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237270; c=relaxed/simple;
	bh=ebZWA2+dSTUkV10/r9grEzALXwTLDvss2s7MOIuEXPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQ6c70P60XFusGCkbZ+rRQ2PWf/u5dxCV6sA3Xad9RYugJ6fd9SWJU93oFbPro7C6aKw7GoTv5PbxcWlVXU9iLVWxrq7J0GYQJ2fllmdery3THglCtKU2dKWvpotuEWpuz+X512gVAvlzwPRcEXQYCyvy0kBQW8G2HQBGwmaEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RINtRsVd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RINtRsVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AAD1F00ADB;
	Tue,  1 Sep 2026 04:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237268;
	bh=x4M/9i3il9+uoX/0hvXXuMXtTWxZNwDv4ttKnUbtHPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RINtRsVd9/foAQbOaBX56tC049v1kog7NgWy4abZ57p/Cz6znuQU9abXl/832moQa
	 zzi2wkXW8FdmHqtfEIg9QwbEvdRYvT1hikUJ+3klq4/koLO8CymNPi8Fb11scqQIUI
	 ffWBwrEFpGYnlWj59twjW3zAXjtCI2sG0HY8cha/S0wZS3yaiQ5v7d+27PfJOnsp1y
	 LAjK8kPYubg2vVOsgPTgeQx/rM5IZuSsNOc0mAN4oyuN1/k4ymAk945Ic3ZXf45PP8
	 PYjDmE3CuRHnExPOT0nGSLr9XVIP/OQtizTOoEY6dmrMZhvB72tSRh3kPu/VFgemRJ
	 rP8m9TB3mL63Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/17] mm/damon/sysfs: implement preps directory
Date: Mon, 31 Aug 2026 21:34:05 -0700
Message-ID: <20260901043417.2165-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901043417.2165-1-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a sysfs directory named 'preps' under the probe directory.  It
will be evolved to be used for specifying probe preps.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 65 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 3593bf9c7b7aa..09641257d3a89 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -749,6 +749,35 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * preps directory
+ */
+
+struct damon_sysfs_preps {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_preps *damon_sysfs_preps_alloc(void)
+{
+	return kzalloc_obj(struct damon_sysfs_preps);
+}
+
+static void damon_sysfs_preps_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_preps, kobj));
+}
+
+static struct attribute *damon_sysfs_preps_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_preps);
+
+static const struct kobj_type damon_sysfs_preps_ktype = {
+	.release = damon_sysfs_preps_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_preps_groups,
+};
+
 /*
  * filter directory
  */
@@ -1069,6 +1098,7 @@ static const struct kobj_type damon_sysfs_filters_ktype = {
 struct damon_sysfs_probe {
 	struct kobject kobj;
 	unsigned int weight;
+	struct damon_sysfs_preps *preps;
 	struct damon_sysfs_filters *filters;
 };
 
@@ -1079,25 +1109,48 @@ static struct damon_sysfs_probe *damon_sysfs_probe_alloc(void)
 
 static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *probe)
 {
+	struct damon_sysfs_preps *preps;
 	struct damon_sysfs_filters *filters;
 	int err;
 
-	filters = damon_sysfs_filters_alloc();
-	if (!filters)
+	preps = damon_sysfs_preps_alloc();
+	if (!preps)
 		return -ENOMEM;
+	probe->preps = preps;
+
+	err = kobject_init_and_add(&preps->kobj, &damon_sysfs_preps_ktype,
+			&probe->kobj, "preps");
+	if (err)
+		goto put_preps_out;
+
+	filters = damon_sysfs_filters_alloc();
+	if (!filters) {
+		err = -ENOMEM;
+		goto del_preps_out;
+	}
 	probe->filters = filters;
 
 	err = kobject_init_and_add(&filters->kobj, &damon_sysfs_filters_ktype,
 			&probe->kobj, "filters");
-	if (err) {
-		kobject_put(&filters->kobj);
-		probe->filters = NULL;
-	}
+	if (err)
+		goto put_filters_out;
+	return err;
+
+put_filters_out:
+	kobject_put(&filters->kobj);
+	probe->filters = NULL;
+del_preps_out:
+	kobject_del(&preps->kobj);
+put_preps_out:
+	kobject_put(&preps->kobj);
+	probe->preps = NULL;
 	return err;
 }
 
 static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *probe)
 {
+	if (probe->preps)
+		kobject_put(&probe->preps->kobj);
 	if (probe->filters) {
 		damon_sysfs_filters_rm_dirs(probe->filters);
 		kobject_put(&probe->filters->kobj);
-- 
2.47.3

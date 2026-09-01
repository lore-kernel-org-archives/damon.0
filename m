Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C7480DD2;
	Tue,  1 Sep 2026 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269120; cv=none; b=trtVOBpLJUdpOCy5ZZ1beVdjPhOmsONYMPcZ+YenTUG2zbI5/dncCwp/DJa0aOXdNRAQ8D6lWcemOAmpZ4LFkkpf0OtQZveHl53bpmQ/1/YkpbMFlJEkgg31Nay1gc8cVmx4u0qawCzwSh7sxX3Eso0h9q5MpJ/HnJKzu25wdds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269120; c=relaxed/simple;
	bh=ebZWA2+dSTUkV10/r9grEzALXwTLDvss2s7MOIuEXPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbNZPee0Sr5LjZEdc3IabaCgzadksPFcPDqNJ2k4LQpz6MbQ75jQ4vCuIDOhdi++4z7eaQRezaBgagYwjt1Fu/nGPbBLj7GdREeNsl6tOy6UKgMT8A1zs3JBfJY++4WlkgBezGp5G/s0hRP68HpJMRo3Z9zsN1iLZdJ28RP5l20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2/FGnLg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2/FGnLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58A61F00ACF;
	Tue,  1 Sep 2026 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269118;
	bh=x4M/9i3il9+uoX/0hvXXuMXtTWxZNwDv4ttKnUbtHPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n2/FGnLgDgXTvCYFjErpYKblPGIZZk4Ju9X7ymZOtgi264KCJLbw4odBjGDwwMOf5
	 0sGBvLV7uzFzTsVyj3aWTWT46keqxGfdpioiETdT//Iw48QHsCyITNoCLZd4Id9Dbv
	 usywHVX69XXYJXpcRrPVoRgX1dat7OIhbORjsuwPJz/D6qi4yrEVJ6zqoA7jNolN9T
	 YCcQcIiilwLSN5xXzc/dfKbrfNtH5E2EBExh5XJzXNYgkSTYyo3Z7CovAxYB3ynWzr
	 aOKZhvAx0g0xOrOYdrCgPrknX3DXw0Qh8XN46JqcJ7aO6qDCYqiLlRbS3pGvNsysLr
	 cRiI6E3yjzTOQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 09/17] mm/damon/sysfs: implement preps directory
Date: Tue,  1 Sep 2026 06:24:56 -0700
Message-ID: <20260901132506.99243-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901132506.99243-1-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
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

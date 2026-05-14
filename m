Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB340242C;
	Thu, 14 May 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767761; cv=none; b=Rxd/ZHSJ/2M58BchzbwfIeEx0QSkegaFSol7POWS9mvml7LF8XG4yVFPqOtrTKI/Up70ggxrsnUdZ+qyXKqJFfGyGlvJ4kgSN3Z0ilrqQ2+AMt9ygwFKA4kJRiUMpHwYRQgNr3tTSlcDPmgpeVRopOzcaSI05Zh2YxWtoNEWEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767761; c=relaxed/simple;
	bh=SZZB/8Y34d4c5OpPrN0Tt1+a+YDiqj7LFYZQ5Lka3iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhBRUuWWLosuIwd9zOzA529OdobjR6CZzCXnWnTbhuRqr5uIcJeHWecd6lCSopg3PaRqZVgONdddNWJjc3INktG4WBdVQ5CrkVk1Y7w9wYnUXflVwdXwtobZxfj8f9XX86MUlQiG8R7+T4lF4dynQzTjPsFePjPfwAEHvmUg/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpxTp9Gw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpxTp9Gw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D254C2BCB3;
	Thu, 14 May 2026 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767761;
	bh=SZZB/8Y34d4c5OpPrN0Tt1+a+YDiqj7LFYZQ5Lka3iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpxTp9Gw+l8Vl8rBZw4W+zQuKZ06VS+IOj7ZH1TMUCHyZIanKD/HwS/HkrcQ/t33/
	 sfdoqFcRr8elEGvTVOpLDLTxd7wmQYUEDLRzWanxkX3dxTF3Glo1Zum608QEz81meA
	 D++RreXMFH0Z09jFjdlJk2PL5Oz+DkyVA/lPT4mbDA3V7vTEST8QIdedYARCUc7K7O
	 UcUkDS4ms3weyKW3OyEL/veSXn00H0qGmNlkIO/PE/pH9YjwKmz0m1u3XLz3RdFEMm
	 0WaifBrCEJSTkZh4dpTISxjvtIIMZAoAIcVoEWp+QlS26K117My2LEKkJFIQkgxa/4
	 iv0vCKPveUiqQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 10/28] mm/damon/sysfs: implement probe dir
Date: Thu, 14 May 2026 07:08:43 -0700
Message-ID: <20260514140904.119781-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement sysfs directory for letting users install each data probe.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ccd19fc062f31..fac4e37aa2851 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -747,12 +747,43 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * probe directory
+ */
+
+struct damon_sysfs_probe {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_probe *damon_sysfs_probe_alloc(void)
+{
+	return kzalloc_obj(struct damon_sysfs_probe);
+}
+
+static void damon_sysfs_probe_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_probe, kobj));
+}
+
+static struct attribute *damon_sysfs_probe_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_probe);
+
+const struct kobj_type damon_sysfs_probe_ktype = {
+	.release = damon_sysfs_probe_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_probe_groups,
+};
+
 /*
  * probes directory
  */
 
 struct damon_sysfs_probes {
 	struct kobject kobj;
+	struct damon_sysfs_probe **probes_arr;
+	int nr;
 };
 
 static struct damon_sysfs_probes *damon_sysfs_probes_alloc(void)
@@ -760,12 +791,99 @@ static struct damon_sysfs_probes *damon_sysfs_probes_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_probes);
 }
 
+static void damon_sysfs_probes_rm_dirs(
+		struct damon_sysfs_probes *probes)
+{
+	struct damon_sysfs_probe **probes_arr = probes->probes_arr;
+	int i;
+
+	for (i = 0; i < probes->nr; i++)
+		kobject_put(&probes_arr[i]->kobj);
+	probes->nr = 0;
+	kfree(probes_arr);
+	probes->probes_arr = NULL;
+}
+
+static int damon_sysfs_probes_add_dirs(
+		struct damon_sysfs_probes *probes, int nr_probes)
+{
+	struct damon_sysfs_probe **probes_arr, *probe;
+	int err, i;
+
+	damon_sysfs_probes_rm_dirs(probes);
+	if (!nr_probes)
+		return 0;
+
+	probes_arr = kmalloc_objs(*probes_arr, nr_probes,
+				   GFP_KERNEL | __GFP_NOWARN);
+	if (!probes_arr)
+		return -ENOMEM;
+	probes->probes_arr = probes_arr;
+
+	for (i = 0; i < nr_probes; i++) {
+		probe = damon_sysfs_probe_alloc();
+		if (!probe) {
+			damon_sysfs_probes_rm_dirs(probes);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&probe->kobj,
+				&damon_sysfs_probe_ktype, &probes->kobj,
+				"%d", i);
+		if (err) {
+			kobject_put(&probe->kobj);
+			damon_sysfs_probes_rm_dirs(probes);
+			return err;
+		}
+
+		probes_arr[i] = probe;
+		probes->nr++;
+	}
+	return 0;
+}
+
+static ssize_t nr_probes_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_probes *probes = container_of(kobj,
+			struct damon_sysfs_probes, kobj);
+
+	return sysfs_emit(buf, "%d\n", probes->nr);
+}
+
+static ssize_t nr_probes_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_probes *probes;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0 || nr > DAMON_MAX_PROBES)
+		return -EINVAL;
+
+	probes = container_of(kobj, struct damon_sysfs_probes, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_probes_add_dirs(probes, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
 static void damon_sysfs_probes_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_probes, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_probes_nr_probes =
+		__ATTR_RW_MODE(nr_probes, 0600);
+
 static struct attribute *damon_sysfs_probes_attrs[] = {
+	&damon_sysfs_probes_nr_probes.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_probes);
@@ -862,6 +980,7 @@ static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
 	kobject_put(&attrs->nr_regions_range->kobj);
 	damon_sysfs_intervals_rm_dirs(attrs->intervals);
 	kobject_put(&attrs->intervals->kobj);
+	damon_sysfs_probes_rm_dirs(attrs->probes);
 	kobject_put(&attrs->probes->kobj);
 }
 
-- 
2.47.3

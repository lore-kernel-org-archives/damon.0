Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A89E555;
	Fri, 15 May 2026 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805891; cv=none; b=aRchhvE3dhtbcEtW02fhqoaAPE8aM9sKvEYPd0fVciPhrXsb//yi4PZOc26XZpT47ZpnyGJ9Y7Pfa4sBTEvigzLSbSsy4cumHiDi1stRiETl3dO7CvuOcEaUJfA80IzAD2LPSP859ve+rYB54mWYQRcBQxRLTnbui+bzN2BHIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805891; c=relaxed/simple;
	bh=R8sw7cd3IqpXiTp+P06ij8H6WLOiT1rj6PEiqecHRpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+QtoOddmVK9vi0wxOJoKNJXcqx6ZaD8+9qPrKpCMKLfNkwIBbCZLRbYwql/VYP0m4tSlmiiault0XTcLtdCqs2rliqUf00gOKhTDHsyr8RErfcxa+AmMSIbGrWLyjgy3ZwgkWb/z3CxWvqBQ87gEGpV2qsLenK0pRsmoZKM3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkj++EYu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkj++EYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F6FC2BCF5;
	Fri, 15 May 2026 00:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805890;
	bh=R8sw7cd3IqpXiTp+P06ij8H6WLOiT1rj6PEiqecHRpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkj++EYumGm7QpLo9MUXQqAklmyNkKzq6wQNzFE/Ka0cCt/LHT0LM2+EG+KHnZ/Si
	 OYvymtS01FBY3rMx0tSOVwgxs0CJOJL0e/hk+TmAZDg/0vdqJ6cpioG4uZrrEmqnqQ
	 zmBN68KF1RtSE3TCv8iD3drYf7As4v587QaZGAKxD1pjSaUHOsvvZusUY/StWSfEPr
	 OR0JxnMkS63jozC4CkTfbnwDcxJPG8qIs6a7Ayp4SjoDkLkINfuJWAyrI/xQQoBOhH
	 muaTTGsVNtCwqqZiIQDhW3TNdbWDwJ9PklqyONceV0WdFhIlf6pCksEdCH0TiU6XRt
	 t6pmySXni8JGg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 10/28] mm/damon/sysfs: implement probe dir
Date: Thu, 14 May 2026 17:44:11 -0700
Message-ID: <20260515004433.128933-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
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
index 5f3b253f50ebf..c028e4b1281e6 100644
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

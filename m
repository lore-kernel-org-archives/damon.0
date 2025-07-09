Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF101865FA
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022830; cv=none; b=BLLc52Jw42eFwzWy+bP1NisFvRjYYe/IZYccA912ofztH/IEWxcfk2czWgV78WhR6aef5HDXOmNYlwiv4cTu+9ooBHhDp3OgOrRGuQneHaph1Liu1xj2I/1GSuz4fp4qpo9spltpmVS+Cz/nMg0tu5Ig1+TjDtLy39CaxnUKp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022830; c=relaxed/simple;
	bh=eF/H/z2pYqktDTEJ23uY4F7DAK6ZaD5jret1tgIuUMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFTwuo1iXB/nN/oIVjtMlNoro7Kic5gY0pAqXuKJU8YRe5E562XcQqgyjeTeFPbCYVvGXJgeukIxmmWNz9uvWJwCwftwAL3il4gB4+znyXnTchKk5yaThwZss92+SDi4AFsWDDyQ06lP8aJvyLn4RKxGz353Zdbv1r0LAZDqKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAGzhDdY; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAGzhDdY"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8600c87293so3882398276.1
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022827; x=1752627627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwKG6sHtooB+0pjFJ6ZV0sLHha49Q9YzgcCRLM4NWHU=;
        b=cAGzhDdYiL8Ke5Cbw86+Ag1xP4/PvnKiow6TyCgfVdYPQl65Q/RiyiP/o5RZ7PyRDQ
         vc/Cdo9xmvDasI8pFQ33V7dcSBm+xk71DySsRjAjyg2IRimQy1kuBj+TLf7na0hhHm2o
         ioak72bF/ydGFzMUpXm4pd40nnj5KicHJir+jTJliis+wRNqDWKyJkjtDpxfLgm/FVDV
         U6HVfnqN2AiGSjE6x/PlVhw81y7IuVqaWvqOICIqNyq67ZRfI8/h6SuJOc24kD7i1TgR
         UoLPOC2ASzTNdKmDEk979YTf5ll+09s3tAhgicqkIidiSbZOMOPzYeNgkrn+SbjoxMFD
         /YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022827; x=1752627627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwKG6sHtooB+0pjFJ6ZV0sLHha49Q9YzgcCRLM4NWHU=;
        b=ZR8n9OVcje43qOlCLLVHfwt8H3W/Pyze1A2dzKgXK9kRSI6zV8pLEomF71ODH08Z1m
         Y/vNduyVQOGO9EI+dp7WqtJVJmH0QMYmVFpJloDVMngk3+ZLlBkCBXTzVnI07+2YQruZ
         ITQbPCu/6F1IGHV45dKeSKqzurvNOWymvA9aD0VTbVy7WPDDeSYegbTS3zj4yx9weSTQ
         ek6kuLS3sDSZoM42OybT6i/96Y90+lBCD6LRMvl2MqJsO/jFj3i7PHjKDVP0ndACp/2g
         XymWE7Kb16XF8A9DKzslmc9pK2HlK6pxEjqSI79h4GYvHAWDmpB3hlW6HCzlfN+7xV8h
         UmBA==
X-Gm-Message-State: AOJu0YytqkXN8dvUH4NHuM40buDVoF9LylG633vJz30P4SjBAU45293K
	ObIsbhTryhr4arHKeKS8R9tm6nCgsscnnKOt37APlJQ/JlaWJkaYxS5vshyrsfVEc9Q=
X-Gm-Gg: ASbGnctwQbpyri4eXMqgm4wjCfLjKdDmqwW/WA/8Jtde+fXogOUyDciiKzMPf8ags/z
	+5i9/KTFxHKRmJ90YBzNsYmEdVu6p9Kil+s+Ydc7s8Ne1x5NygZmkSHbuurd9BqjHcA9Mj7wcAW
	nppSbe+Ew84NQsDfuHj5zOEofhvAj1+OwRN/gplDZY/xc5gabK7TGU4icAdWJxCaLkB1WH4xYUg
	5KnEFfSgd986xVAT6C3/jfZHUV96cViVDM2ehbkmGiBL4nziRE+s2neXCSc6+3R/8Jc40KykPsR
	uiLXu/fgi97ZrBAEEyk61mNNNMZIMc+55GRwbmwtvxtk5990UQQ8JfRIl1a4aMBJRTY6swzuYli
	z2/n037ZCsvtnng4HrQ==
X-Google-Smtp-Source: AGHT+IGeQ1u4AoGhlYo8kgmCKQenafouUCLlNX4fxfebzGsC3hfoSv6y546S9TcBswJHKfgNZJfd/Q==
X-Received: by 2002:a05:6902:6b0a:b0:e8b:411a:64a8 with SMTP id 3f1490d57ef6-e8b6e14faaamr725647276.24.1752022827080;
        Tue, 08 Jul 2025 18:00:27 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:26 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com
Subject: [PATCH v4 03/13] mm/damon/sysfs-schemes: implement DAMOS action destinations directory
Date: Tue,  8 Jul 2025 19:59:33 -0500
Message-ID: <20250709005952.17776-4-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

DAMOS_MIGRATE_{HOT,COLD} can have multiple action destinations and their
weights.  Implement sysfs directory named 'dests' under each scheme
directory to let DAMON sysfs ABI users utilize the feature.  The
interface is similar to other multiple parameters directory like
kdamonds or filters.  The directory contains only nr_dests file
initially.  Writing a number of desired destinations to nr_dests creates
directories of the number.  Each of the created directories has two
files named id and weight.  Users can then write the destination's
identifier (node id in case of DAMOS_MIGRATE_*) and weight to the files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 225 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 224 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 601360e9b521..b9434cdaacdc 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1655,6 +1655,204 @@ static const struct kobj_type damon_sysfs_access_pattern_ktype = {
 	.default_groups = damon_sysfs_access_pattern_groups,
 };
 
+/*
+ * dest (action destination) directory
+ */
+
+struct damos_sysfs_dest {
+	struct kobject kobj;
+	unsigned int id;
+	unsigned int weight;
+};
+
+static struct damos_sysfs_dest *damos_sysfs_dest_alloc(void)
+{
+	return kzalloc(sizeof(struct damos_sysfs_dest), GFP_KERNEL);
+}
+
+static ssize_t id_show(
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_dest *dest = container_of(kobj,
+			struct damos_sysfs_dest, kobj);
+
+	return sysfs_emit(buf, "%u\n", dest->id);
+}
+
+static ssize_t id_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_dest *dest = container_of(kobj,
+			struct damos_sysfs_dest, kobj);
+	int err = kstrtouint(buf, 0, &dest->id);
+
+	return err ? err : count;
+}
+
+static ssize_t weight_show(
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_dest *dest = container_of(kobj,
+			struct damos_sysfs_dest, kobj);
+
+	return sysfs_emit(buf, "%u\n", dest->weight);
+}
+
+static ssize_t weight_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_dest *dest = container_of(kobj,
+			struct damos_sysfs_dest, kobj);
+	int err = kstrtouint(buf, 0, &dest->weight);
+
+	return err ? err : count;
+}
+
+static void damos_sysfs_dest_release(struct kobject *kobj)
+{
+	struct damos_sysfs_dest *dest = container_of(kobj,
+			struct damos_sysfs_dest, kobj);
+	kfree(dest);
+}
+
+static struct kobj_attribute damos_sysfs_dest_id_attr =
+		__ATTR_RW_MODE(id, 0600);
+
+static struct kobj_attribute damos_sysfs_dest_weight_attr =
+		__ATTR_RW_MODE(weight, 0600);
+
+static struct attribute *damos_sysfs_dest_attrs[] = {
+	&damos_sysfs_dest_id_attr.attr,
+	&damos_sysfs_dest_weight_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damos_sysfs_dest);
+
+static const struct kobj_type damos_sysfs_dest_ktype = {
+	.release = damos_sysfs_dest_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damos_sysfs_dest_groups,
+};
+
+/*
+ * dests (action destinations) directory
+ */
+
+struct damos_sysfs_dests {
+	struct kobject kobj;
+	struct damos_sysfs_dest **dests_arr;
+	int nr;
+};
+
+static struct damos_sysfs_dests *
+damos_sysfs_dests_alloc(void)
+{
+	return kzalloc(sizeof(struct damos_sysfs_dests), GFP_KERNEL);
+}
+
+static void damos_sysfs_dests_rm_dirs(
+		struct damos_sysfs_dests *dests)
+{
+	struct damos_sysfs_dest **dests_arr = dests->dests_arr;
+	int i;
+
+	for (i = 0; i < dests->nr; i++)
+		kobject_put(&dests_arr[i]->kobj);
+	dests->nr = 0;
+	kfree(dests_arr);
+	dests->dests_arr = NULL;
+}
+
+static int damos_sysfs_dests_add_dirs(
+		struct damos_sysfs_dests *dests, int nr_dests)
+{
+	struct damos_sysfs_dest **dests_arr, *dest;
+	int err, i;
+
+	damos_sysfs_dests_rm_dirs(dests);
+	if (!nr_dests)
+		return 0;
+
+	dests_arr = kmalloc_array(nr_dests, sizeof(*dests_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!dests_arr)
+		return -ENOMEM;
+	dests->dests_arr = dests_arr;
+
+	for (i = 0; i < nr_dests; i++) {
+		dest = damos_sysfs_dest_alloc();
+		if (!dest) {
+			damos_sysfs_dests_rm_dirs(dests);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&dest->kobj,
+				&damos_sysfs_dest_ktype,
+				&dests->kobj, "%d", i);
+		if (err) {
+			kobject_put(&dest->kobj);
+			damos_sysfs_dests_rm_dirs(dests);
+			return err;
+		}
+
+		dests_arr[i] = dest;
+		dests->nr++;
+	}
+	return 0;
+}
+
+static ssize_t nr_dests_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_dests *dests = container_of(kobj,
+			struct damos_sysfs_dests, kobj);
+
+	return sysfs_emit(buf, "%d\n", dests->nr);
+}
+
+static ssize_t nr_dests_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_dests *dests;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	dests = container_of(kobj, struct damos_sysfs_dests, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damos_sysfs_dests_add_dirs(dests, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damos_sysfs_dests_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damos_sysfs_dests, kobj));
+}
+
+static struct kobj_attribute damos_sysfs_dests_nr_attr =
+		__ATTR_RW_MODE(nr_dests, 0600);
+
+static struct attribute *damos_sysfs_dests_attrs[] = {
+	&damos_sysfs_dests_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damos_sysfs_dests);
+
+static const struct kobj_type damos_sysfs_dests_ktype = {
+	.release = damos_sysfs_dests_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damos_sysfs_dests_groups,
+};
+
 /*
  * scheme directory
  */
@@ -1672,6 +1870,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_stats *stats;
 	struct damon_sysfs_scheme_regions *tried_regions;
 	int target_nid;
+	struct damos_sysfs_dests *dests;
 };
 
 struct damos_sysfs_action_name {
@@ -1762,6 +1961,22 @@ static int damon_sysfs_scheme_set_access_pattern(
 	return err;
 }
 
+static int damos_sysfs_set_dests(struct damon_sysfs_scheme *scheme)
+{
+	struct damos_sysfs_dests *dests = damos_sysfs_dests_alloc();
+	int err;
+
+	if (!dests)
+		return -ENOMEM;
+	err = kobject_init_and_add(&dests->kobj, &damos_sysfs_dests_ktype,
+			&scheme->kobj, "dests");
+	if (err)
+		kobject_put(&dests->kobj);
+	else
+		scheme->dests = dests;
+	return err;
+}
+
 static int damon_sysfs_scheme_set_quotas(struct damon_sysfs_scheme *scheme)
 {
 	struct damon_sysfs_quotas *quotas = damon_sysfs_quotas_alloc();
@@ -1894,9 +2109,12 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	err = damon_sysfs_scheme_set_access_pattern(scheme);
 	if (err)
 		return err;
-	err = damon_sysfs_scheme_set_quotas(scheme);
+	err = damos_sysfs_set_dests(scheme);
 	if (err)
 		goto put_access_pattern_out;
+	err = damon_sysfs_scheme_set_quotas(scheme);
+	if (err)
+		goto put_dests_out;
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
 		goto put_quotas_access_pattern_out;
@@ -1927,6 +2145,9 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_quotas_access_pattern_out:
 	kobject_put(&scheme->quotas->kobj);
 	scheme->quotas = NULL;
+put_dests_out:
+	kobject_put(&scheme->dests->kobj);
+	scheme->dests = NULL;
 put_access_pattern_out:
 	kobject_put(&scheme->access_pattern->kobj);
 	scheme->access_pattern = NULL;
@@ -1937,6 +2158,8 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 {
 	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
 	kobject_put(&scheme->access_pattern->kobj);
+	kobject_put(&scheme->dests->kobj);
+	damos_sysfs_dests_rm_dirs(scheme->dests);
 	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	kobject_put(&scheme->watermarks->kobj);
-- 
2.43.0


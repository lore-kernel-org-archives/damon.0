Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D331984D;
	Mon,  8 Dec 2025 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175401; cv=none; b=KjN7UDslZ2nWLDGM32bJ8PfgnvEdv2o0e2zQg8G6D4ShjwXn6SKmq4f1WEPpqbEyYjR7GpsJZ8lWc34pY7Y9pkU0osDYHW0rlpNvRUfalAokFVYGivnmUKVxzOepbLRXKIkY02R791O46ceSbQ43GejT/yiao45QwRMboKBJdRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175401; c=relaxed/simple;
	bh=PIidHNr/VkcFOE2gAHJhxadKF2Da7aKAwZ3oDyJGFRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzQ2cS8Z0Zkpy7kk6CN8xqjBdmudBNH0T4/sjhiBbVGon9Mp6sZ01TXQ/VPZScJ9SywDoR5YnThTSK6V2cL5gC2sxlzQTWuxZei7dEK7A9u5dqytqO7PtLt3/O1UDY270Xt9RD2N1bu+BLhQt+zEmtmmC/KtlCWfRz2U9Kvek70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuqerH5f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuqerH5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF121C116B1;
	Mon,  8 Dec 2025 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175400;
	bh=PIidHNr/VkcFOE2gAHJhxadKF2Da7aKAwZ3oDyJGFRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IuqerH5fST4Q0MUSx48O3pCSTGmeM3CXG4UcARZdiFmwDCgxJavXxf9W6niH2Szya
	 a8KPStk1sjhHmlrO0kQVZDKgYRHZunmYcAQWbHNDyJbQfm8/u19camQsfCvZ3afmI2
	 VrqZrkoV3ZACOyz6cJPSEsg5la75dOzdubY1oPlXdVew1BCuKgAdMScP21JtOPSr0N
	 OxSlhXvLB/ArTSA2EzEKEsYmYQRCCWcgDb0CK4mGC75BdfG2LCR4irNdou/5NyIP1m
	 jSj6M2gUsqa/dgoV7MF6rACA1e/d6T7wbVuf9GYDowCI9c56sNUNWf5U9yoZiW5/nV
	 YNhgaPPwSUMwg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 08/37] mm/damon/sysfs: implement monitoring_attrs/sample/ dir
Date: Sun,  7 Dec 2025 22:29:12 -0800
Message-ID: <20251208062943.68824-9-sj@kernel.org>
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

Add a sysfs directory for letting DAMON ABI users control what access
sampling primitives to use, among page table Accessed bit and page fault
events.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e2bd2d7becdd..851e8c0dc989 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -749,6 +749,41 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * sample directory
+ */
+
+struct damon_sysfs_sample {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_sample *damon_sysfs_sample_alloc(void)
+{
+	struct damon_sysfs_sample *sample = kmalloc(
+			sizeof(*sample), GFP_KERNEL);
+
+	if (!sample)
+		return NULL;
+	sample->kobj = (struct kobject){};
+	return sample;
+}
+
+static void damon_sysfs_sample_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_sample, kobj));
+}
+
+static struct attribute *damon_sysfs_sample_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_sample);
+
+static const struct kobj_type damon_sysfs_sample_ktype = {
+	.release = damon_sysfs_sample_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_sample_groups,
+};
+
 /*
  * monitoring_attrs directory
  */
@@ -757,6 +792,7 @@ struct damon_sysfs_attrs {
 	struct kobject kobj;
 	struct damon_sysfs_intervals *intervals;
 	struct damon_sysfs_ul_range *nr_regions_range;
+	struct damon_sysfs_sample *sample;
 };
 
 static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
@@ -773,6 +809,7 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 {
 	struct damon_sysfs_intervals *intervals;
 	struct damon_sysfs_ul_range *nr_regions_range;
+	struct damon_sysfs_sample *sample;
 	int err;
 
 	intervals = damon_sysfs_intervals_alloc(5000, 100000, 60000000);
@@ -801,8 +838,23 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 	if (err)
 		goto put_nr_regions_intervals_out;
 	attrs->nr_regions_range = nr_regions_range;
+
+	sample = damon_sysfs_sample_alloc();
+	if (!sample) {
+		err = -ENOMEM;
+		goto put_nr_regions_intervals_out;
+	}
+	err = kobject_init_and_add(&sample->kobj,
+			&damon_sysfs_sample_ktype, &attrs->kobj,
+			"sample");
+	if (err)
+		goto put_sample_out;
+	attrs->sample = sample;
 	return 0;
 
+put_sample_out:
+	kobject_put(&sample->kobj);
+	attrs->sample = NULL;
 put_nr_regions_intervals_out:
 	kobject_put(&nr_regions_range->kobj);
 	attrs->nr_regions_range = NULL;
@@ -817,6 +869,7 @@ static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
 	kobject_put(&attrs->nr_regions_range->kobj);
 	damon_sysfs_intervals_rm_dirs(attrs->intervals);
 	kobject_put(&attrs->intervals->kobj);
+	kobject_put(&attrs->sample->kobj);
 }
 
 static void damon_sysfs_attrs_release(struct kobject *kobj)
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB943FB040;
	Thu, 14 May 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767761; cv=none; b=oJgqngi00qR/IpqhH+3qtbUFzz4P4YktlcpNJpbegKtkUYt9+SridRaxXKLj4RNBvKg4rsAXzSYqSTCAiCJSwoim+rLO7dhVKYQK+3JqPIiinenTJ86NtEmlLO62c/1jWLjDrNcwdC+PE4s6/Xgqg2aBGy649DUdvEMuMjHmAmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767761; c=relaxed/simple;
	bh=MsWu2zyYAy4V2rgxAX8KgVIMloArlsZthg7SEALRXSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwbdGD+TMEAoVRIT1Wq2QctaslTLDNMQGxgukCmsjpxg132JdVvU/F8FtM80CXfkc32FLjOb0y9LVQY6zxLu2RIueyh8TVSmSe1j56meT9Ee+810p8RqAJnvGTP3x5N5g9HXyxOpUYCIRuthDxDl2s0AZ2Io0qGftEy6Y0e54w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sjf5pZe0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjf5pZe0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB21C2BCFA;
	Thu, 14 May 2026 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767761;
	bh=MsWu2zyYAy4V2rgxAX8KgVIMloArlsZthg7SEALRXSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sjf5pZe0cBh5aXrpjcORrXx6Zd8i8sFTWDQPNJeNj9Px/IoUTwdOzDRKar3U+wdBJ
	 14QVa7N8/vbm0uaB/PfvoMQxKgLOPhvcltWO/eftrGRi9cAp5d78xjj1UuQ8q6sJw5
	 R4+utRwuGK64K6aEaYxMnIkLbevWyeW7lGqldzFoZwgVlrgiEIXJub/XGQ4zn8t0Mc
	 4sNjlU418Q6tfjcAjPDEbzmpgmTQxvwbpyvTzl9wBefL9406dqwDLO4fwVufI4AVWZ
	 2V/XxZ8zMp19QiFp4elOPhc93T9VaR6Xvfu/m2MBCJdzPf5S9ycDTJccgItNvHoks9
	 nIIayvn7bjv8g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 09/28] mm/damon/sysfs: implement probes dir
Date: Thu, 14 May 2026 07:08:42 -0700
Message-ID: <20260514140904.119781-10-sj@kernel.org>
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

Implement sysfs directory that can be used by the users to install data
probes.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index d5863cc33d230..ccd19fc062f31 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -747,6 +747,35 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * probes directory
+ */
+
+struct damon_sysfs_probes {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_probes *damon_sysfs_probes_alloc(void)
+{
+	return kzalloc_obj(struct damon_sysfs_probes);
+}
+
+static void damon_sysfs_probes_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_probes, kobj));
+}
+
+static struct attribute *damon_sysfs_probes_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_probes);
+
+static const struct kobj_type damon_sysfs_probes_ktype = {
+	.release = damon_sysfs_probes_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_probes_groups,
+};
+
 /*
  * monitoring_attrs directory
  */
@@ -755,6 +784,7 @@ struct damon_sysfs_attrs {
 	struct kobject kobj;
 	struct damon_sysfs_intervals *intervals;
 	struct damon_sysfs_ul_range *nr_regions_range;
+	struct damon_sysfs_probes *probes;
 };
 
 static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
@@ -771,6 +801,7 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 {
 	struct damon_sysfs_intervals *intervals;
 	struct damon_sysfs_ul_range *nr_regions_range;
+	struct damon_sysfs_probes *probes;
 	int err;
 
 	intervals = damon_sysfs_intervals_alloc(5000, 100000, 60000000);
@@ -799,8 +830,22 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 	if (err)
 		goto put_nr_regions_intervals_out;
 	attrs->nr_regions_range = nr_regions_range;
+
+	probes = damon_sysfs_probes_alloc();
+	if (!probes) {
+		err = -ENOMEM;
+		goto put_nr_regions_intervals_out;
+	}
+	err = kobject_init_and_add(&probes->kobj,
+			&damon_sysfs_probes_ktype, &attrs->kobj, "probes");
+	if (err)
+		goto put_probes_out;
+	attrs->probes = probes;
 	return 0;
 
+put_probes_out:
+	kobject_put(&probes->kobj);
+	attrs->probes = NULL;
 put_nr_regions_intervals_out:
 	kobject_put(&nr_regions_range->kobj);
 	attrs->nr_regions_range = NULL;
@@ -817,6 +862,7 @@ static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
 	kobject_put(&attrs->nr_regions_range->kobj);
 	damon_sysfs_intervals_rm_dirs(attrs->intervals);
 	kobject_put(&attrs->intervals->kobj);
+	kobject_put(&attrs->probes->kobj);
 }
 
 static void damon_sysfs_attrs_release(struct kobject *kobj)
-- 
2.47.3

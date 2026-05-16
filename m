Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B43446A3;
	Sat, 16 May 2026 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956647; cv=none; b=cDIDbRtD2l+0xgWcm9jAc06SZtVPXXJPxmWTvjcdg3EvVjLL7H2pPgFMw7ta8y6gb5TpyakbuI3SxrAXpOEYHoJ9sOzz6qug0+dRK2U+mADSoqjz6XnrWjsZMZApjqJ2KRa4uSkhsMWOWTGrmTvMlyyB96R1NKPp7ai0x2U1HcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956647; c=relaxed/simple;
	bh=iRZBRbnhuMWGPc47mimwPtAfnZSCPltTg9pBo2Ew2oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVbcghsNXWi3Hg6nsMqyjqiAK2zt2UkwMnOYYpBiHHCW79TQgTL+vXWyi0LFG2p1IqWBj+XLHeh2/XxeqQsQthZhRIyM7N6yj2pIe/xGAn4MtjZS1h0oZlJ0cLwD1tqJehSDgEghnwx/r6KxIW+Hvxx8TwQYzs/sNUr3uTPOqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGYojE+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGYojE+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663A7C19425;
	Sat, 16 May 2026 18:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956647;
	bh=iRZBRbnhuMWGPc47mimwPtAfnZSCPltTg9pBo2Ew2oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGYojE+shBdtvikrnxOfsrT13b1eW4VMwiFxQ17DjbE9RTrpRNiUYBW/ItmCHLxZf
	 8vbHrJ9JMniWgT88pKw9bErJFBu0oR+x6KbKek2PUZD23r6BC4YgY/N9t6IQYISKk8
	 TLomoYIVsPz4nVsw+I7+7arQ2y8l2/MLM/kuQpflJbNYy8C+4tvLcQTViY+eu5p8yK
	 rSCVpCHjQ0M6j0TAUGtN+8OTQihDSO7/JZj1wyol/PgcT8nUoP3ZrzGoXixLtzJwFX
	 IJcnqNWrKShJLSqFfuUIVNcIDcJM+l3acjpfqXcEiRoExOieJwDhOZRhI05caqF+ZN
	 v7O8gBKKB6rLw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 09/28] mm/damon/sysfs: implement probes dir
Date: Sat, 16 May 2026 11:36:50 -0700
Message-ID: <20260516183712.81393-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
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
index eefa959aa30ae..5f3b253f50ebf 100644
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

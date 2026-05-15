Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8536493F;
	Fri, 15 May 2026 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805892; cv=none; b=ouokLaVbpAmfof9111HT2cpEjIMXrZJOdBXuhz05/68W6yoX5r9Yr58bS1W1nCRmHsw1wioQGrwKfNHTDA0n2RO7xEdm0h6eJeRi5S4nAZTe4mfVYJHDmc536fSI/ro2EHJyu3maePsTUOapok78dpqW+peJR61/7nJSMApzZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805892; c=relaxed/simple;
	bh=S1XmGP9+Xcb1Qcew2IaauTokk0V1jo5N6xOnyHaorjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xrlojn7BoR9CXARUGW+awZ31K3H6MidePDYoGlV9p204PK8/lc0w5GpKUxEKJH2+jjejqw7spLyZR7xJ4NYP4mTTqzbfpPNyIg4OsqTLFzKc+T7fDgxOVxSOtd5IZueVBTwsjkWM6otet0Ny77zABeUuI/opqUaXdGFo9K/rL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8b11s5J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8b11s5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7219EC2BCC9;
	Fri, 15 May 2026 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805890;
	bh=S1XmGP9+Xcb1Qcew2IaauTokk0V1jo5N6xOnyHaorjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8b11s5JMpFrUIzpDhCudJPn4MMM6r3CMpRyKtuWDNsH5IyPQxJxS8WbqEUyzxOjW
	 IHuE5Bk7riC9mLpURRk6/dneEp3+LHSPHRVrCoN4yyyoNdeQk2hNX0jri9ScjD5kFY
	 xa4yp0Rw85l55uH+ExRSUnHKuieXyU8L66/LafrQ/T9+c2ZNQ2iGJtBKOG5mb3rfSD
	 sEaq5s12o6sK69gF/ed+yw+XyRP+truly6hTAdM4+aOi0iZ8YydPcECCP4S5zHAZu3
	 +F9sMO0wAOdP+qElgTAwzy4JC1GtL6pFALxwNHzo9LxJWSpvg0IW4Ba5bjicXWXhsN
	 XS3yG7Ahh6CMA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 11/28] mm/damon/sysfs: implement filters directory
Date: Thu, 14 May 2026 17:44:12 -0700
Message-ID: <20260515004433.128933-12-sj@kernel.org>
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

Implement a directory for letting users to install data probe filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c028e4b1281e6..6b15886190545 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -747,12 +747,42 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * filters directory
+ */
+
+struct damon_sysfs_filters {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_filters *damon_sysfs_filters_alloc(void)
+{
+	return kzalloc_obj(struct damon_sysfs_filters);
+}
+
+static void damon_sysfs_filters_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_filters, kobj));
+}
+
+static struct attribute *damon_sysfs_filters_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_filters);
+
+static const struct kobj_type damon_sysfs_filters_ktype = {
+	.release = damon_sysfs_filters_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_filters_groups,
+};
+
 /*
  * probe directory
  */
 
 struct damon_sysfs_probe {
 	struct kobject kobj;
+	struct damon_sysfs_filters *filters;
 };
 
 static struct damon_sysfs_probe *damon_sysfs_probe_alloc(void)
@@ -760,6 +790,30 @@ static struct damon_sysfs_probe *damon_sysfs_probe_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_probe);
 }
 
+static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *attr)
+{
+	struct damon_sysfs_filters *filters;
+	int err;
+
+	filters = damon_sysfs_filters_alloc();
+	if (!filters)
+		return -ENOMEM;
+	attr->filters = filters;
+
+	err = kobject_init_and_add(&filters->kobj, &damon_sysfs_filters_ktype,
+			&attr->kobj, "filters");
+	if (err) {
+		kobject_put(&filters->kobj);
+		attr->filters = NULL;
+	}
+	return err;
+}
+
+static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *attr)
+{
+	kobject_put(&attr->filters->kobj);
+}
+
 static void damon_sysfs_probe_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_probe, kobj));
@@ -797,8 +851,10 @@ static void damon_sysfs_probes_rm_dirs(
 	struct damon_sysfs_probe **probes_arr = probes->probes_arr;
 	int i;
 
-	for (i = 0; i < probes->nr; i++)
+	for (i = 0; i < probes->nr; i++) {
+		damon_sysfs_probe_rm_dirs(probes_arr[i]);
 		kobject_put(&probes_arr[i]->kobj);
+	}
 	probes->nr = 0;
 	kfree(probes_arr);
 	probes->probes_arr = NULL;
@@ -836,6 +892,13 @@ static int damon_sysfs_probes_add_dirs(
 			return err;
 		}
 
+		err = damon_sysfs_probe_add_dirs(probe);
+		if (err) {
+			kobject_put(&probe->kobj);
+			damon_sysfs_probes_rm_dirs(probes);
+			return err;
+		}
+
 		probes_arr[i] = probe;
 		probes->nr++;
 	}
-- 
2.47.3

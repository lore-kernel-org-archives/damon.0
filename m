Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224A3BE633;
	Tue,  1 Sep 2026 04:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237270; cv=none; b=g7pwKexjRkid+0EqCGpSvPH31IDcpCnpVPWWSa6ndYX0bv6FqsgIcxsdCyXoM6d0HdLuytyM+O9fnWZqG9HGlHBV5UCOVxlIMG4sFrQJ3grvg0Lx0o9ARbvY+ZSJZIkNDfWd3zkLsRIw+nLCr4/N86AxDJXEC0zSsf8ani1znao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237270; c=relaxed/simple;
	bh=TjaLRLGl85k1NfsJfJlZ8AUSjsqL+FlUFngH+W3xeuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ol97JM64wgik5at3m21aZambpYvQnYaTdTwWExH8oXnSyK390Xo5NzKsYgIaRY/LNNFOS+DIHbQxIu8s5dZJVOQ7wxGBC1vtfgY6iveJcykT5cUfTJmwjRa/cJHqBDBz9TadnHWegqyW7hDpUvN54gqRUF8pPUTmQPHPgtQIB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dipnz7Cb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dipnz7Cb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A671F00ACF;
	Tue,  1 Sep 2026 04:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237269;
	bh=SGq3BJdNnnCTCYeGqjvgppOd2nVk87x7Bo82sRuFOlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dipnz7CbbjBVWIVGEHxCrzsLQn8sqLmZEK0SdDMem24OMUYjYS8f8TucC9wihNIS8
	 qhIxzQHv3T7ObDkmkiaU/hUvprTG+EbI4Afxi63kTWF01X92Lbl8ghmg0snvR3HP3F
	 sW+fuCQMzceEY8YiJIqVLN5NN0/zTcf/NU1Blle6bNwCDd9irJlCZ7A/+Y66iD9GqR
	 J8wt+JIXczDL11TV8N53AePTLuG8RzoUSStMWcGEc17bsoRFWZ6vXI74X3k7t/Lnmm
	 dXVdtSPAjDfiJqCbHjU2E1TPXw3RJFGDQ5Io9mXn3CcLgkTNJHFz1QRsBVeTZwP4oh
	 WVABe1XxVfv7g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/17] mm/damon/sysfs: implement preps/nr_preps file
Date: Mon, 31 Aug 2026 21:34:06 -0700
Message-ID: <20260901043417.2165-11-sj@kernel.org>
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

Implement nr_preps file under the preps directory.  It will be evolved
to be used for generating sub directories that will represent each probe
preparation action.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 09641257d3a89..1d2d9950716e1 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -755,6 +755,7 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 
 struct damon_sysfs_preps {
 	struct kobject kobj;
+	int nr;
 };
 
 static struct damon_sysfs_preps *damon_sysfs_preps_alloc(void)
@@ -762,12 +763,60 @@ static struct damon_sysfs_preps *damon_sysfs_preps_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_preps);
 }
 
+static void damon_sysfs_preps_rm_dirs(struct damon_sysfs_preps *preps)
+{
+	preps->nr = 0;
+}
+
+static int damon_sysfs_preps_add_dirs(struct damon_sysfs_preps *preps,
+		int nr_preps)
+{
+	preps->nr = nr_preps;
+	return 0;
+}
+
+static ssize_t nr_preps_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_preps *preps = container_of(kobj,
+			struct damon_sysfs_preps, kobj);
+
+	return sysfs_emit(buf, "%d\n", preps->nr);
+}
+
+static ssize_t nr_preps_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_preps *preps;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	preps = container_of(kobj, struct damon_sysfs_preps, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_preps_add_dirs(preps, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
 static void damon_sysfs_preps_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_preps, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_preps_nr_attr =
+		__ATTR_RW_MODE(nr_preps, 0600);
+
 static struct attribute *damon_sysfs_preps_attrs[] = {
+	&damon_sysfs_preps_nr_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_preps);
@@ -1149,8 +1198,10 @@ static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *probe)
 
 static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *probe)
 {
-	if (probe->preps)
+	if (probe->preps) {
+		damon_sysfs_preps_rm_dirs(probe->preps);
 		kobject_put(&probe->preps->kobj);
+	}
 	if (probe->filters) {
 		damon_sysfs_filters_rm_dirs(probe->filters);
 		kobject_put(&probe->filters->kobj);
-- 
2.47.3

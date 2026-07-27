Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFD33E1D1A;
	Mon, 27 Jul 2026 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163118; cv=none; b=kBY6Cc0gXuPYcvRQuYbmHT7X/61ggGSul/hrLfPTEzMybmfaUKEmQhyF6cpx1exZ93MVzU4gUIqD3nPH+a346aDpnx6amPPg5ROQdHLpYsFAWo+8EyL7B/opnDjyalPGS/IK5Bx4CNA2CBI3Ff/DxLaUK2alWO5No83uU86p5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163118; c=relaxed/simple;
	bh=d7pf79u6VeHtDpTchOv1ph3Cb9nyyNPcaDkMQnqw6mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQWBg7yzcc7KqtjcBL9jLCXnNaPh69AeDZERqmTX9LlN5coZZj+N9u5CBDP7e1KaO3rPuoH6cF83dIysO753T86YtTmhq3NJUxLrjvUgFJirBYmJ3SQCR68qKOtKPi6YaQkR8vovykKYrm33CcCaohctUur+ENSlCOi+8Wu5xvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hlimw8ML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlimw8ML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD541F00A3A;
	Mon, 27 Jul 2026 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163116;
	bh=75WNvMQ88+SBOSCD3WYFyt6Ye1FE/Gea2+Axargrbvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hlimw8MLamfcIrZSFABY2AOxhNJvK+Env+BYkcO4rULDAAdIeojPvF1FmQ32BPadr
	 HMr9O4rW3u4r7t7o+u2zTB9lSIBPJbVwEpQtICTiz1k5iFq7APR44bwDmgm26ApHD5
	 9lKuVZR+NKxj6P8FOBLqyiteVZ4bG0CGdPaajGIsMQqrIfXItUW3mEKE3QD1p23JlU
	 nicHTogsY+aTI9CKkjNH+mhFCLpZNvvPL2mCSloNyLAqczFBKgYIHo6MPBewNJm/Nm
	 8ZRQcIwipNVNbfZ37s01mNOrJlm6OszYFpfZ3OKpRlXCtiTcuk7ZfQ37Ll7kfFJX3q
	 twBw05Hkn7ncw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 10/17] mm/damon/sysfs: implement preps/nr_preps file
Date: Mon, 27 Jul 2026 07:38:19 -0700
Message-ID: <20260727143829.86236-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
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
index e33070d2cbcc6..6d3ed80fb2eb1 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -756,6 +756,7 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 
 struct damon_sysfs_preps {
 	struct kobject kobj;
+	int nr;
 };
 
 static struct damon_sysfs_preps *damon_sysfs_preps_alloc(void)
@@ -763,12 +764,60 @@ static struct damon_sysfs_preps *damon_sysfs_preps_alloc(void)
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
@@ -1150,8 +1199,10 @@ static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *probe)
 
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

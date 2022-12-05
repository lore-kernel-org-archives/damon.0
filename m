Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA4215CAF
	for <damon@lists.linux.dev>; Mon,  5 Dec 2022 23:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09CDC43141;
	Mon,  5 Dec 2022 23:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670281720;
	bh=5gMO8cLybx9rIEkN5/YUfJzDl3RNG0bek/qaVakfGfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LiP2vcVcBH/ViJzcxFOdvs7s/0ZOLtF88q4fj24PDoJGfxkBZjEF8SXWCNKmTEl2v
	 doSq1h0O0yLwR6AujiHFTLkm2uTaqqpxul11peFqTmBfzkwYqAsM7opXy4CKcP2GZU
	 V0XivkIlN1gRGQk0CakM7U7GSLsyXBq93UQMdhNJ4AsHvYcWhZHuz6ZP6sxGe6AsDG
	 bVhzMIt+5pNU04+9c80VMWLkZ3mfZ+t/ic3yCqjXHIIn0skiSH9EfmNJPrwFvlh0vv
	 D3qPnFwH05tjEQeJo3ZNrv58MvU65bCrn3ha3yrT1Wve2Tk3NOvnin9kCr+R+m8eN6
	 csTQbzfoWVcuQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 07/11] mm/damon/sysfs-schemes: connect filter directory and filters directory
Date: Mon,  5 Dec 2022 23:08:26 +0000
Message-Id: <20221205230830.144349-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205230830.144349-1-sj@kernel.org>
References: <20221205230830.144349-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement 'nr_filters' file under 'filters' directory, which will be
used to populate specific number of 'filter' directory under the
directory, similar to other 'nr_*' files in DAMON sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 68 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index afbfc55a8e84..e79c678a69d5 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -269,6 +269,11 @@ struct damon_sysfs_scheme_filter {
 	char *memcg_path;
 };
 
+static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_scheme_filter), GFP_KERNEL);
+}
+
 /* Should match with enum damos_filter_type */
 static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
@@ -392,6 +397,7 @@ static struct kobj_type damon_sysfs_scheme_filter_ktype = {
 
 struct damon_sysfs_scheme_filters {
 	struct kobject kobj;
+	struct damon_sysfs_scheme_filter **filters_arr;
 	int nr;
 };
 
@@ -401,6 +407,57 @@ damon_sysfs_scheme_filters_alloc(void)
 	return kzalloc(sizeof(struct damon_sysfs_scheme_filters), GFP_KERNEL);
 }
 
+static void damon_sysfs_scheme_filters_rm_dirs(
+		struct damon_sysfs_scheme_filters *filters)
+{
+	struct damon_sysfs_scheme_filter **filters_arr = filters->filters_arr;
+	int i;
+
+	for (i = 0; i < filters->nr; i++)
+		kobject_put(&filters_arr[i]->kobj);
+	filters->nr = 0;
+	kfree(filters_arr);
+	filters->filters_arr = NULL;
+}
+
+static int damon_sysfs_scheme_filters_add_dirs(
+		struct damon_sysfs_scheme_filters *filters, int nr_filters)
+{
+	struct damon_sysfs_scheme_filter **filters_arr, *filter;
+	int err, i;
+
+	damon_sysfs_scheme_filters_rm_dirs(filters);
+	if (!nr_filters)
+		return 0;
+
+	filters_arr = kmalloc_array(nr_filters, sizeof(*filters_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!filters_arr)
+		return -ENOMEM;
+	filters->filters_arr = filters_arr;
+
+	for (i = 0; i < nr_filters; i++) {
+		filter = damon_sysfs_scheme_filter_alloc();
+		if (!filter) {
+			damon_sysfs_scheme_filters_rm_dirs(filters);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&filter->kobj,
+				&damon_sysfs_scheme_filter_ktype,
+				&filters->kobj, "%d", i);
+		if (err) {
+			kobject_put(&filter->kobj);
+			damon_sysfs_scheme_filters_rm_dirs(filters);
+			return err;
+		}
+
+		filters_arr[i] = filter;
+		filters->nr++;
+	}
+	return 0;
+}
+
 static ssize_t nr_filters_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -413,6 +470,7 @@ static ssize_t nr_filters_show(struct kobject *kobj,
 static ssize_t nr_filters_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
+	struct damon_sysfs_scheme_filters *filters;
 	int nr, err = kstrtoint(buf, 0, &nr);
 
 	if (err)
@@ -420,6 +478,15 @@ static ssize_t nr_filters_store(struct kobject *kobj,
 	if (nr < 0)
 		return -EINVAL;
 
+	filters = container_of(kobj, struct damon_sysfs_scheme_filters, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_scheme_filters_add_dirs(filters, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
 	return count;
 }
 
@@ -1166,6 +1233,7 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	kobject_put(&scheme->watermarks->kobj);
+	damon_sysfs_scheme_filters_rm_dirs(scheme->filters);
 	kobject_put(&scheme->filters->kobj);
 	kobject_put(&scheme->stats->kobj);
 	damon_sysfs_scheme_regions_rm_dirs(scheme->tried_regions);
-- 
2.25.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C232143F;
	Mon,  8 Dec 2025 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175434; cv=none; b=ifv/5PM6Dm8wN7mgNW0i0q7XehX3/yGunGk6EXFJOiSHaYhFjjknY1r2RQgZddFxMgQr58XskWDDasKlDkVTh2zPBhjHG2WSpEwTmzg688f8Nc5aVQux/VvKeVUqz79McBO0+eMWmWIG7gLoQkzM6TwJvCGZzbbzlfxtdAsf/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175434; c=relaxed/simple;
	bh=3JZCkxkL4i/kCYq9wc6IiaTGi5wDXb4PyYdbk+AUHf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0xd4OPl/Kc7s8caZ9FQybG8wQ9QSw4ZKuqjbWRJszpqZSEDQWaJctvlXp905nGgKdcvzW2npqmyqgoireg0h6K/UaTpOLJBKZwtNmrrO8v9BKyxma0LtmXbe67fvHLcGKFuZIUH86ELUQkIYYNZflN1sEq9AKk9voy8fb95LJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPzC8mFh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPzC8mFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AD8C19421;
	Mon,  8 Dec 2025 06:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175434;
	bh=3JZCkxkL4i/kCYq9wc6IiaTGi5wDXb4PyYdbk+AUHf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPzC8mFhApK44AZvUzvwj+vo6IrDlAMEE5iJ9ohs4vVx8YFqcfCPEy4nxJfKP1ppg
	 6ZznWeeXOhkl3NdXCkNyJU1vNhCTA3vjJmkw8vn4SnWbB44QcpBDsEVdjjP7SCY4c2
	 lRXZOJ1wVVY6hvlcor6fZLEeZcUdvZ2wqlRGMwZwcslxW8ohkFxNZpLvEqmJycs4UK
	 jOLUzQfTZMD45lsKWkW7xE3U0OYt6sG0g5PiUjkz3WJyt1t79cpLPtFIhiGsF6AEwY
	 eIzvmmkUmC1s8ca5DE672uyCZFaE0sPqSuNXj8g+1pzRf4AkUgqzCih/TEz5hTeYbk
	 y7ENPFpbIzg9g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 30/37] mm/damon/sysfs: support thread based access sample filtering
Date: Sun,  7 Dec 2025 22:29:34 -0800
Message-ID: <20251208062943.68824-31-sj@kernel.org>
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

Add support of the threads based access sample filtering on DAMON sysfs
interface.  For this, add a new file for setting the threads of interest
of the filter, and pass it to the core layer.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 3aac2aea6b0c..b96df2d2d17e 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -759,6 +759,7 @@ struct damon_sysfs_sample_filter {
 	bool matching;
 	bool allow;
 	cpumask_t cpumask;
+	int *tid_arr;	/* first entry is the length of the array */
 };
 
 static struct damon_sysfs_sample_filter *damon_sysfs_sample_filter_alloc(void)
@@ -777,6 +778,10 @@ damon_sysfs_sample_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_CPUMASK,
 		.name = "cpumask",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_THREADS,
+		.name = "threads",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -888,6 +893,47 @@ static ssize_t cpumask_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 
+static ssize_t tid_arr_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_sample_filter *sample_filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+	char *str;
+	int nr_tids, *tid_arr;
+	int i, ret;
+
+	if (!sample_filter->tid_arr)
+		return sysfs_emit(buf, "\n");
+
+	str = kcalloc(2048, sizeof(*str), GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+	nr_tids = sample_filter->tid_arr[0];
+	tid_arr = &sample_filter->tid_arr[1];
+	for (i = 0; i < nr_tids; i++) {
+		snprintf(&str[strlen(str)], 2048 - strlen(str), "%d",
+				tid_arr[i]);
+		if (i < nr_tids - 1)
+			snprintf(&str[strlen(str)], 2048 - strlen(str), ",");
+	}
+	ret = sysfs_emit(buf, "%s\n", str);
+	kfree(str);
+	return ret;
+}
+
+static ssize_t tid_arr_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_sample_filter *sample_filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+	int err;
+
+	err = parse_int_array(buf, count, &sample_filter->tid_arr);
+	if (err)
+		return err;
+	return count;
+}
+
 static void damon_sysfs_sample_filter_release(struct kobject *kobj)
 {
 	struct damon_sysfs_sample_filter *filter = container_of(kobj,
@@ -908,11 +954,15 @@ static struct kobj_attribute damon_sysfs_sample_filter_allow_attr =
 static struct kobj_attribute damon_sysfs_sample_filter_cpumask_attr =
 		__ATTR_RW_MODE(cpumask, 0600);
 
+static struct kobj_attribute damon_sysfs_sample_filter_tid_arr_attr =
+		__ATTR_RW_MODE(tid_arr, 0600);
+
 static struct attribute *damon_sysfs_sample_filter_attrs[] = {
 	&damon_sysfs_sample_filter_type_attr.attr,
 	&damon_sysfs_sample_filter_matching_attr.attr,
 	&damon_sysfs_sample_filter_allow_attr.attr,
 	&damon_sysfs_sample_filter_cpumask_attr.attr,
+	&damon_sysfs_sample_filter_tid_arr_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_sample_filter);
@@ -1952,6 +2002,25 @@ static inline bool damon_sysfs_kdamond_running(
 		damon_is_running(kdamond->damon_ctx);
 }
 
+static int damon_sysfs_set_threads_filter(struct damon_sample_filter *filter,
+		int *sysfs_tid_arr)
+{
+	int nr_tids, i;
+	pid_t *tid_arr;
+
+	if (!sysfs_tid_arr)
+		return -EINVAL;
+	nr_tids = sysfs_tid_arr[0];
+	tid_arr = kmalloc_array(nr_tids, sizeof(*tid_arr), GFP_KERNEL);
+	if (!tid_arr)
+		return -ENOMEM;
+	for (i = 0; i < nr_tids; i++)
+		tid_arr[i] = sysfs_tid_arr[i + 1];
+	filter->tid_arr = tid_arr;
+	filter->nr_tids = nr_tids;
+	return 0;
+}
+
 static int damon_sysfs_set_sample_filters(
 		struct damon_sample_control *control,
 		struct damon_sysfs_sample_filters *sysfs_filters)
@@ -1972,6 +2041,12 @@ static int damon_sysfs_set_sample_filters(
 		case DAMON_FILTER_TYPE_CPUMASK:
 			filter->cpumask = sysfs_filter->cpumask;
 			break;
+		case DAMON_FILTER_TYPE_THREADS:
+			err = damon_sysfs_set_threads_filter(filter,
+					sysfs_filter->tid_arr);
+			if (err)
+				damon_free_sample_filter(filter);
+			break;
 		default:
 			break;
 		}
-- 
2.47.3

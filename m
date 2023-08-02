Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF0134AB
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864C3C433BF;
	Wed,  2 Aug 2023 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691012601;
	bh=Z5TufRLeeFt1IBETpXgGonzkgtF37kqef1//j1myid4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGXW/no8kpmZgpQpS3OiSc3SSTkLbifo0+BdHXTF7aQ9MCoo6qcnEBrp0nq4ukQUf
	 Ag3+nuYsoDCyPt4EH++KRhy7E++Eo7xh3gSL/5rLy5nalVdj0ieh1nqoGZBSkMcO2Q
	 wWUlA1IE7UsJT5pw8B29eHbAGRuqJhbiLaXbDYhwgxYQ1lSyNweW1c7nG6wmkAmqBq
	 dBxpzsKclteCHtOChtqidh0wXZuKzu0R3kfTWEEiA8oFlH8zZpNsDLwvkUvgLkbtPR
	 /ea40Qks1h8F2LQdIl4cJCZyiSj3eltppdoEUSYwwCQOJDNXV2tup7XXkze3Vfz2Ga
	 IzbsOMIF/h6RA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] mm/damon/sysfs-schemes: support target damos filter
Date: Wed,  2 Aug 2023 21:43:08 +0000
Message-Id: <20230802214312.110532-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802214312.110532-1-sj@kernel.org>
References: <20230802214312.110532-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to support the DAMON monitoring target
based DAMOS filter.  Users can use it via writing 'target' to the
filter's 'type' file and specifying the index of the target from the
corresponding DAMON context's monitoring targets list to 'target_idx'
sysfs file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 03ddba3e216d..527e7d17eb3b 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -283,6 +283,7 @@ struct damon_sysfs_scheme_filter {
 	bool matching;
 	char *memcg_path;
 	struct damon_addr_range addr_range;
+	int target_idx;
 };
 
 static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(void)
@@ -295,6 +296,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
 	"addr",
+	"target",
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -413,6 +415,25 @@ static ssize_t addr_end_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t damon_target_idx_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%d\n", filter->target_idx);
+}
+
+static ssize_t damon_target_idx_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	int err = kstrtoint(buf, 0, &filter->target_idx);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_scheme_filter_release(struct kobject *kobj)
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
@@ -437,12 +458,16 @@ static struct kobj_attribute damon_sysfs_scheme_filter_addr_start_attr =
 static struct kobj_attribute damon_sysfs_scheme_filter_addr_end_attr =
 		__ATTR_RW_MODE(addr_end, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_filter_damon_target_idx_attr =
+		__ATTR_RW_MODE(damon_target_idx, 0600);
+
 static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
 	&damon_sysfs_scheme_filter_type_attr.attr,
 	&damon_sysfs_scheme_filter_matching_attr.attr,
 	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
 	&damon_sysfs_scheme_filter_addr_start_attr.attr,
 	&damon_sysfs_scheme_filter_addr_end_attr.attr,
+	&damon_sysfs_scheme_filter_damon_target_idx_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_filter);
@@ -1539,6 +1564,8 @@ static int damon_sysfs_set_scheme_filters(struct damos *scheme,
 				return -EINVAL;
 			}
 			filter->addr_range = sysfs_filter->addr_range;
+		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
+			filter->target_idx = sysfs_filter->target_idx;
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.25.1


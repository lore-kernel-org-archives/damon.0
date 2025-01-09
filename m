Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F81B0413;
	Thu,  9 Jan 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445104; cv=none; b=XSqheAnQ9E61s/4mdkh00nH8wXvY0p4Z+3rcMBaP848mT+VSYc/chbSphxdTQ43L2it/NKaaO+iSm4vZbmxqJhHlSUXWBskNMU2sIE+pnfUF75fDGKj2cg0w/aRE5dk9wzEfacl+pFWaySanlv4zOmQS4Op9Z7DmSXqC5ZltKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445104; c=relaxed/simple;
	bh=qmaIUnx59dUjwJkr4G+Ggfwt4z+WkdllmHRXE6wuoJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AXWujfUR2PpVWE0ropx9hDc9/GnZwWDWmwIkE2SOiUciAjKbSuKWATWz2UyaTUYiF2ZpPeBbfWmKOFBIPZuhiRGlraLa1JWBLvo9+xhX6Quwj8CsGqE4GAPr4oRXBBWeupIJbUNNrHMscBCnMBjA0toa1oq59tG0WWrM0Aoan6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8NlydKr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8NlydKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E877C4CEE2;
	Thu,  9 Jan 2025 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736445103;
	bh=qmaIUnx59dUjwJkr4G+Ggfwt4z+WkdllmHRXE6wuoJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8NlydKrZFuP8R5wAjf7JbfscwIPB64jz+BGzzEkjRkiQZqySwJ97bJzTajtYLk+F
	 0xXmae4ZRT78XzzUs1KT7FmLdBlxWrn0RMcxKFtG7TO2kA6sR8YMDUTmrws2e3ycFG
	 2ttU3NmCipytEE+qOvbm25XhIsMPT6hQUQ2YCu6FSo4LXdibz9bnQ1QqJ9wYOE4Cjs
	 rstP5YUKEr+Ekx6gMov2qd3AWBoffGg9Rd/b3dZUMjRaTLR+SPsAaATPfHLCno6uNc
	 jQhulsnR2GHmgyX6YJVmV+IWHp8k6De+eqP+SueNmgk84xgIVzB/CHwqp6WhUiAnLT
	 U7/MjPM6Y6uSw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 06/10] mm/damon/sysfs-schemes: add a file for setting damos_filter->allow
Date: Thu,  9 Jan 2025 09:51:22 -0800
Message-Id: <20250109175126.57878-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109175126.57878-1-sj@kernel.org>
References: <20250109175126.57878-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only kernel-space DAMON API users can use inclusive DAMOS filters.  Add
a sysfs file named 'allow' under DAMOS filter directory of DAMON sysfs
interface, to let the user-space users use inclusive DAMOS filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 9a883e8aea1c..98f93ae9f59e 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -313,6 +313,7 @@ struct damon_sysfs_scheme_filter {
 	struct kobject kobj;
 	enum damos_filter_type type;
 	bool matching;
+	bool allow;
 	char *memcg_path;
 	struct damon_addr_range addr_range;
 	int target_idx;
@@ -385,6 +386,30 @@ static ssize_t matching_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t allow_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%c\n", filter->allow ? 'Y' : 'N');
+}
+
+static ssize_t allow_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	bool allow;
+	int err = kstrtobool(buf, &allow);
+
+	if (err)
+		return err;
+
+	filter->allow = allow;
+	return count;
+}
+
 static ssize_t memcg_path_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -482,6 +507,9 @@ static struct kobj_attribute damon_sysfs_scheme_filter_type_attr =
 static struct kobj_attribute damon_sysfs_scheme_filter_matching_attr =
 		__ATTR_RW_MODE(matching, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_filter_allow_attr =
+		__ATTR_RW_MODE(allow, 0600);
+
 static struct kobj_attribute damon_sysfs_scheme_filter_memcg_path_attr =
 		__ATTR_RW_MODE(memcg_path, 0600);
 
@@ -497,6 +525,7 @@ static struct kobj_attribute damon_sysfs_scheme_filter_damon_target_idx_attr =
 static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
 	&damon_sysfs_scheme_filter_type_attr.attr,
 	&damon_sysfs_scheme_filter_matching_attr.attr,
+	&damon_sysfs_scheme_filter_allow_attr.attr,
 	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
 	&damon_sysfs_scheme_filter_addr_start_attr.attr,
 	&damon_sysfs_scheme_filter_addr_end_attr.attr,
@@ -1901,7 +1930,8 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			sysfs_filters->filters_arr[i];
 		struct damos_filter *filter =
 			damos_new_filter(sysfs_filter->type,
-					sysfs_filter->matching, false);
+					sysfs_filter->matching,
+					sysfs_filter->allow);
 		int err;
 
 		if (!filter)
-- 
2.39.5

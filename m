Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630641F869A;
	Tue,  7 Jan 2025 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281095; cv=none; b=HA6YghPEtX9N16e8nm0mavjHrcSilMcfRz4sK51F7Yi0xq/r48Hqchr/edIDEbkoo+6fe3Ol1bxmIfx9TMG4aCsePbTzUt1Nm5IOtvUg6GaV6nJLhdEWfRYCYTLHovd5VSNEUAZCTbAddHRerg8XeWZ14lvEG2dFt5N4drgGSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281095; c=relaxed/simple;
	bh=ZERQXRIpbhEDVEpD6J6LgTdFsTQpbeeZuCqI48fC6sI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbHz+WHSQk8NF5FAylSnItntVlhDSzEPoZXO2nmeAFeC4t6dP+5KYP3I4DgF+RDlJ8wXXxEZQ9cacukie6jRXNTbsu8Z733WzYVRqELE6Djyxj3EoRkaOPn0C4L1e4jN9UnvNYUvXBgVypoItDjF34McL1OI3BI1vqodlHZE7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slJilpwI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slJilpwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4C5C4CED6;
	Tue,  7 Jan 2025 20:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736281094;
	bh=ZERQXRIpbhEDVEpD6J6LgTdFsTQpbeeZuCqI48fC6sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slJilpwIOoWc2ruriXmweZYgn+/8so1cWoZ3VtcHYglEtfsQV3O5P/QcknYVWIl/6
	 Uj0dxHDQ4mFZQtIY755fd7pfC0oFdHjkFMyPMYtjAbmXbFcUggxCRpTakGpP852ZIB
	 7AgH7fKhj9cBedscF09kRtT7rEtw32LCiK+0HpAhqMMZ1JiQgmQivgjQMx/tI5jI3A
	 Y+psKcsEi6caa/3wxr3kuMlvxtQf7UOsp50JIS4qNs8zIqExutcm3WC5DPjUbSxBgC
	 6PaUBjyu6mJA6AOD3Cr8srUrjYMY890PaT0zEfQlMEtz77lbUXwCgu7u6xQOFnC1/O
	 JQnwkn3DV+TLA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/10] mm/damon/sysfs-schemes: add a file for setting damos_filter->pass
Date: Tue,  7 Jan 2025 12:17:35 -0800
Message-Id: <20250107201739.79484-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107201739.79484-1-sj@kernel.org>
References: <20250107201739.79484-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only kernel-space DAMON API users can use inclusive DAMOS filters.  Add
a sysfs file named 'pass' under DAMOS filter directory of DAMON sysfs
interface, to let the user-space users use inclusive DAMOS filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 9a883e8aea1c..9e171046ee94 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -313,6 +313,7 @@ struct damon_sysfs_scheme_filter {
 	struct kobject kobj;
 	enum damos_filter_type type;
 	bool matching;
+	bool pass;
 	char *memcg_path;
 	struct damon_addr_range addr_range;
 	int target_idx;
@@ -385,6 +386,30 @@ static ssize_t matching_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t pass_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%c\n", filter->pass ? 'Y' : 'N');
+}
+
+static ssize_t pass_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	bool pass;
+	int err = kstrtobool(buf, &pass);
+
+	if (err)
+		return err;
+
+	filter->pass = pass;
+	return count;
+}
+
 static ssize_t memcg_path_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -482,6 +507,9 @@ static struct kobj_attribute damon_sysfs_scheme_filter_type_attr =
 static struct kobj_attribute damon_sysfs_scheme_filter_matching_attr =
 		__ATTR_RW_MODE(matching, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_filter_pass_attr =
+		__ATTR_RW_MODE(pass, 0600);
+
 static struct kobj_attribute damon_sysfs_scheme_filter_memcg_path_attr =
 		__ATTR_RW_MODE(memcg_path, 0600);
 
@@ -497,6 +525,7 @@ static struct kobj_attribute damon_sysfs_scheme_filter_damon_target_idx_attr =
 static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
 	&damon_sysfs_scheme_filter_type_attr.attr,
 	&damon_sysfs_scheme_filter_matching_attr.attr,
+	&damon_sysfs_scheme_filter_pass_attr.attr,
 	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
 	&damon_sysfs_scheme_filter_addr_start_attr.attr,
 	&damon_sysfs_scheme_filter_addr_end_attr.attr,
@@ -1901,7 +1930,8 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			sysfs_filters->filters_arr[i];
 		struct damos_filter *filter =
 			damos_new_filter(sysfs_filter->type,
-					sysfs_filter->matching, false);
+					sysfs_filter->matching,
+					sysfs_filter->pass);
 		int err;
 
 		if (!filter)
-- 
2.39.5

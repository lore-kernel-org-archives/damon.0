Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959F26460B;
	Thu, 20 Feb 2025 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080813; cv=none; b=pDwgWNKBuvW//H5ozBF2gg5TTVfR6Z/p2jgKobBhVk3VZMJ3cBZzKt2pU7SNjVQ1VX8HGdPacCKluDFc73OFJAB2MFzhakT70OiZEn5ePh67lWLXLL1jCnMj+f3qcNpflZTzL4i7dzGNm963+aao5iSnVYJCmMGCJZPz/FqEpcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080813; c=relaxed/simple;
	bh=x49E7WlC9jzDdYoMfkdigGCJYjlYQheM7yPC5VYZSrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ni58a9ZrnIUYDJY4AACIzO2OH7ujwbHrP1OYomz6ITThZerBtpH7ubBdVqaIRmeOSMlgl2/5P3JdX0iRNgLYrJZOhkSxtTz8IzORtXFHs4gCpl8HDBvEU45eVuUOds3e73zmVUo4x9n6XHTNXN0yeyzgSijdW9J7RKppEyC7s60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azoYwA17; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azoYwA17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BF8C4CED1;
	Thu, 20 Feb 2025 19:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080813;
	bh=x49E7WlC9jzDdYoMfkdigGCJYjlYQheM7yPC5VYZSrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azoYwA174ibgpxsa5omO/gZ6EKQsnGkEk4Ql2SF2Cy0Tj9zoSDHUXemgBNpO64T6U
	 cvSp28YFClj3X9fS3NRI1PHh+KP714IZORD2IOG8JFCqJKpbUBXZcdVaJ0oKfNgAQD
	 /SvEQayW/MtBtvBsu2bk4PI105CSB1SZfo09wwh9kcbEf0FR2gIqKpntM8AVVcewjd
	 E8DhLOrwUW54aUlMiyS00gXij0XmoU3+06uWAH5hkHyJQUvz/DCymOeyo8QNdMV3h4
	 ar4O5h7nNZQuDFBW4VJETtLu838dvoLBGecYZRA54ufmuZWNOllIrN5YHkAwl+Ti97
	 DhwgBnBHIu4bA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] mm/damon/sysfs-schemes: implement core_filters and ops_filters directories
Date: Thu, 20 Feb 2025 11:46:40 -0800
Message-Id: <20250220194646.37726-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220194646.37726-1-sj@kernel.org>
References: <20250220194646.37726-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement two DAMOS sysfs directories for managing core and operations
layer handled filters separately.  Those are named as 'core_filters' and
'ops_filters', and have files hierarchy same to 'filters'.  This commit
is only populating and cleaning up the directories, not really the files
with DAMON.  Following changes will make the connections.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 541ca5887b24..61ff800ce78d 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1504,6 +1504,8 @@ struct damon_sysfs_scheme {
 	unsigned long apply_interval_us;
 	struct damon_sysfs_quotas *quotas;
 	struct damon_sysfs_watermarks *watermarks;
+	struct damon_sysfs_scheme_filters *core_filters;
+	struct damon_sysfs_scheme_filters *ops_filters;
 	struct damon_sysfs_scheme_filters *filters;
 	struct damon_sysfs_stats *stats;
 	struct damon_sysfs_scheme_regions *tried_regions;
@@ -1624,6 +1626,33 @@ static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme,
 	return err;
 }
 
+static int damos_sysfs_set_filter_dirs(struct damon_sysfs_scheme *scheme)
+{
+	int err;
+
+	err = damon_sysfs_scheme_set_filters(scheme, "filters",
+			&scheme->filters);
+	if (err)
+		return err;
+	err = damon_sysfs_scheme_set_filters(scheme, "core_filters",
+			&scheme->core_filters);
+	if (err)
+		goto put_filters_out;
+	err = damon_sysfs_scheme_set_filters(scheme, "ops_filters",
+			&scheme->ops_filters);
+	if (err)
+		goto put_core_filters_out;
+	return 0;
+
+put_core_filters_out:
+	kobject_put(&scheme->core_filters->kobj);
+	scheme->core_filters = NULL;
+put_filters_out:
+	kobject_put(&scheme->filters->kobj);
+	scheme->filters = NULL;
+	return err;
+}
+
 static int damon_sysfs_scheme_set_stats(struct damon_sysfs_scheme *scheme)
 {
 	struct damon_sysfs_stats *stats = damon_sysfs_stats_alloc();
@@ -1672,8 +1701,7 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
 		goto put_quotas_access_pattern_out;
-	err = damon_sysfs_scheme_set_filters(scheme, "filters",
-			&scheme->filters);
+	err = damos_sysfs_set_filter_dirs(scheme);
 	if (err)
 		goto put_watermarks_quotas_access_pattern_out;
 	err = damon_sysfs_scheme_set_stats(scheme);
@@ -1688,6 +1716,10 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	kobject_put(&scheme->tried_regions->kobj);
 	scheme->tried_regions = NULL;
 put_filters_watermarks_quotas_access_pattern_out:
+	kobject_put(&scheme->ops_filters->kobj);
+	scheme->ops_filters = NULL;
+	kobject_put(&scheme->core_filters->kobj);
+	scheme->core_filters = NULL;
 	kobject_put(&scheme->filters->kobj);
 	scheme->filters = NULL;
 put_watermarks_quotas_access_pattern_out:
@@ -1711,6 +1743,10 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 	kobject_put(&scheme->watermarks->kobj);
 	damon_sysfs_scheme_filters_rm_dirs(scheme->filters);
 	kobject_put(&scheme->filters->kobj);
+	damon_sysfs_scheme_filters_rm_dirs(scheme->core_filters);
+	kobject_put(&scheme->core_filters->kobj);
+	damon_sysfs_scheme_filters_rm_dirs(scheme->ops_filters);
+	kobject_put(&scheme->ops_filters->kobj);
 	kobject_put(&scheme->stats->kobj);
 	damon_sysfs_scheme_regions_rm_dirs(scheme->tried_regions);
 	kobject_put(&scheme->tried_regions->kobj);
-- 
2.39.5

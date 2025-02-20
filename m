Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D991DED7C;
	Thu, 20 Feb 2025 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080817; cv=none; b=AOuNvtbKN9CJstlgBsPJxTbRBb/yW57ifSoEniAWoD13AIktiAkwpjgpk8AwEclYLJNjgEIi9cPyx35vTWG9R51a8wQTeNz2YwNdkerhkgYCpuULfUb9XmN2ndDNuY44A6j7ReYRtr82zuqGXbmUGeLS93h+ff/uyo6IrF8Z2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080817; c=relaxed/simple;
	bh=Oq7zbJY/d75refySY9fqfwByqDNucfBFfKnaietebjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Je6mO9SE2vqpJZn8QPXPu6fk7+mV7BB1/sIWRXF4/CdogE8crPYoHl7gi+39DFhGsemlBu4jX58TEhQrhn162ywcTDl2J6JXUoUFnAoQsQ5JSIh2eNBkDrYwN3Shu+Da0rlttvuWGZOGf8I2unT27fWuoWjwZtm53MEGGhTvgW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maUxGS9R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maUxGS9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583C9C4CEE4;
	Thu, 20 Feb 2025 19:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080816;
	bh=Oq7zbJY/d75refySY9fqfwByqDNucfBFfKnaietebjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maUxGS9RJdK/mzBVdHSuSfIk7VmThiSz7N59euVqeFHpmaCGfRUL/9WfYVhzkNwFc
	 /bv/0r0YnnNsDvxgNMcPkITwNP2+d+Y8uizGuWm1hLHD5CHLiGT8+5bHhyMDKrFD02
	 CwKNdOI9XLKrBmZCCMMyK3KpxdmxEZ5E67aUvcfUPE8HzzggqWLPfsbH50GnAEG9Vs
	 D58in8g9O2J0YICICksTAR+qBmUF6zVfTOrk/06L2BE2e4turV5njT2kMPTyPeEzN3
	 akk6KIthCZdvwKXuZxNlDlziSTSGeT1DBuh+m31Vw3+AqpEvizFzWqO/DsRM9zwpwq
	 F1XWNTZfmRUvw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] mm/damon/sysfs-schemes: set filters handling layer of directories
Date: Thu, 20 Feb 2025 11:46:43 -0800
Message-Id: <20250220194646.37726-6-sj@kernel.org>
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

Unlike their name and assumed purposes, {core,ops}_filters DAMOS sysfs
directories are allowing installing any type of filters.  To restrict
wrong type of filters to the directories, first add information about
filters that handled by what layer should the filters allow installing
to DAMOS sysfs internal data structures.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 46 +++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index e85feb329bd6..b9f035f4b00f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -309,8 +309,18 @@ static const struct kobj_type damon_sysfs_stats_ktype = {
  * filter directory
  */
 
+/*
+ * enum damos_sysfs_filter_handle_layer - Layers handling filters of a dir.
+ */
+enum damos_sysfs_filter_handle_layer {
+	DAMOS_SYSFS_FILTER_HANDLE_LAYER_CORE,
+	DAMOS_SYSFS_FILTER_HANDLE_LAYER_OPS,
+	DAMOS_SYSFS_FILTER_HANDLE_LAYER_BOTH,
+};
+
 struct damon_sysfs_scheme_filter {
 	struct kobject kobj;
+	enum damos_sysfs_filter_handle_layer handle_layer;
 	enum damos_filter_type type;
 	bool matching;
 	bool allow;
@@ -320,9 +330,15 @@ struct damon_sysfs_scheme_filter {
 	int target_idx;
 };
 
-static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(void)
+static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(
+		enum damos_sysfs_filter_handle_layer layer)
 {
-	return kzalloc(sizeof(struct damon_sysfs_scheme_filter), GFP_KERNEL);
+	struct damon_sysfs_scheme_filter *filter;
+
+	filter = kzalloc(sizeof(struct damon_sysfs_scheme_filter), GFP_KERNEL);
+	if (filter)
+		filter->handle_layer = layer;
+	return filter;
 }
 
 /* Should match with enum damos_filter_type */
@@ -595,14 +611,20 @@ static const struct kobj_type damon_sysfs_scheme_filter_ktype = {
 
 struct damon_sysfs_scheme_filters {
 	struct kobject kobj;
+	enum damos_sysfs_filter_handle_layer handle_layer;
 	struct damon_sysfs_scheme_filter **filters_arr;
 	int nr;
 };
 
 static struct damon_sysfs_scheme_filters *
-damon_sysfs_scheme_filters_alloc(void)
+damon_sysfs_scheme_filters_alloc(enum damos_sysfs_filter_handle_layer layer)
 {
-	return kzalloc(sizeof(struct damon_sysfs_scheme_filters), GFP_KERNEL);
+	struct damon_sysfs_scheme_filters *filters;
+
+	filters = kzalloc(sizeof(struct damon_sysfs_scheme_filters), GFP_KERNEL);
+	if (filters)
+		filters->handle_layer = layer;
+	return filters;
 }
 
 static void damon_sysfs_scheme_filters_rm_dirs(
@@ -635,7 +657,8 @@ static int damon_sysfs_scheme_filters_add_dirs(
 	filters->filters_arr = filters_arr;
 
 	for (i = 0; i < nr_filters; i++) {
-		filter = damon_sysfs_scheme_filter_alloc();
+		filter = damon_sysfs_scheme_filter_alloc(
+				filters->handle_layer);
 		if (!filter) {
 			damon_sysfs_scheme_filters_rm_dirs(filters);
 			return -ENOMEM;
@@ -1607,11 +1630,11 @@ static int damon_sysfs_scheme_set_watermarks(struct damon_sysfs_scheme *scheme)
 }
 
 static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme,
-		const char *name,
+		enum damos_sysfs_filter_handle_layer layer, const char *name,
 		struct damon_sysfs_scheme_filters **filters_ptr)
 {
 	struct damon_sysfs_scheme_filters *filters =
-		damon_sysfs_scheme_filters_alloc();
+		damon_sysfs_scheme_filters_alloc(layer);
 	int err;
 
 	if (!filters)
@@ -1630,15 +1653,18 @@ static int damos_sysfs_set_filter_dirs(struct damon_sysfs_scheme *scheme)
 {
 	int err;
 
-	err = damon_sysfs_scheme_set_filters(scheme, "filters",
+	err = damon_sysfs_scheme_set_filters(scheme,
+			DAMOS_SYSFS_FILTER_HANDLE_LAYER_BOTH, "filters",
 			&scheme->filters);
 	if (err)
 		return err;
-	err = damon_sysfs_scheme_set_filters(scheme, "core_filters",
+	err = damon_sysfs_scheme_set_filters(scheme,
+			DAMOS_SYSFS_FILTER_HANDLE_LAYER_CORE, "core_filters",
 			&scheme->core_filters);
 	if (err)
 		goto put_filters_out;
-	err = damon_sysfs_scheme_set_filters(scheme, "ops_filters",
+	err = damon_sysfs_scheme_set_filters(scheme,
+			DAMOS_SYSFS_FILTER_HANDLE_LAYER_OPS, "ops_filters",
 			&scheme->ops_filters);
 	if (err)
 		goto put_core_filters_out;
-- 
2.39.5

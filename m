Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10B266B42;
	Wed,  5 Mar 2025 22:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213659; cv=none; b=k/YkBj9o/oTQyPHKgJxT3+DIkBBYyANg1skm3HSNOEOn7n6hPFx1hiLxu42ywGvVxM/M0yOhc7zBCNknyfqiTt0cu3NGcjtju7ja0uOQCvRmeXkmDOnX1LXhw1wGhGWGqlvULYs+5uU0AvjJ0bqn6nRECUfOwnP7GZt4UcHCk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213659; c=relaxed/simple;
	bh=OpjcLDxsccLyhNm0FxG5QdoWmIkJ0HjMaFtLsbzpWMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltPCoMKlustYxNv/dKgrb8xwOSkTKT3/OD4hKNKeUADy39MT7XQ0TjIP0pq44Z7tfnaAeKgMV0oytKE84ldYZ+YkU3Z+1STVZbWs40JOAGnYvq/yRUpscB3jAS4cGfw0+oMTkT5Vecwa+hw3/flNwNNNv8L/b0qhvuPt76n7yJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6/FBMSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6/FBMSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EA9C4CED1;
	Wed,  5 Mar 2025 22:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213659;
	bh=OpjcLDxsccLyhNm0FxG5QdoWmIkJ0HjMaFtLsbzpWMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6/FBMSgQVrOici0mbqK5Zz2q121hKQ90mpoRt1jvWNL4rdHuUukYMSqZHjwWeIYn
	 ZSu7YU66rHiK91B7IA/lmZWNK9aRZigfjjnSaIDQfAx4Eqyr6Nz/1LVI6nofqL7Wir
	 01RdrzhjTteerB8sEERse1+cmDZOVqmYZ2zvxKzN56dG8/+hwYLJIwsb8oRkc6L42T
	 3sNodszdWMb4IW5T/zyltjJW6WU4TUIic5Rt92fyxpA3GLCywpMUlxb+7ZXdbwLdI/
	 qImf3tpp8hKjm9RyGIooK5FDtpOuMkn+UymvRcINrAwX3yv5OwzkX9JI1gHC3WmiRD
	 xECHKJ83hwFGA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mm/damon/sysfs-schemes: let damon_sysfs_scheme_set_filters() be used for different named directories
Date: Wed,  5 Mar 2025 14:27:26 -0800
Message-Id: <20250305222733.59089-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305222733.59089-1-sj@kernel.org>
References: <20250305222733.59089-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_scheme_set_filters() is using a hard-coded directory name,
"filters".  Refactor for general named directories of same files
hierarchy, to use from upcoming changes for adding sibling directories
having files same to those of "filters", and named as "core_filters" and
"ops_filters".

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 66a1c46cee84..541ca5887b24 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1604,7 +1604,9 @@ static int damon_sysfs_scheme_set_watermarks(struct damon_sysfs_scheme *scheme)
 	return err;
 }
 
-static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme)
+static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme,
+		const char *name,
+		struct damon_sysfs_scheme_filters **filters_ptr)
 {
 	struct damon_sysfs_scheme_filters *filters =
 		damon_sysfs_scheme_filters_alloc();
@@ -1614,11 +1616,11 @@ static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme)
 		return -ENOMEM;
 	err = kobject_init_and_add(&filters->kobj,
 			&damon_sysfs_scheme_filters_ktype, &scheme->kobj,
-			"filters");
+			name);
 	if (err)
 		kobject_put(&filters->kobj);
 	else
-		scheme->filters = filters;
+		*filters_ptr = filters;
 	return err;
 }
 
@@ -1670,7 +1672,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
 		goto put_quotas_access_pattern_out;
-	err = damon_sysfs_scheme_set_filters(scheme);
+	err = damon_sysfs_scheme_set_filters(scheme, "filters",
+			&scheme->filters);
 	if (err)
 		goto put_watermarks_quotas_access_pattern_out;
 	err = damon_sysfs_scheme_set_stats(scheme);
-- 
2.39.5

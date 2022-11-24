Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFA79E9
	for <damon@lists.linux.dev>; Thu, 24 Nov 2022 21:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD92CC43147;
	Thu, 24 Nov 2022 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669324884;
	bh=FrCQktxb/IHIkJr0quKPsuPjXDJwuo+SRuylRA+I1fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRxL/q2g8NWpSQCutGPjfq4P2N/YBsWxmeL5Gok4EK2itrLtEnIQ24rhpi0GZzI2t
	 FALEHRm3hMVoWYKWgI6T4Og4yKjy+KOh3oY1U3PFY4FGn6QUWwWVLwVW274l7eEn5w
	 +utRorYUkFfkos6yTaO+uuKYX0gHxaYGdpRyX69kb3eMo51IKZW3ro8TBplYwathq7
	 Og8dIjZUI1YThNcJaBo9oyPITPqoo6MIADODcXVzRqwEL3iq04Agg2Msai9wMvIFbc
	 3jnNWAwmB8o4d0jzMIQwnIDjKtshiR7qvil6B+Ng13wZnj++p4uCBytRZp38XpgKGE
	 ieAYUaSeE6fJw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 08/11] mm/damon/sysfs-schemes: implement scheme filters
Date: Thu, 24 Nov 2022 21:21:11 +0000
Message-Id: <20221124212114.136863-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124212114.136863-1-sj@kernel.org>
References: <20221124212114.136863-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement scheme filters functionality of DAMON sysfs interface by
making the code reads the values of files under the filter directories
and pass that to DAMON using DAMON kernel API.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 85 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7f2bab617156..6f014b328e6f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1402,6 +1402,71 @@ struct kobj_type damon_sysfs_schemes_ktype = {
 	.default_groups = damon_sysfs_schemes_groups,
 };
 
+static bool damon_sysfs_memcg_path_eq(struct mem_cgroup *memcg,
+		char *memcg_path_buf, char *path)
+{
+#ifdef CONFIG_CGROUPS
+	cgroup_path(memcg->css.cgroup, memcg_path_buf, PATH_MAX);
+	if (sysfs_streq(memcg_path_buf, path))
+		return true;
+#endif
+	return false;
+}
+
+static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
+{
+	struct mem_cgroup *memcg;
+	char *path;
+
+	if (!memcg_path)
+		return -EINVAL;
+
+	path = kmalloc(sizeof(*path) * PATH_MAX, GFP_KERNEL);
+	if (!path)
+		return -ENOMEM;
+
+	for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
+			memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
+		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
+			*id = mem_cgroup_id(memcg);
+			break;
+		}
+	}
+
+	kfree(path);
+	return 0;
+}
+
+static int damon_sysfs_set_scheme_filters(struct damos *scheme,
+		struct damon_sysfs_scheme_filters *sysfs_filters)
+{
+	int i;
+	struct damos_filter *filter, *next;
+
+	damos_for_each_filter_safe(filter, next, scheme)
+		damos_destroy_filter(filter);
+
+	for (i = 0; i < sysfs_filters->nr; i++) {
+		struct damon_sysfs_scheme_filter *sysfs_filter =
+			sysfs_filters->filters_arr[i];
+		struct damos_filter *filter =
+			damos_new_filter(sysfs_filter->type,
+					sysfs_filter->matching);
+		int err;
+
+		if (!filter)
+			return -ENOMEM;
+		if (filter->type == DAMOS_FILTER_TYPE_MEMCG) {
+			err = damon_sysfs_memcg_path_to_id(
+					sysfs_filter->memcg_path,
+					&filter->memcg_id);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
 static struct damos *damon_sysfs_mk_scheme(
 		struct damon_sysfs_scheme *sysfs_scheme)
 {
@@ -1410,6 +1475,10 @@ static struct damos *damon_sysfs_mk_scheme(
 	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
 	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
 	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
+	struct damon_sysfs_scheme_filters *sysfs_filters =
+		sysfs_scheme->filters;
+	struct damos *scheme;
+	int err;
 
 	struct damos_access_pattern pattern = {
 		.min_sz_region = access_pattern->sz->min,
@@ -1435,8 +1504,17 @@ static struct damos *damon_sysfs_mk_scheme(
 		.low = sysfs_wmarks->low,
 	};
 
-	return damon_new_scheme(&pattern, sysfs_scheme->action, &quota,
+	scheme = damon_new_scheme(&pattern, sysfs_scheme->action, &quota,
 			&wmarks);
+	if (!scheme)
+		return NULL;
+
+	err = damon_sysfs_set_scheme_filters(scheme, sysfs_filters);
+	if (err) {
+		damon_destroy_scheme(scheme);
+		return NULL;
+	}
+	return scheme;
 }
 
 static void damon_sysfs_update_scheme(struct damos *scheme,
@@ -1447,6 +1525,7 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
 	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
 	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
+	int err;
 
 	scheme->pattern.min_sz_region = access_pattern->sz->min;
 	scheme->pattern.max_sz_region = access_pattern->sz->max;
@@ -1469,6 +1548,10 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 	scheme->wmarks.high = sysfs_wmarks->high;
 	scheme->wmarks.mid = sysfs_wmarks->mid;
 	scheme->wmarks.low = sysfs_wmarks->low;
+
+	err = damon_sysfs_set_scheme_filters(scheme, sysfs_scheme->filters);
+	if (err)
+		damon_destroy_scheme(scheme);
 }
 
 int damon_sysfs_set_schemes(struct damon_ctx *ctx,
-- 
2.25.1


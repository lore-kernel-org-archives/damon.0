Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC737E2FB;
	Thu, 25 Jun 2026 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397494; cv=none; b=J0qY9A5z0z9bgUNTQfhoRIrRDzbQe0JbWDYMCJwYF3VP16exHulMcYkPZcrckneffA0AvB1opW8v7oai9eODMc8vxzVzoUaxuLgd3AYZG4DP6/9rKlxeU7i+mpI7+mt3S6aS8yPc7pAjjiH1F5CeMn9oC2SbztCWyeM1kKh/x2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397494; c=relaxed/simple;
	bh=okIK07moQLx3ER5ErmrgTfwRe5dUBIZuWmrnRf1ysJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QU2EOhVjaie4vB7FXCqPAxHQjBUTVX43MudWKn7HNn4OjWLHD7K7JtHiahofmCQsxLkLmLokFHz+m86cjm0ylvSL4E3Aw0/uAUgPnXPBoVZZItuOlBcuYohzGrXZHGSAXnRDGqbZTrjr7Rxx+9bfx1oPHjaeEAIAw0B4WTWqFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX6h3onx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX6h3onx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1391F00A3A;
	Thu, 25 Jun 2026 14:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397492;
	bh=rt+skPoflDd8ZOfYhc/MuTewnEe5bpXk/xs4uU5zeT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bX6h3onxlEPGQYf3PNZ2j6wn2PBhLPtbrlz7+2QYO4tIjFYsRBZdRhINQOUiue6Jc
	 qHbXiLxUNAQ/5efM6gM1ViuqNaYAp+yTEWlF7ED28r1vRTuNh9vYEWUwNfPfe1mP5L
	 ucmdbBsz0FvwS6l12z8b6vMLMF8TTHmFk8axWIuB8XCV2JUiCRC3YdQ0gYxq25Av6f
	 U6jwbOFbtqhCdOTaUGckvY0P6JrerlrkwV2WQ52XmDZCacXw5VPHIH/LFBRf5DlwEy
	 3JGgty2p7/6Zz40inUICEuardN9dBWESYxM9cGsG6L2f/sU1vHPPWO/BpxI+dnvVv8
	 LrBm9ImAXP/Wg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 09/11] mm/damon/sysfs: split probe setup function out
Date: Thu, 25 Jun 2026 07:23:54 -0700
Message-ID: <20260625142357.103500-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625142357.103500-1-sj@kernel.org>
References: <20260625142357.103500-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_set_probes() function is relatively long.  It has two nested
loop for setting two nested entities, namely probe and filter.  Split
out the probe level setup for readability.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 80 ++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 2e95e3bac774d..982d824f63c21 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1899,47 +1899,59 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 	return damon_set_attrs(ctx, &attrs);
 }
 
-static int damon_sysfs_set_probes(struct damon_ctx *ctx,
-		struct damon_sysfs_probes *sys_probes)
+static int damon_sysfs_set_probe(struct damon_probe *probe,
+		struct damon_sysfs_probe *sys_probe)
 {
+	struct damon_sysfs_filters *sys_filters;
 	int i;
 
-	for (i = 0; i < sys_probes->nr; i++) {
-		struct damon_sysfs_filters *sys_filters =
-			sys_probes->probes_arr[i]->filters;
-		struct damon_probe *c;
-		int j;
+	sys_filters = sys_probe->filters;
+	if (!sys_filters)
+		return 0;
 
-		if (!sys_filters)
-			continue;
-		c = damon_new_probe();
-		if (!c)
+	for (i = 0; i < sys_filters->nr; i++) {
+		struct damon_sysfs_filter *sys_filter =
+			sys_filters->filters_arr[i];
+		struct damon_filter *filter;
+
+		filter = damon_new_filter(sys_filter->type,
+				sys_filter->matching,
+				sys_filter->allow);
+		if (!filter)
 			return -ENOMEM;
-		damon_add_probe(ctx, c);
-
-		for (j = 0; j < sys_filters->nr; j++) {
-			struct damon_sysfs_filter *sys_filter =
-				sys_filters->filters_arr[j];
-			struct damon_filter *filter;
-
-			filter = damon_new_filter(sys_filter->type,
-					sys_filter->matching,
-					sys_filter->allow);
-			if (!filter)
-				return -ENOMEM;
-			if (filter->type == DAMON_FILTER_TYPE_MEMCG) {
-				int err;
-
-				err = damon_sysfs_memcg_path_to_id(
-						sys_filter->path,
-						&filter->memcg_id);
-				if (err) {
-					damon_destroy_filter(filter);
-					return err;
-				}
+		if (filter->type == DAMON_FILTER_TYPE_MEMCG) {
+			int err;
+
+			err = damon_sysfs_memcg_path_to_id(
+					sys_filter->path,
+					&filter->memcg_id);
+			if (err) {
+				damon_destroy_filter(filter);
+				return err;
 			}
-			damon_add_filter(c, filter);
 		}
+		damon_add_filter(probe, filter);
+	}
+	return 0;
+}
+
+static int damon_sysfs_set_probes(struct damon_ctx *ctx,
+		struct damon_sysfs_probes *sys_probes)
+{
+	int i, err;
+
+	for (i = 0; i < sys_probes->nr; i++) {
+		struct damon_sysfs_probe *sys_probe;
+		struct damon_probe *p;
+
+		p = damon_new_probe();
+		if (!p)
+			return -ENOMEM;
+		damon_add_probe(ctx, p);
+		sys_probe = sys_probes->probes_arr[i];
+		err = damon_sysfs_set_probe(p, sys_probe);
+		if (err)
+			return err;
 	}
 	return 0;
 }
-- 
2.47.3

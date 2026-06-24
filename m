Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592DD3C13FE;
	Wed, 24 Jun 2026 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310836; cv=none; b=AhkYjDFV35KtY/pazYWmSp2mMjOjiXWPZDWHPv6owl8ieq+xRToKVlmGoyB4WE1elPmSXwxfejxoyPFyTh1Evr9pYe5dVtk5okbbQuw3cc3Zz2JSG7ZNqSK3QAQB6dL/nZA8gEG1xYwXvJ+Kyf2GrcHjWzvTuIebkuR3iGx9GnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310836; c=relaxed/simple;
	bh=Xqgbuq/B7lsiyjC9z+Hv2/6FwxWyYmnX8cCNrmIZCSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw9TmaKk/+JcOnG/lwsscCOBVjQZCb4NwRsmsL6pUCMMIzWY/+8zYobFLLUhzSKs4cu7/RteNpQPyHlZApLqpM2o5ZTJbevDQBi9oFdV7hv5SQfhrghN1pUS+xxKkmGYP+LMgpU5msss7Ctyn6Eqquq++ztayWz8RRgf/laEDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyfqY9FG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyfqY9FG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AA91F000E9;
	Wed, 24 Jun 2026 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310834;
	bh=EUjYA4YKs65xmCeOj45MTc/zAzF9jp3SHtMdBi79Pxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DyfqY9FGL34hmvkr50EjzNCE03Mzek6Y95cn6oNRfig2AXRzDllUwH3aAcoCgCxpq
	 Pi/hx1N11V6IwhN4szDSPNzOQoJeWyPUTFkKmC705pNubTx6Bcrg6iBFAnXw2rnw50
	 qC9QfxBw9FbDh/t0SHhBFQCirZQpoNwMm4FPMwJvzHe3Zi2S9Hz0ZsFXyv17vWYNBW
	 /kC7N2xKGa8C430pW8n4nGUlJilTXGp3JZMRA4clWvh7NpLCqXlYwthBsXgABZkerF
	 5Vpj47B50r+czaKNstGy0zGJGfBmB9vVErCVF5s1Q63xn4CRS3KUiTk4f5RVUyrmXD
	 tanr1ikilfjVg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/11] mm/damon/sysfs: split probe setup function out
Date: Wed, 24 Jun 2026 07:20:05 -0700
Message-ID: <20260624142008.87180-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624142008.87180-1-sj@kernel.org>
References: <20260624142008.87180-1-sj@kernel.org>
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
index ffbc99411f53b..b662afd41791d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1911,47 +1911,59 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
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

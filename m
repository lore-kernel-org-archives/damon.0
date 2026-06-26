Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06332D877A;
	Fri, 26 Jun 2026 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433034; cv=none; b=iVjcmnroxnOTYpq+RJ1O3gBcDgUDucQfeny6lmiWv6RBaiTRFl2dDTvx1NBuuhm38VIFBa1RSh4lJEF5N17Yi/TuyKCBidtwM3pl8Ov+ImNY4uKRRQUS9Sd0P5AA3900jXYn3hnw9TCycuF8eTGkcZfyzBcAzyUJ7hHo8HJc58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433034; c=relaxed/simple;
	bh=okIK07moQLx3ER5ErmrgTfwRe5dUBIZuWmrnRf1ysJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plsiyiPAUdaqPkmSKIzE/iacyVM8ylYyimJfr+kUeZDWza+m/mPJYG9U/iDH8FkctammhizgUlJMJY9xfnMiAZPjkE01gtvRaQHgO29fHcawj4Ma1mwFUD2cTNN7NFomJg9AvRjU77u0pyBSEnyg1RkwzcDgqglF7xy8kx8wjq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfICE3kp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfICE3kp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF5F1F000E9;
	Fri, 26 Jun 2026 00:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433033;
	bh=rt+skPoflDd8ZOfYhc/MuTewnEe5bpXk/xs4uU5zeT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfICE3kp1MAmkg3sO4IPg+CEhVM5iqAwq/8P7b0D0kwAwI0wynL1K6Z0cHm/E9u2R
	 MaBxBpzG0LlLPTRiDBlJ7cT1NSFjSABK2RNe2IQ02GB6InNbvDzl0TCkZuWEnCqsP3
	 jEkZBgFN72CvCXsFo7NK+nQhEZpBrcvAvZLnovCOPXjygf2+yzEYrRRJNW2IFwk62v
	 GaZ4t8R//wd7rBXe5LSbuNF0S9bktlscdzw7JPZ0JQvMaB2uvEHl7XJQ8ixj0QW7ZO
	 bkpwlGQiZsWLnENtyNVqve0VjP7Jr8tXXOcx7BCVQxGQAihtWStFd7fpNNDPXHpyUd
	 AI7P+UuwUUpRA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 09/11] mm/damon/sysfs: split probe setup function out
Date: Thu, 25 Jun 2026 17:16:40 -0700
Message-ID: <20260626001644.85825-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626001644.85825-1-sj@kernel.org>
References: <20260626001644.85825-1-sj@kernel.org>
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

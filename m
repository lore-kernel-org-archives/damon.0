Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98B2E738E;
	Fri, 26 Jun 2026 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433035; cv=none; b=bGfI6HGNurvSLkzSQ+6owQiDBfyXGJzZyYFVxTo9dlhz4/VhBXRsFy7FRLVa077gHko9zvtj6euNEIM4fB/Zves/L4XkV6qv5OZWOM8sJe54i10c03zqfhnxMAuEys0+BKXBje9MijudEHdMtC3g5AGGBub1Z2ETT5EZzvD74vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433035; c=relaxed/simple;
	bh=RA5E0IVRziTxkehe8RwMfImo5CCC3gzpNK3zQdywLIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJad29DM3o7i+qtWw/b7tqRtPHm4KqDPl0X7Ko6NG/VgiM2R4DwaGmNMASuU+NEbLn2cRp1gPBZxpc+oJAJgL1NiopCkNBTqXw9Vmh+skJNliBN6xufuRMKvpNx6hCua1tY99VjgEGwtrvHm5PZ0nPndpo7fhwXyg2w4b61dqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWfA4IyA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWfA4IyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71161F00A3E;
	Fri, 26 Jun 2026 00:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433034;
	bh=QU3Mdz0QWuS68FFe2kfHvyIPhX+22pphhD8CNUTJFTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lWfA4IyAJHopNKP4vyAHu4NTSxCRpcoIH3gthHc/XsYcOwP2k7nthFA3+VRavn4YC
	 tTuZyNhmSS5YCVxT0FTJqIZRDlECUigr2l+TNyE44ic2mMg4KE82KvAahbeUTE/A4y
	 JIszmYeyNnVmG4D5c/nm0Zuq5p/EJ01eWSDD6Nv9CQDF2g0zGxQSIVOwzdmqr3qw5t
	 vVJiDsuPZhN6riI7oNqnA3yi6RMKhWYg3LGW/2VL4KTLD+12I6BV1nO0/prPyFEH5i
	 06gzK3ZtwHtKriUr3AehVMx/Nun63DfMuOZA3MrZh5TAbq6PoNI+Orre8Cii1X1U7q
	 g/+3BODmNIzsQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 10/11] mm/damon/sysfs: split out filters setup function
Date: Thu, 25 Jun 2026 17:16:41 -0700
Message-ID: <20260626001644.85825-11-sj@kernel.org>
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

damon_sysfs_set_probe() is doing not only probe setup but also filters
setup.  Split out filters setup for readability.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 982d824f63c21..f3bb146b204df 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1899,16 +1899,11 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 	return damon_set_attrs(ctx, &attrs);
 }
 
-static int damon_sysfs_set_probe(struct damon_probe *probe,
-		struct damon_sysfs_probe *sys_probe)
+static int damon_sysfs_set_filters(struct damon_probe *probe,
+		struct damon_sysfs_filters *sys_filters)
 {
-	struct damon_sysfs_filters *sys_filters;
 	int i;
 
-	sys_filters = sys_probe->filters;
-	if (!sys_filters)
-		return 0;
-
 	for (i = 0; i < sys_filters->nr; i++) {
 		struct damon_sysfs_filter *sys_filter =
 			sys_filters->filters_arr[i];
@@ -1935,6 +1930,17 @@ static int damon_sysfs_set_probe(struct damon_probe *probe,
 	return 0;
 }
 
+static int damon_sysfs_set_probe(struct damon_probe *probe,
+		struct damon_sysfs_probe *sys_probe)
+{
+	struct damon_sysfs_filters *sys_filters;
+
+	sys_filters = sys_probe->filters;
+	if (!sys_filters)
+		return 0;
+	return damon_sysfs_set_filters(probe, sys_filters);
+}
+
 static int damon_sysfs_set_probes(struct damon_ctx *ctx,
 		struct damon_sysfs_probes *sys_probes)
 {
-- 
2.47.3

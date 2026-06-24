Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465093BED75;
	Wed, 24 Jun 2026 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310841; cv=none; b=kHF/Px9PrDMwQhlWhzji7kEKZMS20Gvir6krzARp35m4P1rwwTTrdCMTSsRkWoJBWrYUQKMX1YWc+821Cqq4OqRWrOnTOwkEkC1x0BN9VCPvYRsGDmSx0P8QfmUyIVDfJ9QHy9dQfPadwkOC3RODrGz0l7cv0bzkQ/JQWaX/8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310841; c=relaxed/simple;
	bh=OuKVjU1HzNhEWiEzzIPzdplPmLLvDduO5SPgJPM7B3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeYlPXhUqgm6rK0madAynD9hPyzntS+PPeG0eQar5dXrVvf0VGexSZEd3phZ4UMf05QhYJdIHRaOPyVHIT+zFmhfvblvGkvXq/rdNLRe0fKh6VhitHGWUf0srlMMPjvP3ZcqeIFodZpodNrM2pnqCA/4IwxFloJHPHNxwXXf8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHvS5sZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHvS5sZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4031C1F00A3E;
	Wed, 24 Jun 2026 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310836;
	bh=7XnY6JlGmHDm9EPC8r6m1olyqqXaV+5C6iqLBZxkBgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHvS5sZvbu6AMpXrSj9t69t+7pcsUYEI+ma72cqQP5jzjOOGtA0QPX47XCx6c8V81
	 Z2niPSXaVrB+sLfQhh5QBjAtrULh1oLX9Z/A8As7GFi9agOt+c9LOM/Bu/L9srgKvN
	 z/1ki0kxptxnW6PfLIINFwHLFBPt8W3IRu4mxydgChlJ1kK9vOS+s+9LZxICu+w3F3
	 E+8IcqPs2+l4b+ZiWD+hWxghtj/QBxkGpE8ep0arwZofOj04t0I0EHxUZDlywFOvek
	 jXIiCRDpWZlqIRSPRTnWOojwqx69WDK+oFArv3ytOmYVycrWwY2g/YWIf/k4KUL+oh
	 nHR4nXPzP0xfQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/11] mm/damon/sysfs: split out filters setup function
Date: Wed, 24 Jun 2026 07:20:06 -0700
Message-ID: <20260624142008.87180-11-sj@kernel.org>
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

damon_sysfs_set_probe() is doing not only probe setup but also filters
setup.  Split out filters setup for readability.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b662afd41791d..92de341827cab 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1911,16 +1911,11 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
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
@@ -1947,6 +1942,17 @@ static int damon_sysfs_set_probe(struct damon_probe *probe,
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

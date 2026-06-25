Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E7330276A;
	Thu, 25 Jun 2026 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364109; cv=none; b=Eo+9cuu+EPSj8ocipg7GRCHvHTO+I1WN9q7sO7tmmPZucQwcIjjDbzBHODy8Ei9Nq2/pVROmCKV59RysIFVLWak+IeuQEZvOcSkm4n4mfoSu/WAy4bsR4aCSIN1BekWKBQTY/gnSUnZdfHRvS9zOLxWiesvHhkp7TO8ZEYsNvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364109; c=relaxed/simple;
	bh=RA5E0IVRziTxkehe8RwMfImo5CCC3gzpNK3zQdywLIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLTcsK0UvAAL8FvMuMfTNqLrmb3sM+IgpZnh7K3L0tg2XNKLrZVsVPSL8dxd+bT6JTx1RJSru6V0FaL6OtCambIIDHbkADWmFQQZCvISucIfgkgxfm2PRumZUX9a1y3hJD4kET5NeSWWwmTNqewhGwYpYdIsCE1+gO86iWA8nZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAaXcJYy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAaXcJYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419571F00A3E;
	Thu, 25 Jun 2026 05:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364107;
	bh=QU3Mdz0QWuS68FFe2kfHvyIPhX+22pphhD8CNUTJFTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MAaXcJYyEtQEueJLO/n8K9/UB7R2lm3O+yqiiBrNDseZgWoCAyOoWnaTXQMFBw2kU
	 OCiDajI6Ciumy2p0ZI8b9sOR9AW5FpSH7h/z5HrImTuOxaPLVD8SC8CG7rjM83NkKY
	 LIg6JkDyi+yGNW52qbt/jmy/5Mhv0UH96ijuhBEZxV+fxIr/19/tbCxC7UTimTNk2j
	 pfJCTDHqFfiCS6biAc6yjNXUIAsmFaSqfsC3UAD0Sh262N1ixys7K3EEoWdK4yD1tu
	 iTzmbVHxT9i+2TFhveDZ0jLkm6QRPVe8700pTWtd8bw9Hnc+eAe4PTdQndb46RaTgd
	 y1Nc8VM4NcA5g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 10/11] mm/damon/sysfs: split out filters setup function
Date: Wed, 24 Jun 2026 22:07:53 -0700
Message-ID: <20260625050756.91115-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625050756.91115-1-sj@kernel.org>
References: <20260625050756.91115-1-sj@kernel.org>
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

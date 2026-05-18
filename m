Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD635344D9D;
	Mon, 18 May 2026 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147688; cv=none; b=Mkfoh2RI+un3JdWvXtKfF7MjvOBcbOOgaKPrSj9CzCI+7ppRdZcp+BVcgJrhv82Ypvo8So7+JMnpcI/QDTksHy29XxHF5+4rvmFRgWvU+j7R0Rupp0ptSEJYAzCgDeouQqT80OD8IQOWALiWes8chW1Fnd+Yx3OkTsF4JgThGYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147688; c=relaxed/simple;
	bh=foWtH36Q1RoAgy2NDpXfRZA2kQ9BRRcIQByE1JbM4RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOuCXKRs5EyP1Kjt4Y7pyD38GCjnhIExTWsJ9xqWXjz4syVTayYmVeJ+yEvj4sglyYymNzlOqWvmiD8JIVvmwRT1sP6sda3vXT6IJ7/bE4GtlaaywkzfbngaL2bex/TVpTzQHC+8CjZefhMKAlwn43DtHioVrskxLp2aOJN2f7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtqJ7PSm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtqJ7PSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1A7C2BCB8;
	Mon, 18 May 2026 23:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147688;
	bh=foWtH36Q1RoAgy2NDpXfRZA2kQ9BRRcIQByE1JbM4RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtqJ7PSm6gqQlw+wraffFbAk4b2n9djCzxehALH8UETbcdW2RBd7zxyqfB/x7ca/4
	 m04k2OXrkOjnZwQbBD9P37fWEQRPS3d7NuztyzJawfgqE5BzJem5BQfjLpXjsdQlGZ
	 ELS3ibL5Tcg56X5oVwP6FmddbGxLgrDLjvhFcu6Nzg9rd7toJvDd1dniqS+U9kMMMc
	 dnVBXJqtYO9GzXd7oxJEep42QNklP5zBpyEstNJXBg9I8kDDgIEqjXHfpLL7zw3nbw
	 +ghKd6OZ3dY6p3yIzBooc1TcDQaVNPHkGHvHxysgumly0hauXWuRVtxqgiIRMQqjs6
	 vbKX098uCoxAw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 14/28] mm/damon/sysfs: setup probes on DAMON core API parameters
Date: Mon, 18 May 2026 16:41:02 -0700
Message-ID: <20260518234119.97569-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add user-installed data probes to DAMON core API parameters, so that
user inputs for data probes are passed to DAMON core.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 51a4f05c9275c..eeb7fdd030cf0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1855,6 +1855,40 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 	return damon_set_attrs(ctx, &attrs);
 }
 
+static int damon_sysfs_set_probes(struct damon_ctx *ctx,
+		struct damon_sysfs_probes *sys_probes)
+{
+	int i;
+
+	for (i = 0; i < sys_probes->nr; i++) {
+		struct damon_sysfs_filters *sys_filters =
+			sys_probes->probes_arr[i]->filters;
+		struct damon_probe *c;
+		int j;
+
+		if (!sys_filters)
+			continue;
+		c = damon_new_probe();
+		if (!c)
+			return -ENOMEM;
+		damon_add_probe(ctx, c);
+
+		for (j = 0; j < sys_filters->nr; j++) {
+			struct damon_sysfs_filter *sys_filter =
+				sys_filters->filters_arr[j];
+			struct damon_filter *filter;
+
+			filter = damon_new_filter(sys_filter->type,
+					sys_filter->matching,
+					sys_filter->allow);
+			if (!filter)
+				return -ENOMEM;
+			damon_add_filter(c, filter);
+		}
+	}
+	return 0;
+}
+
 static int damon_sysfs_set_regions(struct damon_target *t,
 		struct damon_sysfs_regions *sysfs_regions,
 		unsigned long min_region_sz)
@@ -1967,6 +2001,9 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
 	ctx->pause = sys_ctx->pause;
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
+	if (err)
+		return err;
+	err = damon_sysfs_set_probes(ctx, sys_ctx->attrs->probes);
 	if (err)
 		return err;
 	err = damon_sysfs_add_targets(ctx, sys_ctx->targets);
-- 
2.47.3

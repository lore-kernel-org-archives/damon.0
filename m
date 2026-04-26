Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8A30DD3C;
	Sun, 26 Apr 2026 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236759; cv=none; b=KUA8ChVzOLxh/TGDDXJwL+uRTSyZoDHBBhHmuzJx+/CMnL7gNwDSdJZUC0zKpkIrPJUHdWzUlDvJr1H3ZOEOMqn2oqjVr/C2iN2QU1GkzSehGZz5dUbwJ5kUAXHRnhAIlj9dQ4kKnF0R96U3i9UOOjbLhkKTFlQ8fmRZez+afNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236759; c=relaxed/simple;
	bh=YkBI5K8l4kX9GxDYWU0L93ohTAXKAjjCaL6+mqVkPmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAKmy9KElBVdJv+mwkVLDclzsLzdZukPYNA+jY/4SR6Hf6I1Pjwu/iHbnfjlpEg2MtVG17H/PGLBvNOeZrkzbWH6ziMsmMEtwbUplWXo1584HTYK5z4KriBWpHDUCjh9qOT07hRlD35UhovPAwCThNDL0aRdfVNA6pBf4n6djqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie4ISYBB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie4ISYBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428E7C2BCB6;
	Sun, 26 Apr 2026 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236759;
	bh=YkBI5K8l4kX9GxDYWU0L93ohTAXKAjjCaL6+mqVkPmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ie4ISYBBbYbks+BRWXlN8FTrrPZPAbU077AJgFANVwD/kLYdI1OgtmoZX+j8cajXU
	 b8rTYtiHOyYBocsuvSOcK72XG9M634CHBkY7D0t8eQHTgeiVa0ISodBBRt8OipRSDN
	 3zzJvgUYWBzCz26Luodu113b196lFHXF/lyNV6jIaeXpZRnYLUFRFhdeoWCm+tcSFs
	 z73AvTRrN+na2Qbp6lsj0GUCbcodwiDNYtjPcVD32hpG/WSmDamlmRDCm8VTVwdzF4
	 WAQZa0E9do+5y+CKpKG2+JoWKlGIycRjypC0f5UVNs569nhKhuRGuZCEIi2mg309o5
	 ksNHeCcJQq6Tg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 14/19] mm/damon/sysfs: setup probes on DAMON core API parameters
Date: Sun, 26 Apr 2026 13:52:15 -0700
Message-ID: <20260426205222.93895-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426205222.93895-1-sj@kernel.org>
References: <20260426205222.93895-1-sj@kernel.org>
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
index 2e0b7eca6bcbf..8007961295d3d 100644
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
+			struct damon_filter *t;
+
+			t = damon_new_filter(sys_filter->type,
+					sys_filter->matching,
+					sys_filter->allow);
+			if (!t)
+				return -ENOMEM;
+			damon_add_filter(c, t);
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

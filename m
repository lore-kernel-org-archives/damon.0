Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB40366806;
	Fri, 15 May 2026 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805892; cv=none; b=K/QyHBj59AsfTnPh67yrMCXXophsLRxyKYn17yS73EDD0ToQrxa7NQ81zNzx2IDSRHFxLuZhBLb7tFiAji6qTo2lxxzzVywZ0c4Ei8biNAzuv7N8t4IaIHvPv3LJOR5bR51jwLRo+If+Zyu0IHC2/9/aY8YEYZkiRFCob269z4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805892; c=relaxed/simple;
	bh=FnXqCOHFDGvJv0wq5YsdefT6POS2mPmRouI+CopcLks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8Yq/l9M+JPH4Z98qgU2mX6U0Xfe/oYnsukewOPDEYGLWJZYzwfXoHo8FL1m9EGAz+iubNCwKLSNBdOB51Fbgtje9lLgwNF9l+EkFlgLmG8lQm30o6aFFmMa5FrulJW1RqNDw5E4KNAvIWlDCqFhbt+XD9JlLRnpvcklUAFEUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqAbhuCZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqAbhuCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2331C2BCB3;
	Fri, 15 May 2026 00:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805892;
	bh=FnXqCOHFDGvJv0wq5YsdefT6POS2mPmRouI+CopcLks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqAbhuCZYwRVTcA7zp+bkbgr+8Gico9Vyk+HnlFgYCZbFgcBnMGkWw7OE4gec/taI
	 qk9sHLP4yHjyMl5aMfY6HcjTMVJ+i7WCQ+h0D7c8YpjhCA8JDWd6HIDEYPoaryWMc9
	 R6FC/G/Nj6uOjZFpmrn03B8wVLPZR1Ve5H0790rxg9RpwNwlKi0y05IC7ErImmCQDL
	 OpEXOVx/RPSq3+xkoF5JjTzX7U8sZekzRO11/s+OW8d7/cdw8kLVFA+R7FZKAaRN33
	 9uAfmNXJOlpMgOiJJy3qbaTtlDDFCLlwqORZ55aWzwr+7wvQapV/H08MzzKQ6j+QJS
	 1beloxFlWaGpA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 14/28] mm/damon/sysfs: setup probes on DAMON core API parameters
Date: Thu, 14 May 2026 17:44:15 -0700
Message-ID: <20260515004433.128933-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
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
index dd520e39d3602..c2c172aeae149 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1825,6 +1825,40 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
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
@@ -1936,6 +1970,9 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 		ctx->min_region_sz = max(
 				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
+	if (err)
+		return err;
+	err = damon_sysfs_set_probes(ctx, sys_ctx->attrs->probes);
 	if (err)
 		return err;
 	err = damon_sysfs_add_targets(ctx, sys_ctx->targets);
-- 
2.47.3

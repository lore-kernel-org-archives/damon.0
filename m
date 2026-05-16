Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567233F8C3;
	Sat, 16 May 2026 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956649; cv=none; b=VQCFuNs4v5dVXUz1MKUskjNdkj7g7dUsotdCAGvCzC8M1R7As0sCOzepKgaxFkd2ngfI3LYu6Ldlgo5rCrVcFy6cSIApC9cnmLcAz12u7Bx5+8uqRWepXJHxK59s+fdy7V9gqxokLKudxjXeHdSmAhWoQA9eWN84xEnNAzsTxJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956649; c=relaxed/simple;
	bh=YQ/bQKvFB6FRBUR2JrGvHQEa09kCyYCD7LjEDEyXhiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKzZgcm5jtW4rBVNwGl/6TwZCnqKx8lRRrnfZ/0fwYaQ9qFbIxZgFmN/anxmx+gMgEy7YNJrTns1pg8HSImTqq0ZH82yr+3WUAcXSiI3qjNBo3oIUiPuf3OsZPYr56w6LkYFJLl67vHPVSTI7NlFH1J+kinLDUIndjKOnpPL3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOKV989N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOKV989N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3707AC19425;
	Sat, 16 May 2026 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956649;
	bh=YQ/bQKvFB6FRBUR2JrGvHQEa09kCyYCD7LjEDEyXhiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOKV989ND2cKNdGxP5PDsmVUlhDxYOfvNwWeKyweVV/m1LOK2+iouQjtCeLZcTL9u
	 ckuzNLAI+z6eKtXX1s6ATxZwKdlzfq0zOs5whRXO7SHV1q9+aNHd5U5Xeny3VLLYLt
	 1Y+QpEATiGsLtsCp1aSnFTRvP7qRrhnI260X+/s6MlMuZP4s+NFRkWGpO0chmYfWN3
	 FSCONfhKCZh+OLLo+EczCkZODe+PESe+HJS/QIdMj5E8UVUiNU3eADWgALGR8bpHKH
	 d2QeoUMjkVFe1gVy9ti1oI9p1xwZXWhylxFGMXGfa/Ue8+D4A1nYjjT0A/3SqtVTpH
	 KWNN7xmbPbBWA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 14/28] mm/damon/sysfs: setup probes on DAMON core API parameters
Date: Sat, 16 May 2026 11:36:55 -0700
Message-ID: <20260516183712.81393-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
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
index 35a4fa5c530f5..f1b7d79386866 100644
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

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B0378814;
	Thu,  2 Jul 2026 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026369; cv=none; b=g6EEulLxVdQ9DFO4vl7lWyZzuWu3Y1dEMzE7YDXo1tbjVxpVP1W/fEBGAuqOJ37jYOzpnhEXzXdmCQ8OwXiQgGW7oFGn3bHdGTmsfqbGnWLIJUfhvK5uXaf+bwydOmgY1cV1x2Q6hL9uqpGavGZGTxpmp4qX4dreLP0D+/RKJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026369; c=relaxed/simple;
	bh=Kvg9OrQ43oPQ0781qqZUt2aE4b6/BWEXTvCLUXj9UDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeWB+TYJ7tQK2hofm6L7Tk1/FM+fgqkTEeAfwPuw3VNWA4eY/Hl+YFAwM0jYZhJTQ2Gwf5XalH2RI05RMpkCNidtho/tSB9oDLU54TULS5L6ZS2toXUMkb6/u/z+xdlZkc/X9lHrThEkHYMtSDMuN+dmHXlnwjtmIRxxcybuF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orNg6UEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orNg6UEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA37D1F00A3D;
	Thu,  2 Jul 2026 21:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783026368;
	bh=Y3unaNvAR5NVnY1x+9C1/8TjIcTr9Grgg5m5/eq+8dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=orNg6UEfRALfBkf+MUF1sxATuW6DAkntBOP2Ths4c4tIdvd8knG/Eo1ZukPI6Jkh3
	 f/piXPhqqrMeVEIBMKNN7Ix8Ju1Oc4EnRKOqs2k+mAk1jSo9UrgdezXW3/y+njxdnq
	 s+L0eGAB9/+uhyTkh+4TfYCQe1yT4MBpdLR8MdXaq6xHLZuzXz6T80jfM4selgT+2b
	 psULNGSkJnJpIVgehJx3fPxcmtGVGEtRkeiopTmR6YrViFKji/KvQd1wZVsoYOTffF
	 Q1SgoifP27p22AB7/MvwEzjmtLU8BuSanGLDCSVE+2u6KY1GlMNQUv2/Ow7KuE7ovX
	 Faujjikv7epAQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 2/8] mm/damon/core: do parameter testing commit on damon_start()
Date: Thu,  2 Jul 2026 14:05:44 -0700
Message-ID: <20260702210551.95167-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702210551.95167-1-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_start() and damon_commit_ctx() are two main DAMON core API
functions for setting whole DAMON parameters.  While damon_commit_ctx()
does holistic parameters testing, damon_start() just believes the caller
validated the whole thing.  Embed the holistic parameter check that is
already in damon_commit_ctx() into damon_start().  After this change,
the callers can safely call damon_start() without validating the
parameters.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 018dd5ff80324..ca301abcb9ec5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1865,6 +1865,8 @@ static int __damon_start(struct damon_ctx *ctx)
 	return err;
 }
 
+static int __damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src);
+
 /**
  * damon_start() - Starts the monitorings for a given group of contexts.
  * @ctxs:	an array of the pointers for contexts to start monitoring
@@ -1886,8 +1888,16 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 	int err = 0;
 
 	for (i = 0; i < nr_ctxs; i++) {
-		if (!is_power_of_2(ctxs[i]->min_region_sz))
-			return -EINVAL;
+		struct damon_ctx *test_ctx;
+
+		test_ctx = damon_new_ctx();
+		if (!test_ctx)
+			return -ENOMEM;
+
+		err = __damon_commit_ctx(test_ctx, ctxs[i]);
+		damon_destroy_ctx(test_ctx);
+		if (err)
+			return err;
 	}
 
 	mutex_lock(&damon_lock);
-- 
2.47.3

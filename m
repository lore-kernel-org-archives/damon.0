Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269425E469;
	Fri, 10 Jul 2026 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691225; cv=none; b=SvtwFbr7myDvMc9KeEfzjLaelbKn63RnC4sJHmCbw1LjVGDdg59r2l/gIvuZcHtq270IUM3kTH1rkL1RZbMyaaS/v0Dg634YTu+g9PoHx6Tgo0OFGd6j47F5dZUsYu37NpfM9vYaGC3W4umWRSP8XwzLcjwLiJaLnEThbSmxMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691225; c=relaxed/simple;
	bh=JQsX7Gm1JD05lCIe7X4kBXFM6ajpTlxVt3gO1kGwky4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3Kmmou+is0dbr98mX6P3Zlw6CrMM9bgtoQQ/b0kLGK/vzzAcCG5rdtwr0hQOHgKxRTrUo761i7lZMsGtZQWfIpNm6mFECqWeFCKs/z880HJ0ueC4SFCc9CGAq6h5WxzBW8MZDUH+pswRhvKdt4SVqRnbb0BrYMFxM2iydptYo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2xx555d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2xx555d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786D21F00A3D;
	Fri, 10 Jul 2026 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691223;
	bh=0MmLe9bOPXvyR7OHttIBw8WieSr9mwuKyL25YGhL6QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N2xx555dFwRTDQ/8HpoGYjZjZIiG8+XH7Yr3Qkp+4vxUvr0Gk9mkQPeJadr4QLgPg
	 eU3B4GlgbZH8BPSfS8MyuN3y06Buv19uOd+LDdQ6btRatIBf5HxJAYa98mxnxvAPI8
	 U5T4nSZA3G7gKy2W4qI7iWrlWcsNFlz4IXrEb41gTR+CR/VtkzJSquoi9ixa8YWJKq
	 EuwPOIjlcBcbTWkd9tYFIpkNPnBcLK4AMN5RGkNIDlOhbFsoAKCkxnUmjfGp29zAK+
	 ZKRqtxGLvpBKM4kC60/vzYz+icswnvXcolIvTKi4K+/KwYK88YPXUeOtxmlZ22upC5
	 adOXKaKPp4UZg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/19] mm/damon/core: validate params for probe hits weighted sum overflow
Date: Fri, 10 Jul 2026 06:46:39 -0700
Message-ID: <20260710134651.18084-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_probe_hits_wsum() could overflow in weird setups.  Users could set
the weight unreasonably high.  They could also set the aggregation
interval unreasonably high compared to the sampling interval.  Such user
setup is unlikely.  Even if such setup is used,
damon_has_probe_weights() always returns false, so the overflow cannot
happen.  The function may be completed in future, though.  Even if the
overflow happens, the consequence is degraded monitoring results for the
unreasonable setup. It is just a trivial user experience issue.

It is still better to be prevented unless the cost is expensive.  Avoid
the overflow by adding the parameter validation in the core layer
parameters validation function.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4f1425e56950b..a0e6a5129fbf3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1335,6 +1335,9 @@ static void damos_set_filters_default_reject(struct damos *s)
 static bool damon_valid_probe_params(struct damon_ctx *ctx)
 {
 	unsigned long sample_interval;
+	unsigned char max_probe_hits;
+	struct damon_probe *probe;
+	unsigned int wsum, wsum_to_add;
 
 	if (!damon_has_probe_weights(ctx))
 		return true;
@@ -1342,6 +1345,18 @@ static bool damon_valid_probe_params(struct damon_ctx *ctx)
 	sample_interval = ctx->attrs.sample_interval ? : 1;
 	if (ctx->attrs.aggr_interval / sample_interval > U8_MAX)
 		return false;
+
+	/* invalid if probe hits weighted sum can overflow */
+	max_probe_hits = damon_nr_samples_per_aggr(&ctx->attrs);
+	wsum = 0;
+	damon_for_each_probe(probe, ctx) {
+		if (probe->weight > UINT_MAX / max_probe_hits)
+			return false;
+		wsum_to_add = probe->weight * max_probe_hits;
+		if (UINT_MAX - wsum < wsum_to_add)
+			return false;
+		wsum += wsum_to_add;
+	}
 	return true;
 }
 
-- 
2.47.3

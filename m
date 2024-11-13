Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E8200123;
	Wed, 13 Nov 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515194; cv=none; b=sMHCe6MlHRpwCKmfXhajmQF6lCL7rbWhCnufxApQd+8VGbfEU+X55aMOVk/nXv2/R5QrL7ZXvsNQ4/VPjcT8qebkOSTPBoggt9FZk1/NiqHBsZj7QKr7ILobUDmlm3Zq5CE4seSLHRipXGKH7qKXqxjd6bl+9IJgZITgGXhS+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515194; c=relaxed/simple;
	bh=f5G64UqwzMEmnAbYFpT0izlILG/ACPrrbDzbSfum1w0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4fZp3QG8XaosRHSR3RPqwWGXFviQdh5u6cksyDoQXvtZIjDKnLbPduRVmbuzlvFncTgLhxTri2FMXwMBn5+7IjDqGSiVAkRVLwautvgwvPQoK3Mh4yOqBsgQT4z/bGrODSS570ibgdCH+EPhTVNE+r36B0xpb7dgPDD+AEj1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rk5i0Kre; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk5i0Kre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB50C4CECD;
	Wed, 13 Nov 2024 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731515194;
	bh=f5G64UqwzMEmnAbYFpT0izlILG/ACPrrbDzbSfum1w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rk5i0KreF7flYadabrj+EGCJCsLTTGhajaATGds4Av2dLFB0ET5NvC82TjBJvxycS
	 3F8B3QAS6ZhPWnO9ZPIMKlxRAiDVZD43qKCgcswmHDjsxDUt7FdvPsdRgCCnNF5f0Q
	 nGsxcUiUXI3EBRNq4mGalvtz3KFT4U2fWWmau6RdFhPU87dw0wVaz34G9equ3oi1Xr
	 xEtAoBju34QRz8l6yzGQUtToGKT66VZWojsuE2QRXF0yMMgYeBNeuJX1Q7W44KrNca
	 LKUAIEWOzRsLZxxDEX0rKCfNkJ5cXx8nZ/TRa+cLJTebBn0njV5enL1Bhugdqy8ZlJ
	 wTsUAyssqsUIQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 5/5] samples/damon/prcl: implement schemes setup
Date: Wed, 13 Nov 2024 08:26:24 -0800
Message-Id: <20241113162624.48973-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241113162624.48973-1-sj@kernel.org>
References: <20241113162624.48973-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the DAMOS-based cold memory regions proactive reclamation
logic.  The logic treats memory regions that assumed to not be accessed
at all for five or more seconds as cold, and reclaim as soon as found.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 32ccdd91cf55..cf8c6f29d8a3 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -49,6 +49,7 @@ static int damon_sample_prcl_after_aggregate(struct damon_ctx *c)
 static int damon_sample_prcl_start(void)
 {
 	struct damon_target *target;
+	struct damos *scheme;
 
 	pr_info("start\n");
 
@@ -75,6 +76,23 @@ static int damon_sample_prcl_start(void)
 
 	ctx->callback.after_aggregation = damon_sample_prcl_after_aggregate;
 
+	scheme = damon_new_scheme(
+			&(struct damos_access_pattern) {
+			.min_sz_region = PAGE_SIZE,
+			.max_sz_region = ULONG_MAX,
+			.min_nr_accesses = 0,
+			.max_nr_accesses = 0},
+			DAMOS_PAGEOUT,
+			0,
+			&(struct damos_quota){},
+			&(struct damos_watermarks){},
+			NUMA_NO_NODE);
+	if (!scheme) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_set_schemes(ctx, &scheme, 1);
+
 	return damon_start(&ctx, 1, true);
 }
 
-- 
2.39.5


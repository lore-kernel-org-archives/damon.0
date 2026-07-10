Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98458248F73;
	Fri, 10 Jul 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691223; cv=none; b=Fi6L+MNHM16SRLPWOXu//qiL1fm7x3cVDtpWCQdjRzM0L0xPBuXel67+UML5iJF6lRhQO7EN5Pe4nN3k9QMi+6sGfCwY/u3yIjPi+11m6ux9FRvob+CqTYrTbwUmqArDsjRsLQg8vuIADMVOhG+Mc/cTcMFCjgcL7P4xq8Ktn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691223; c=relaxed/simple;
	bh=cOO8k05qs8K2ptOfg1ImvOrODYynHhEQW31RNZPhIV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcQPEriCN466hQM3W96wWWXZnEcFSYrsEOceT3m08Z6IDNl9G5e8hIRfnWpyaQmKdOZFPd6A9M7dIJNhOEPjEAVIWmMaXKYHCdJe1RmxwZ351XET3ZRpafjTUu8N/sRmMsEEPo3rEKOh83Wym9EwbbUN4+466/NZwY8nfNIHRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/F5bCb7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/F5bCb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348DC1F00ACA;
	Fri, 10 Jul 2026 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691222;
	bh=HWM9ulbAfG9bosKr1Xo0BbZMoQtsvPUcnEqaGbAY52s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b/F5bCb7VYRuB7bxQDZbwQQlxBXciGRSeXazTLmsH/ZOAOJOsHvu6/QW7zMBqocSp
	 rt3TBZNIT8kUV5m3+I1BTPJ3zlm4ERceNclzDkvP9BlKOSR8+WvMeGPBzjJ8/nwfk8
	 SsUFWwsk58wAdCp2g/m4zVoKc5h3QJMnCJrChahtxKh2Keu6mYFoUv7ylZKdnjhVPo
	 Uq1KBQh9LQh8TbC8GVUu7r2uNrvHJqL+Qp64vHGOTzybgLaMQdw28acReru+cNfvek
	 pphtVbLdXvHSUiOSkt4Q2QZksFayQxu39j2Yb3DnUONzlcoQHIqYrpwUr1IhGOLmcU
	 6dbh6sukxcINA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/19] mm/damon/paddr: respect return_max_wsum
Date: Fri, 10 Jul 2026 06:46:35 -0700
Message-ID: <20260710134651.18084-7-sj@kernel.org>
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

apply_probes() ops implementation in DAMON_PADDR is ignoring
return_max_wsum.  Respect it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 3eba3564a31fc..b85f88a7a38f4 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -172,6 +172,7 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 	struct damon_target *t;
 	struct damon_region *r;
 	struct damon_probe *p;
+	unsigned int max_wsum = 0;
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
@@ -182,7 +183,6 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 			if (set_samples)
 				r->sampling_addr = damon_rand(ctx, r->ar.start,
 						r->ar.end);
-
 			pa = damon_pa_phys_addr(r->sampling_addr,
 					ctx->addr_unit);
 			folio = damon_get_folio(PHYS_PFN(pa));
@@ -193,9 +193,12 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 			}
 			if (folio)
 				folio_put(folio);
+			if (return_max_wsum)
+				max_wsum = max(damon_probe_hits_wsum(r, false,
+							ctx), max_wsum);
 		}
 	}
-	return 0;
+	return max_wsum;
 }
 
 /*
-- 
2.47.3

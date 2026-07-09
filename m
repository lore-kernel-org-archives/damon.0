Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27539416CE4;
	Thu,  9 Jul 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605967; cv=none; b=Xrdrze+/2CVKCNdlqn5Kq9MPfqGOHlOxbkL3vZed21GZk9X2hMSDQsrLu2cSem+S94DGTohePK1lKLc4ReJHKK4hfiUsyOz2IWv/zfQDPwfmqF6RjhT2z6MmR98p3Gl2bb691w/QXlc7GIUk8JBJsOmjbZuszVQNZ5XNJpaVO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605967; c=relaxed/simple;
	bh=cOO8k05qs8K2ptOfg1ImvOrODYynHhEQW31RNZPhIV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTqcSyVHyMXQ36hv67aXY4xmee98uQnbgXxqoMz5apKB5FCyITJ6OSWmLZ+hvHOhk1Ox+ikOKxKRGNmzz9E7g6VwsJ78tMoMv1XijQLyX/ZZRBi3AxwkRTH+5hun42kBj7Yz9IkZDDlEDZnL9+kM1xwCM4fXSmtKKpYMv6K19zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVhAT7hU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVhAT7hU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0631F00AC4;
	Thu,  9 Jul 2026 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605965;
	bh=HWM9ulbAfG9bosKr1Xo0BbZMoQtsvPUcnEqaGbAY52s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cVhAT7hUdkosfNwbP8UnavLeo0F9t+WLJHfUYu0JxwhIRPAv5fwgn0iRcsJFWlo6e
	 rSe1Ehge/90Sw1ZgkeTwMy/oTwetyRP1yM+J3YobvZdjpqzvQB8zw+hJx/IVLi/Jx7
	 KKyBc1gp2Mg8p+uVuToQKUoJ5aPafYWl1lCWCRF+/J+C/bCnwR6IAbGCf4qV23Za/g
	 42KnUlrbKnxkUqqAeMOUAnpzC8cyZ8iKdpyC1eNgQcxi+/jAXgXg1M1kGJOC5OUFYU
	 d0B8l6fM12hgkvgltNY3Fi71nOLtsU+yJwbY38lzLGeyQTnmvZ83vAVbXxQLmgRIs6
	 hIOD2qxSwJEGQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 06/19] mm/damon/paddr: respect return_max_wsum
Date: Thu,  9 Jul 2026 07:05:44 -0700
Message-ID: <20260709140600.90950-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709140600.90950-1-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
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

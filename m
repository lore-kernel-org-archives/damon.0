Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08F3BB664;
	Tue, 12 May 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596620; cv=none; b=sj3T7V+HoqKKK9qzFjNgErTh4OJLmtsAgU8TGO6F40RKMeAG30Z5fhb4LaAqkIAfMBcyNFRvZ9pzJeBpfWiEw4HrdR5KiIIoUMmSINZuTHZWhkWuQB8tFJhOyPFPwolKH8IP7yIt0FmhShoRvnqzzC6XuqxmFs51Dah2uQLlpeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596620; c=relaxed/simple;
	bh=SGvDGH8HeHXn8zTVaCZsyhJzQGptwbmD0KfHLczQ4ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzZqlUGfttmZynoVYVEBp/X2UoRCFpnBrczsFRCmVmRf1eqKdr+DVFx5O0GWRnrBzV8Acg5+bSrkl/7xohqACAaB6HyWbg0E5PJ+VKff3RLc4Hw4kvZVqDAEyTndlySGsRAOU5fAKZIIzsinigvJVg+LSvaq8MbGeFBcVm+VAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHr6kjg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHr6kjg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3898DC4AF0B;
	Tue, 12 May 2026 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596620;
	bh=SGvDGH8HeHXn8zTVaCZsyhJzQGptwbmD0KfHLczQ4ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SHr6kjg97yrhddopCh8SrS0cwoGVIPtpCqP5/w4RUiObXCcA3wmwpgxqte3SYsJPn
	 X9BUHP6Oup1PCbFOBXJgiCcxuircBIQLf7Xh+GBaWXYOmk+dflW1dlupl3s/uYevFp
	 xN+10+EOp8rmU3yhqZMufXwuNrono7E4FdDODyi3HAFJ4ZD+/ZSi/bkAoNPPEX06ao
	 9tUNu/nNdEfddhknATnywZ1JFtzJywaZwg13YitlJVhXcAt7g/0YZjnG7/npKSHS1+
	 dghbEosUoqHDr0GBCgxeovXUzuJzod/OCt/aVTfHrDLccx1ujIKMYDnnrlK1iFsIi8
	 ArW2pUWni0raQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 07/28] mm/damon/core: do data attributes monitoring
Date: Tue, 12 May 2026 07:36:22 -0700
Message-ID: <20260512143645.113201-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the data attributes monitoring execution.  Update kdamond to
invoke the probes application callback, and reset the aggregated number
of per-region per-probe positive samples for every aggregation interval.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 72acdeb8c478e..fe6c789f2cecb 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1910,10 +1910,14 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 		struct damon_region *r;
 
 		damon_for_each_region(r, t) {
+			int i;
+
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
 			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
+			for (i = 0; i < DAMON_MAX_PROBES; i++)
+				r->probe_hits[i] = 0;
 			damon_verify_reset_aggregated(r, c);
 		}
 		ti++;
@@ -3400,6 +3404,8 @@ static int kdamond_fn(void *data)
 
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
+		if (ctx->ops.apply_probes)
+			ctx->ops.apply_probes(ctx);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
-- 
2.47.3

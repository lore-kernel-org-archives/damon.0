Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9026238838F;
	Tue, 28 Jul 2026 04:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211978; cv=none; b=JGPoS+a6l7aIcEOYNkXpCyePpBKe2uRGkpu3a3UB1A9WNRcQlPUTBZ9Ui9PFIMW5pJxgxe54lMi91GJ2quti6bPwYE3CdJRHyqDSoFWYNBsOPubHat4n8RvFGjfo53YTxKdzAh9rGMNuv3dA2zuBGaXNcYRE6UNHsrPpD2rT7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211978; c=relaxed/simple;
	bh=RlII/+bxZALx45h8wxz+V5lWsOUPfHwlNy6XORJIOTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTt4TIiTZ8ZqY/4WwrFXVHHBKbR7VvxiaWfifaFhsLVZ6WJFLSx9Il7FoAH0dK10mWRrUBFUHUaNCDJqdQxQrg1aIuNKALHcYZt6sLIB3QXgsUOzLiOFGfXmRQUttOEnaKKevBIe35l7F3Y9f3b30HB4su6YoK7nt7/NJhvFC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oglScrxw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oglScrxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A365C1F00A3D;
	Tue, 28 Jul 2026 04:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211974;
	bh=dLFzt3EcCEm4IM9i5M5f2Ly9bLRqeWPD/3m4Jo0md2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oglScrxwVAH88y6Ax7Ax7nnGkpy9HeysXFQJDjpvqI5IlUIlekaEm1w+D89X0wbo+
	 78qaNFDrd5Bu6wYCq2Zo6xQv0qz0BHqSjTGf5CK5q4aHDYIa3Ub766rcZbtMwCqJLD
	 pv4RZcD2mI3Kb2snc/TrF7MDTGBchgaDC7FCgmcLQDV1YIwxnVqTJfl1JBUpYFEk2x
	 Qyxz6tPo6aDHVfPXjC1N1QCPrWtz2fkChF8U0Ky3T0AD7b9Qv4UDAPBv4pjaZmpJR3
	 r6JvlwMTGkah/JYwA34QKcw6KzXEYLC4ROhNuADZZ4iVBdv9FLFGdZKRoWieN2jn3l
	 0TkHeM0TtIqUQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 08/17] mm/damon/paddr: support damon_prep
Date: Mon, 27 Jul 2026 21:12:29 -0700
Message-ID: <20260728041242.187380-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728041242.187380-1-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement damon_operations->prep_probes() callback.  Support the only
existing prep action, DAMON_PREP_SET_PGIDLE in a way similar to what it
was doing for the access check preparation: unset page table accessed
bits and set PG_Idle flag.  Reuse the function for the access check
preparation.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5b307dcbb2a50..8fb71183b76c0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -105,6 +105,40 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+static void damon_pa_prep_probes_region(struct damon_region *r,
+		struct damon_probe *probe, struct damon_ctx *ctx)
+{
+	struct damon_prep *p;
+
+	damon_for_each_prep(p, probe) {
+		switch (p->action) {
+		case DAMON_PREP_SET_PGIDLE:
+			damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr,
+						ctx->addr_unit));
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void damon_pa_prep_probes(struct damon_ctx *ctx, bool set_samples)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damon_probe *p;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t) {
+			if (set_samples)
+				r->sampling_addr = damon_rand(ctx, r->ar.start,
+						r->ar.end);
+			damon_for_each_probe(p, ctx)
+				damon_pa_prep_probes_region(r, p, ctx);
+		}
+	}
+}
+
 static bool damon_pa_filter_match(struct damon_filter *filter,
 		struct folio *folio)
 {
@@ -448,6 +482,7 @@ static int __init damon_pa_initcall(void)
 		.update = NULL,
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
+		.prep_probes = damon_pa_prep_probes,
 		.apply_probes = damon_pa_apply_probes,
 		.target_valid = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
-- 
2.47.3

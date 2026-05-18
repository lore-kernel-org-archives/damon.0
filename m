Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666933A6E0;
	Mon, 18 May 2026 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147686; cv=none; b=CuKinXvD+A8WHz3BK3d1E8btvmXrgOscM0ZPcBV3MavJP8t4sp3UbAONOqxO33GdYExeYxzyo4GRNKhKQLJCbDnkWG/o+3zjhDtxE6pu2CRJvbAvXUqmfNTpL60J8NP3JeVjm4J6ZkUB1kum7+yX3X0GUNIFZTkbXb9yUh2y2Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147686; c=relaxed/simple;
	bh=68XCaizJWpb0cvYPnjOEqbd/hx47Dw30XZpPcOn5Ze4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+LUKK/ndAHdkCfr1eLX1o2OhbrK8VzVMunNY4hbdTlj18PKTMORd2slfsf6YotsBWDU63YKjlVRQ6wqzNdwQRLtUSZPxKPdxQaum7DYoF7JEtV5dalhowHtVVyzbMTvnNE72lTl41dZ9jhdL7TT1Cd/mVBUyY+snPI9l3ak0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTA9vo/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTA9vo/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDB3C2BCB7;
	Mon, 18 May 2026 23:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147686;
	bh=68XCaizJWpb0cvYPnjOEqbd/hx47Dw30XZpPcOn5Ze4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTA9vo/O0Xr5kznzHrfK+9YrtR3JWfTICJHBHiwShjW6hCG/dT20uJsCq5m/tawNn
	 iwMD6ihHE/CtmV7T11aplUeNxneg89abq9jdcoxRW0/ZfhxUIoY7DFjOQ810fYQ5NY
	 6OwxIRRH8U7bqrOyWa43q5JV3Rt5oqmZ9NHbysNdOoe3CI7fkpL07vjF81eq0NMcDH
	 qCM8W0G6d9VoDRj41HICy3O/9GmMAKZYY7fx1V2IfKOuxexCiUiwViKkhFDbC3JhIk
	 UmpKZxj2NWZ9Vnk1YLN4FVKXtVxaYIq3j0gVgqfeo/TGPbeQcZAOFWJL/OUr0I1wAD
	 0PLrySLWvYgXQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/28] mm/damon/paddr: support data attributes monitoring
Date: Mon, 18 May 2026 16:40:56 -0700
Message-ID: <20260518234119.97569-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement and register damon_operations->apply_probes() callback to
support data attributes monitoring.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index c4738cd5e221e..9997c5174ef1b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -120,6 +120,67 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+static bool damon_pa_filter_match(struct damon_filter *filter,
+		struct folio *folio)
+{
+	bool matched = false;
+
+	switch (filter->type) {
+	case DAMON_FILTER_TYPE_ANON:
+		if (!folio) {
+			matched = false;
+			break;
+		}
+		matched = folio_test_anon(folio);
+		break;
+	default:
+		break;
+	}
+	return matched == filter->matching;
+}
+
+static bool damon_pa_filter_pass(phys_addr_t pa, struct folio *folio,
+		struct damon_probe *p)
+{
+	struct damon_filter *f;
+	bool pass = true;
+
+	damon_for_each_filter(f, p) {
+		if (damon_pa_filter_match(f, folio)) {
+			pass = f->allow;
+			break;
+		}
+		pass = !f->allow;
+	}
+	return pass;
+}
+
+static void damon_pa_apply_probes(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damon_probe *p;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t) {
+			int i = 0;
+			phys_addr_t pa;
+			struct folio *folio;
+
+			pa = damon_pa_phys_addr(r->sampling_addr,
+					ctx->addr_unit);
+			folio = damon_get_folio(PHYS_PFN(pa));
+			damon_for_each_probe(p, ctx) {
+				if (damon_pa_filter_pass(pa, folio, p))
+					r->probe_hits[i]++;
+				i++;
+			}
+			if (folio)
+				folio_put(folio);
+		}
+	}
+}
+
 /*
  * damos_pa_filter_out - Return true if the page should be filtered out.
  */
@@ -371,6 +432,7 @@ static int __init damon_pa_initcall(void)
 		.update = NULL,
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
+		.apply_probes = damon_pa_apply_probes,
 		.target_valid = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
 		.get_scheme_score = damon_pa_scheme_score,
-- 
2.47.3

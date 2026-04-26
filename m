Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E944301493;
	Sun, 26 Apr 2026 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236757; cv=none; b=UlNJEsen+4ZTUlhCx5ulOerwI5cTy2Hx0l4vq92weJaFHM42oMxmvSehQ/fRZBHLoRyhliAcrcQfNGjiNIX8II9G4AzjVc0LTBx4ye810s612yjJYHlNstp67+4qYtDjWglqLpWbpmAaXVVwAYBDx60ZMLikHD2vuR7XrWW/0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236757; c=relaxed/simple;
	bh=HJ0qb7oUAaoxmDsZao082N7cLDcGDLFu+2qQv2Gc5Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4Q4jR7MHUhWI6HisnCduqzIEMEA+UWSdbPVsD3YWfFSmc5UcI5xWZO5p8Kpl0/1NE71BAbPwdTj1ZlwtDy/k25G61PJCMdtoNBvhuWoQkZ9f2GE//9roumUN1ZjKR/VwNhR7FBSksTGYj4R68qyKStWGRgJDocyR7fNPmkbsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/0Ya48K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/0Ya48K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A56C2BCAF;
	Sun, 26 Apr 2026 20:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236757;
	bh=HJ0qb7oUAaoxmDsZao082N7cLDcGDLFu+2qQv2Gc5Gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/0Ya48KYKkrK37e94LOhSRnzfxTxt14tjEDmMpyuAEmdpPr/MpPbp3Isb6DiSJlG
	 g023Jo+R7gYbNW7X5FYNE+ZkLLBl2BVuudJpdDT9G7/fdjtnr2YXsnfxAe1gX+fGVS
	 8iPf1vJepsINzLzdF1A7JjG/87G8eJwktjsszHJMtGh27ztaUdbdfm9E3X3e/QF3l8
	 iKi5CFIv+zuO6tMx9EAIYnp28uyWShjISOa5Ro7I3cafTL0JL2e4B39oB7Mcar64fu
	 i+8YqOLe/2oacF8dnDUBtGdKfRuASXeEekr5PlNfxqi+pQd9/fyxS9M1w773Vc9p6D
	 PZX8TQfQRSVxw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/19] mm/damon/paddr: support data attributes monitoring
Date: Sun, 26 Apr 2026 13:52:09 -0700
Message-ID: <20260426205222.93895-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426205222.93895-1-sj@kernel.org>
References: <20260426205222.93895-1-sj@kernel.org>
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
 mm/damon/paddr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5cdcc5037cbc1..cacfbf774ca4f 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -120,6 +120,50 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+static bool damon_pa_filter_pass(phys_addr_t pa, struct damon_probe *p)
+{
+	struct damon_filter *f;
+	bool default_pass = true;
+
+	damon_for_each_filter(f, p) {
+		bool matched = false;
+
+		if (f->type == DAMON_TEST_TYPE_ANON) {
+			struct folio *folio = damon_get_folio(PHYS_PFN(pa));
+
+			if (folio)
+				matched = folio_test_anon(folio);
+		}
+		if (matched)
+			return f->allow;
+		default_pass = !f->allow;
+	}
+	return default_pass;
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
+
+			damon_for_each_probe(p, ctx) {
+				phys_addr_t pa;
+
+				pa = damon_pa_phys_addr(r->sampling_addr,
+						ctx->addr_unit);
+				if (damon_pa_filter_pass(pa, p))
+					r->probe_hits[i]++;
+				i++;
+			}
+		}
+	}
+}
+
 /*
  * damos_pa_filter_out - Return true if the page should be filtered out.
  */
@@ -371,6 +415,7 @@ static int __init damon_pa_initcall(void)
 		.update = NULL,
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
+		.apply_probes = damon_pa_apply_probes,
 		.target_valid = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
 		.get_scheme_score = damon_pa_scheme_score,
-- 
2.47.3

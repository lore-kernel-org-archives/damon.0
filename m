Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E43FE65D;
	Thu, 14 May 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767761; cv=none; b=t9vsmM+yZZoDWfcTRiT0JG9WHrL/LpQTa6v8dcXRo49AR8Ev5QZVVPmodoXR35RQbB+C3BTkr2h6btMiVrbNEPDrSkh1wIVQbByXH7lpsdMIQTTc1pUWnaE5kN5wJf4Erdsbs95Agbr7J9YiaECQa9fD73gUmumcGfAiGElxkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767761; c=relaxed/simple;
	bh=rzjMv8caD4Lt/pj2/Puwk16Om6tdIYt4pV2QDp5f+Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1R07yJ15Dc6nnMzOc6VBpGpdM5XbL38bLYUpQKiZU28iUDbq5SYBNXXBncjAEpqS/UNHxhheBlLxgxKw6q2PBiiZDCkGgLkZYJn3yHU16lIZQxGtAr8jsBA/Nef0xHMB13qgcyk9kIp+cHaRJPoUuL5cBOvjge/nQiEuLC4hHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwTHbYD0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwTHbYD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3892C2BCC9;
	Thu, 14 May 2026 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767760;
	bh=rzjMv8caD4Lt/pj2/Puwk16Om6tdIYt4pV2QDp5f+Xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwTHbYD0GHARWC1RgNnGp1Xz90K/OzzCFZa5sFhLp0BnrB6O1hF4P75yI6JrM6jGL
	 YE5eYgwqsMQcdrieFDZ1nMbymu0ZSxBlPoP34Il6Kk1pjZqz7iDoec4Sq4MeROGm3y
	 ki99IrLSIu56dMBu4fji0P6BFnZoL2ds2HEvsaMiasGd783981K7srP/qqOqFjaUH9
	 6OKixbVsf5ZZeeHLqLCY3YofmbAqNin0aM+fkIG9nCKDn8tzxvFH/wsVUK+tvGViyU
	 oJNI/0elOF1oXbm9zXvfa8utm2EciLB+4h0zHFCIynsZz70N6xQKjiyqyKWDrCrP+8
	 NnqT4Og++DG+Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 08/28] mm/damon/paddr: support data attributes monitoring
Date: Thu, 14 May 2026 07:08:41 -0700
Message-ID: <20260514140904.119781-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
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
index c4738cd5e221e..e60af2cbc1089 100644
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
+static bool damon_pa_filter_pass(phys_addr_t pa, struct damon_probe *p)
+{
+	struct damon_filter *f;
+	struct folio *folio;
+	bool pass = true;
+
+	folio = damon_get_folio(PHYS_PFN(pa));
+	damon_for_each_filter(f, p) {
+		if (damon_pa_filter_match(f, folio)) {
+			pass = f->allow;
+			break;
+		}
+		pass = !f->allow;
+	}
+	if (folio)
+		folio_put(folio);
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

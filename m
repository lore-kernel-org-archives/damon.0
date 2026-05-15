Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD83385BE;
	Fri, 15 May 2026 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805889; cv=none; b=JYKFUWQLxNd2ul7TXp4Ambgu3G2z/WGi7bkM8iZCDmsJCSf+R+BMeUQt9T0Bd00szvd2dDkEdPF3HvpChQqgHKYgzXOJTyJOByswkD+8eP9hdL3yjXD6wqWOaQEpEdNq/GixSGGTBmwxSqtWoexb43i183lgJRuIB1x14H/J9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805889; c=relaxed/simple;
	bh=XJz1lrbnCSIcGGsCp292XxEMr77UR12PQX3+0VG2CCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSXj7sB5V7EHK9SGoHYcmOybQogtVSyYQeiZe8N60aplAjHGO4OB7fzLIUqHweSM7t+gyvmF0hH2SXxmuvjQ+eBQKasf3iNS/IpY63yu7l1/yHNqmS7M6zI8Q4FC0XN17K23mED+asgPSX7rOITSh7Fjjo+JMbvTaFim9J2rF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c305JDKt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c305JDKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFBCC2BCF5;
	Fri, 15 May 2026 00:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805889;
	bh=XJz1lrbnCSIcGGsCp292XxEMr77UR12PQX3+0VG2CCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c305JDKtdZwckegZOgZqdHs3w1vbcaGR12vM+XkFcV/Er2btR8k1MWJwb9fycDBus
	 ripuud6obkSso8KB9L4rSdbxUEDoijhQ6ZQeEqY7YkHEqa1o9sDGYm3/7OXwEQd5M/
	 klXv1oHXsyymGwYXMeJmZfgjmdFxBUuoLBeE7ayixMTskUWotEKil8awTg7GmD/HL8
	 caBK+U7g8N1zokS88daF3Ki3bb7nfJHPHVbLiAjmo7CbsEtVyd3jzfx21Q+/b+6zu1
	 YEiwad+2vF1SGqiCWjsk5T1QsmG3UHSgSjFk/MLFNqTB8SgI4hVOkRH7Ky0PmEsbhs
	 eJT+LlfRL+QuQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 08/28] mm/damon/paddr: support data attributes monitoring
Date: Thu, 14 May 2026 17:44:09 -0700
Message-ID: <20260515004433.128933-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
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
index 5cdcc5037cbc1..493bcca8ff104 100644
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

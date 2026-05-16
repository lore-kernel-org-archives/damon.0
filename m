Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59486342CB4;
	Sat, 16 May 2026 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956647; cv=none; b=h2bl0N6AQFsYkZt4+7tdHm7vhrQCo0lbIDvLXcR0OCVTqDQEAAHmTD8jmwbPAtXPZxE1/8P93n+jDSqhqQmw/CpwlL4UWY24p8bEcm4J3JJpaDIirYBgV1d2OUiu/TOHSaxPhkLWqgEdYb3XMiHJJ6kPg7pgb/US4Zfp6QXEWxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956647; c=relaxed/simple;
	bh=YUEUEwyNL9PReREavu4cR4f44O9YYFDKrNpJr/Ooyz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbIU3Ovpu+QEvk9eBeZp/oVkZapQKgbCEGBG49MF+qn/MO24QGJoxF1eP6ECk/lGdxu9tyAhRzJtcSD/tgQtlT26QbEwbzp7ZtVMNomTrxJjE/gK9lPzZz8s4i9nGxFoYOznuwzStMMhqsTSLRxaTtkDLUidLKcyx9L8atTlB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3w8+4T1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3w8+4T1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127B2C2BCC7;
	Sat, 16 May 2026 18:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956647;
	bh=YUEUEwyNL9PReREavu4cR4f44O9YYFDKrNpJr/Ooyz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3w8+4T1W3iNDJnRNOsh+A55B+RcmvuWDBMe5TonS+ne5qofWDudjhSrVuME5OyFz
	 Qs7KPBG5AuG8LmcJIx4LNnGVkWApeaRCiu6NLQfZhZGzHuC4aDM8GsBxzH7BeKBR0d
	 6agISdRkDPWbMlCHnNGHaDHp6hIi6cD28HI3LDRc/OjY6uDOVz79woxAaROzms4/P5
	 XotRF9QgDLkJ+u36QxqffkICMVbvQ3/EWp/IYbaGPT6lqxCuJQ60cCtWKhm+Tl+lwp
	 D3QgnGfvuwTQetjowQg4J9O0tvyKea5Dp944AUHWu8ercaFSi7zNUqm84Njbxd9RvJ
	 8AOd0eKYx6Hgw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 08/28] mm/damon/paddr: support data attributes monitoring
Date: Sat, 16 May 2026 11:36:49 -0700
Message-ID: <20260516183712.81393-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
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
index 5cdcc5037cbc1..81780b05c175e 100644
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

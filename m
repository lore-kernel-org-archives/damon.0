Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAADF3BB67B;
	Tue, 12 May 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596620; cv=none; b=k5QxL8wxTYhETz+IUkOslj5ZCaq/0fQTa3cilL8WxNqF1E8MsLyZyu+cVFuD6r7GM2OIYRn0gj3YSRy9rAlr3v01J3klfCb4WFjzi/ZsqbPRt6jvAFR1ygOX2jEW5MP22N0wrCvY+7yFuIA3AvLOkUm5CkfHMZA4CIypvc/BT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596620; c=relaxed/simple;
	bh=rzjMv8caD4Lt/pj2/Puwk16Om6tdIYt4pV2QDp5f+Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnbpBraWfuhCMpO+PAG41cW3DMf+KMYyhILu4ciaGFi31hqgZB70f6dNUvzZ5pdRUZc7JFjY91M/DlYHhCrvsILJo3quHe1bVjTE+pTG2aMoB5Yy0hgFkEwj6BWWo+A2GVazK5CsE9fDOwNYosoZFaD55KlYHLZvcyB1KAvJoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4ICceRA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4ICceRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875E8C2BCB0;
	Tue, 12 May 2026 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596620;
	bh=rzjMv8caD4Lt/pj2/Puwk16Om6tdIYt4pV2QDp5f+Xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4ICceRAbBffvDG9myKtbeCFfZMPjBeJhpxt40NJZFu8JcOfWccI1H5xfmFfVqlo/
	 wQHeO4Ujlv2DgLvLN+P5JtHVzOiPqwLPKW+yXXqi8soEVkfkagqyAXrpJUTyHdEtrh
	 f3Hpdz2yIbLx8ZIXPW79UCk/2pFIsRHyKtUxWLEaDrcyD686rW2BKQ9De4WjS3OR5o
	 oVEL7bKuBrGh5DEHh2xKzSHY/UZZeinXYafPw4SWBo4VzulEiXEQeW6Xh0qpmnUSGp
	 n57NMdQCq0g9jWpgqaJCrG/jfIvC90pXmkx9jj6w1Ef4M5yeJhd0Ljd2kOyaIZnB3D
	 uWs8X7p7PnbSw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 08/28] mm/damon/paddr: support data attributes monitoring
Date: Tue, 12 May 2026 07:36:23 -0700
Message-ID: <20260512143645.113201-9-sj@kernel.org>
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

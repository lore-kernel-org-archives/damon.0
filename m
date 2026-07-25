Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE83749E3;
	Sat, 25 Jul 2026 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013358; cv=none; b=uUhgM2k4lRfKD9tOpjq1PAq3r6oSi4OSpQ+UQ9SU/BFI30+TvwY3lhYEDYo+omRhFDRcpB/xu+3CNU3MTSNt7sZ86bPWHezNKG7K7YaXROaOPDLorOfXDFabeWxd6CyjK+U53Lw5izprT//8sEtUVWL4v8u4DspzRx/mZnE9eZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013358; c=relaxed/simple;
	bh=p4Y1VykKpHDYgGeZTYk/Au+mxC11G4edsYRklYGoa0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHnMSnbvbYSYSErOmRlkfWF5kcjcIVl+7WQX8+iqVhTS2DCr4kU2zfu+UPIXrWTEXajUuLAC1L511WvYGZfq+imXmDnvAtTPIgdYNrH1+ru0x18qxFijvaFTeOPxMoZgip4aiCh1BtuQi7n5auKzMMur6tRwvrX1F6iCXKCS+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh2Tq3rz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh2Tq3rz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409271F000E9;
	Sat, 25 Jul 2026 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013357;
	bh=wJj1wPDvg7DvY7LzgO/Bh4Zqj5IQYFAr5WffY+jOQ6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zh2Tq3rz/06YoVGt4cPFRGuDjLH7APG0ktpHglvXaI3J9iLvEGGSB7CIIVjw2o2+H
	 Vao9eN+dElnkP9QdIUVeCe3cHhw3vwioQH7kJ6v6TWJ3uC2pTaVPdb5VF8/BtFGTce
	 nlPrabnb2QJaQOi2EXASiO8upMyWzlIELo14xOVc9OpbUB6FRc7jkrWHYRkBSwBa/D
	 X/4gbFXU0OwzXhQtoofXWJfJ7nO3oWXxvbsz7qaYnRXlOqx2awip2aXZPOMGzobcHN
	 c3lsnGSCb++sEwfGJcaG0Hso25MMtmP3HQ2SdcZ3S8DTbighWfZElSGzZ5Y7NALNFt
	 ZXUDP1qzyZA2w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/17] mm/damon/paddr: support damon_prep
Date: Sat, 25 Jul 2026 14:02:12 -0700
Message-ID: <20260725210225.129944-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
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
index 199de1463fa06..8d8fcd1369e56 100644
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
@@ -446,6 +480,7 @@ static int __init damon_pa_initcall(void)
 		.update = NULL,
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
+		.prep_probes = damon_pa_prep_probes,
 		.apply_probes = damon_pa_apply_probes,
 		.target_valid = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
-- 
2.47.3

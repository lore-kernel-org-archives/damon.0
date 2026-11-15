Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774547;
	b=Euv2Mog7rffvt02CYw4gjE8w77n64SgJXRqJc+eKs4SlYpbnlYkdjkTbSQcqiXVtCW2t
	 ed8KzW5MkM/8u2tsyd381tBMmSAJR08CbQuAW0bKy/VQfeOcngX+yz09LTZE9nbjA3tCw
	 igB/oDrRE+93UTDybQyfg5+9xmeEb6mkped+9d7u3e+xjSiCX2CtFSEBXRbe0U6oIcRHa
	 54DanU+gwreoZjA9B8AcBwyP1Vvb03en6lJtLXVlIeItHKN2SbeZINOnpsIRNWUOiFJhm
	 Cxil54jQcChwIPUaEiWE0vihn8/HdKSlinnnC7JF9TP02ahIjeWHtctilmyM8rI1XnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YVIDIsarcg4flQK51gffTpdo9vpbQ6R+h4bt6Nmq354=;
	b=F6D0I5c8knHPDREa0Pgd5nqfeJLTclzK7L9brKJdnPM8qw/xUqZlExDHUUnCm0qpreZl
	 eihIEP+22Se+slLl9cPQQ+MB3zO92F3CNfg17oHB1NuEZ86J1TwSM7eAobiGDmu2hOAFG
	 vW1x0tgaKt95zFWrAlBfZkCH9h2hCCQy+HBHF34NWoZOk1uXz2TS2EogNOdXOC0cmwhip
	 avdFkMYfpvdpq/eWIu8JjDA4+9UiWwOtI0PnHfl26ADCub8+BknVNjBDke6ubK6OQIwC5
	 cPQeeTXO+/dWfqg4aVbV1YnBw3x0dvvhZG9e9GVZ6fhVqf1IgTj7mldMoVi+wAKIwHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YMgs8l/c";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5E606A89F;
	Sun, 15 Nov 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMgs8l/c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0648C1F000C9;
	Sun, 15 Nov 2026 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774547;
	bh=YVIDIsarcg4flQK51gffTpdo9vpbQ6R+h4bt6Nmq354=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YMgs8l/c5DaJT6mpLqKbvdNxvRKT5bQQg9S/OprybcinK+IP9kRoQcNIQC9KjYZK5
	 eNwqiAgBa6jnEwFdvYl64YpOHfWl3oU9e6AmjziiKsJu5QvyZvaQeUb+yxOA5m+CxU
	 Mb0f8s0o2yyAttRJm+p6EZnW42QMgcLQOzjiJXJGEVCG5fqQG61kAVkpETUAG7SHop
	 MsrorhPJ9+DVtra9WzwvmWOyvJXzGpAFfAJvlFtY6XN+iCENUUjnkvS5QWDGfIeGo5
	 GrBHbP1Q6YkbgPJjryHPwMGNQxv/Uc6tPAaCYZwV7qebulLLwL6cmnxG3987z1znKr
	 o4XrVpX83z3pA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
Date: Sun, 15 Nov 2026 12:28:32 -0800
Message-ID: <20261115202849.99134-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a support of DAMON_FILTER_TYPE_REPORT_MADE type probe filter to the
physical address space operation set.  Use the DAMON core API function,
damon_report_exist() for the core report search functionality.  Set the
time range as the last sampling interval.  Pass damon_ctx to the filter
matching function for getting the sampling interval.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5b773012a8764..04e95047f8cea 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -140,9 +140,10 @@ static void damon_pa_prep_probes(struct damon_ctx *ctx, bool set_samples)
 }
 
 static bool damon_pa_filter_match(struct damon_filter *filter,
-		struct folio *folio)
+		struct folio *folio, phys_addr_t pa, struct damon_ctx *ctx)
 {
 	bool matched = false;
+	struct damon_addr_range addr_range;
 
 	switch (filter->type) {
 	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
@@ -157,19 +158,27 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 		else
 			matched = damon_folio_young(folio) == false;
 		break;
+	case DAMON_FILTER_TYPE_REPORT_MADE:
+		addr_range.start = pa;
+		addr_range.end = pa + 1;
+		matched = damon_report_exist(filter->report_type, &addr_range,
+				jiffies -
+				usecs_to_jiffies(ctx->attrs.sample_interval));
+		break;
 	default:
 		return damon_ops_filter_match(filter, folio);
 	}
 	return matched == filter->matching;
 }
 
-static bool damon_pa_filter_pass(struct folio *folio, struct damon_probe *p)
+static bool damon_pa_filter_pass(struct folio *folio, struct damon_probe *p,
+		phys_addr_t pa, struct damon_ctx *ctx)
 {
 	struct damon_filter *f;
 	bool pass = true;
 
 	damon_for_each_filter(f, p) {
-		if (damon_pa_filter_match(f, folio)) {
+		if (damon_pa_filter_match(f, folio, pa, ctx)) {
 			pass = f->allow;
 			break;
 		}
@@ -199,7 +208,7 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 					ctx->addr_unit);
 			folio = damon_get_folio(PHYS_PFN(pa));
 			damon_for_each_probe(p, ctx) {
-				if (damon_pa_filter_pass(folio, p))
+				if (damon_pa_filter_pass(folio, p, pa, ctx))
 					r->probe_hits[i]++;
 				i++;
 			}
-- 
2.47.3

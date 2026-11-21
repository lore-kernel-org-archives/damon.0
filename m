Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294826;
	b=lcE1xHNVWFGaYPfzOXa0zfsu0Sriyhph7EdNPTBzrhYBShjq1FNP2FkLpg5HLzYcfRDr
	 fvMXFUQgbWGmh2od2quSCsKF4tPNrmroFAzeDnOU7Q+KyRrZsR80YeYcJrFsDVKcTo1DS
	 7vmQPZI3/V+oswuMNJwEhZ+L0Ym9KTII91vHifQj9JsZCjt8m5J55fQoikdSqR/J4ekNk
	 KxtZIqzC+SK6iI6Q0MDyc8M7gAxUt1BbkHQHczoRhb66tMjnl41AZY8/YnxXctkp4OUuY
	 twRocMCHlBQBs7L6jxF44v8LVu2VhzrrjylAFigxNWNA/14R72eD/C3KQUkW88KfwRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L5v3TNUEUyGkIhCVZhl1qQoqUnXYUnCoqLwCawYZ32A=;
	b=MxrFc2UB3D2FSt40sBdLXJTIhCpJQU+iwRGGb+DrJ8v58Qt8uflj7/g7d5dt4RjMAHse
	 zYvq5g3ifpCGYKOgIUlAY6VMAl8qbkUyI7+iKpy4qu/ZeSjuzmEHBG/+HVTcmduFg63ek
	 dftY9qN6lUkvBvgsNXaJZGtepwMdd85Y36SmpnAOnW9s3nhviC3C2aR51YAOR7u/6OD+B
	 EhW516UsV7SO9K2hZBvcfk9McfZWHUVReUtbbD3zkZJ975SXiFgjE/cy3OkurZ25kcjws
	 vOBUIdRD7fgBLey64zDFtG1HlAbuAFHboWwTkaE4iq+Vts7Jv/QV28G6LCzXB2OJnaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHBDSLi2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11475606A32C
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHBDSLi2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18D71F000C0;
	Sat, 21 Nov 2026 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294825;
	bh=L5v3TNUEUyGkIhCVZhl1qQoqUnXYUnCoqLwCawYZ32A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DHBDSLi2J4lW/6RdWT3/YH657cSPK07zdlaE9dS5lGt3YFFgtZoMGyhkWY0KXLpPA
	 XRzB3FYHwymaO9O2WgDWFpLINNA/Udg257WfMW6rHGueQO7xUHaoMppErIrt3WeW5R
	 sluWF3EYg2e3Bpnr0JJUwq4sXMUt9eY8Sw9kAQiUNeYJNi9S/ao8boXvEGw5O1BW1t
	 faRvDl5SNuGTy2FbUJbNqHY/bddHMTUUJRs3UYded34TjT5CnPjoTkj6ztdW0QVl/L
	 yEkCcgMGVbug+qROslCYlXOV132k3zDzr6vGWjo5UgFiCLWGtPhtpJabDvfzowVM5Q
	 GvI0WFlh42AKw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
Date: Sat, 21 Nov 2026 12:59:58 -0800
Message-ID: <20261121210013.130397-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
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
index e89cb14ee17be..4003ae914f1a2 100644
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

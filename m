Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968557;
	b=RRJ9QdoJf7xm0uZua7nCioW7dUNqf41SCzPzw5smIOekTOvFGa959yRVTtJGWhxVXpeQ
	 rZDbRZTPZe3XjRglR8cWWaGoqXfyizcuEWEhhAtXgyP7ODk9m3iMqSFr6xszNGvMBqqTo
	 5DcFa5FonshuHhoE7AIXRlIUzJrWp49q2SyNcQ87Hnsiq0s0uvUu+LBG5FrCAOKshMVOQ
	 y0iL1J7R5RpcGMnOViwyadRLSF1rHgc+O2h3aOudAhZqWgwKvi1to97jJ+QqCPkd/411R
	 hin4hVVK8Uml2eDcn8Yz+422pPjNErysydsjUVvCOH8r/bk6XKkQNOEVwTynXbNCCvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L5v3TNUEUyGkIhCVZhl1qQoqUnXYUnCoqLwCawYZ32A=;
	b=AkU2biU/1AZdzdTPE8iuIMLnNQnFPbrMM/x04YGwnDsK44kDloCS7Uykb2AY8FIwRGsG
	 CHeWYT1fMZi1piVE5ciSpTS9vN1hLG+MUs3xflr1oAZa4sKdQFnhNhoHX781TxfuGRtvZ
	 t+t22N9QVtHn2Dq9QCUofL4CFpCORdl73fhF/Aa9ksfYYZJy06ma0M+HHfWSDlkFhY/5i
	 OMc+cTU+r0jWydDwzowCe+O6oNzTQX3bzIwQdZ+nOZod7Csog7Nxi1f3Pt8H1vnWXtgfl
	 zcFp1dJeiAv6ugqNZ1+Th46BvQVnQXtl8LGatzieTohNSPHbG4Q5cWE9NpaKSjWf8ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0IPem1m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915860A3804;
	Wed, 18 Nov 2026 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0IPem1m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2113C1F0089E;
	Wed, 18 Nov 2026 02:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968557;
	bh=L5v3TNUEUyGkIhCVZhl1qQoqUnXYUnCoqLwCawYZ32A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V0IPem1mBDKRz8TiosCk09YG40S9in5HFFUBLvrEX7fIGBZ3+oV8p9GtLaEGla9JK
	 v7TXkUYWW3G/q9KS3Lpyr3Shz2AfXLCgvTmHvyyI7rY+nCtV9IZwj+SQ7CmxHvdHgq
	 mucNlomL4RsDtDFDG/tZYHVPgLkgFSP42zHBS5v32PnvQkupDLFEXzhiS76Z0tNXfj
	 gEudUfHjaWA/nOm/3AJhZu0xnPST6s4uG7NoxORf4qLk0Fj9tuGor/v3dejsYfXUOw
	 z9Vs46Sz78rFszSZr0lvChKAOf+gSVEYyiVCmG0RVNE26m0ErfpJfiQHQ3uM7XohY7
	 hOkDWDMIjlyKQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
Date: Tue, 17 Nov 2026 18:22:09 -0800
Message-ID: <20261118022225.100659-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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

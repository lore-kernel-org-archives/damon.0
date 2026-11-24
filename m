Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534615;
	b=g4cBdqOtdyjmiXd6yQYEhigOWRJKemI55BaP2Ehw6AZ4+1U8oFgdmtGyuvK0tS02nZ6a
	 9A6lm9sjEUHE9LRFljl9uLj3W0FGIKqWEbjiHylXSdrp84SGUDfinbAJCmO2XaFPr59Ij
	 EcsimUllgYjWhyzpBq/1xFmpUeP//YOb5oktLla7zJezEwLw2GOvkNxQDVSPhYD46Tdxc
	 +mWEnCV0AmQaL8+bqEmsAQIKzTC+6Y/0lITh2az9Cf/37hZKNmz0f0aqtLWKar3Gdd0rX
	 HGUeuNYeMgB4Zpi/sR+oP0yzW+oX3q7NntzC5kEpLzXDhr3nNBHgZRRDZhbnwQ4vk2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534615;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Kn32Anyj7C2dLxq5vqYUn8DgCRQ5YH6k1PpdHy0AroY=;
	b=lmnqCgBrbn3dtKvnr9/y+nHbrhM/+m8jQVgWbHYcIloejSvtMvX9AROea/ocbcvB4weq
	 b4E8sA8hBdjTqESh7GgbA0/TvB92LLLTkGMO8LDuptPvO20F5cpXlD6EewqM6Yd78+slp
	 gdsi2VFRbfgFtSO4uZKlS6QzNzcqyh5rEYzkleVaBBLlkEWTkyYXX/qqNGqSH+L9L40Wd
	 yHsy3jIjhNlPNvu5BXVbAj7VN3vqk8lClLoJ0+pMFnSL+Hub7EUPn4r6JKYDS4GXGSBTg
	 +rToWKP8E3rTk5RxKqZhe//vBifUGCZgZsV3ZlG8h7zDyveSVf46TaGqBAtAGXUfWoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qzey5u8c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6AD606A31E
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qzey5u8c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862B91F000F0;
	Tue, 24 Nov 2026 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534614;
	bh=Kn32Anyj7C2dLxq5vqYUn8DgCRQ5YH6k1PpdHy0AroY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qzey5u8cmOaUuvB2QIkVTr1HgFa2g2DdZyJdljzMJZQdes3DmE+1eVmflsmxIW05C
	 eV86IYjzBLAuWeMBHoyM0VFRSpUCGrWChQTVbvEzvNp4vqsGEK+iJkh7Cu+29IBmxM
	 caK6GinYWWPS1o6BQIoUJffqkhxY1RQBRpimKxPeG1354oOzOdHJ9B7OLeZNNjNset
	 NWjsyVWFz7/s4XBubE7ikJMIWV/BJ2crltNh1BD4Elr+lCslcUX477O/kwSZNs0DlD
	 uOoLDfssnmltUtiBNTaT/KDrTR/kBt7OA5bxoaA8eVUUfL1kP90APHUVYok7dWEvwJ
	 V6KC8dWeSDthQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
Date: Tue, 24 Nov 2026 07:36:20 -0800
Message-ID: <20261124153636.91854-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
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

Tested-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 411e1d557ba3f..70e8687dd1f66 100644
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
+		addr_range.start = damon_pa_core_addr(pa, ctx->addr_unit);
+		addr_range.end = addr_range.start + 1;
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

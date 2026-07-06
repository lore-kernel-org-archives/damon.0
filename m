Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11E42A168;
	Mon,  6 Jul 2026 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347563; cv=none; b=kRWkdg92xcS4U1wfPH2dMkAkuuWKjYq+XiC/HOQWR9r6T7bQcnSGu8sQxq2o0uXrlTjsV1WADlj1BqS4kMYwVQQM41Vew42UfOLpeEJoqlQovpXMOD1GeSpWTEnHbQpy5kNyAUVTSavcJblWqCbzKhkUwITbetTu9ZNMYI0C+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347563; c=relaxed/simple;
	bh=cOO8k05qs8K2ptOfg1ImvOrODYynHhEQW31RNZPhIV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbdtvwqjagllvqhTis9RsjcaW5gJQE+nIiHxtZUxl1LyHlYD9mJkmz6e6N2GSkc0cCUbl/16b7laDUiIjVd98E/1PPMhpGOgbDzkUnF8vg4zKR6bPqXBhCi13J97cI720AWtDISpKVCSGANYswt4EA064wUxAoicWi8THhNKQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGEvX9ld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGEvX9ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371BE1F00A3F;
	Mon,  6 Jul 2026 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347562;
	bh=HWM9ulbAfG9bosKr1Xo0BbZMoQtsvPUcnEqaGbAY52s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IGEvX9ldaMMuYssG9Up8AFd3AOZseOjwO7bbkT9gJrWDd0K71El2q+i9XP8jLCJO3
	 XLwByoBp+S3VlZc5+quQauusWRX41PLzYKj4e1PSiaaK39TQ5bQkI3vHUM7F06AkFr
	 frW8vGtNxnq3Tpg/oVK1jRpROD9YWVcUXtG80wbWk74WQ9bGham0AeKIpVGBWbVdDX
	 i238eYqva+YsYQIaj2CCv2xqEY3r7AhYqPTXp5iZUnm/BNLsTZbSfJJZq1zFIA4IRE
	 qzHrZCbOW3mQqKyaTNVyzWil+wesGzzLPCcDY9jOHGsTlY5jYhyan2MeDW45pl8166
	 1xNlsc3nbtk2g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 06/16] mm/damon/paddr: respect return_max_wsum
Date: Mon,  6 Jul 2026 07:19:00 -0700
Message-ID: <20260706141912.88445-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706141912.88445-1-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apply_probes() ops implementation in DAMON_PADDR is ignoring
return_max_wsum.  Respect it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 3eba3564a31fc..b85f88a7a38f4 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -172,6 +172,7 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 	struct damon_target *t;
 	struct damon_region *r;
 	struct damon_probe *p;
+	unsigned int max_wsum = 0;
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
@@ -182,7 +183,6 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 			if (set_samples)
 				r->sampling_addr = damon_rand(ctx, r->ar.start,
 						r->ar.end);
-
 			pa = damon_pa_phys_addr(r->sampling_addr,
 					ctx->addr_unit);
 			folio = damon_get_folio(PHYS_PFN(pa));
@@ -193,9 +193,12 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 			}
 			if (folio)
 				folio_put(folio);
+			if (return_max_wsum)
+				max_wsum = max(damon_probe_hits_wsum(r, false,
+							ctx), max_wsum);
 		}
 	}
-	return 0;
+	return max_wsum;
 }
 
 /*
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EC3B71AB;
	Tue,  1 Sep 2026 04:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237269; cv=none; b=S1p/av+tLs9ZkDLJ9Cq1j0QYa+6Ng1rKUTaNXDHCQeKXKHgDmG2jU/hW6FI+FeqeV1uIuNHouGIdQ52mHQQ2itDtSdFQZrV1RSD22inMr4NCptrenbcQ7RzUYJ902vawpOHueMHKSPl7qkxc+B5DUBdcZmGB8CbR6zvmcxiHSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237269; c=relaxed/simple;
	bh=psLetOg121R0QNdJs+CF5/aps8rlnAQgTRRu06h/FW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnnLtQQ8LfCFPSLXJzi2I9zlzfDiz26AXAg2xda7HwkL4iqRRyuxsgdGT7P8zYa1aZn3faX9SToKMMa+l+GubIizYVDHqSL4x5hTa3JFURgsQ5OntxYn7nmoLRMFDCizeys4AmbcNevxHnv92+Gspaom6HJYiCFYHQJ/tpV4hkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdDh3UTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdDh3UTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382991F00ACA;
	Tue,  1 Sep 2026 04:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237268;
	bh=OpyWxBrGaST77vm6YyG0Qbwcf9E6DAqPTZr9W1qgAUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mdDh3UTqfrDhR7uBGv/FI05EnOJmHfyawvr+M1N0YN28ZIXhcm6e4UmmUvwN6/sIS
	 RK79G41zR+Gqh0QpHT9MGwojDAmVH6kMk3iOnupR9pMbwVG+HgkOEEQLOtRrZDhO6r
	 aVes3UwJfL8tWIEdfx5Cs02LfPJqS5XjJj34WvuIUOJfFIUfP1U/q7MGpO1NJu+8CB
	 2ozfeuYy2ZIZj/CGgtz9erURMlYZGsZQWF7B6yXb5avGCnrvjtBW55UjP7N8Z6hPdO
	 vurrv/20EULnHR1IHl5KqzYnWGgcwe1DHyi9t+cXx98zAi3wU4ENrsBS35FebqHjr5
	 +Q/IOKB2YsiRA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/17] mm/damon/paddr: support damon_prep
Date: Mon, 31 Aug 2026 21:34:04 -0700
Message-ID: <20260901043417.2165-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901043417.2165-1-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
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
index 6f756f8493894..c1e7d7a4f40df 100644
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
@@ -448,6 +482,7 @@ static int __init damon_pa_initcall(void)
 		.update = NULL,
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
+		.prep_probes = damon_pa_prep_probes,
 		.apply_probes = damon_pa_apply_probes,
 		.target_valid = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
-- 
2.47.3

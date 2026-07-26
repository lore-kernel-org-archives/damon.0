Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BD03D79FD;
	Sun, 26 Jul 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087588; cv=none; b=B7+3mE4zYpVb6nZU6Sxoc/RZAR7oQln93W+KfvDL7zjWaj6MYeFghlE2UGPYJpt0F4DvtCd4t3e5DlidZUlmuohJGinojIlTZ0+MzFybq5SZ1IZJ0a9Hl1R3ZUuA3uqAcLS6WQoHEm+ePU9mLOsIo2JIuHllVwjT5Ku/SdRWQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087588; c=relaxed/simple;
	bh=p4Y1VykKpHDYgGeZTYk/Au+mxC11G4edsYRklYGoa0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4fxKe2kerZBT88M0sEw4MWHWoSvYGMl64TZrr0wnRsctB+RnRCVicWLcs7W6+4vp+BRVJnxR5y12VYJs9Adil+kaERH0JwNh0CWohmb1d79u+tT0XDPYjZ4D92iVNY7RcwLmEfiBUkqmlfvBThhgDx/v7pXcQ8HGUns3wMejCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7PUDJOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7PUDJOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E884E1F00A3E;
	Sun, 26 Jul 2026 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087587;
	bh=wJj1wPDvg7DvY7LzgO/Bh4Zqj5IQYFAr5WffY+jOQ6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T7PUDJOPeIDeUK+HaqTOd3FPl/rJkFOhMFaRxejyXN6pbuQqV3u0zK+2L8+k8G5ux
	 O5bF0ihEEAAmDxld9JxBVP8mhKuzCiLeEqVnW6l9B1ZDsY5xblGfzQtMV3WQGWxVaf
	 CnPKCM+5ctSmQxDiM/AnVwVHuDS4Mfthom5nNPZe0NqUeyAHxBIWgJzKZN5cBoqvcc
	 e9bqAniSXti0h181UMT/WvW1gLyy4/eOTKL4Sunn/kwcuR5Ky+6gKaX+639tKqG6wY
	 HiVaqSVumuYFUkb7oYhzk/e54RWxTlRBi2IHRBfUV6oymiWPkgFXMx8yeNMZy/Udmp
	 KocTzjidqb0QA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 08/17] mm/damon/paddr: support damon_prep
Date: Sun, 26 Jul 2026 10:39:24 -0700
Message-ID: <20260726173935.94046-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
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

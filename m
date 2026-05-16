Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E0F342514;
	Sat, 16 May 2026 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956647; cv=none; b=NUNPdUVMmXfBudcxFq70FXzesn8SrWs6XtuClafVpXfFcwT55lOgOb4EDm3cher/ypEb2YynJtTvSrTvKp1eedXUIUVJy3I3xoSYSHfcH+zFLZYEUxQPyaPxjclN7Bv0BW3Q4QDfbCxjgV3WfFHPYbkda/N4+rlPeJ1u6w3P6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956647; c=relaxed/simple;
	bh=uClJ0L17ynWbY4YuI5snfXPDwvcqzODKDGDtrjyzs6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0wKNr1dTJd1Q6AYBNQCrpv9y+oxfhP00SjEjuJQFhOvwQLFD2YdjVIPhCk0VmjOiKW/GK2hVnTv8aUaCYK4LHc4bByNkFAJC0vdzSc2IuSZYg5cvdzYKrXm+Fvkz0VKj8MIK3RSTVu/kHTbHr1HfBWYiReivixziQpLdpmukN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahYiYfUu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahYiYfUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B051BC2BCB8;
	Sat, 16 May 2026 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956646;
	bh=uClJ0L17ynWbY4YuI5snfXPDwvcqzODKDGDtrjyzs6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahYiYfUuE7c1uPb7cCFrsijDXb3+lORDe/eBd6SqLA9iZ7SWMSdssqv2TfKfQjxh2
	 JBiUBXvOuPpqpJ+2AzsaGURyx2GxQmjr9rB9QSxnEW0TQtnge/IkuSDprJcjrv98+Q
	 iSagIWedjuRRSsgAB1+QX2xvYH0wDdRRlisv8cBkJkcGtib+aG+lTg2/v+XtP1PuFe
	 yHrlgI9gIT5QGOo4u3i/mne/7Dfjq/me4uTjgSqXQE3SVcAdIMK7tsmTFpjvlbrki4
	 w2K5+/kzBYsjUwby0GwIGxn7OUByOyIUNd78wEyL3tQV/CRf0yanjIx3o9v1cxvtUQ
	 fjxww7q58P2BA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 07/28] mm/damon/core: do data attributes monitoring
Date: Sat, 16 May 2026 11:36:48 -0700
Message-ID: <20260516183712.81393-8-sj@kernel.org>
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

Implement the data attributes monitoring execution.  Update kdamond to
invoke the probes application callback, and reset the aggregated number
of per-region per-probe positive samples for every aggregation interval.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e5667660b4cd9..dde3c8d8fef89 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1886,10 +1886,14 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 		struct damon_region *r;
 
 		damon_for_each_region(r, t) {
+			int i;
+
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
 			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
+			for (i = 0; i < DAMON_MAX_PROBES; i++)
+				r->probe_hits[i] = 0;
 			damon_verify_reset_aggregated(r, c);
 		}
 		ti++;
@@ -3179,6 +3183,8 @@ static int kdamond_fn(void *data)
 
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
+		if (ctx->ops.apply_probes)
+			ctx->ops.apply_probes(ctx);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
-- 
2.47.3

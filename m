Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C135CB95;
	Fri, 15 May 2026 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805889; cv=none; b=b4V1epj1zYDne+WqCW3zK+s1EguqBMXOsrSwP/sovFaEF6GcYsmMPBpuiTZvioTaeERKsaPke4Ekb8dhlcZ/er2/hgwTQbarbFmbqCGgeye+U7t+/7O1J81TZTaZCg0O7EkZf2tsKFVYB1mYpRTid5JLh8dk0kYKRx/kqcm6o6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805889; c=relaxed/simple;
	bh=hJODIpSBe8AcoDpxEMr90X7CC52zMi/o1RheHHmVCuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETEl8Fiaty/BZb8L7yYA3JFp7+6Icy49Pa34CkfOEXE/YWcEF6hjjmg05Je+56mW3zrBbhl2hmjJ6RavibDvS/UJFU7PL+qZPZ4CIhfatcESuVltv3x86ZJ+C63QoAadtadt1hOsHhskWQLOBY10FsifJJmuu8zsZINqjh7ftvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvWDiupR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvWDiupR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8C2C2BCF6;
	Fri, 15 May 2026 00:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805888;
	bh=hJODIpSBe8AcoDpxEMr90X7CC52zMi/o1RheHHmVCuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvWDiupRPolo+bI3uwA60KKbJSlraBTVeak2lv4k19vVRUsmGYp2FM4FYG0HezUWa
	 JNRqhbb1tMro1nEZQqZRlQIk+W++tGR2PL1KERbGAVbDGxyYHcruVGetbp76QqG9EG
	 mDkbw19PUUYbJofBvNMsBl9+CRt7gxPjRvUmO3htl/vwONMng087yE7Mwz3KTtQRWE
	 h9Baf0U2IyesUlOsTQsrEUfHudVljtcfxwkVxLwW/GQCXciuUiY9CNwsCGnT1NIX89
	 l0c8sL9WCMQq3bowKSxfzboyTZnrKOm5ye6sHwPLCb5jVlWJEtAQDsmeNsAXw8NfrI
	 ZwSiRlAueNd4g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 07/28] mm/damon/core: do data attributes monitoring
Date: Thu, 14 May 2026 17:44:08 -0700
Message-ID: <20260515004433.128933-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
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
index f6b4beb4b8ecd..1c9d2fb69f98d 100644
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
@@ -3172,6 +3176,8 @@ static int kdamond_fn(void *data)
 
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
+		if (ctx->ops.apply_probes)
+			ctx->ops.apply_probes(ctx);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
-- 
2.47.3

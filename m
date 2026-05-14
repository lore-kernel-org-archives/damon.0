Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60098401A37;
	Thu, 14 May 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767761; cv=none; b=sXtItBm6lBO2gogy1UDliiDY5rXOyVsJmitXr+ZGT5wtFbIhtTK4fUO2T5kxQUaa1d7LwHa5gm8+zATdcYZvRrmmJA65AuWS11Ox1aZAn+6yDfIUygrkmIJL9bK4r0wnhnJsoAziFyr7D2rlQ2MxC2aRUW9LaF5D6iiQ7oPkvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767761; c=relaxed/simple;
	bh=SGvDGH8HeHXn8zTVaCZsyhJzQGptwbmD0KfHLczQ4ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXD1tuJ2gr8xG1N1m90s1mjkzhVaoaWe1CBqeoeYqBpcyBLFreou4VCuLocAoZ3YrNCsxrQ2SU9metRLMAdUt5R92WKGPx616x0O7v61j8OJom3RYqz4cWv/cCZHnQt4QGOfaiORnobeZt6ylbbpoEnYI7o4dokfGiwbGPG8U/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSxFk+bb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSxFk+bb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64246C2BCC7;
	Thu, 14 May 2026 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767760;
	bh=SGvDGH8HeHXn8zTVaCZsyhJzQGptwbmD0KfHLczQ4ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSxFk+bbIJ21MwYKBtiVCAORutbQ0qsh59pDgQMMBT6Jjm2t9L8OffX/GZ3fEqHpn
	 J7LxEhj0pPWxKuLFSOlUSZEtTC1YUE6XsusV8x/g8X+2m+it5qU0b7MSzmFcrnSx2d
	 2GJ5u/ivLnq72A6gIsBONUtwAlaJrtqU2eQUPoo7fUxDwRlcCrE2epC2YCdHuXZoCv
	 Lb418mWzR0q7ApNNOppcHUMK28BlQfF3elCubjVvpJ9M5r+adADmphEhjswa8yCin8
	 FU6oz0jdyfLF10poeCbdzylDNZiyCDld43ltKUQgYDTcIHdV0M/IsL/8wRlnPDrPi/
	 xpwlRpY30sbkA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 07/28] mm/damon/core: do data attributes monitoring
Date: Thu, 14 May 2026 07:08:40 -0700
Message-ID: <20260514140904.119781-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
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
index 72acdeb8c478e..fe6c789f2cecb 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1910,10 +1910,14 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
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
@@ -3400,6 +3404,8 @@ static int kdamond_fn(void *data)
 
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
+		if (ctx->ops.apply_probes)
+			ctx->ops.apply_probes(ctx);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
-- 
2.47.3

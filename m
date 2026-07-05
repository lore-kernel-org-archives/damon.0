Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4283A1E80;
	Sun,  5 Jul 2026 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285076; cv=none; b=mtlF75YevFljtFytywABnau1OGaOkYr/FPyR0iBIlE/M9JRAVoW2d1vV1PqXlGbphpOY09/4K0p3ZdkymeFpGPWhcyo4kFCkRnsMsaINjIzv9H2WEx7GTPOQPasnINFnxP441IGLGSUFUOlPEHwE2mg3t5ANmgCo6mgDEtiTrvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285076; c=relaxed/simple;
	bh=cOO8k05qs8K2ptOfg1ImvOrODYynHhEQW31RNZPhIV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNeBeNEGkhNVzrr3Q7Y47VrFWDVcET7s1tG03HlWyS3h3vTauD1O54i2AHUZm0HeEujrF5BU/q/hQLds9u8q2PtAE3bfDBKy4jo3/1iw6vt/nGeqZsr8QdPKXvuiC9fQS2n6WhJheWjnNOe3WNkvBI5AViRc7V74ovT8V+8NiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5ZpNRl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5ZpNRl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4819D1F00A3D;
	Sun,  5 Jul 2026 20:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285075;
	bh=HWM9ulbAfG9bosKr1Xo0BbZMoQtsvPUcnEqaGbAY52s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d5ZpNRl6fvmW83KKSXyUuTyE87rA/bXRA4wLjovZyHCnAYMuO8wFQksZ25hz4kabW
	 JH434phDAKXBga/SdAIN8rSmdTThwWYr3eLBKC7sef82/z3T50sE+puhGzbSemQwHx
	 sp4drReeE2DtOSUY3i5tDnSg79rzuD9TQyFiVJo0tmFzUWYs/OB4Z02B5ZujzRfT3P
	 jaz+8RZNTa80vqKB29hhVyF0wB8CYT/x9b81s+ZHtWOWB+lOt5B4GZMsng6ueqker/
	 wdg9HMPBBJC0es0q0Cl8cSxwt9+7nSjRgH2+znPUByyINF+3gPCFpp+w3kjZww82An
	 dpdymwrCpN1cg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/16] mm/damon/paddr: respect return_max_wsum
Date: Sun,  5 Jul 2026 13:57:28 -0700
Message-ID: <20260705205743.98656-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705205743.98656-1-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
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

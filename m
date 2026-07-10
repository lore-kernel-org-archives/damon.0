Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEED1DA60D;
	Fri, 10 Jul 2026 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643041; cv=none; b=gKMQOOMFFu8xEM3FdrJkZEXMjUOwFes+UdngmFnWzDS34n4U0bQF9JELzD5HZygz4lOWgR+BNSS0qczJInUz4EurhYA8VmlOyGtCV9K6zxRAEbURq1nlby96ng2FlcprH0E+q3xlDsRIgCf9px9wdEpK6Qc6YlSoMtw7PaMkK1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643041; c=relaxed/simple;
	bh=cOO8k05qs8K2ptOfg1ImvOrODYynHhEQW31RNZPhIV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLBlk+0507pO1piuR4Doo5LqAAvA+79RJP2Ps9ZMDP3fDVtMOCjYumDSPZR0OSulROrS6C+rvtWzZ3iDXATpjHjxWMeIItcvbBOaDZLf5qLHTJatCfzXnWgvq+Hol+n2fF4+ilIv76nzXoNU9fv/iqd7ORwhiL/XIycYjDzcaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0hmnbHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0hmnbHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872A71F00A3F;
	Fri, 10 Jul 2026 00:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643040;
	bh=HWM9ulbAfG9bosKr1Xo0BbZMoQtsvPUcnEqaGbAY52s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0hmnbHBPEHzGx8A+oPtTkkPBrTG39LRjcnvRUfEvoczdjBCHtnSxb/6R9S5LQH6+
	 9JXrO1XzAr2ACSM5XaiQ2gc9bJej1WSruLpboI6WKxsA63rxIaMrkX7xyHIOkQLP39
	 ga7bwUHEfnbiIfQTfNUCEJ5hKEE7kkBVi9Mu6+Uab/zsQsOG+lbMQU/ZUKPVhZhgYB
	 aPSpFp/vLdAM8RI0oAVWcyzGWTlggcpe3VSzFeAs9QQQq30OpiOfIAkNDyvHDj2h5T
	 V1JwxwdGEKZ+SHw0LyDiH2OMa3aGhFr2x58orb5NSnh7cM9ZYsq6xQ9yVJJnciiLsU
	 vWiauJWMjCRGg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 06/19] mm/damon/paddr: respect return_max_wsum
Date: Thu,  9 Jul 2026 17:23:32 -0700
Message-ID: <20260710002349.111414-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
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

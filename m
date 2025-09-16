Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF5B2BD58A;
	Tue, 16 Sep 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047492; cv=none; b=gfizkkis8yg0HJmgh5bDLl4cB6nH2TkSXJKo0k0qxLIwIoJv5mvhJ71feKahkRG7UTmsIzdlJWAtWSMfGoewPdf1Fp7bSVpk+bLwQAi50H8oLvegR3pQFKMPZzJYCkFRSRhHHo5vUBppYNPH4LJa7ZqfKT4QTjfeTxAl6vRNyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047492; c=relaxed/simple;
	bh=BVPIvvATKe2I5aamkuVMwHJN/okxBP1F7amj6w2lqa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KcxSBV3C4gdVuGruCNad7kKyQsBwWlKmvfmxMF25Vn7pZfhzc0rPlABKtZdRngxaIqvEnjszZSAfHanttYDjY/vu8TXuj9Vh0au1d63ayWZWIg403XKi+unMG2s7zov+ElbMJbu5U8qk1tTnWBcWVw8sYJeeuHZW2hf563QGaJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoQXHer3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoQXHer3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DDBC4CEF9;
	Tue, 16 Sep 2025 18:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758047491;
	bh=BVPIvvATKe2I5aamkuVMwHJN/okxBP1F7amj6w2lqa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MoQXHer3AtMIRfigqulPv6i5Mkb+ktfl4XK7TU1Ai5vW1g6Pp6u/gKs/5BKnGDkQs
	 lTSekckm0rCrJzkLz/QOwdRP+1gtL3NCsrShjfBLgIxSTIc5pOhFCqqmd626C/3wA6
	 G8g+OFcc6n0/XWjudponNYf58faEGX9AZ0Nc4s7ulD1GjoRGoYWNAIW/W7TzCv0nLg
	 Jat5H6VcbTLyBj6sRlzvaC1DQCkvfB86S2CbZItmg53Cz4r7oDfkpmuQSHPVdZ+2dm
	 9AgyjmUs+8pJDiGVmfHlWSH3TqrPeq3OtQ5xtQlTQrzdbDJxUwxN4q+djN0/ksi6RI
	 UREY/Vn4s2z9w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/stat: expose the current tuned aggregation interval
Date: Tue, 16 Sep 2025 11:31:26 -0700
Message-Id: <20250916183127.65708-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916183127.65708-1-sj@kernel.org>
References: <20250916183127.65708-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT calculates the idle time for a region as the region's age
multiplied by the aggregation interval.  That is, the aggregation
interval is the granularity of the idle time.  Since the aggregation
interval is auto-tuned and not exposed to users, however, users cannot
easily know in what granularity the stat is made.  Expose the tuned
aggregation interval in microseconds via a new parameter,
aggr_interval_us.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index c4fbd8cfa5eb..1a8465abef4a 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -39,6 +39,11 @@ module_param_array(memory_idle_ms_percentiles, ulong, NULL, 0400);
 MODULE_PARM_DESC(memory_idle_ms_percentiles,
 		"Memory idle time percentiles in milliseconds");
 
+static unsigned long aggr_interval_us;
+module_param(aggr_interval_us, ulong, 0400);
+MODULE_PARM_DESC(aggr_interval_us,
+		"Current tuned aggregation interval in microseconds");
+
 static struct damon_ctx *damon_stat_context;
 
 static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
@@ -133,6 +138,7 @@ static int damon_stat_damon_call_fn(void *data)
 		return 0;
 	last_refresh_jiffies = jiffies;
 
+	aggr_interval_us = c->attrs.aggr_interval;
 	damon_stat_set_estimated_memory_bandwidth(c);
 	damon_stat_set_idletime_percentiles(c);
 	return 0;
-- 
2.39.5

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8B2DAFD2;
	Tue, 16 Sep 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047493; cv=none; b=udVFmbyrg4zgzJX5R5/CiEMUrWMK1Q8ir0BZXFotw2XKY8KiXFVzFLnucYHUXNuvd627HAadbazulrLoWWstgVPAx2C0Slvw31k8ohzICYDQ9iYfnGNC2P3CEZkjewN5lrEPU5/zFpzn+9PXikDv+9FHsPxuVxwbGj0ZkZHjTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047493; c=relaxed/simple;
	bh=7h0SXCHIrLtkJvqCMts1fDwLssCc9jFcz1TwtN1yTk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgHiwQJBgvHInjBXIl7fZD/CHuzQQPe6svkIHvNkqAAEZUv9xGoZkflaDtPW87TtX0XPTXO2Q4UxGyyQQY34Tj1FZgexCfPjUSNOHVSxu/TZc8Oeqkfgk3QsPgiHcki8KIF2FrmzR8BXlH3MdmuBP3W7Pwchac6pR0YdX05Qv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO9D/T+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO9D/T+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B657BC4CEF7;
	Tue, 16 Sep 2025 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758047492;
	bh=7h0SXCHIrLtkJvqCMts1fDwLssCc9jFcz1TwtN1yTk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dO9D/T+U4fIXZoWGmqq+0hnaP8FRrEocTXAw1wplxnxtODrrLMbq8X1Vo7D+lQI+3
	 1da6zj9EYZ1qZBXD0o6QzbrW6opZDO3SXX45YZxOx/WilrvFKiknqBmue7zKZN8+jq
	 7ALnwCVH8qH8Sqz3J0eI8mbBKPXxM+MdGK0x0SqvIl9Lpo36pF3BG6EmYz+IVMsmtd
	 uLbJG0ue1r/EVSEuiMbhf3YI/rF/aBBv9ArHcsoO9ReUl2XHrAr5LN+fhUyJ1r3sQu
	 TlLrPXWzfY+VYeTCsd16jZsv7YiTnteGkLmGTRbcVsmeCxmrnODNYwz0eaTAvInpC/
	 rAjfH+zMNu/1g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm/damon/stat: expose negative idle time
Date: Tue, 16 Sep 2025 11:31:27 -0700
Message-Id: <20250916183127.65708-3-sj@kernel.org>
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

DAMON_STAT calculates the idle time of a region using the region's age
if the region's nr_accesses is zero.  If the nr_accesses value is
non-zero (positive), the idle time of the region becomes zero.

This means the users cannot know how warm and hot data is distributed,
using DAMON_STAT's memory_idle_ms_percentiles output.  The other stat,
namely estimated_memory_bandwidth, can help understanding how the
overall access temperature of the system is, but it is still very rough
information.  On production systems, actually, a significant portion of
the system memory is observed with zero idle time, and we cannot break
it down based on its internal hotness distribution.

Define the idle time of the region using its age, similar to those
having zero nr_accesses, but multiples '-1' to distinguish it.  And
expose that using the same parameter interface,
memory_idle_ms_percentiles.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 1a8465abef4a..d8010968bbed 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -34,8 +34,8 @@ module_param(estimated_memory_bandwidth, ulong, 0400);
 MODULE_PARM_DESC(estimated_memory_bandwidth,
 		"Estimated memory bandwidth usage in bytes per second");
 
-static unsigned long memory_idle_ms_percentiles[101] __read_mostly = {0,};
-module_param_array(memory_idle_ms_percentiles, ulong, NULL, 0400);
+static long memory_idle_ms_percentiles[101] __read_mostly = {0,};
+module_param_array(memory_idle_ms_percentiles, long, NULL, 0400);
 MODULE_PARM_DESC(memory_idle_ms_percentiles,
 		"Memory idle time percentiles in milliseconds");
 
@@ -61,10 +61,10 @@ static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
 		MSEC_PER_SEC / c->attrs.aggr_interval;
 }
 
-static unsigned int damon_stat_idletime(const struct damon_region *r)
+static int damon_stat_idletime(const struct damon_region *r)
 {
 	if (r->nr_accesses)
-		return 0;
+		return -1 * (r->age + 1);
 	return r->age + 1;
 }
 
@@ -122,7 +122,7 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
 		while (next_percentile <= accounted_bytes * 100 / total_sz)
 			memory_idle_ms_percentiles[next_percentile++] =
 				damon_stat_idletime(region) *
-				c->attrs.aggr_interval / USEC_PER_MSEC;
+				(long)c->attrs.aggr_interval / USEC_PER_MSEC;
 	}
 	kfree(sorted_regions);
 }
-- 
2.39.5

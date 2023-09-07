Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE0EBF
	for <damon@lists.linux.dev>; Thu,  7 Sep 2023 02:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C04C433C9;
	Thu,  7 Sep 2023 02:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694053785;
	bh=BKOeFu7T8a2LEb2S23swx71FouyPaLhdxkSplv88jDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kW9lSKJUK8+ODGx8+zLAuwY4U8iF1ZuvoO7A+S27Q/xz6o4XPq68SwXNgzmyYnuEj
	 7WyyAtobo0uu9GfdSX6ATJ6HmrbwpUrlbRY76oIle3a7639PBD8FsDroWOedtlhvBJ
	 BprdBWHVEqzGCzw1lDqWeyDNOvDtW4K3fbPjftNElyFGevEYFcZI9LzRv05kW1qN4M
	 6PYPngTZqKcq7sHlV9uEdLmA9k+RYmpT5Y6vpkCEZmF6/KzzVksprDIJzoQbnn7lf6
	 8EYD5qEPNvxsMDKaO3Nq5KDn2d3yN6qiyuRZxCJf3DJt5CLXz0xiLjdo+Z3cOkkHoo
	 eI3cefVYuwqfg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] mm/damon/core: remove 'struct target *' parameter from damon_aggregated tracepoint
Date: Thu,  7 Sep 2023 02:29:29 +0000
Message-Id: <20230907022929.91361-12-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907022929.91361-1-sj@kernel.org>
References: <20230907022929.91361-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_aggregateed tracepoint is receiving 'struct target *', but doesn't
use it.  Remove it from the prototype.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 6 +++---
 mm/damon/core.c              | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index c79f1d4c39af..0b8d13bde17a 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -11,10 +11,10 @@
 
 TRACE_EVENT(damon_aggregated,
 
-	TP_PROTO(struct damon_target *t, unsigned int target_id,
-		struct damon_region *r, unsigned int nr_regions),
+	TP_PROTO(unsigned int target_id, struct damon_region *r,
+		unsigned int nr_regions),
 
-	TP_ARGS(t, target_id, r, nr_regions),
+	TP_ARGS(target_id, r, nr_regions),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, target_id)
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1ce483a3c2b5..b895f70acb2d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -805,7 +805,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 		struct damon_region *r;
 
 		damon_for_each_region(r, t) {
-			trace_damon_aggregated(t, ti, r, damon_nr_regions(t));
+			trace_damon_aggregated(ti, r, damon_nr_regions(t));
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
-- 
2.25.1


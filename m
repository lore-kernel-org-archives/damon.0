Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ECF3C0C
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29C2C433D7;
	Tue, 13 Sep 2022 17:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091097;
	bh=0FJOrqHiBH1OMZ45Xdi5Z4U0goCpXjUFgshxwmAlQlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=es99vqn1ffMbBBFLbtJGVKcjrXyHgR79vSQyF0z+ScdGpaJVr4lW+yHoZQY+cSeoA
	 sDnWKHHLwouvB+Zqwonl+asV8uuQ5yR3RntZz1IOzHkyWWrBqHL+dCMk1djGjKD2w/
	 cadkRl8b9QdRMDShd4e8ji6ZM44RrDr5DaZoBADBZCiKrMoShbygsJBMtDTVNIH9fJ
	 bZLFnSUNJJ1OTq/ZZO/TQSFP2yIjj3mZpxhQA4R/6qcuZYoCskfcc+6uDPI8/TywE6
	 Lw9m7KejLWOzndrIP8VeFBEQAs1J/S2f7h+Q5xNCBA33BVfctyyg2DNBGdTuErwq+U
	 uoTiG3DLxRwoA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/22] mm/damon/core: copy struct-to-struct instead of field-to-field in damon_new_scheme()
Date: Tue, 13 Sep 2022 17:44:30 +0000
Message-Id: <20220913174449.50645-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function for new 'struct damos' creation, 'damon_new_scheme()',
copies each field of the struct one by one, though it could simply
copied via struct to struct.  This commit replaces the unnecessarily
verbose field-to-field copies with struct-to-struct copies to make code
simple and short.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c21f5fe5928a..27e0c312f7a5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -276,22 +276,13 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme = kmalloc(sizeof(*scheme), GFP_KERNEL);
 	if (!scheme)
 		return NULL;
-	scheme->pattern.min_sz_region = pattern->min_sz_region;
-	scheme->pattern.max_sz_region = pattern->max_sz_region;
-	scheme->pattern.min_nr_accesses = pattern->min_nr_accesses;
-	scheme->pattern.max_nr_accesses = pattern->max_nr_accesses;
-	scheme->pattern.min_age_region = pattern->min_age_region;
-	scheme->pattern.max_age_region = pattern->max_age_region;
+	scheme->pattern = *pattern;
 	scheme->action = action;
 	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);
 
-	scheme->quota.ms = quota->ms;
-	scheme->quota.sz = quota->sz;
-	scheme->quota.reset_interval = quota->reset_interval;
-	scheme->quota.weight_sz = quota->weight_sz;
-	scheme->quota.weight_nr_accesses = quota->weight_nr_accesses;
-	scheme->quota.weight_age = quota->weight_age;
+	scheme->quota = *quota;
+	/* caller might not zero-initialized the private fileds */
 	scheme->quota.total_charged_sz = 0;
 	scheme->quota.total_charged_ns = 0;
 	scheme->quota.esz = 0;
@@ -300,11 +291,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->quota.charge_target_from = NULL;
 	scheme->quota.charge_addr_from = 0;
 
-	scheme->wmarks.metric = wmarks->metric;
-	scheme->wmarks.interval = wmarks->interval;
-	scheme->wmarks.high = wmarks->high;
-	scheme->wmarks.mid = wmarks->mid;
-	scheme->wmarks.low = wmarks->low;
+	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
 
 	return scheme;
-- 
2.25.1


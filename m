Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE282200B8
	for <damon@lists.linux.dev>; Fri, 20 Oct 2023 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2Uo8d1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744D4C433C9;
	Fri, 20 Oct 2023 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697822608;
	bh=A7qQGX2x61HuX9WngSjrxy/tMdxThwG7cO+vlCnt/oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2Uo8d1dOObRxHmQhvT+GaBkbeipS3EDjJHzlrqnXCOqDtzreW0cAfNfLBKnVc8lc
	 lCprkGxeggXj98oVNf/z2gNIDicTFnmBoUSvD8XtZKmqF8BGuA1vA5ufLZh4OjhNfY
	 xc9+xQc4jg/efEPeUXH3jErpnXwLGo738cZmOScqm/dYnZfejUTXwGj+LjFdURrRTu
	 pAbE3gO8gyfQ/zOq8DRIK0aUFpnm+GIxyJPhGLoPRDPqkfz3HJWzOyFpKlnff7OBsQ
	 1he8H2Uc1OZyM9peBjSqaiWiqy51/HuuUooffHS1eN5ncUvPAJQtvNwZEIHW/YnzZt
	 O2zyOi3nvaUSA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mm/damon/core: avoid divide-by-zero from pseudo-moving window length calculation
Date: Fri, 20 Oct 2023 17:23:17 +0000
Message-Id: <20231020172317.64192-6-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020172317.64192-1-sj@kernel.org>
References: <20231020172317.64192-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calculating the pseudo-moving access rate, DAMON divides some
values by the maximum nr_accesses.  However, due to the type of the
related variables, simple division-based calculation of the divisor can
return zero.  As a result, divide-by-zero is possible.  Fix it by using
damon_max_nr_accesses(), which handles the case.

Note that this is a fix for a commit that not in the mainline but mm
tree.

Fixes: ace30fb21af5 ("mm/damon/core: use pseudo-moving sum for nr_accesses_bp")
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Note that this is for a patch in mm-stable that not yet merged into the
mainline.

 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e194c8075235..aa2dc7087cd9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1665,7 +1665,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 	 * aggr_interval, owing to validation of damon_set_attrs().
 	 */
 	if (attrs->sample_interval)
-		len_window = attrs->aggr_interval / attrs->sample_interval;
+		len_window = damon_max_nr_accesses(attrs);
 	r->nr_accesses_bp = damon_moving_sum(r->nr_accesses_bp,
 			r->last_nr_accesses * 10000, len_window,
 			accessed ? 10000 : 0);
-- 
2.34.1


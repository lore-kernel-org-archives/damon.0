Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7123C3F
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A331C433B5;
	Tue, 13 Sep 2022 17:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091098;
	bh=vJRpVbuRNEWxiwJhtSxeIniDUyu+JoVCpD8GHbjL3iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oa67jNZTl390H4yWs/1PtCmIDFSn0aIjc4wOuOXCSz50qUjEsDezOvqO40mBPvRBb
	 JUqkSUSti/9RzAq9wIXpJ9bVY4V+KGnatsFN9xP62cAbc0b2R0l7y9232rPe/ehdi4
	 4diPT6xyF1GWkQxGDSKEvTnVsLMkMf4gIvMxMUWWFdAyzm9ad05f7365FDP5wyXYB2
	 t3XGfWvJlYcP231su+/HpzPF23arUhQ1wjp4YdxXPn6uta8Qb5L7ZheEYatfDBsBQb
	 eNZJvCqQXW3ZwEqG21pchF6xekZzdau7IIzVqNBiLwPog0t5W/PxfU9QK/tgEdukdN
	 zpRO4nyJerBOw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/22] mm/damon/core: factor out 'damos_quota' private fileds initialization
Date: Tue, 13 Sep 2022 17:44:31 +0000
Message-Id: <20220913174449.50645-5-sj@kernel.org>
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

The 'struct damos' creation function, 'damon_new_scheme()', does
initialization of private fileds of 'struct damos_quota' in it.  As its
verbose and makes the function unnecessarily long, this commit factors
it out to separate function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 27e0c312f7a5..6767580c0a27 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -267,6 +267,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	return 0;
 }
 
+/* initialize private fields of damos_quota and return the pointer */
+static struct damos_quota *damos_quota_init_priv(struct damos_quota *quota)
+{
+	quota->total_charged_sz = 0;
+	quota->total_charged_ns = 0;
+	quota->esz = 0;
+	quota->charged_sz = 0;
+	quota->charged_from = 0;
+	quota->charge_target_from = NULL;
+	quota->charge_addr_from = 0;
+	return quota;
+}
+
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action, struct damos_quota *quota,
 			struct damos_watermarks *wmarks)
@@ -281,15 +294,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);
 
-	scheme->quota = *quota;
-	/* caller might not zero-initialized the private fileds */
-	scheme->quota.total_charged_sz = 0;
-	scheme->quota.total_charged_ns = 0;
-	scheme->quota.esz = 0;
-	scheme->quota.charged_sz = 0;
-	scheme->quota.charged_from = 0;
-	scheme->quota.charge_target_from = NULL;
-	scheme->quota.charge_addr_from = 0;
+	scheme->quota = *(damos_quota_init_priv(quota));
 
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
-- 
2.25.1


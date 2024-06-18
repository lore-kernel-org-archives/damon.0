Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0416630B;
	Tue, 18 Jun 2024 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734704; cv=none; b=pK9UAJiGPXHPfoKr9AJDyss3JOFOthiiONEsRRSlNzNG+F333BNC9MuMQREdcC2CAaFOgH4RhKRzNiMANgLopKR5suNOyC1656jQ3FgLOdIB7ouk6tFxcwajR3HqPT5d98ayM5dc3veXZOk9FZx04orqwEKUXO2qAZfyXWMRKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734704; c=relaxed/simple;
	bh=EHvHHvs3IdQ5P9rJaPK4ESC9R2II3qWxcAR6kWa1t4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Thx5gemWxCHeFebJzz9LyuFriogJHRPVHaLnsPzfj3TkKpTjFIc7krSRjHN2Os3Mgs7DHY1rmJKtN1H//g3bzmxCovGY3pmT5eHKVU94Kfx0uGW+3U18S7vWg+pZ42OKWnf/9ibQDz//g8ZqeEtz5zOZRxnx/etvkMj7/TpiyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b83Rt0oM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b83Rt0oM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B564AC4AF1C;
	Tue, 18 Jun 2024 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734704;
	bh=EHvHHvs3IdQ5P9rJaPK4ESC9R2II3qWxcAR6kWa1t4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b83Rt0oMqPtrzFHwkktThAbwt6RLmjgTiYcJl5Yy8yP9GJeb/W67nnfp5KZK0arUv
	 AILftpGiE3WMsdcmNVeO06uiWCOP57jzQFLd1M8NPK1GdpHyeeBWFks1meqa/uR74z
	 DWfr3k0KW/cwRj2FJZ4zBkjFtSID93TaQ4C7+cS9bb0DBl9MUr+I84JLe5+2BrtIRJ
	 BUqf6UfT/EeGXEDHkhVbNrnNcvbOZNlJIgR/RwJHs/r28rZ1dBIEY6OkC+j0xFOk89
	 gykTKPRNkIWYUZK8UdpT7GsbE6qwRUCV9YHJ614stO3SWX0cnJ/oDWEJL45ZS2dn1m
	 2zQtXOPOaSZGg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] mm/damon/lru_sort: remove unnecessary online tuning handling code
Date: Tue, 18 Jun 2024 11:18:09 -0700
Message-Id: <20240618181809.82078-13-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618181809.82078-1-sj@kernel.org>
References: <20240618181809.82078-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT contains code for handling of online DAMON parameters
update edge cases.  It is no more necessary since damon_commit_ctx()
takes care of the cases.  Remove the unnecessary code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index f83542973946..4af8fd4a390b 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -186,23 +186,11 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
 }
 
-static void damon_lru_sort_copy_quota_status(struct damos_quota *dst,
-		struct damos_quota *src)
-{
-	dst->total_charged_sz = src->total_charged_sz;
-	dst->total_charged_ns = src->total_charged_ns;
-	dst->charged_sz = src->charged_sz;
-	dst->charged_from = src->charged_from;
-	dst->charge_target_from = src->charge_target_from;
-	dst->charge_addr_from = src->charge_addr_from;
-}
-
 static int damon_lru_sort_apply_parameters(void)
 {
 	struct damon_ctx *param_ctx;
 	struct damon_target *param_target;
-	struct damos *scheme, *hot_scheme, *cold_scheme;
-	struct damos *old_hot_scheme = NULL, *old_cold_scheme = NULL;
+	struct damos *hot_scheme, *cold_scheme;
 	unsigned int hot_thres, cold_thres;
 	int err;
 
@@ -215,22 +203,11 @@ static int damon_lru_sort_apply_parameters(void)
 		goto out;
 
 	err = -ENOMEM;
-	damon_for_each_scheme(scheme, ctx) {
-		if (!old_hot_scheme) {
-			old_hot_scheme = scheme;
-			continue;
-		}
-		old_cold_scheme = scheme;
-	}
-
 	hot_thres = damon_max_nr_accesses(&damon_lru_sort_mon_attrs) *
 		hot_thres_access_freq / 1000;
 	hot_scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!hot_scheme)
 		goto out;
-	if (old_hot_scheme)
-		damon_lru_sort_copy_quota_status(&hot_scheme->quota,
-				&old_hot_scheme->quota);
 
 	cold_thres = cold_min_age / damon_lru_sort_mon_attrs.aggr_interval;
 	cold_scheme = damon_lru_sort_new_cold_scheme(cold_thres);
@@ -238,9 +215,6 @@ static int damon_lru_sort_apply_parameters(void)
 		damon_destroy_scheme(hot_scheme);
 		goto out;
 	}
-	if (old_cold_scheme)
-		damon_lru_sort_copy_quota_status(&cold_scheme->quota,
-				&old_cold_scheme->quota);
 
 	damon_set_schemes(param_ctx, &hot_scheme, 1);
 	damon_add_scheme(param_ctx, cold_scheme);
-- 
2.39.2


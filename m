Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94A317173;
	Thu,  2 Jul 2026 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026374; cv=none; b=LAHQpGoypghqVcFiFr4dyk0y04SiW13TUY0Gyoyejm6tnI12NadYg0v2Sc/+DZNYbHdA2rjP/f8JlN7LoVJbgslp941yXut0xi8/WtN0pdit4L+v7Mt7OKwxUYxb36WdpyuiqgjQsOEddhW7D+JDXznV8nwRCcAb88rDbfdDzjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026374; c=relaxed/simple;
	bh=bVI/yoXGy31smQ7HrzpZhw/q4TPXvx89CW3lmyFpUZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bI2IYxyScQBfBvKPauF80yYCg0RE5hPhVzpHPcejLnI69hvvha60aoQQ2it8Dd7kLdunjkXpgNTYaQaYeLnSzMklHahtzfaCR+xHZNG4EHmqYM5hrtNb0+UrF0+fccVKF5ZstKZONz6YUgcrazJy4TYPfZjSYiwOvkhNAsUAgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljGPoVaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljGPoVaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD1F1F00A3D;
	Thu,  2 Jul 2026 21:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783026371;
	bh=z4feI/qU1SbwMydOJY76MHjKjfYHnoO820guZYu+4uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ljGPoVaRPSsYpd8xs8EBy2MLqzQCKbktUtw89flLSbk4nzvtlLCe/43mE10Bq9u+4
	 akxWatJ3/XfFjzRYBuiPRshbxUd5pDyWnZ1AvBxB0+79mzcKtLtsEoBUQzkJl7bVc6
	 oZLkTrQcoVHvCMcYhMQhAySQOVd9S2PunLvrPf2ebBHGXNvT9w0IU42vESskpQwZxT
	 O+zmtBjwLSBc3qqg/a3LBrDWFCA11CFy9kVsJHxei4AMYtopl39KS3WXXYgGFUYypE
	 H/e2AkkcfzlNXxhvnCBYJmzGa3MBij+3UPIDawYwwMRUyFnmltMK/yJUBlvQCDrpI0
	 +wC1CUFbLRFmA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 4/8] mm/damon/reclaim: remove duplicated min_region_sz power of 2 check
Date: Thu,  2 Jul 2026 14:05:46 -0700
Message-ID: <20260702210551.95167-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702210551.95167-1-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM validates the user input for min_region_sz.  The same
validation is done inside damon_start() and damon_commit_ctx().  Remove
the duplicate.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 11b70d0a9a6f0..6469b25cc34f9 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -208,11 +208,6 @@ static int damon_reclaim_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
-	if (!is_power_of_2(param_ctx->min_region_sz)) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.47.3

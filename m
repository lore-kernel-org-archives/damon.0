Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005FD38945C;
	Wed, 29 Apr 2026 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777435959; cv=none; b=aEJzB2T7vnVsU9yzOhVKovt9aLROXLcM3wZs1VMDI8i+kRCmpnhU8Rg8H69DHOuDrwEurrshckqUNdHCZB/rOll7cOvsWdfswFUAQXO7rG/jYCLTSS+INz/CqX18pNCwg0exvrnGWzjgBx2ZWtMLPmoCnU3KJOfLr45JRSJt+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777435959; c=relaxed/simple;
	bh=tLnMMWyWOb5JWter/hkS9/BroYtAzNu6DanZ/dgc7BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDtOdMgEsyk1HDFS29svWErdyWHIuEZnituXzDbik53z+wur27/FlNfITPD6nKVOMNS15gDBNVnT6eEhrPg7NXETR0AFq/TAZLTKMRgAGfFoJm8EDTtgAGuMI9fTLwFDCWT5QPrxkyn6e3wLyvmReVkAnRYeX9cujoNN7e1uOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWV9Zwqj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWV9Zwqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91620C2BCC7;
	Wed, 29 Apr 2026 04:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777435958;
	bh=tLnMMWyWOb5JWter/hkS9/BroYtAzNu6DanZ/dgc7BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWV9Zwqjp6SCQsoS8qqmQHNRel8GAHCYcF5lV7VFcRdPqRxvyktNufhT1B9y81cht
	 Nh6OekIufSS//qGawwe1wlVuDt0OSUCcptCmhOCHMHY1k/FeIaoJoTWSc6kmXmq8/S
	 hyeY1RQs2v8avPKP1ej2D2hh3DRxNhs8kIs5ktxOtmMLaqnc/RrO9rMtgJCZHronXT
	 T4kR5fK9jjjF2qNZTlzE9iZwmAQCzWyrGUkzpAhsGyJQHx1c4XbqiyvMt+ZKVP2X9X
	 xWWPIH4GBpqKo2BnJjv4ZQUvOx5+7/5x0u1pNrSNJIOxG4vV1/lXEbeHLwtfQi5Lyi
	 VIDXo6MDVIL6w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/7] mm/damon/stat: use damon_set_region_system_rams_default()
Date: Tue, 28 Apr 2026 21:12:27 -0700
Message-ID: <20260429041232.90257-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429041232.90257-1-sj@kernel.org>
References: <20260429041232.90257-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_stat_set_moniotirng_region() is nearly a duplicate of the core
function, damon_set_region_system_rams_default().  Use the core
implementation.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 53 +++----------------------------------------------
 1 file changed, 3 insertions(+), 50 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 3951b762cbddf..f4d3203e92639 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -148,59 +148,12 @@ static int damon_stat_damon_call_fn(void *data)
 	return 0;
 }
 
-struct damon_stat_system_ram_range_walk_arg {
-	bool walked;
-	struct resource res;
-};
-
-static int damon_stat_system_ram_walk_fn(struct resource *res, void *arg)
-{
-	struct damon_stat_system_ram_range_walk_arg *a = arg;
-
-	if (!a->walked) {
-		a->walked = true;
-		a->res.start = res->start;
-	}
-	a->res.end = res->end;
-	return 0;
-}
-
-static unsigned long damon_stat_res_to_core_addr(resource_size_t ra,
-		unsigned long addr_unit)
-{
-	/*
-	 * Use div_u64() for avoiding linking errors related with __udivdi3,
-	 * __aeabi_uldivmod, or similar problems.  This should also improve the
-	 * performance optimization (read div_u64() comment for the detail).
-	 */
-	if (sizeof(ra) == 8 && sizeof(addr_unit) == 4)
-		return div_u64(ra, addr_unit);
-	return ra / addr_unit;
-}
-
-static int damon_stat_set_monitoring_region(struct damon_target *t,
-		unsigned long addr_unit, unsigned long min_region_sz)
-{
-	struct damon_addr_range addr_range;
-	struct damon_stat_system_ram_range_walk_arg arg = {};
-
-	walk_system_ram_res(0, -1, &arg, damon_stat_system_ram_walk_fn);
-	if (!arg.walked)
-		return -EINVAL;
-	addr_range.start = damon_stat_res_to_core_addr(
-			arg.res.start, addr_unit);
-	addr_range.end = damon_stat_res_to_core_addr(
-			arg.res.end + 1, addr_unit);
-	if (addr_range.end <= addr_range.start)
-		return -EINVAL;
-	return damon_set_regions(t, &addr_range, 1, min_region_sz);
-}
-
 static struct damon_ctx *damon_stat_build_ctx(void)
 {
 	struct damon_ctx *ctx;
 	struct damon_attrs attrs;
 	struct damon_target *target;
+	unsigned long start = 0, end = 0;
 
 	ctx = damon_new_ctx();
 	if (!ctx)
@@ -230,8 +183,8 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	if (!target)
 		goto free_out;
 	damon_add_target(ctx, target);
-	if (damon_stat_set_monitoring_region(target, ctx->addr_unit,
-				ctx->min_region_sz))
+	if (damon_set_region_system_rams_default(target, &start, &end,
+				ctx->addr_unit, ctx->min_region_sz))
 		goto free_out;
 	return ctx;
 free_out:
-- 
2.47.3

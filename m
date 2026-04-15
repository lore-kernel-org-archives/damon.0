Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7232F531F;
	Wed, 15 Apr 2026 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216058; cv=none; b=i+61HDjM9ezvOFpRFqhqG7znCcH5GWLRRP63W9s1MUlE1VQzb6CGQ3Qei53XLwSiPu5724UEOh0SX4g5o8DWE9xulrF0Kdv4UgKUEx5XR2Nx6fTm1aYxwjAAaLi2m5c8B99dXOA13ASaPHqYYb2VqAQA8poGtAaXs06bWX2uRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216058; c=relaxed/simple;
	bh=N5D6bRH3BZfS+yc275UKlEY8TXSI6Z9gc0T71/W6wpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9ed/KWaTuuKwdpNx8nguCrcFsCofoCF3U2NkjsKw/TbPDkAApUkbNzlmrYUfsNvt6DPeHJkEEmTiXECxMSVLSYiYNh6YaeCZ9Ck4ZH0vLQ/Oyvfh2a89jxhPbANH2lYHxpPKR2SF77AghIV5kD6aMPo4lQfnk+4QSvnE7r64DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnTw+psW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnTw+psW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20456C2BCB3;
	Wed, 15 Apr 2026 01:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776216058;
	bh=N5D6bRH3BZfS+yc275UKlEY8TXSI6Z9gc0T71/W6wpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CnTw+psWl8aAIVYof592X9ltj79ixjRksFlUcDFybT/C6QT2R2sbnm3AxFn1pR3o7
	 OzbY23Ixwq4WX/1PGbQz/OX5w+x0VxoPXNhppwDvNFK3P37PgEjHP/BxYHsbDXDAST
	 U/TW5Wm9RS3HuiaaPtcYlya0QIBrgWWg+pExCZWd52QbUmGH/aYLjh+ekFGKGBSlAH
	 py3vdGmOoFW7Ha48wm9YpXVhnISzH6Btws5rRhpSNK8YKVOt2VlWJWziWeCvUNVkgg
	 /Smgt+0dqFKVUSt+EfZ5F4x3qXV/P2iWuyHqfGsy3ehDtgJ4Kbh18nEIaeEA8FwGGD
	 xTsZRBYdnDSaA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/7] mm/damon/stat: use damon_set_region_system_rams_default()
Date: Tue, 14 Apr 2026 18:20:33 -0700
Message-ID: <20260415012048.76508-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415012048.76508-1-sj@kernel.org>
References: <20260415012048.76508-1-sj@kernel.org>
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
index 4901e9a7c3398..da2ebf90ef64e 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -154,59 +154,12 @@ static int damon_stat_damon_call_fn(void *data)
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
@@ -236,8 +189,8 @@ static struct damon_ctx *damon_stat_build_ctx(void)
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

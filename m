Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F522B8A4;
	Wed, 16 Apr 2025 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777563; cv=none; b=jBmYk2Ktit+h9/SNoIxy+oEGLi5oXQu1q9fIdkEW2jv6yEcF9NzJoA/W4tsHjAErIy171D8/UodskJUGVofKVottFZhyPZi9cqtd8M5wTZ4OHGEs6bUt8zxIhYHqy3K2WzuP+U1fSZYozmRZ3l+Biz4fjAm6Q9TVk0Q3jM9C/bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777563; c=relaxed/simple;
	bh=NF1Fz3bDL9B8+3kS7pFSCGv/wFAjiHx4+Ev+Qri+nRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rj/CooClmAxuv3qkSAAag2oqUM61fq9hTYSLYzXLM7pZs7jXySIsguZ2Ws0rL2SUpKsb9kTTt7StMZJKmRO5TnBGFKuzYNmG3d4rCKftFeL2K+HypqyFQk/PCZIFu/VyQo7Mc0p+eLh2Dx/uGd5tXkiqiJQ21fC24P5tMvVHUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2f4NLft; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2f4NLft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE81DC4CEEA;
	Wed, 16 Apr 2025 04:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777563;
	bh=NF1Fz3bDL9B8+3kS7pFSCGv/wFAjiHx4+Ev+Qri+nRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2f4NLftPAY2dyH5uJ9BBSOkQIXPLI+NMI9wIuqb7TxG/RSNHu+LqtgDjjEBIDVNn
	 7NtByuthkgHRjmg5XBSlhPisAWE9Ln77uuth9cLZlM3EZpUXYGlPhAnGPZBvtitINP
	 63X4bG0SB48Nzt1kUGflNNpg1zEruzc+c9gYKuKP1A7fvNc3egUsHhpKKVwxUIf/6t
	 v799YleAqN9wag0aUJil73BmheVT3RjtnY4//DpGbSNUTqJiaORH0WZRLLb27b6rdQ
	 rgiLsnYIFC+tWi/MvINGZXCb+eE6hDegvyOT5C0oxrwmese+t3rxR2MVEQXe2R0NcZ
	 tiBbouF8I9YNg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ze Zuo <zuoze1@huawei.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/10] mm/damon/paddr: support addr_unit for DAMOS_STAT
Date: Tue, 15 Apr 2025 21:25:47 -0700
Message-Id: <20250416042551.158131-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416042551.158131-1-sj@kernel.org>
References: <20250416042551.158131-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of addr_unit for DAMOS_STAT action handling from the DAMOS
operation implementation for the physical address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 20955eefcdbf..0d6491159a04 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -562,18 +562,19 @@ static bool damon_pa_scheme_has_filter(struct damos *s)
 	return false;
 }
 
-static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
+static unsigned long damon_pa_stat(struct damon_region *r,
+		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	unsigned long addr;
+	phys_addr_t addr;
 	LIST_HEAD(folio_list);
 	struct folio *folio;
 
 	if (!damon_pa_scheme_has_filter(s))
 		return 0;
 
-	addr = r->ar.start;
-	while (addr < r->ar.end) {
+	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
+	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
@@ -701,7 +702,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_alloc_or_free(r, scheme, false);
 #endif
 	case DAMOS_STAT:
-		return damon_pa_stat(r, scheme, sz_filter_passed);
+		return damon_pa_stat(r, aunit, scheme, sz_filter_passed);
 	default:
 		/* DAMOS actions that not yet supported by 'paddr'. */
 		break;
-- 
2.39.5

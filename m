Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96A338F5C;
	Thu, 28 Aug 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401170; cv=none; b=imfa5gq3seBjyasEvR+qmEvTd//X5+BlhDFCmYAx47076PgPT4zMYvY8hr5ID48Lgi9VGDx7yBJf1aZfoixFve5CsiMRJUMkhRK0NmTif3A+Rpf7JHob8T2FrNYEU5mQV77HrQGDGNXfYy9mlgGYJSiXZR7EPui0iXESP+9IPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401170; c=relaxed/simple;
	bh=/viP4eNKlIp3xNvGENLPiu9ygdeBlYDEw/GbgmbYmHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkG7uiWMeKMJxzadHNoxFKQu7QeExBQtUSElCcZeKMfkuMCofRqzHVv4E4XQZQgg9eSKo/v4rhM9IVNK6bIBxsa9jB1SfgYcMvv8vRYQchrun7EFalSjYSPXriZf5U+XvmBFFtIu4++c5kUFjpjpbXFxlSUHUVrOxad1K+8tMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShoWSbxe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShoWSbxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DED1C4CEEB;
	Thu, 28 Aug 2025 17:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401169;
	bh=/viP4eNKlIp3xNvGENLPiu9ygdeBlYDEw/GbgmbYmHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShoWSbxe/VvRANS1E4btJRQii4QhZd4/DyUYBSCTQIJf+/FMvp59isNQLoZyRyWt0
	 /wRnFM9kYrcNo+SdHTDNCzwhIYfMoH/Opof0rlgrAxwNB7U4E+vdyPYfjgJ3R13Hwb
	 /OVKiFSvOuap6k0V6h/XNSqen2Gt98MzZkp9J/7vJCtSWZFqSVQ1hDNcsvjWW92eN4
	 1tk38a9xbnwiNQErYYyxtmHetcl99oox3epZiEWoElrPgQZbZf+lIN/l6xeis+GEZ+
	 HikmhBENmXwOZk3CbzDeLf/UpEF8EJOtrDrmnls8ylJgkXQ5xH8c4wVMvTHHvCo6Ok
	 wuljHjyCK4eRg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: [PATCH v3 02/11] mm/damon/paddr: support addr_unit for access monitoring
Date: Thu, 28 Aug 2025 10:12:33 -0700
Message-Id: <20250828171242.59810-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250828171242.59810-1-sj@kernel.org>
References: <20250828171242.59810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of addr_unit paramer for access monitoing operations of
paddr.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 0b67d9321460..d497373c2bd2 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -18,7 +18,13 @@
 #include "../internal.h"
 #include "ops-common.h"
 
-static void damon_pa_mkold(unsigned long paddr)
+static phys_addr_t damon_pa_phys_addr(
+		unsigned long addr, unsigned long addr_unit)
+{
+	return (phys_addr_t)addr * addr_unit;
+}
+
+static void damon_pa_mkold(phys_addr_t paddr)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 
@@ -29,11 +35,12 @@ static void damon_pa_mkold(unsigned long paddr)
 	folio_put(folio);
 }
 
-static void __damon_pa_prepare_access_check(struct damon_region *r)
+static void __damon_pa_prepare_access_check(struct damon_region *r,
+		unsigned long addr_unit)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
-	damon_pa_mkold(r->sampling_addr);
+	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, addr_unit));
 }
 
 static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
@@ -43,11 +50,11 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t)
-			__damon_pa_prepare_access_check(r);
+			__damon_pa_prepare_access_check(r, ctx->addr_unit);
 	}
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed;
@@ -62,23 +69,25 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 }
 
 static void __damon_pa_check_access(struct damon_region *r,
-		struct damon_attrs *attrs)
+		struct damon_attrs *attrs, unsigned long addr_unit)
 {
-	static unsigned long last_addr;
+	static phys_addr_t last_addr;
 	static unsigned long last_folio_sz = PAGE_SIZE;
 	static bool last_accessed;
+	phys_addr_t sampling_addr = damon_pa_phys_addr(
+			r->sampling_addr, addr_unit);
 
 	/* If the region is in the last checked page, reuse the result */
 	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_folio_sz)) {
+				ALIGN_DOWN(sampling_addr, last_folio_sz)) {
 		damon_update_region_access_rate(r, last_accessed, attrs);
 		return;
 	}
 
-	last_accessed = damon_pa_young(r->sampling_addr, &last_folio_sz);
+	last_accessed = damon_pa_young(sampling_addr, &last_folio_sz);
 	damon_update_region_access_rate(r, last_accessed, attrs);
 
-	last_addr = r->sampling_addr;
+	last_addr = sampling_addr;
 }
 
 static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
@@ -89,7 +98,8 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
-			__damon_pa_check_access(r, &ctx->attrs);
+			__damon_pa_check_access(
+					r, &ctx->attrs, ctx->addr_unit);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
 	}
-- 
2.39.5

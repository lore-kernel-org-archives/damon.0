Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290EC229B30;
	Wed, 16 Apr 2025 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777559; cv=none; b=aNwzEPE+BTkPI1Ay4f9OiQe2aFtKdTDoeZa2rD80lHgQMz2pzogNc7tteE/b7IZUw8HGOLiyC2GJM7GrA8LEDxxYt8HwCoNgv71m4JunNhX2ricj+4FKJwIIk7EUAfVX34F59N/yLHaOtVJtNQjuF8rXFIa1e5EpnkAaLjTw++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777559; c=relaxed/simple;
	bh=GTiO6/BXPbz9EroOm99u95+iwY8aI3Ihnu6Y7KgKfdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VjqUh9GoZhmQHnoJRnQR6V2kA3bRjlnAWuW92JRwmo0zG+BIKmc4a/TQlSNpGO1Tpcxk4DBBd5OmMxSxxzC1FrvLuG38P+Rdd4pE2BOtgRz19HmwTR0SMRtSVFhfIzvkaFUnw6RqYQDk6AJnvaES3dLFXU2MeJ3EnFyO4QfBYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n847wnN4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n847wnN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7051EC4CEED;
	Wed, 16 Apr 2025 04:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777558;
	bh=GTiO6/BXPbz9EroOm99u95+iwY8aI3Ihnu6Y7KgKfdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n847wnN4J7wouK/OJGntuS3+CHz5ypT4BG3pfvdVdvDfKO/742UJG+PY376cto4hF
	 7z2RfOtp7sDpCyIMLeZlhB9RtsmMV/1G3vLefr8hH1/uRMzpOunNf69uVGvQhlyI+4
	 KjsnLP3kYlwp3k/58CtD1PD5YXun3S+i+PpIRd1KAFd/7T0jDMWrRLaZLSF9P4oGem
	 F8LI94C5b0ykntvzkKdx3mMdiPW4Nns+sxg3kjqZgfd1deTfqJrs9XrMJwKG0fTtwL
	 nqePUJh1VqrE1H01WrZm40yJ5gzuY+1ic+tAuznRqcs3CiZ/YGIDPbcuMAJUwM8dsP
	 Y3e9mf4gI/MrQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ze Zuo <zuoze1@huawei.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/10] mm/damon/paddr: support addr_unit for access monitoring
Date: Tue, 15 Apr 2025 21:25:43 -0700
Message-Id: <20250416042551.158131-3-sj@kernel.org>
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

Add support of addr_unit paramer for access monitoing operations of
paddr.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b207c79ab9de..bc188aa2f01b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -58,7 +58,13 @@ static void damon_folio_mkold(struct folio *folio)
 
 }
 
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
 
@@ -69,11 +75,12 @@ static void damon_pa_mkold(unsigned long paddr)
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
@@ -83,7 +90,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t)
-			__damon_pa_prepare_access_check(r);
+			__damon_pa_prepare_access_check(r, ctx->addr_unit);
 	}
 }
 
@@ -156,7 +163,7 @@ static bool damon_folio_young(struct folio *folio)
 	return accessed;
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed;
@@ -171,23 +178,25 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
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
@@ -198,7 +207,8 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 
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

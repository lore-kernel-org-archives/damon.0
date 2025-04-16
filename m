Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D922A7E8;
	Wed, 16 Apr 2025 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777561; cv=none; b=SESVgFScwuuMEEsi7w6JUzaIcpojz+9JAfFhaTAGWT9fxI9cdF/lv9jOYrgge7nR2FX3nmie3t54CUnsmDKufCxbMrFDD0YqxQBkcd/Vh3yIiAmY95pNYV5lglMg06G9++eQorZPEHigexZOGJIorKCr7BgGQO3kO8SWszFr/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777561; c=relaxed/simple;
	bh=aVhepC2SbbyeztBh1elFWeExoYmm7rHUW1i6zPW/jCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uzsHdj5+Xq4L4hLXJRl4sT+nazO+j2gHfV7/KwREvP5PLg9fne+czrz8O71HscnTEl90p2hh/q7HC0AQx9SsN1lJbRl2iz5Tk4gLSTLnFSfbHH7/a3SSMWeCLRKxG0vNzp2FAq/P07s4+gFtVlfpyH7GtsRIoU9khSpaI7nhMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4usEUUh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4usEUUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1183C4CEE2;
	Wed, 16 Apr 2025 04:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777560;
	bh=aVhepC2SbbyeztBh1elFWeExoYmm7rHUW1i6zPW/jCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4usEUUhCGZUhfSiRp1VRg49kAqyRNEsUR/S5IHIPt1kf3tjOXkdSUhkaW3lwh9y2
	 7z3WWsrN6c/Dxcl0hSJoz+NrkJrJzf6mvKovDg2QpXOsfrWT7dC93umI7ZIj5mwdh5
	 sITAtyzkZsPAFqwGLf3sPAvhikhjbY6+ZCTZFbeePRb2SeXVoOyDgNppz8LEoGYgAN
	 D4FzQLf6bsUBD4bRWXe+TG7CdUp5xq1aqB45jOFEWYZEuHtcV1nsUzcmDqt14wjhIN
	 dKUba4U53Wi/saW1ZIAbCE/rFhlwJ/GCXHl98QimK71DVGZZZXRHOFQs0Ut3f5P6Z+
	 t57woOdqReygA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ze Zuo <zuoze1@huawei.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/10] mm/damon/paddr: support addr_unit for DAMOS_LRU_[DE]PRIO
Date: Tue, 15 Apr 2025 21:25:45 -0700
Message-Id: <20250416042551.158131-5-sj@kernel.org>
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

Add support of addr_unit for DAMOS_LRU_PRIO and DAMOS_LRU_DEPRIO action
handling from the DAMOS operation implementation for the physical
address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 169ba81d4182..fc1c720e8cb5 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -347,14 +347,16 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 }
 
 static inline unsigned long damon_pa_mark_accessed_or_deactivate(
-		struct damon_region *r, struct damos *s, bool mark_accessed,
+		struct damon_region *r, unsigned long addr_unit,
+		struct damos *s, bool mark_accessed,
 		unsigned long *sz_filter_passed)
 {
-	unsigned long addr, applied = 0;
+	phys_addr_t addr;
+	unsigned long applied = 0;
 	struct folio *folio;
 
-	addr = r->ar.start;
-	while (addr < r->ar.end) {
+	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
+	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
@@ -380,16 +382,18 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 }
 
 static unsigned long damon_pa_mark_accessed(struct damon_region *r,
-	struct damos *s, unsigned long *sz_filter_passed)
+		unsigned long addr_unit, struct damos *s,
+		unsigned long *sz_filter_passed)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, s, true,
+	return damon_pa_mark_accessed_or_deactivate(r, addr_unit, s, true,
 			sz_filter_passed);
 }
 
 static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
-	struct damos *s, unsigned long *sz_filter_passed)
+		unsigned long addr_unit, struct damos *s,
+		unsigned long *sz_filter_passed)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, s, false,
+	return damon_pa_mark_accessed_or_deactivate(r, addr_unit, s, false,
 			sz_filter_passed);
 }
 
@@ -680,9 +684,11 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_PAGEOUT:
 		return damon_pa_pageout(r, aunit, scheme, sz_filter_passed);
 	case DAMOS_LRU_PRIO:
-		return damon_pa_mark_accessed(r, scheme, sz_filter_passed);
+		return damon_pa_mark_accessed(r, aunit, scheme,
+				sz_filter_passed);
 	case DAMOS_LRU_DEPRIO:
-		return damon_pa_deactivate_pages(r, scheme, sz_filter_passed);
+		return damon_pa_deactivate_pages(r, aunit, scheme,
+				sz_filter_passed);
 	case DAMOS_MIGRATE_HOT:
 	case DAMOS_MIGRATE_COLD:
 		return damon_pa_migrate(r, scheme, sz_filter_passed);
-- 
2.39.5

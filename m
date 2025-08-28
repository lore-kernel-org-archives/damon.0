Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D0E340D90;
	Thu, 28 Aug 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401174; cv=none; b=LiiKm4Ufmb0vC8NCI3mjCYWVTscmYBG7KeR+uE8K6qT5AAVoRjESj6EbJt+DlqFIn33Hk5AsR/AvrKdLeLzzbKmXc8cavNWxT+fvor2zyPC9hBR/SuFOlJNdwQ95eK3Q8rge3TcLJa6+9663GfcRFlx2vvqpJJuAFnxwSub7fds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401174; c=relaxed/simple;
	bh=s/ZtUKWoi9HlBtotMtbYAXHGNUrzkyLE//5a+5BjQyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djPZ/xNVPVJ8dDEGjCiYCrosT8eDkbbXTXx73m0H/qlXgNeOPoadiW2xufA8iRNQ/H7XsgJLnSlp3Z/lKgzWBy/MAQxNLmL6VIc8vG/fLzZcrYMXYOMkfPn6hRUQvqDwKht+Ue+Jz5LkmA7jN2n7+jp4l/YwmRcAZzdieoUf8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmFEKtsF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmFEKtsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EF0C4CEF4;
	Thu, 28 Aug 2025 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401173;
	bh=s/ZtUKWoi9HlBtotMtbYAXHGNUrzkyLE//5a+5BjQyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmFEKtsF9NbDuJufKLJyMTnrxl4FEig2ZS4T+ULHygt3c8X7mDRAtCE5JAqcculiU
	 kyUE6iiiyi6fCLo3tx9CD3MPDkgiMihYeEpgqr/aRtpxbxs9TPz6SdGY4eB0I057BY
	 ZZBB3paIFdzOnC6yw1xnBAC6YBGb82+uCLxehk28tncossRjUA+r1qA4vpHB2YnNnF
	 oIa4cQxY78apjx6gQyTcgbPJFIB6Q0kM52+yTXLn7a+i8FVY0cLh3/OBhxQxc0iEVX
	 R5UKPDu38pyq5cY6Yw8gitFjkd1t/11AOrI3kOt1a7aGgOVz3z8oAUGUX7eSycSlMx
	 Jym+oTukm3YaQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: [PATCH v3 06/11] mm/damon/paddr: support addr_unit for DAMOS_STAT
Date: Thu, 28 Aug 2025 10:12:37 -0700
Message-Id: <20250828171242.59810-7-sj@kernel.org>
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

Add support of addr_unit for DAMOS_STAT action handling from the DAMOS
operation implementation for the physical address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 0a122a8a9f1c..07a8aead439e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -290,17 +290,18 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 	return damon_pa_core_addr(applied * PAGE_SIZE, addr_unit);
 }
 
-static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
+static unsigned long damon_pa_stat(struct damon_region *r,
+		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	unsigned long addr;
+	phys_addr_t addr;
 	struct folio *folio;
 
 	if (!damos_ops_has_filter(s))
 		return 0;
 
-	addr = r->ar.start;
-	while (addr < r->ar.end) {
+	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
+	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
@@ -308,7 +309,7 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		}
 
 		if (!damos_pa_filter_out(s, folio))
-			*sz_filter_passed += folio_size(folio);
+			*sz_filter_passed += folio_size(folio) / addr_unit;
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
@@ -335,7 +336,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_MIGRATE_COLD:
 		return damon_pa_migrate(r, aunit, scheme, sz_filter_passed);
 	case DAMOS_STAT:
-		return damon_pa_stat(r, scheme, sz_filter_passed);
+		return damon_pa_stat(r, aunit, scheme, sz_filter_passed);
 	default:
 		/* DAMOS actions that not yet supported by 'paddr'. */
 		break;
-- 
2.39.5

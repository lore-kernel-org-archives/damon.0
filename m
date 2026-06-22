Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2307D3BE642;
	Mon, 22 Jun 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138130; cv=none; b=dgqlhezJFtYGuZ0dCkpe7nHYzZnAlHBop4xQB59ZOZhaXLsi4OWlc3grOKfApBBBwqhPbJMFLaBn58z6W0bQ+S4PKbKOtRrI6KumYRcdQ0JJyhqrqoJHbsjQAyEaB7BwJhHikaOfAG9Ai7TKcesb+lg3o3ky+qm6spww4H78K0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138130; c=relaxed/simple;
	bh=GSiR6rFpomKB+hkh4JfSMEBAzdi3NNnj1dlQF+MAF0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyXJk89HsRElArPdT/jvwmdViDmeVqFb//o1z3absrnFhmz1X+DcLrotoyK8gOb7V0OyjA62WbfPcxe3aC0AqUgc7/L+csO8JkIkNTDbBSj7+l7kSFnRQKGIjlQEmsgafaAbuxcRPVRFONQ5XBL3I3fpqZNN5Hkz/HT8X/tJnlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKh7fVcO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKh7fVcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6CA1F00A3A;
	Mon, 22 Jun 2026 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138128;
	bh=yDzAJDAVQX7rFXuERBq8+a6fsMKEIvYdRJNiU0vHoME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YKh7fVcOTLzrba1i52g2yPRRyhzaMsT7D1T5XMmeIjdfwjU93hAXKEa+ABrHYgHOD
	 Oi0yPqszRwvXa6XCAFdqXEgzBnaYp2MeYf7mMIdXR/20MSzsgtQgJ2mWkfcAqQLT1L
	 3OTNfhIBI5Fafxg9aUPEO/rxGSsdEFyKdY3U7pueLPjuPQMnh0r5LP+yMSS0mPtZ0Y
	 PDCM3jecb/b7hF9w2Ep1/msVGFVH1HFa+98fJx8RHXkA5K0FLEDwtoJpb9lbTXplUC
	 X4LTGt19LVVyqeYCaJ6AHhOa/HjXxJ8OD4IcxpFYsVt9fzFXmjtvvVBho2fdwUGGWt
	 LGVt5ITAIeuBQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 16/18] mm/damon/vaddr: remove attrs param from __damon_va_check_access()
Date: Mon, 22 Jun 2026 07:21:36 -0700
Message-ID: <20260622142139.30269-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142139.30269-1-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is not using attrs parameter.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2e12cc628fea0..ec08fc6624479 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -495,8 +495,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * r	the region to be checked
  */
 static void __damon_va_check_access(struct mm_struct *mm,
-				struct damon_region *r, bool same_target,
-				struct damon_attrs *attrs)
+				struct damon_region *r, bool same_target)
 {
 	static unsigned long last_addr;
 	static unsigned long last_folio_sz = PAGE_SIZE;
@@ -532,8 +531,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 		mm = damon_get_mm(t);
 		same_target = false;
 		damon_for_each_region(r, t) {
-			__damon_va_check_access(mm, r, same_target,
-					&ctx->attrs);
+			__damon_va_check_access(mm, r, same_target);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 			same_target = true;
 		}
-- 
2.47.3

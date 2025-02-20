Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24039264F94;
	Thu, 20 Feb 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080120; cv=none; b=j6/srB5HwHuojuYC1M/q1FhzituSvzX8tSzz8Hz4PCs2fyJMPpqHePQK7ycf1KebakqX2WOVK7kVlB/2X5hCRaXosSRh6OkMu9pltpH/t4GxNIgejH0D6QCfhVK9N2ZlmQdz/RbALLTf8lI3/7fF+/tv5thQikfTU+KwMcCEs84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080120; c=relaxed/simple;
	bh=unOKD6NYD7kObbIq6Phkmd4weQFW6UAeoYB9fTWAe20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EdbXeAnceROLzNV3L1/PZqcQuZPQn2Ao+lqMxtZ+SEe8o8FhCnkiGCzMrtdmFx4pIq3o1QI/0+avHuTyCwAiwfbkWkrQubg0jpYzIcHHMSbymYYNP+CtD4nnoqcKH+c2alpgNRYyw8Nr5INbVQEnusgtnzI5LmZkHz+eYgO25mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeDHtsFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeDHtsFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C94C4CEED;
	Thu, 20 Feb 2025 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080119;
	bh=unOKD6NYD7kObbIq6Phkmd4weQFW6UAeoYB9fTWAe20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZeDHtsFngTR52TeMYoctmWNGqUoOWb0eIchFcx9LTiy6jhaPyB5cJhHIC8vL7qb1x
	 dlO+ObLrleiDNl12SajbdA4sZ56fk0htLHAQb0i/C8A1SpCAc2dCWyHZMYIZmn2N3s
	 p7Hvi9HGoSuAFamlBBRbIU+4UH+kRQszxOt2V2A24pzEsDzkP/lr3zozhXDYdFdYsC
	 F4G9FzjdYzNf76y9VlhOg71YZ0OtJa1hc7xLW/5Yj52aRZxLJFqeHOw+5I4beOFmrb
	 Y0ZOeg5yVkhTgzCBUKQAxD67NNg4tpCwhL2b0Z7+za2z8VfEGoUNpNZZ8Tsfpy8amX
	 xVYqW8nLpemPg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/9] mm/damon/paddr: support only ops_filters
Date: Thu, 20 Feb 2025 11:35:05 -0800
Message-Id: <20250220193509.36379-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220193509.36379-1-sj@kernel.org>
References: <20250220193509.36379-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON physical address space operation set implementation (paddr) has
updated to support both ->filters and ->ops_filters to avoid breakage
during change for the ->ops_filters setup.  Now the change is done, so
paddr can safely drop support of ->filters.  The support is only waste
of the time.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 3e651308ba5d..432ea4efdc4b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -253,10 +253,6 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 {
 	struct damos_filter *filter;
 
-	damos_for_each_filter(filter, scheme) {
-		if (damos_pa_filter_match(filter, folio))
-			return !filter->allow;
-	}
 	damos_for_each_ops_filter(filter, scheme) {
 		if (damos_pa_filter_match(filter, folio))
 			return !filter->allow;
@@ -285,12 +281,6 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 	struct folio *folio;
 
 	/* check access in page level again by default */
-	damos_for_each_filter(filter, s) {
-		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
-			install_young_filter = false;
-			break;
-		}
-	}
 	damos_for_each_ops_filter(filter, s) {
 		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
 			install_young_filter = false;
@@ -543,8 +533,6 @@ static bool damon_pa_scheme_has_filter(struct damos *s)
 {
 	struct damos_filter *f;
 
-	damos_for_each_filter(f, s)
-		return true;
 	damos_for_each_ops_filter(f, s)
 		return true;
 	return false;
-- 
2.39.5

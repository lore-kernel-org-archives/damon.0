Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4780F17333F;
	Thu, 27 Feb 2025 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621487; cv=none; b=WJhB5a+dn2yWSijOZndVywmQygxaYR20/rNKALhUu2qWuXIQOnuxdYDpOCgy2yKBC6p8qKDKzQdWYn3033bhXOtnqcazV7IPjK6o8UxyUuczGL9xbPJ9eP0qPTg2N60VhXD1vN6aIO6UocX1yko9+x7n52iWhKYzUOWh3Z/0YY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621487; c=relaxed/simple;
	bh=uM1uKPmHuTy5pB3aPnhpc/7ev2gt12cM7i26onsayOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QWPEsKqc8fALNKUBjeBDI5F/Sx1Z6tT2+BDQQLzODPbcxeYNfXoz+55c0KC9DGtdJMU2HKPzAoAT6cZFNYUSUSsxtaDC8fJBDfrsUH1LYIpiGpiLiZhCdqa17B6uoiVxhksMFd/TXNXv0FYJvTVnEWVd3pBD7ixEMkcLyfB3TGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg510x5K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg510x5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B48C4CEE2;
	Thu, 27 Feb 2025 01:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621486;
	bh=uM1uKPmHuTy5pB3aPnhpc/7ev2gt12cM7i26onsayOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tg510x5Knaqgx/5rbI29YLeqJ09i5IxQbxlBnCdce0+KaJQ05TqNa9e3eG3y86gB/
	 tsqn9Wu39k12aa5QoBNX3awpzJoN42ffPh5euGJrJnoEAg3fN7jKJVpilXVBoH97wa
	 6dQ5JIi4VZdw90XP3DpK/06W4NrnRymTYvjTNV1QQ4jVn/m+u2R1N33PjulAHdMiGP
	 HWcjfaxiU7wvtWAhrSadi0RgQ628vApLEZYNwf1I3ITjhYmhaMIKjUZw9XRiqRoe12
	 YfuT6BfzY4HSgakp0hhr7K82dL9IGJHxoj4zWFBL6ejGqDvb/fsR4tWOprqiRg5D5m
	 +AyZggXXK9PcQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 5/9] mm/damon/paddr: support only damos->ops_filters
Date: Wed, 26 Feb 2025 17:57:50 -0800
Message-Id: <20250227015754.38789-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227015754.38789-1-sj@kernel.org>
References: <20250227015754.38789-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON physical address space operation set implementation (paddr)
started handling both ->filters and ->ops_filters to avoid breakage
during the change for the ->ops_filters setup.  Now the change is done,
so paddr's support of ->filters is a waste that can safely dropped.
Remove it.

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

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68430407CD7;
	Thu, 21 May 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374081; cv=none; b=cyYGo5W/aJUQMSuUccQDPTSRu1WCOmZbbxNiWDWTNSVenSn0VFYmkjnwevzZNFw2nBb8Q6r71sBtfIDAUaJJqRekHM8HqINXBlvBrgpRAbZA7lfzahoPAQAnEp4aapx5eidluQlLx9G2B6LkcvKj0SatT1dJbQFxAMguWweW+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374081; c=relaxed/simple;
	bh=U3R/VpB5fsj2Kzc8E2SVAl/KkIrkOZVOd6iQ6EUqjEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrHcRubdpdPa83RlU8LmFzTap0wFuygQQ8ZCOl6IQYgcqreJQTFvpqKvYF2wmG9j9LhsG2447lDimgeMVsZCOAbfG3KqtJmvMmaIyQNg44TAw31vkVCcr9cVqxgjqeEFjTE0tmI+/7xW7/zD4rb3CNtTfyMnzDBn9IDpIUd3tS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOgQlyu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOgQlyu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1902C1F00ADE;
	Thu, 21 May 2026 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374079;
	bh=lFIspApNE5pg+37NC/h+0JPjyuQa8BCwW93puC6WNUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jOgQlyu0BYsrKxDGlx0PvO7DdBjbvN7CW5DtqEpZxMUx2Gcdtqam12jT6ss4J0h1C
	 y+R0+IWciA5VKq9J9KKjc0DwF2nzueOQhyBWFK7hqYBgy6ezzPOvvnFle30C7lkEoa
	 lEoZPAZFl+V5dSxi33GHp9x3NMsj76wu1qXq4t3oh6r5pHRpznDfPy+Bq09lYzd8cQ
	 bWEnmKmOn+lIY3dtRmU/g/jopxQUMyxiWkmSTu7x8nVoLmuup+GRvb5z8FYImMKHKk
	 Fi+QGPU4BNnF7VaXbzeTdRUyL7uLfCSPhnElHpOU6zEx+HqQ2kQG5jZlpwMnhDqpvW
	 u0YLb3ENq/SCw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 05/14] mm/damon/core: hide damon_add_region()
Date: Thu, 21 May 2026 07:34:15 -0700
Message-ID: <20260521143428.83157-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521143428.83157-1-sj@kernel.org>
References: <20260521143428.83157-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_add_region() is being used by only DAMON core, but exposed to
DAMON API callers.  Exposing something that is not really being used by
others will only increase the maintenance cost.  Hide it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 -
 mm/damon/core.c       | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4014fd0d463cb..b9370c1779cba 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1024,7 +1024,6 @@ static inline void damon_insert_region(struct damon_region *r,
 	t->nr_regions++;
 }
 
-void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index e8cf3632115e5..7d1de6ff54eba 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -250,7 +250,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	return region;
 }
 
-void damon_add_region(struct damon_region *r, struct damon_target *t)
+static void damon_add_region(struct damon_region *r, struct damon_target *t)
 {
 	list_add_tail(&r->list, &t->regions_list);
 	t->nr_regions++;
-- 
2.47.3

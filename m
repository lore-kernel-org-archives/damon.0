Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A2B10786
	for <damon@lists.linux.dev>; Sun, 19 Nov 2023 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkfEizFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C42C433C8;
	Sun, 19 Nov 2023 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700414131;
	bh=wGhN7a1c1/p9kfRbyE8itY6KQu9wn5cOAaIJeGVmnnc=;
	h=From:To:Cc:Subject:Date:From;
	b=XkfEizFwjv4s2yyAh/IAdR4Ce6ANjOrHPS6OuUGobhk63MS2x68e7h7vDvp478EgL
	 raG02fy8zS6Zg8iVPZ2/GmQeoINkjLj9ER0t634jT0bMnPTVJlIGwZEuAhRG9bRdGp
	 LGqm7giPcvncWcu7qPOQbfn4BAZzlqiiIw4JVn4sJh9HLYuVRRcvUKgpXRLATg3bE3
	 Z3/oPm1KhExae4SvDwzPARf/8tZLK4fi6QW6K38QS/kF5fUs0mYxWbzOVIuNMUGEM3
	 Jk6MSHWzyA/E66pjT5jbU5I17CbKbEz4aou4ik1VANNJ4G2tAZhC+9o2fL+3tA+Dlu
	 j0XgF6IfYEe/w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/core: copy nr_accesses when splitting region
Date: Sun, 19 Nov 2023 17:15:28 +0000
Message-Id: <20231119171529.66863-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regions split function ('damon_split_region_at()') is called at the
beginning of an aggregation interval, and when DAMOS applying the
actions and charging quota.  Because 'nr_accesses' fields of all regions
are reset at the beginning of each aggregation interval, and DAMOS was
applying the action at the end of each aggregation interval, there was
no need to copy the 'nr_accesses' field to the split-out region.

However, commit 42f994b71404 ("mm/damon/core: implement scheme-specific
apply interval") made DAMOS applies action on its own timing interval.
Hence, 'nr_accesses' should also copied to split-out regions, but the
commit didn't.  Fix it by copying it.

Fixes: 42f994b71404 ("mm/damon/core: implement scheme-specific apply interval")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Cc-ing stable@ is not needed, since the commit that introduced the issue has
merged in v6.7 merge window.

 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6262d55904e7..ce1562783e7e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1225,6 +1225,7 @@ static void damon_split_region_at(struct damon_target *t,
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
 	new->nr_accesses_bp = r->nr_accesses_bp;
+	new->nr_accesses = r->nr_accesses;
 
 	damon_insert_region(new, r, damon_next_region(r), t);
 }
-- 
2.34.1


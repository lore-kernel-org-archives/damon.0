Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD23C3F
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 21:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5B9C433D6;
	Tue, 13 Sep 2022 21:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663106076;
	bh=ycEw7JynDo34GmuIv/leSXfixPw6mJwy50s6KoPFIzM=;
	h=From:To:Cc:Subject:Date:From;
	b=JvOyqRNlgDve60ECg+sQGQiPkA6QZcU9G3NcJ+ZzsEqoFQ33voD7dPMvyEt0QrwzW
	 fDRIpRFhpBTSlZ5J9IwHToYQ6syJZMFAJdWA4LTahz60WyVw2sPZX/DF4qbdK1AGn9
	 rssdNERTeO8OfvHjoWfWEZhq9eALOSiTvbfCzB7Dxt77ieoIwgUNpcGR4TX0Tw7IiN
	 QbsXH5x+x1G1iUolYqRRadZNHpZ8rjWUmmrOuonI2KCzf6mG1i+sB2M+mTAMUhEhaY
	 TI8swIrECVc+dkaDELvgwRudXjEyuTOkQkOJuVIaKMAtqtAlAKRm9BNK/orUYv47tn
	 RRdjCJmk5rYLw==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH for-mm-unstable] mm/damon/core: handle error from 'damon_fill_regions_holes()'
Date: Tue, 13 Sep 2022 21:54:20 +0000
Message-Id: <20220913215420.57761-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 91fc6af21c61 ("mm/damon/core: avoid holes in newly set monitoring
target ranges") in mm-unstable tree introduces
'damon_fill_regions_holes()', which does not check failures of
'damon_new_region()' call, so NULL dereferencing is available.  This
commit fixes the issue by checking failure of the function and returning
an error code.

Reported-by: Coverity Static Analyzer CID 1524904
Fixes: 91fc6af21c61 ("mm/damon/core: avoid holes in newly set monitoring target ranges") in mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 520d3bb22d91..3ef3d13e504b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -173,7 +173,7 @@ static bool damon_intersect(struct damon_region *r,
 /*
  * Fill holes in regions with new regions.
  */
-static void damon_fill_regions_holes(struct damon_region *first,
+static int damon_fill_regions_holes(struct damon_region *first,
 		struct damon_region *last, struct damon_target *t)
 {
 	struct damon_region *r = first;
@@ -186,9 +186,12 @@ static void damon_fill_regions_holes(struct damon_region *first,
 		next = damon_next_region(r);
 		if (r->ar.end != next->ar.start) {
 			newr = damon_new_region(r->ar.end, next->ar.start);
+			if (!newr)
+				return -ENOMEM;
 			damon_insert_region(newr, r, next, t);
 		}
 	}
+	return 0;
 }
 
 /*
@@ -207,6 +210,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 {
 	struct damon_region *r, *next;
 	unsigned int i;
+	int err;
 
 	/* Remove regions which are not in the new ranges */
 	damon_for_each_region_safe(r, next, t) {
@@ -251,7 +255,9 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
 
 			/* fill possible holes in the range */
-			damon_fill_regions_holes(first, last, t);
+			err = damon_fill_regions_holes(first, last, t);
+			if (err)
+				return err;
 		}
 	}
 	return 0;
-- 
2.25.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069E612F
	for <damon@lists.linux.dev>; Fri,  9 Sep 2022 20:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369FEC43470;
	Fri,  9 Sep 2022 20:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662755345;
	bh=OVGs4WGaZlHSNw1bV9aTKJG9y36ZzMQPGlZGZcjins0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ip+V2dwR7+a6tDS2JAnQCwO5rJFAyowrX5+FfGIBNIsTYot/Veb/nwDlEqmeNtUQs
	 nEMBGWe6pqrJyEb8Hs+MdAFA+I5oFdJNB36NlBpZC0nkTMOd21lG8iO2Ra4ypuPpjQ
	 4W5dX/F5GI0AkFryiAkYJKkQO8JIV3lB45w4lT7jL47LAAaPIRzynMz6uwU45Bh+XZ
	 E5o5BI4Lyarzt66Xj/yFuiQb9R8RZ3h4J+c8G2gc9WN4gZbF7NICi52SH5OVqMv0in
	 TH9MrIoz+J6fNJe93GTJ17U6HxX04QkESr522tdExGQL28caqt3vzzSA3ojYrHEmu/
	 K2etw9lz6iwkg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yun Levi <ppbuk5246@gmail.com>
Subject: [PATCH 2/7] mm/damon/core: avoid holes in newly set monitoring target ranges
Date: Fri,  9 Sep 2022 20:28:56 +0000
Message-Id: <20220909202901.57977-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202901.57977-1-sj@kernel.org>
References: <20220909202901.57977-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there are two or more non-contiguous regions intersecting with
given new ranges, 'damon_set_regions()' does not fill the holes.  This
commit makes the function to fill the holes with newly created regions.

Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Reported-by: Yun Levi <ppbuk5246@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bae41990f422..6f6c9c9aca9d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -168,6 +168,27 @@ static bool damon_intersect(struct damon_region *r,
 	return !(r->ar.end <= re->start || re->end <= r->ar.start);
 }
 
+/*
+ * Fill holes in regions with new regions.
+ */
+static void damon_fill_regions_holes(struct damon_region *first,
+		struct damon_region *last, struct damon_target *t)
+{
+	struct damon_region *r = first;
+
+	damon_for_each_region_from(r, t) {
+		struct damon_region *next, *newr;
+
+		if (r == last)
+			break;
+		next = damon_next_region(r);
+		if (r->ar.end != next->ar.start) {
+			newr = damon_new_region(r->ar.end, next->ar.start);
+			damon_insert_region(newr, r, next, t);
+		}
+	}
+}
+
 /*
  * damon_set_regions() - Set regions of a target for given address ranges.
  * @t:		the given target.
@@ -226,6 +247,9 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			first->ar.start = ALIGN_DOWN(range->start,
 					DAMON_MIN_REGION);
 			last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
+
+			/* fill possible holes in the range */
+			damon_fill_regions_holes(first, last, t);
 		}
 	}
 	return 0;
-- 
2.25.1


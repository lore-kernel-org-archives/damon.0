Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633953806C1;
	Thu, 21 May 2026 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374079; cv=none; b=gKtUM5OyOBcYK5oOFiG5BLEYLwnTQDh07WixiYym/0clq1W9XT3PwFZjgpr949VTyOytJFCYlkn2D9RLTnIYB/W4mbePASiV5UbYLHHAp7BklOGBR9zFf+LPy5rUjojQtAZTL1cebwp/RTp8xpdQt02bdc/gfmpIAZi0w5JKNfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374079; c=relaxed/simple;
	bh=SeQSeIT9kw4GiQ+HZa+CgcRvg0CvL1bbL4gPUN4MWDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWf8Yv9e3Q20taKN679ONcM4BiRN/7i+h+sn8+P4HzB9Yq121azkQpeuilm6b3RE4PB/8T6sZLZQdLLkPlazKRxCGS8BnMRIYsH4KzO9D0S73UcHrnYeQMj0uHVQoACGJ89+UNw/JD9YBI89rIuWOjm36VJ4spShIpteCw23TNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWEuYdaN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWEuYdaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E491F00A3D;
	Thu, 21 May 2026 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374078;
	bh=iMM8ZRfSsARmGo6eD+hRIbIxGHEMj2jHM5nMAylgAOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWEuYdaNmVFDjKsvRuqq0YJHRvCUaAx2GvJr9y3wf/72QFXCBCP5rUH7TqGW7iQJE
	 bBZZpk650IhubHqIwaD3RR3WZ/xBWzD+e5BtzDBK8V5caF6krimBN09VdUGqiphQ9i
	 G+Wwgm6Ghl3smylvGOwZDVG1E49zp9cH+irT9akiBGo/ubPnqxpn44F4JENymzjUf+
	 y06/U4llsZhlI3lzFZ9wFOUyu29lPX6yKhem0HuViWrgSrqFYaNMoM+KhkE+S0nsAT
	 tqQhxF3Zefm12Ssc4iXZRH9BxQKKNmIREsYxTkATQT3YIHarbKSNBWh0z71oQlf7T7
	 JOTLdLi+PrT4A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 02/14] mm/damon/core: do not use region out of a loop in damon_set_regions()
Date: Thu, 21 May 2026 07:34:12 -0700
Message-ID: <20260521143428.83157-3-sj@kernel.org>
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

damon_set_regions() assumes the DAMON region iterator is referencing the
last region after the region iteration loop is completed.  The code is
indeed implemented in the way, but that is not a documented safe
behavior.  Hence it is unreliable and difficult to read.  Cleanup the
code to avoid the case.

No behavioral change is intended.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 40946a7f6f549..e8cf3632115e5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -374,6 +374,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	for (i = 0; i < nr_ranges; i++) {
 		struct damon_region *first = NULL, *last, *newr;
 		struct damon_addr_range *range;
+		bool insert_before_r = false;
 
 		range = &ranges[i];
 		/* Get the first/last regions intersecting with the range */
@@ -383,8 +384,10 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 					first = r;
 				last = r;
 			}
-			if (r->ar.start >= range->end)
+			if (r->ar.start >= range->end) {
+				insert_before_r = true;
 				break;
+			}
 		}
 		if (!first) {
 			/* no region intersects with this range */
@@ -394,7 +397,11 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 					ALIGN(range->end, min_region_sz));
 			if (!newr)
 				return -ENOMEM;
-			damon_insert_region(newr, damon_prev_region(r), r, t);
+			if (insert_before_r)
+				damon_insert_region(newr, damon_prev_region(r),
+						r, t);
+			else
+				damon_add_region(newr, t);
 		} else {
 			/* resize intersecting regions to fit in this range */
 			first->ar.start = ALIGN_DOWN(range->start,
-- 
2.47.3

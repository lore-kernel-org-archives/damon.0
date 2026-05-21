Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD73672A7;
	Thu, 21 May 2026 03:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335641; cv=none; b=pYZXgTNZTZIQUi7/VM4qcXvue/Ihj8x6EpWPIlFRkJCJigm6TmbeBZuqBs/OS9GIXro4eIRM/PSrdw6UMV2qDitK9pX/WmgXwTiSzTKDt1uA/5jhicS/SRq/82ZAQRyHqfW/K1TW+HIirrMES6DFsVHVJrBTGLxIxXVLG6YVkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335641; c=relaxed/simple;
	bh=SeQSeIT9kw4GiQ+HZa+CgcRvg0CvL1bbL4gPUN4MWDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu49FWzm9Nj7/7N2BK4YrXO3JK7EXWwp3mUOb6x53NwSpv4PaOE7JKte39Cvt+kOrveOGfmnoULZe+vwe4OJuqk3P23IqhMYx5xmTmIlWan8JM3opEhh9KlkqkYRTLwfp/ZyK85GZ/gr46Slgx3nfkX3qWuvUo8wowu5GWe2b3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDvBnehm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDvBnehm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1E71F00A3D;
	Thu, 21 May 2026 03:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335640;
	bh=iMM8ZRfSsARmGo6eD+hRIbIxGHEMj2jHM5nMAylgAOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iDvBnehmRwrVXOGnplb24UwMW47ZtquKrCHal2FynT4Ad3Mp9Q9J40uXtQF2rdiR3
	 YzxegO2k2fBKjorOE+WtZaQYhoQ4F2LOttuwuKK6pYUtm+fr4WTNW/lzNet2rY/tZU
	 O/tzrKzPt1fZwl1WEbUwTA4lFu6elBajsb3v31UFjGCXmjKYAKpXdPw9hQH2SQDEtA
	 xttATGDDDmfwxcI+m+fZKaEaVEpZh2jrtQjt3r2Fievnbm6TU8osdgLZmqQgZGfsmj
	 3gphpztxGPo2dBezI0az/vtMF5mJSkLEKmRVBO7zYMn3m9wqKENvMG5/8nXBFJH6Ah
	 LBBeMPB856YJw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 02/14] mm/damon/core: do not use region out of a loop in damon_set_regions()
Date: Wed, 20 May 2026 20:53:36 -0700
Message-ID: <20260521035349.87565-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521035349.87565-1-sj@kernel.org>
References: <20260521035349.87565-1-sj@kernel.org>
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

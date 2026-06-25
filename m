Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ECC37D113;
	Thu, 25 Jun 2026 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397491; cv=none; b=cfjP7/1r/5mFtKuLRwApz3HK519Q+WQvS4frpT5K2ty2ugVt0dokORPGPkegktW7yXdSF7Q3tG3WamTV7JqCC0uMlNn2q3pJwDXJ95CvFjJ/+sczW7kStSwvu3RJzWdG6fZlzd6H0hpZvdAdSw9GpiiClPrQtOB0cMRwflaVp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397491; c=relaxed/simple;
	bh=3kFNcksddTMoPl6d1RNPtllzhSXlxi+x+OM5EDF9YpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su0jsr5qD++Iv7C35OZiCV5rgKCqWW4UU5wpfTQjtdL2qCdvK6fXW8jaYw9i67sXzKBEC9R0KTW/OsYVtoVNCrGWKObeQLE9sioWWx+TaP1yXJLeZ/OOcl0uaNx2BgY33iHZGXeQx1DdWvgGyAY9PIQJHbVG12migFibT55Vijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdAoFumM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdAoFumM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C441F00A3E;
	Thu, 25 Jun 2026 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397490;
	bh=HI/zoVaSGKDNLoA6cct9QoJPib3MnUiHJc9KJcrjGCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kdAoFumMFmi8lT19UnVawdo/dF2kT1jrR8Zpwb1bBDvnk5ceyRoTQhg8gVQjibl0d
	 lIPsINw6UFSNllBr8tHQs4ab+lrffozZWkxzXV35ueEto6mG27HfvKwuDg0W+ZjIoE
	 xnVqQY03+pDWmkQef7urPe5XGKmBDsnhH09Uahn+MI1CiC1FH+/jI8Y4rf5hZHPj+e
	 TYnyYPdax/RtAbWo+IZ2uOWYL6cacsu3n/Cnn3SqprbSP5phS6I7TulDGAUIDsy8fB
	 rrX/QxRE/1Dr0V3zLrJfOuZ/DEM8M1aKecVwQAVDPB31xD/VAp1DrgNBhoPAVk1wu0
	 2RUGOhCnRndoA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 08/11] mm/damon/core: reduce range setup in damon_commit_target_regions()
Date: Thu, 25 Jun 2026 07:23:53 -0700
Message-ID: <20260625142357.103500-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625142357.103500-1-sj@kernel.org>
References: <20260625142357.103500-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_commit_target_regions() calls damon_set_regions() for updating the
destination target's monitoring target region boundaries.  It sets the
boundaries same to source target's monitoring regions, even if they are
adjacent.  Meanwhile, damon_set_region() sets the destination target
regions exactly the same to the source, only when the target regions are
empty.  When there are existing target regions, only a few regions are
expanded or shrunk to fit on only the boundaries for disjoint regions in
the source.  Hence the adjacent source ranges mean nothing in common
cases.  When there are many regions, such adjacent range setup is only a
waste of time and space.  We recently found [1] it is actually causing
memory overhead.  Setup the ranges for only distinct ranges.

[1] https://lore.kernel.org/20260603112306.58490-1-akinobu.mita@gmail.com

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7e4b9affc5b06..ce5294cb1b4f3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1349,21 +1349,33 @@ static struct damon_target *damon_nth_target(int n, struct damon_ctx *ctx)
 static int damon_commit_target_regions(struct damon_target *dst,
 		struct damon_target *src, unsigned long src_min_region_sz)
 {
-	struct damon_region *src_region;
+	struct damon_region *src_region, *prev = NULL;
 	struct damon_addr_range *ranges;
 	int i = 0, err;
 
-	damon_for_each_region(src_region, src)
-		i++;
+	damon_for_each_region(src_region, src) {
+		if (!prev || prev->ar.end != src_region->ar.start)
+			i++;
+		prev = src_region;
+	}
 	if (!i)
 		return 0;
 
 	ranges = kmalloc_objs(*ranges, i, GFP_KERNEL | __GFP_NOWARN);
 	if (!ranges)
 		return -ENOMEM;
+	prev = NULL;
 	i = 0;
-	damon_for_each_region(src_region, src)
-		ranges[i++] = src_region->ar;
+	damon_for_each_region(src_region, src) {
+		if (!prev) {
+			ranges[i].start = src_region->ar.start;
+		} else if (prev->ar.end != src_region->ar.start) {
+			ranges[i++].end = prev->ar.end;
+			ranges[i].start = src_region->ar.start;
+		}
+		prev = src_region;
+	}
+	ranges[i++].end = damon_last_region(src)->ar.end;
 	err = damon_set_regions(dst, ranges, i, src_min_region_sz);
 	kfree(ranges);
 	return err;
-- 
2.47.3

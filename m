Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4243C0A09;
	Wed, 24 Jun 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310835; cv=none; b=lMAd+lL3aS8uRB91sw99BSXzElHNC84er2Eyc+UM2fhVryJUbkccDqBgGXoGZqbVDC8fKA4bSz7/KKM753NqmodkJd0Dwi6/i8Qvv2+XuIXxbp4WPrdpH1KkgBP2ZRFnKcM+FqDRaewt1qvTD5LQE401sbwKNezZITHOEqmN6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310835; c=relaxed/simple;
	bh=9TEKpo957/A+8bLAR55MeefWwqLiyxZCKxFYxH7k6WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqbduwoAvm5UE31qW58uGSsWiIMRKKKHortY0pmEQsQyRqai6phQP1F7ON2n7333bCGR8isr7wnhPX/b/8Km3yxUGmWWNbl5ubCUNNJnCoPE0RJxfNqAq+JQ3g0bMHmcwNmDM2W3AJQ83SO2ND5c0owfzWXXrl4tuAQyG89E0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwArp1Jc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwArp1Jc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444E31F00A3D;
	Wed, 24 Jun 2026 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310834;
	bh=e2mraUvSsMm7k53gR/hu+9iLKWZ52dB0SyQlMrxy7JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CwArp1JcnEolIG6QvpKI6fGN7Me2Or60i0nv98sy+kzWXoE1nbJevjLFWONNSxwAp
	 IEYf3Ew6ek+LBBpWi1AV9ixRNEBjaD4GzvUM532e66vCmpw7vdqne2zscDPbH4fM3H
	 HR7TUCe8oVKXRPp0rq2ug9ZCQUrGaXHPsNOUGxpaQPYXkWCYihQ7/YybA70DScugMT
	 ynPvn+5JRwQs6HfffXf9W7vTzLiXk3mI7rHZEA1CPlAF4KQKllb2r05QFc6TbZOmrE
	 XprENZRd5VRg3t9uGHkerZvJqUYvH6y7FwxOuWdbn5SSoEzyJmJq0RKlRBs5JSPYZH
	 CkGYWUwFkd2kg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/11] mm/damon/core: reduce range setup in damon_commit_target_regions()
Date: Wed, 24 Jun 2026 07:20:04 -0700
Message-ID: <20260624142008.87180-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624142008.87180-1-sj@kernel.org>
References: <20260624142008.87180-1-sj@kernel.org>
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
index b5f63f2f726be..10deab847ee71 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1433,21 +1433,33 @@ static struct damon_target *damon_nth_target(int n, struct damon_ctx *ctx)
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
 
 	ranges = kvmalloc_objs(*ranges, i, GFP_KERNEL | __GFP_NOWARN);
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
 	kvfree(ranges);
 	return err;
-- 
2.47.3

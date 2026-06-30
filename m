Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F8429825;
	Tue, 30 Jun 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829068; cv=none; b=eaazgyfybuDI2CD76omfg0a5MLmeb6uzdRTJs6QRRvTjp10ppZ8NGTbGOjA2NC7ooXWlvJ0tDyTd5cmkTQknce4khHnTz9U7Vltx5Zxt68AuIaVj3Fy4hkYQAKEFUtf3r/SDx9hTFBZ0Yi4T1lJcfzt5XgUSa2xoe2gigs2OS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829068; c=relaxed/simple;
	bh=G/ZpBa5u6B8jXpyKowGiDeGK38MbRvqczLtYl8jj3kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goYu2r8YgbgTqRx0DJFhqXtOjU/wdTdtv57p6oBFIv6B5pwsWBcXcw0nDTE2oL2fs+iuMe+s1j4LV/p0IKSet3ESGsqprUhCMuVCAurTQ2JwdwowOgEPADMTIbHogX7PB+MptqHdVlQjBn1RE4LZCH/KB3LLIO3FDYh/2Xpgeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rky3Uhju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rky3Uhju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BED1F00A3A;
	Tue, 30 Jun 2026 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829067;
	bh=LL+0Zjf9t3hBYduoXGS/7g+XduqJe2JKqWYU56ceygg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rky3UhjuG2xBomQeg45ocsbvupyHFy7vbiUOjvY3IXqdgzv0LhvKiCXe5Kxw8+az3
	 PqOXy5FyuIEaFHdt0UYIUkm9RUX3IhHh4SkwcD4rSvF8fK+PLNlozG84Fk3+udaS2p
	 8LCW3PG0c8avqaDX9XhMmIMHAsIf7CwNAugK00CIds46WobXpWmTFcdsZ0lPjBQ5NQ
	 xJvV/2BmIN6cBTQol4jPir7YE+zR6Zo9nftxGK7pGRF0n88dVZCx74/sKbongXM0EA
	 +s++AHYy8nD6mv3L3ggJMwzmvCDuaFo4czT0oARLf80MwSvot4z0pDIAYJXzlhtzTy
	 pMUj2RRIWX82A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/11] mm/damon/core: reduce range setup in damon_commit_target_regions()
Date: Tue, 30 Jun 2026 07:17:22 -0700
Message-ID: <20260630141726.92246-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630141726.92246-1-sj@kernel.org>
References: <20260630141726.92246-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 59a91a0ab6d45..c6fc35be633b3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1414,21 +1414,33 @@ static struct damon_target *damon_nth_target(int n, struct damon_ctx *ctx)
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

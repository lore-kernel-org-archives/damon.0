Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C43D1CB2;
	Fri,  6 Mar 2026 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810963; cv=none; b=dO1UFlyI7NGmgrEv33OJPR7i8x5HC6aaF9/13yg55K/sjps1MAyVcVj3/nnuDjWWRA1iKKtD1Zu2Lt1VkKMPF0F3ppEWJMBe9DMcGVOzIvE9BrV48eCjFanDdUwWR6kAp1CQHyYRijMzgoAaCL7Ey1fUip0jhm8Qd0sx+FyjdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810963; c=relaxed/simple;
	bh=DbZTn4AVN3XfN74TG8oRW8P+LKBDP3hbPLRg+ZDBhJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQfbP0y9mCChf1PUPRQF3toTjGX8psP9vKBWBvxWgdTyjV9z4omT2q4tdfzKtot9DCakZwy/P/Eg050bZ+7Y/1fkP2DjKPv8Dr+4fuNHVsXLqC6Y2gnOip0D9Zsw6xmV2wPjyytfjiIBXDLgPje25fCyh5wtSa7f4YNuh3b6+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9X92hQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9X92hQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771F7C2BCB0;
	Fri,  6 Mar 2026 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810963;
	bh=DbZTn4AVN3XfN74TG8oRW8P+LKBDP3hbPLRg+ZDBhJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9X92hQsj5ctbO2KCOOvIWvY64DUXlPEAbUFN1LaUjDwBtNz9naa62II0rGXIRJ+Q
	 6Ys9FlwbtiUTT/NSoXJcwPUl6bTCQqTmIN+ALXeeuWiBpz5UZoFmV3KHifGtvqNKgA
	 JihBLT8MavLFZaNFjR+XhDC5t4MP9lHi7X1AKWlEM1qVs6SArV8CbxOm/Z2p/QBsPk
	 ffCZGw1IGFtJFF7FW5XuFhTprMQkapZAxJYmDENKtq8a9IkeA2MIOc+LXmd1Oub1hk
	 K4SKuF4S9sSP+caqgo6/U+F2FuD9iuMJWl/4VpIS36Fyur59NAcNPHtSFVgRji30fC
	 id9RP/X8fmKfA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/10] mm/damon/core: add damon_split_region_at() debug_sanity check
Date: Fri,  6 Mar 2026 07:29:10 -0800
Message-ID: <20260306152914.86303-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306152914.86303-1-sj@kernel.org>
References: <20260306152914.86303-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_split_region_at() should be called with the correct address to
split on.  Add a sanity check for that under CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 93d1577b1ae07..be2300cf3aeae 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2586,6 +2586,21 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 			threshold / 2 < max_thres);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_split_region_at(struct damon_region *r,
+		unsigned long sz_r)
+{
+	WARN_ONCE(sz_r == 0 || sz_r >= damon_sz_region(r),
+			"sz_r: %lu r: %lu-%lu (%lu)\n",
+			sz_r, r->ar.start, r->ar.end, damon_sz_region(r));
+}
+#else
+static void damon_verify_split_region_at(struct damon_region *r,
+		unsigned long sz_r)
+{
+}
+#endif
+
 /*
  * Split a region in two
  *
@@ -2597,6 +2612,7 @@ static void damon_split_region_at(struct damon_target *t,
 {
 	struct damon_region *new;
 
+	damon_verify_split_region_at(r, sz_r);
 	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
 	if (!new)
 		return;
-- 
2.47.3

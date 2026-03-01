Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00017338939;
	Sun,  1 Mar 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387013; cv=none; b=SdgiNxMSAJ8UgAL/ODwg33Wr2YoW9qghzMH0YUyTsCcIN7e5RQMuK0qoqfhBn56h3kDDYp9xMwcAdLyG4BL5PgEBtCXIcak61TNcKx+kCYMKITKG2JFS6gF2Y18Qe0HQ9/HJHEIc2mup8P2YV0CwmnBIphMKVh+TrhIgWeHLqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387013; c=relaxed/simple;
	bh=DbZTn4AVN3XfN74TG8oRW8P+LKBDP3hbPLRg+ZDBhJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyjSqHVWnixEPxP5fQ43lx/HGdcTE7sNREKAMpGzaaKNJMXWest4I3HDAEbGQ3qD/OArZE4s9wk3t5KQ0JwtfZN1B+xnmn9G5V6k6hlqG+0C1hReftZUN2j0g4VcAXECRR3lEfhfQACUU2AE2aMZZUldnuN24Tlilu+MfH5b2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNGnR+3F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNGnR+3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C115DC2BCB3;
	Sun,  1 Mar 2026 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387012;
	bh=DbZTn4AVN3XfN74TG8oRW8P+LKBDP3hbPLRg+ZDBhJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNGnR+3FH8t7f/g/HbzsZJ1b+HxQSNxrNdNk5f9Ui7Ge2IAItZ5wh/tea1t/N3JBp
	 TEQVVevvzupSjNXtNyFfcwJRQ3aV74r5SIXBO4J6Jo4OGuTV1+N5F+zm7VfL2JHsQ/
	 9BoSHUCJ9+weUZp3mWKkDk5CRbTUgpWyndLY5XGsUvvUftRbgK2FNREvnRmqcPrHpI
	 4eX4OjYPgt1eMRwykzNZsJ9saOMxKhN8+RRhsMU6/4G1UiUVMTeMBEWKkLtmB5j3Gk
	 RMPUoZsLdM0Tr/MDLlLCUCOrxIHZskf4+I9mvm7iPmEvnjouzcDYG0WJcrvZzRzvKP
	 sXyYx+rXCIONQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 07/10] mm/damon/core: add damon_split_region_at() debug_sanity check
Date: Sun,  1 Mar 2026 09:43:22 -0800
Message-ID: <20260301174327.76849-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301174327.76849-1-sj@kernel.org>
References: <20260301174327.76849-1-sj@kernel.org>
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

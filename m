Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18EA3ACA45;
	Thu,  4 Jun 2026 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780547040; cv=none; b=nWm61Bxbm5wToWDSzJWSogJ6D+hC3jV++ZU8W7PnqShhp8U80ii027zq5FBCrW/9tizLaInJY5+6Xe1lcrA4wUqM65/nNVHh+BDdeeDQUryEf5P6dFJgjtMBX/bBHtxluuDBqcJZVCFgKtP6Kx+UDix2y4FehNB6N5hBRnHCjwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780547040; c=relaxed/simple;
	bh=ZeUXp47SdGm2YIoNQEUV3H8LF92abujndTmzYbXB9hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZv5fq6sXywx5sE0MWQycYhYSSNMzsNH9YpONJZfoWyvdfmw3AfeCgBN5gZ0Wmv8UZrvXrUAsnJeBniC7/xKBPEchFzTxo03hdzac1EvafXWIM1eJyNfv0OMh64I9khUo9TE0chmGcwZM0yLS5GgAMIm7/nbnPCVa35U/iIY6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUcq6X5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUcq6X5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2081F00893;
	Thu,  4 Jun 2026 04:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780547039;
	bh=/1RezQzgRSB7zj/4EhFJr37swnApDsHs6S9D9sB2K0A=;
	h=From:To:Cc:Subject:Date;
	b=bUcq6X5FM6uC+R2h/RF5skFbUugvDuep9NyDnDnFc9asmMR1PhAxHWsvdBxbgqMrS
	 5kOeWLC/TwIg1yUJ8L7LYRXPsCgdpCyrMf6Uj/xXFRxS6NQkwF1nUhxEPSJGd2/0U7
	 CmCPn8i8Dzu2yDfs/4bOVZio2zfsveljB2TCBm3aUBQSriC3Wj/aLIg/Zv34Q0XWXm
	 TjHA/EvZdFPix3mmijFcsZurLs4NdEM2iynTdpS8g8NWd9GjfNJQllD8UYEPNFI1fA
	 21tms+1YcitR1EH8gyVEvpl1u3qfjScEVJP+p1KaP6cxfnsMckQimblp74Te/0vC2S
	 dywA3GxaFPbRQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/core: always put commit-failed target's pids
Date: Wed,  3 Jun 2026 21:23:47 -0700
Message-ID: <20260604042349.67720-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_commit_target() puts and gets the destination and the source
target pids.  It puts the destination target pid because it will be
overwritten by the source target pid.  It gets the source pid because
the caller is supposed to put the pid after the entire
damon_commit_ctx() is finished.  In more detail, the caller will call
damon_destroy_ctx() to destroy the entire source context.  And in this
case, vaddr operation set's cleanup_target() callback will put the pids.

damon_commit_target() can fail from damon_commit_target_regions().  In
the case, its direct caller, damon_commit_targets(), directly return
error to abort the entire commit.  Both source and destination contexts
are cleaned up using damon_destroy_ctx().  The source target pids are
completely put using the above explained routine.  The destination
target pids could be leaked if the source context was using vaddr while
the destination context was using paddr, though.

If the damon_commit_target() calls from damon_commit_targets() failed in
the middle of the targets list, the targets that successfully committed
already have the target pids that have the reference count incremented.
However the destination context is still using paddr ops.  So after
damon_commit_ctx() returns the error, the caller or the cleaner
(kdamond_fn()) will invoke damon_destroy_ctx(), but it doesn't put the
pids because paddr ops doesn't  have a cleanup_target() callback that
puts the pids.

As a result, in the scenario, the pids can be leaked.  The issue in the
real world should be not very common because it is difficult to imagine
common and realistic use cases that convert a DAMON context from the
paddr to vaddr mode.  Nonetheless, it is a supported DAMON control. And
the damon_commit_target() failure due to memory allocation is relatively
realistic if there are a huge number of target regions.

Fix by putting the already-committed reference count incremented pids in
the case of failure.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260320020056.835-1-sj@kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 265d51ade25bf..b6e1ab1992030 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1387,6 +1387,31 @@ static int damon_commit_target(
 	return 0;
 }
 
+/*
+ * damon_commit_target_fail() - handle damon_commit_target() failure.
+ * @dst:	Commit destination context
+ * @failed:	Commit failed destination target
+ * @src:	Commit source context
+ *
+ * This function is called by damon_commit_targets() for dammon_commit_target()
+ * failure for immediate states cleanups.
+ */
+static void damon_commit_target_fail(struct damon_ctx *dst,
+		struct damon_target *failed, struct damon_ctx *src)
+{
+	struct damon_target *target;
+
+	if (!damon_target_has_pid(src))
+		return;
+	if (damon_target_has_pid(dst))
+		return;
+	damon_for_each_target(target, dst) {
+		if (target == failed)
+			return;
+		put_pid(target->pid);
+	}
+}
+
 static int damon_commit_targets(
 		struct damon_ctx *dst, struct damon_ctx *src)
 {
@@ -1404,8 +1429,10 @@ static int damon_commit_targets(
 					dst_target, damon_target_has_pid(dst),
 					src_target, damon_target_has_pid(src),
 					src->min_region_sz);
-			if (err)
+			if (err) {
+				damon_commit_target_fail(dst, dst_target, src);
 				return err;
+			}
 		} else {
 			struct damos *s;
 
@@ -1432,6 +1459,7 @@ static int damon_commit_targets(
 				src_target, damon_target_has_pid(src),
 				src->min_region_sz);
 		if (err) {
+			damon_commit_target_fail(dst, NULL, src);
 			damon_destroy_target(new_target, NULL);
 			return err;
 		}

base-commit: eeac72cb1b86b53f95c1596ec43db17827a8355e
-- 
2.47.3

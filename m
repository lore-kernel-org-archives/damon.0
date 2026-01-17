Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFE299AB1;
	Sat, 17 Jan 2026 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672385; cv=none; b=EPVx9FSzS3QTjo/8RAXI9VVTxa2qONJOKAIqLJcgvn4b9mznu4np7knQtZhxlUnMQuIKqAzxqqQa0CwZ4J78qpnQ0t1x5IBdZusTNaxmJ3lqTLsE2c7FayA6o3Nq0k5GGCgWuP7NBwrb5RtdB4Z1R6INOXbL1AXKz3HlKxSE1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672385; c=relaxed/simple;
	bh=KFdeOU1Cqynn16FGkaHhjOKt5M+h0bd+XluHiDK/WQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdtsSnZo4VTA2k9wP7YlLnHoy6Cttdx/CuptSZZ9kSTCdXNoTDtkZnaJx+g3Ff9Q4TIMtxY4Pg+BKKUmOaL0ywJHNncpXVhct/THFa5yH9KVx7nIrbBl9ftwZbIBpNCTd5c27paj45lJvhkeEj/FInq9xwqbnZkEzDmGNZ+SdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJTU5Bsm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJTU5Bsm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFEBC2BC86;
	Sat, 17 Jan 2026 17:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768672385;
	bh=KFdeOU1Cqynn16FGkaHhjOKt5M+h0bd+XluHiDK/WQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJTU5BsmjgSpWiQ4aBcyH4NoTiDDamTXPlbz+OYyNaiO4LtArWbnSEFsp9LSoj9t2
	 BFhSaVj/s2oJEvv8OPmFUxC+wN2SnMf55tmnkKQg+NxGOKLdWqXr2Lh88pYSqWF6k9
	 MiryKagHnXH6+9+K+F+TQDJdgV2D0HI3SAjXJvdCEYAbjNys02TkwQN6U7ss4osRbF
	 xdFzz3AHs4KVIIbeEbXgUaEauGh/KAUhlWUVwOew5jn6H/ULP+KltyueEh62pkxjZX
	 cv/iQGwQn3Fax2eoIVtcafhXSdeU2edAkWbOtuu/PDuBF5p4dvpoTuTb7cQ5sRXrKl
	 qzMeg+eode2jA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] mm/damon/core: cleanup targets and regions at once on kdamond termination
Date: Sat, 17 Jan 2026 09:52:49 -0800
Message-ID: <20260117175256.82826-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117175256.82826-1-sj@kernel.org>
References: <20260117175256.82826-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kdamond terminates, it destroys the regions of the context first,
and the targets of the context just before the kdamond main function
returns.  Because regions are linked inside targets, doing them
separately is only inefficient and looks weird.  A more serious problem
is that the cleanup of the targets is done after damon_ctx->kdamond
reset, which is the event that lets DAMON API callers know the kdamond
is no longer actively running.  That is, some DAMON targets could still
exist while kdamond is not running.  There are no real problems from
this, but this implicit fact could cause subtle racy issues in future.
Destroy targets and regions at one.

Adding contexts on how the code has evolved in the way.  Doing only
regions destruction was because putting pids of the targets were done on
DAMON API callers.  Commit 7114bc5e01cf ("mm/damon/core: add
cleanup_target() ops callback") moved the role to be done via operations
set on each target destruction.  Hence it removed the reason to do only
regions cleanup.  Commit 3a69f1635769 ("mm/damon/core: destroy targets
when kdamond_fn() finish") therefore further destructed targets on
kdamond termination time.  It was still separated from regions
destruction because damon_operations->cleanup() may do additional
targets cleanup.  Placing the targets destruction after
damon_ctx->kdamond reset was just an unnecessary decision of the commit.
The previous commit removed damon_operations->cleanup(), so there is no
more reason to do destructions of regions and targets separately.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 53514cb712cf..0c8ac11a49f9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2748,8 +2748,6 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 static int kdamond_fn(void *data)
 {
 	struct damon_ctx *ctx = data;
-	struct damon_target *t;
-	struct damon_region *r, *next;
 	unsigned int max_nr_accesses = 0;
 	unsigned long sz_limit = 0;
 
@@ -2854,10 +2852,7 @@ static int kdamond_fn(void *data)
 		}
 	}
 done:
-	damon_for_each_target(t, ctx) {
-		damon_for_each_region_safe(r, next, t)
-			damon_destroy_region(r, t);
-	}
+	damon_destroy_targets(ctx);
 
 	kfree(ctx->regions_score_histogram);
 	kdamond_call(ctx, true);
@@ -2875,7 +2870,6 @@ static int kdamond_fn(void *data)
 		running_exclusive_ctxs = false;
 	mutex_unlock(&damon_lock);
 
-	damon_destroy_targets(ctx);
 	return 0;
 }
 
-- 
2.47.3

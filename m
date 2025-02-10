Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC11257449;
	Mon, 10 Feb 2025 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212065; cv=none; b=YwBhTqiFxRvPVK3rx9NxlgiQUiSf49CbMwIrBdBZjtHuhKsVBv5WCJcvC1B5FsZW8KHeGsIrwYTz+nABJAkGbxiS4JB/kemsiQPFZ1VYy+ljDy+rHmeVrk8G0nn5uNshUXCBsnpprndeDXdmCMr85exr2gM0pgN5OzVp5Tqxgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212065; c=relaxed/simple;
	bh=JOpbnQ6/GYsrBYDCbmgIB9gcRtACbXxjFLu2npIKqq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWj3QKjfaJuP9Ujn0VXbPGnmYd23dJTFEzWHWGa4b2xvbGpvKDrp4UDVj9fEYZYuHuCiH5Iw/7y+8fUz1E2EBcxoGtv9biglQtx5uwoLyk8HXCPx71M6ky+LUVCCaWswyYyN+6od5jAM3OaxpDfaW1wDmwpQM/eTenbw+jHfeco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXPFF+hp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXPFF+hp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA4EC4CED1;
	Mon, 10 Feb 2025 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739212065;
	bh=JOpbnQ6/GYsrBYDCbmgIB9gcRtACbXxjFLu2npIKqq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXPFF+hpXIwxEWBO4XNrD2qFwVsSZW7Zd4kKXxF+iazZPOwL66VttoSYIR5m+bhjj
	 2CB/dhyYSfNQhw3IG3oL+it13d8rYTeT6VeGziXbskumptRBow6qNtP6DOwJb0Dt/U
	 iOuKJJ75fjj9pMAiGoEPVqYycysEGDxrsez42ETAJnDGpkVDlRyE6MQ7Y5TPm1v2p1
	 dWPo0zSJeLd5FZBKqOV40QVYjdFaC9Dcy6T1KBrHrLcd4bTxcXCbht4hoQ7JKwFI+u
	 tam+aUz/BQ3weJi2T3LTnFTiiVstHMgDYkkcvzHrdaPC7GzElFcb215YtlExmcpQfd
	 FjIs+3adj30QQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] mm/damon/core: do damos walking in entire regions granularity
Date: Mon, 10 Feb 2025 10:27:36 -0800
Message-Id: <20250210182737.134994-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210182737.134994-1-sj@kernel.org>
References: <20250210182737.134994-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_walk_control can be installed while DAMOS is walking the regions.
This means the walk callback function invocations can be started from a
region at the middle of the regions list.  This makes it hard to be used
reliably.  Particularly, DAMOS tried regions update for collecting
monitoring results gets problematic results.  Increase the
walk_control_lock critical section to do walking in entire regions
granularity.

Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4b865b2558d9..c3d9b96b786a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1456,11 +1456,10 @@ static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
 	if (s->walk_completed)
 		return;
 
-	mutex_lock(&ctx->walk_control_lock);
 	control = ctx->walk_control;
-	mutex_unlock(&ctx->walk_control_lock);
 	if (!control)
 		return;
+
 	control->walk_fn(control->data, ctx, t, r, s, sz_filter_passed);
 }
 
@@ -1480,9 +1479,7 @@ static void damos_walk_complete(struct damon_ctx *ctx, struct damos *s)
 	struct damos *siter;
 	struct damos_walk_control *control;
 
-	mutex_lock(&ctx->walk_control_lock);
 	control = ctx->walk_control;
-	mutex_unlock(&ctx->walk_control_lock);
 	if (!control)
 		return;
 
@@ -1496,9 +1493,7 @@ static void damos_walk_complete(struct damon_ctx *ctx, struct damos *s)
 		siter->walk_completed = false;
 
 	complete(&control->completion);
-	mutex_lock(&ctx->walk_control_lock);
 	ctx->walk_control = NULL;
-	mutex_unlock(&ctx->walk_control_lock);
 }
 
 /*
@@ -1845,6 +1840,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	if (!has_schemes_to_apply)
 		return;
 
+	mutex_lock(&c->walk_control_lock);
 	damon_for_each_target(t, c) {
 		damon_for_each_region_safe(r, next_r, t)
 			damon_do_apply_schemes(c, t, r);
@@ -1859,6 +1855,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 			 c->attrs.aggr_interval) / sample_interval;
 		s->last_applied = NULL;
 	}
+	mutex_unlock(&c->walk_control_lock);
 }
 
 /*
-- 
2.39.5

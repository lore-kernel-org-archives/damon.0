Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D14269B12;
	Thu,  6 Mar 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283956; cv=none; b=oM/AdyqCmNv0xo5RLnOfQLVsGTHdod3kpaC/XJlxNo5626sdRySsmXgrfvHC/ErXf5dOtZht7n6eLXXeyrjJAXPb7mg6i6YOqSIeAsYgknqXc4y83XtUCKhF8OTa5oBcUZ4fSDLPvAFWJ/B//ugRzfE+IuC10079GWUlKJfD3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283956; c=relaxed/simple;
	bh=6yhiLeZVnkzlh7XNHP1rZ66eAWt0hQYEE7Tzfoyu2CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZoKAKP1MUrXE5ABdGXmFJhB68vm92td9X6NEMMsnqeoSRQaoUDaltkWXfdBLipwKXbEq5dm3gBKkCwQgq1tHsqS1OeKpq1Dn4MVhsL8gVUzzftbm44Jr7kdcH2q9BUk3GRNYGjAgZKXas7OkzcUshA3Aq2blnf/6jnh5iVEwLOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcOdR4Zg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcOdR4Zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA6DC4CEED;
	Thu,  6 Mar 2025 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283954;
	bh=6yhiLeZVnkzlh7XNHP1rZ66eAWt0hQYEE7Tzfoyu2CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcOdR4ZgX3pF0zydkdFYbvcNF8I6BWC4h0hLsZ4eAATAfrwMOQ8iPaGtVgc2B78JK
	 ndPixVzJSQS3l48cnI+td3Sz0FbmKXrIUocmqDhFloYJIoyUliNhCM4MKvVov0a9u+
	 yOc7JlG8NHMx1bE7fl73nGp5PkU5AY/BblnWeivpN4h8qlrhha5n8LS2Gh9+U0xqI0
	 RxsI/AxsEpEIBZjnWOTsgdv9pik+TtS7FumTIOnWaCUTo5rL2PmROIPb18mbZAdSNl
	 w9Vy+uFxq+f3VfdpjXtjZVCUlBS0J8dOBwGtsIdEnFk6d+EftvapsfFgk5EVOLq+QV
	 aw5oOYQqHKVdQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/13] mm/damon/core: invoke kdamond_call() after merging is done if possible
Date: Thu,  6 Mar 2025 09:58:57 -0800
Message-Id: <20250306175908.66300-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306175908.66300-1-sj@kernel.org>
References: <20250306175908.66300-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_call() callers may iterate the regions, so better to call it
when the number of regions is as small as possible.  It is when
kdamond_merge_regions() is finished.  Invoke it on the point.

This change is also aimed to make future changes for carrying online
parameters commit with damon_call() easier.  The commit operation should
be able to make sequence between other aggregation interval based
operations including regioins merging and aggregation reset.  Placing
damon_call() invocation after the regions merging makes the sequence
handling simpler.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d4fc2c907cfc..0f359b4ebf1a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2420,7 +2420,6 @@ static int kdamond_fn(void *data)
 		if (ctx->callback.after_sampling &&
 				ctx->callback.after_sampling(ctx))
 			break;
-		kdamond_call(ctx, false);
 
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
@@ -2438,9 +2437,10 @@ static int kdamond_fn(void *data)
 		}
 
 		/*
-		 * do kdamond_apply_schemes() after kdamond_merge_regions() if
-		 * possible, to reduce overhead
+		 * do kdamond_call() and kdamond_apply_schemes() after
+		 * kdamond_merge_regions() if possible, to reduce overhead
 		 */
+		kdamond_call(ctx, false);
 		if (!list_empty(&ctx->schemes))
 			kdamond_apply_schemes(ctx);
 		else
-- 
2.39.5

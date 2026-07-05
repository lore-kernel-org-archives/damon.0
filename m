Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301137AA70;
	Sun,  5 Jul 2026 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783266967; cv=none; b=HhR/0Mgr63sb6gYBPmt+GyFzh3dZkOuGL29z2EuuwuOXmROxbNQ4wM4ngiM6yape+6TBBk3g4YLCfvdX+0peltyzMjInvBr1WZIH64VixnKvXE/58LZ8XzrxvSsvL9rMqhhgWP8YOvQ6tSMrCUiMDxC23Yo9VRjUadZxVZjT5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783266967; c=relaxed/simple;
	bh=bVI/yoXGy31smQ7HrzpZhw/q4TPXvx89CW3lmyFpUZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SttF3rNV7WY/Lai6nFSm3CVrkz5TEnxQ5TWNVDvtapgLkMQ/U0uEp0yZByiPbcQXrKiRkQ9BTxcZodyxjAUBJ4FnFyACrkYgXYlBUjj2B//5zwoKtVxPCLKzmXpTmLTgpT5HHKwWHGMlNBm49EhyFzYfeKz/HPxJuDXqCVQPD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0KOOB1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0KOOB1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2C71F00AC4;
	Sun,  5 Jul 2026 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783266966;
	bh=z4feI/qU1SbwMydOJY76MHjKjfYHnoO820guZYu+4uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B0KOOB1vokuwb80M4eI7jlPbhSZfGFRBd+Dw9CLV57xwAGfJHlTnfX+eM+xLnASqG
	 S0Btv1Ykwk3sSzloClyfGKdCOMFgXCY0mC+vP9zbB1bKt5T3364+sTMduxm+FNRyZf
	 o44W808vD0BwHDU+4d7iuQe4CfR7+DMCGPwxCHGvV04jJKc6FXDUGijAazry20Xj9V
	 qw/vk2nA53vKZ6SsiAQ1JN1eGHE2ZGYTme8CB/SbTty/TWcncWUyMQPwB26aPaywq2
	 Oq6KLUwQE3PJH72GtzMlUePxyfmruDAYZGWbHonJnC6m9U8/wM9o5jGl8QZC8zndTK
	 q6BQYZoE1y1+g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/8] mm/damon/reclaim: remove duplicated min_region_sz power of 2 check
Date: Sun,  5 Jul 2026 08:55:55 -0700
Message-ID: <20260705155600.96555-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705155600.96555-1-sj@kernel.org>
References: <20260705155600.96555-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM validates the user input for min_region_sz.  The same
validation is done inside damon_start() and damon_commit_ctx().  Remove
the duplicate.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 11b70d0a9a6f0..6469b25cc34f9 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -208,11 +208,6 @@ static int damon_reclaim_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
-	if (!is_power_of_2(param_ctx->min_region_sz)) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.47.3

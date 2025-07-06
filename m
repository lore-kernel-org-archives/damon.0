Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E82BDC32;
	Sun,  6 Jul 2025 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751830336; cv=none; b=KSLfNWRyM7PTdbw6Yn3+wa5QeK16JS92w4SkpgNO95ZnjIJTbxPhFsxJmRyEhmeO8SD0bo0PTKzoI15w0D2nfczOPP0s/aNTub5RskqWLVWUH6MpxRY2mq9+5s4qas2yze/wEuexk6SZFKvLgmNgmWCaz/GyUSgJBW+gjoyZZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751830336; c=relaxed/simple;
	bh=BX6VH3nU4cicI6oNo09G9KGanoMTvjCG3WQxbqMleEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmkcgOLBya5M4G+I0gjsHImQzuLz1bROmJbahuo51PWO0qG8yeTEQIOXSPG6FBkM32k2gOTiq0DNmdZ/00evRVzyCqtLx8mtqbnAUOaOaJyh9U4SeaIbrGEuGjx8wMPmc8ZSDZLVRgQKMvfjym8paVtQH3ZKeu9QdZpl5sm9oCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6xH6Ldd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6xH6Ldd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1CCC4CEED;
	Sun,  6 Jul 2025 19:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751830336;
	bh=BX6VH3nU4cicI6oNo09G9KGanoMTvjCG3WQxbqMleEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A6xH6LddAHfbhNHvwE1DttcsqSYZdbyBn1mryhXPADkEC8ig/ZF+axPAA2AXwhrg7
	 g0OpHpG5Ekz82QauJzzA1ucDI7H31lcjXxxanhyZ1L7E0FUs0R5IFZqdSLTTxWrtwZ
	 97x+YOiZHThAP/9fxJ/Buq2KXJ3eoC5a6gLbDBqdU+kiPeJBOVLrFSSotnNo4K1SEr
	 WQUmT8TpfrS+w4XQvkHzjqRCcMrPXKkKzi83j9edkjMYrbrLcQiCWC8XY3V8mFP+eu
	 kF19WeZDtg72x+ZZJBT+CwWUQtL7tstsD1zlSqiKSRPZasBvtvtNnV3V81VN+wKHCX
	 oM7tzV/f1hPVQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/6] mm/damon/lru_sort: reset enabled when DAMON start failed
Date: Sun,  6 Jul 2025 12:32:06 -0700
Message-Id: <20250706193207.39810-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706193207.39810-1-sj@kernel.org>
References: <20250706193207.39810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the startup fails, 'enabled' parameter is not reset.  As a result,
users show the parameter 'Y' while it is not really working.  Fix it by
resetting 'enabled' to 'false' when the work is failed.

Fixes: 7a034fbba336 ("mm/damon/lru_sort: enable and disable synchronously")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 4af8fd4a390b..9bd8a1a115e0 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -325,7 +325,7 @@ static int __init damon_lru_sort_init(void)
 	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
 
 	if (err)
-		return err;
+		goto out;
 
 	ctx->callback.after_wmarks_check = damon_lru_sort_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_lru_sort_after_aggregation;
@@ -334,6 +334,9 @@ static int __init damon_lru_sort_init(void)
 	if (enabled)
 		err = damon_lru_sort_turn(true);
 
+out:
+	if (err && enabled)
+		enabled = false;
 	return err;
 }
 
-- 
2.39.5

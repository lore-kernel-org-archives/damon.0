Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940626FDA8;
	Tue, 16 Sep 2025 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993722; cv=none; b=sngm5MwUMPcQBo0OhXBmOVtpnu/642ym2obeInTWkVXoUWhhVYAVREU0MGEdwMrKT33sYg3BP/Gy89NThKY++I4o6kn3f2hLrNSx/0iR0Rp73OrXdpHRzvjmH5iwOdcd4w02HS5cj2ldhWLqEtMwE0l+mXSd1wZYp0ZdMDrLKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993722; c=relaxed/simple;
	bh=jSyChxhp2q57cPUh41M0fEVHkYfztaaT3v+fVBcDkyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XfCACGRNm7bqzZN+m//qd+KFuAm56WbZpeSxlkg8UdjsMEE6mXcK80JU/Ml0DEw5J5dJXT/yOCEteAbU+ze9qKtidH/J7JYUHumDxWXaw2KF8cFfH6RAVzL7oRAiaiKXbPtFuauebHVtvxlapw4ESBTQ03AQ/i0UCCIjSHtcL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orfNy6DZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orfNy6DZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF489C4CEFE;
	Tue, 16 Sep 2025 03:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993721;
	bh=jSyChxhp2q57cPUh41M0fEVHkYfztaaT3v+fVBcDkyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orfNy6DZUAp3GECznrx4oiXg/9pB061b0r3o27o0f0ZJscgUtwEI5JqwK4Co/KrXy
	 yaNtCi+UpfwZqqW7g3XqYNHTSYdu+FGDETrxw20d1UMeMJjxTp7aRn+0SFeJKcyBNT
	 DzbDAeK1n0Tq9I1owIgh9eRtfJeUI0CjWVO7mCBs8sW+pob8csaBqTczIPe6SA93UB
	 ioAz63GmsdAXpimgbDXPlAXHFU/YXLarYZFB/fv6SKznE9dmDVSbXqaeHZz6dflQBC
	 rxZe4GjdLtA4AyGOqR48dJqjpz4nsBl9+DWt/U4ckeQDw7H0iLIIxlq4CRFaBKw4uJ
	 9pycIiU9R1Ilg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/7] mm/damon/lru_sort: use damon_initialized()
Date: Mon, 15 Sep 2025 20:35:08 -0700
Message-Id: <20250916033511.116366-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916033511.116366-1-sj@kernel.org>
References: <20250916033511.116366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT is assuming DAMON is ready to use in module_init time,
and uses its own hack to see if it is the time.  Use
damon_initialized(), which is a way for seeing if DAMON is ready to be
used that is more reliable and better to maintain instead of the hack.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index ab6173a646bd..42b9a656f9de 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -345,7 +345,7 @@ static int damon_lru_sort_enabled_store(const char *val,
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
-	if (!ctx)
+	if (!damon_initialized())
 		goto set_param_out;
 
 	err = damon_lru_sort_turn(enable);
@@ -368,8 +368,13 @@ MODULE_PARM_DESC(enabled,
 
 static int __init damon_lru_sort_init(void)
 {
-	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	int err;
 
+	if (!damon_initialized()) {
+		err = -ENOMEM;
+		goto out;
+	}
+	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
 	if (err)
 		goto out;
 
-- 
2.39.5

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119E4BE42D;
	Mon, 21 Sep 2026 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003762; cv=none; b=OhjPFDrxRi4O2ABGiRHk7vQoPwj53eFzCX5yatcGq0Nudo23sHCwuui3u1IVSlXmz0VTQGs1SxjMYmmKtaWCvnT/321PwQRuf1eGlMbQuxWigod6W9CANplHLz4qY/5KE+/d7GS48VJcy6EW1r0za5nEZ3hwEq4lFp3Cs1f6Ee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003762; c=relaxed/simple;
	bh=GmWPcTpaKF6EHJdlDr9TQZWWAcbUCnyIBkkHLbo5z+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKH+Q6vHXw6RlSPmTg7gqitWr2Vttw+vbjTD2xw0UaHQEx9gYErF9b5gP9wesmLOi95i8lvZVnjL4ftNURlbTumLHfynoi0jj8iC27JEEQQ55UOo9pENiEpjKRlxFtZiLXc0Ogqn83Np3Cj79hfeJ3oMiiYZKtFLY+NEZEZERbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXmy9QfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXmy9QfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26091F000FF;
	Mon, 21 Sep 2026 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003760;
	bh=bKpBenybAt2skpTkLkXIqtzA/nUfxrfvFxG/+NAT6QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JXmy9QfEcwYPI/tNPSUfWcmZK2OvPO0BNfURuaKxF5h9YIMhrUnMM4vFj2sX8VqMN
	 D9YZ9RJFpym5NVLBBcdn7kAsi+ADbCPpi7uonOTui1DTnYbmy+cqcXjJeimWJk8n4I
	 Fm4ss6Uq93K1DV+3x4UJCvl5SLQQedtrdxOfjywEiKCmVD40efRhUpdnILEpejlViq
	 x0Klihsbkoxo2xySgz7mNWR+GGw1ZXba4InQ1N898lk4kVo81w5jX0rilD6VkoU9LZ
	 00MRa34TAFNihHZJffBuN8dixHOYqHlVPiBiMxHpLbvFZDzCCDTLobN6NDo3W3kxx0
	 B0wHQkbEKRtyg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Xuewen Wang <wangxuewen@kylinos.cn>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: [PATCH 3/4] mm/damon: fix typos in comments
Date: Mon, 21 Sep 2026 08:15:45 -0700
Message-ID: <20260921151547.78472-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921151547.78472-1-sj@kernel.org>
References: <20260921151547.78472-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>

Correct spelling mistakes. No functional changes.

Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
Reviewed-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260915102746.647-1-adrianhuang0701@gmail.com
- Collect R-b: from Zenghui and SJ.
- Rebase to the latest mm-new.

 mm/damon/core.c     | 6 +++---
 mm/damon/lru_sort.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 98c767b9e6ef..0aa5d0ea8ebc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2486,7 +2486,7 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
  * This function checks if a given region should be skipped or not for the
  * reason.  If only the starting part of the region has previously charged,
  * this function splits the region into two so that the second one covers the
- * area that not charged in the previous charge widnow, and return true.  The
+ * area that not charged in the previous charge window, and return true.  The
  * caller can see the second one on the next iteration of the region walk.
  * Note that this means the caller should use damon_for_each_region() instead
  * of damon_for_each_region_safe().  If damon_for_each_region_safe() is used,
@@ -2652,7 +2652,7 @@ static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
  * This function is called when kdamond finished applying the action of a DAMOS
  * scheme to all regions that eligible for the given &damos->apply_interval_us.
  * If every scheme of @ctx including @s now finished walking for at least one
- * &damos->apply_interval_us, this function makrs the handling of the given
+ * &damos->apply_interval_us, this function marks the handling of the given
  * DAMOS walk request is done, so that damos_walk() can wake up and return.
  */
 static void damos_walk_complete(struct damon_ctx *ctx, struct damos *s)
@@ -4177,7 +4177,7 @@ static bool damon_find_system_rams_range(unsigned long *start,
  * This function sets the region of @t as requested by @start and @end.  If the
  * values of @start and @end are zero, however, this function finds 'System
  * RAM' resources and sets the region to cover all the resource.  In the latter
- * case, this function saves the start and the end addresseses of the first and
+ * case, this function saves the start and the end addresses of the first and
  * the last resources in @start and @end, respectively.
  *
  * Return: 0 on success, negative error code otherwise.
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index ad8e86dd3a93..273efa3c913e 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -260,7 +260,7 @@ static int damon_lru_sort_add_filters(struct damos *hot_scheme,
 		return -ENOMEM;
 	damos_add_filter(hot_scheme, filter);
 
-	/* disabllow de-prioritizing young pages */
+	/* disallow de-prioritizing young pages */
 	filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, true, false);
 	if (!filter)
 		return -ENOMEM;
-- 
2.47.3

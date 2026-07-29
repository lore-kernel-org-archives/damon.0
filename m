Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566FC4A2E3C;
	Wed, 29 Jul 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333785; cv=none; b=WWwCvUUUMQ7D7NDEBn1aCfy+RNlUtbZdNC2K8SLql+6b7lxpnnEXtnbTn2ZIzHtMjd/8R6vAxrXVih9lqO8Fx/L4PdiTUY+YhplB35t64ChgpsPjTNbQ1QfhaBebNb0AEn4sW1fZgKix+SVN2j1voyEvNTJtJHFILvr9Wues/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333785; c=relaxed/simple;
	bh=hBXKcXG4b0K0CuDzEh4AFJo8ClqwVQvOP73HkbC3Jc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOt3U4vy/wQuLD+NRyiCeYzzWrZLdLD2KlnbuSidYXYM/rqNNoZ8iN4qZuo/q7NXD6i9nydO8+UKLmHYlWo1NFfRoB3falEAMgjiA9XHji92NFA0K4ICBxFg6gGEjn17H34TsYvHJ2gUthBI4godvbmCFk4kM1FgDy3nSAS05Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDou7hQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDou7hQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DF91F00AC4;
	Wed, 29 Jul 2026 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333784;
	bh=OrmqzezRZHpLkQbXvsx8kdT8w9xKKaZj6lZcjNbOnP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UDou7hQm8vW0dPRY6gFTdF1SgjemoxQagg77mAPX+a4NY9m3P7Kw6WrAOG/8aqN0x
	 jEYqHYi1MsuHDf1rgYgQ44SrTRCq/hJmUp/UK01jxnlqA6q+jg4yCSlJgSMS8gkNh0
	 doi0Rxcagff5hG8uv63lsr6URjmvU+G7Dbldvg62YBWpjTD/2vKYHrutZw0EfuO3/J
	 UNx+rfb6wcfHU1XDgeFcBowbcQvSpB4srourGDDwihw9lpg5I3pjlHS8Ul5YpIlxQh
	 Bxliw8lw5wzuH6gYPTMB/abkUguG4ejKOLHvQCGVxnU+6AZf8XR3qfgY+22VstepU8
	 INsw7p4ffNUVQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 03/12] mm/damon/vaddr: remove a debug message
Date: Wed, 29 Jul 2026 07:02:43 -0700
Message-ID: <20260729140253.87753-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729140253.87753-1-sj@kernel.org>
References: <20260729140253.87753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a debug message in the DAMON virtual address space operation
set.  It has not really been used in a meaningful way for the last few
years, though.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 0648400b2d65b..1b220f6f2632b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -189,22 +189,12 @@ static int damon_va_three_regions(struct damon_target *t,
  *   <BIG UNMAPPED REGION 2>
  *   <stack>
  */
-static void __damon_va_init_regions(struct damon_ctx *ctx,
-				     struct damon_target *t)
+static void __damon_va_init_regions(struct damon_target *t)
 {
-	struct damon_target *ti;
 	struct damon_addr_range regions[3];
-	int tidx = 0;
 
-	if (damon_va_three_regions(t, regions)) {
-		damon_for_each_target(ti, ctx) {
-			if (ti == t)
-				break;
-			tidx++;
-		}
-		pr_debug("Failed to get three regions of %dth target\n", tidx);
+	if (damon_va_three_regions(t, regions))
 		return;
-	}
 
 	damon_set_regions(t, regions, 3, DAMON_MIN_REGION_SZ);
 }
@@ -217,7 +207,7 @@ static void damon_va_init(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		/* the user may set the target regions as they want */
 		if (!damon_nr_regions(t))
-			__damon_va_init_regions(ctx, t);
+			__damon_va_init_regions(t);
 	}
 }
 
-- 
2.47.3

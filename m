Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A0753A7
	for <damon@lists.linux.dev>; Fri, 16 Sep 2022 13:35:50 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPxa0sf_1663335339;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPxa0sf_1663335339)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 21:35:40 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH] mm/damon/sysfs: more simplified code calls damon_target_has_pid()
Date: Fri, 16 Sep 2022 21:35:35 +0800
Message-Id: <20220916133535.7428-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch further simplifies the damon_target_has_pid() call and makes
the damon_sysfs_destroy_targets() look cleaner.

Fixes: 49fb890735ab (mm/damon/sysfs: avoid call damon_target_has_pid() repeatedly)
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Suggested-by: SeongJae Park <sj@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index dc8dd56d6589..7692c706bcc5 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2132,10 +2132,7 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
-	bool has_pid = false;
-
-	if (damon_target_has_pid(ctx))
-		has_pid = true;
+	bool has_pid = damon_target_has_pid(ctx);
 
 	damon_for_each_target_safe(t, next, ctx) {
 		if (has_pid)
-- 
2.31.0


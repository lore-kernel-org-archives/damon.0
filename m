Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9B4683
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 14:23:02 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPtLfjQ_1663251759;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPtLfjQ_1663251759)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 22:22:40 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH V1 1/2] mm/damon/sysfs: avoid call damon_target_has_pid() repeatedly
Date: Thu, 15 Sep 2022 22:22:36 +0800
Message-Id: <20220915142237.92529-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In damon_sysfs_destroy_targets(), we call damon_target_has_pid() to
check whether the 'ctx' include a valid pid, but there no need to call
damon_target_has_pid() to check repeatedly, just need call it once.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1fa0023f136e..966ea7892ccf 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2143,9 +2143,13 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
+	bool has_pid = false;
+
+	if (damon_target_has_pid(ctx))
+		has_pid = true;

 	damon_for_each_target_safe(t, next, ctx) {
-		if (damon_target_has_pid(ctx))
+		if (has_pid)
 			put_pid(t->pid);
 		damon_destroy_target(t);
 	}
--
2.31.0

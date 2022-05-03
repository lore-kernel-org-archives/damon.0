Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470233C9
	for <damon@lists.linux.dev>; Tue,  3 May 2022 22:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6ADC385A9;
	Tue,  3 May 2022 22:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1651615533;
	bh=UsYHQ2RMFhU+kqPVwKX92XprgxwwCA2T6bnN4o6xFNk=;
	h=From:To:Cc:Subject:Date:From;
	b=DWdkr2Zn0xk9I/RIzkgqjqAwye1gPjoCBwYg81adHHk8aJOKVJvquxPtHWZ2f/T7N
	 4UUC1cYtIHuV/4kDMmqgVmYWZAPKjChzv0VMZ9oSRNpI35+cJdojXbjKj7PbfIwhbm
	 18QhXlaBtAlUTq5NWFtoYKBxa/ZQWlXkGjQB7oW0XN1QwoAeJiswsuHJyJIbMUo4ZJ
	 Gu1iqZv7IYDG9DMEqYHVQJU/A9roAxikayJ5M/Ala+DhJThDrIVQfdez2W3d7PEAf5
	 zCsrDiBhbXZbVN6GlsMI88ea8QKsRGsZX2YBWfhWsKiCxpdnSwvWuk0DL7zID+Jfxo
	 LpHAHAsI3RxwQ==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/damon/sysfs: fix pid leak under fvaddr ops use case
Date: Tue,  3 May 2022 22:05:31 +0000
Message-Id: <20220503220531.45913-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c83136469313 ("mm/damon/sysfs: support fixed virtual address
ranges monitoring") in 'mm-unstable' does not put the monitoring target
pid when fvaddr ops is used.  This commit fixes it to put pid properly.

Andrew, please merge this into the 'mm-unstable' commit
("mm/damon/sysfs: support fixed virtual address ranges monitoring").

Fixes: c83136469313 ("mm/damon/sysfs: support fixed virtual address ranges monitoring")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 767ab8c33e4d..f753bb405101 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2086,7 +2086,8 @@ static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
 	struct damon_target *t, *next;
 
 	damon_for_each_target_safe(t, next, ctx) {
-		if (ctx->ops.id == DAMON_OPS_VADDR)
+		if (ctx->ops.id == DAMON_OPS_VADDR ||
+				ctx->ops.id == DAMON_OPS_FVADDR)
 			put_pid(t->pid);
 		damon_destroy_target(t);
 	}
@@ -2204,7 +2205,7 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
 
-	if (ctx->ops.id != DAMON_OPS_VADDR)
+	if (ctx->ops.id != DAMON_OPS_VADDR && ctx->ops.id != DAMON_OPS_FVADDR)
 		return;
 
 	mutex_lock(&ctx->kdamond_lock);
-- 
2.25.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05613AC6
	for <damon@lists.linux.dev>; Sun, 22 Oct 2023 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnueFOFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BD1C433CA;
	Sun, 22 Oct 2023 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698008860;
	bh=yOdMqP6KZLl0RBsnjmhN2cj6fhQSH3cbP76PBzRCOAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnueFOFQ6TdfQk/iuPOF/OFgmETyKyueN3Q8xtoB6EEMbxvxVHfON+yY3CJBuKIRg
	 f1yY9C/RuQcxMRhpnmwPmKVJUrrynqKh1TIniakjnBDBebuy6nXz+TWubn1wXJd8Ri
	 010+bl5UYfpbCkevNZLOml+RapqIGvkwqzz3lxyAuuzj2AkffQe+/Rs6lpFqe1g/4y
	 vz4FyTcuIiHO78oGe60UG78FqYJFRUiZgnxU8cZURkIctRznFCXHqveGG5bFPIjO9+
	 4bX43pRwyubtaSVX4tcbeKdOl2Tu5t2E9xGZMEzJx4bTe0+pC+JyvjamJC/usJ0bld
	 D7ogbirT/qmAg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/sysfs: remove requested targets when online-commit inputs
Date: Sun, 22 Oct 2023 21:07:33 +0000
Message-Id: <20231022210735.46409-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022210735.46409-1-sj@kernel.org>
References: <20231022210735.46409-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_set_targets(), which updates the targets of the context for
online commitment, do not remove targets that removed from the
corresponding sysfs files.  As a result, more than intended targets of
the context can exist and hence consume memory and monitoring CPU
resource more than expected.

Fix it by removing all targets of the context and fill up again using
the user input.  This could cause unnecessary memory dealloc and realloc
operations, but this is not a hot code path.  Also, note that
damon_target is stateless, and hence no data is lost.

Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 50 +++++++++---------------------------------------
 1 file changed, 9 insertions(+), 41 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index f73dc88d2d19..5268e8503722 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1150,58 +1150,26 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 	return err;
 }
 
-/*
- * Search a target in a context that corresponds to the sysfs target input.
- *
- * Return: pointer to the target if found, NULL if not found, or negative
- * error code if the search failed.
- */
-static struct damon_target *damon_sysfs_existing_target(
-		struct damon_sysfs_target *sys_target, struct damon_ctx *ctx)
-{
-	struct pid *pid;
-	struct damon_target *t;
-
-	if (!damon_target_has_pid(ctx)) {
-		/* Up to only one target for paddr could exist */
-		damon_for_each_target(t, ctx)
-			return t;
-		return NULL;
-	}
-
-	/* ops.id should be DAMON_OPS_VADDR or DAMON_OPS_FVADDR */
-	pid = find_get_pid(sys_target->pid);
-	if (!pid)
-		return ERR_PTR(-EINVAL);
-	damon_for_each_target(t, ctx) {
-		if (t->pid == pid) {
-			put_pid(pid);
-			return t;
-		}
-	}
-	put_pid(pid);
-	return NULL;
-}
-
 static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 		struct damon_sysfs_targets *sysfs_targets)
 {
+	struct damon_target *t, *next;
 	int i, err;
 
 	/* Multiple physical address space monitoring targets makes no sense */
 	if (ctx->ops.id == DAMON_OPS_PADDR && sysfs_targets->nr > 1)
 		return -EINVAL;
 
+	damon_for_each_target_safe(t, next, ctx) {
+		if (damon_target_has_pid(ctx))
+			put_pid(t->pid);
+		damon_destroy_target(t);
+	}
+
 	for (i = 0; i < sysfs_targets->nr; i++) {
 		struct damon_sysfs_target *st = sysfs_targets->targets_arr[i];
-		struct damon_target *t = damon_sysfs_existing_target(st, ctx);
-
-		if (IS_ERR(t))
-			return PTR_ERR(t);
-		if (!t)
-			err = damon_sysfs_add_target(st, ctx);
-		else
-			err = damon_sysfs_set_regions(t, st->regions);
+
+		err = damon_sysfs_add_target(st, ctx);
 		if (err)
 			return err;
 	}
-- 
2.34.1


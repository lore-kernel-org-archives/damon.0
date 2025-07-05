Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA521B9D6;
	Sat,  5 Jul 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751737808; cv=none; b=l1aVX7YXp0h+RH3SSKcIc/tqVkD91EEvrS14KO0mcRaBtXX29siduOqDvT0nFEt/Fj2wh1BdMGIi86Vj6ReaTaA8NaOv9ZL+UK85WCHgvTvzsD5dN1vcJ35PZf4s17Xq9aaQcRKgcGt3guX16pcEx35fRZS079dyhwYzz83yMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751737808; c=relaxed/simple;
	bh=UlQxor/ZrTo1LCopX/vs+QBnkrkfnY6J7q+nqa5X2vM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zv2Fv3eGh1r08RvjKdgckwMsoBHB+FaEBo9Y5sGHO6VA30FdVM0Rq1s/GGDW/Elfnq/yvqXBRG2ZjZhV2UoCFI7k6ZlXaf9gMCeOtgqNEXwlunNtYui9qyaehI8MSEd0VMEO/YHpdYsWADoHjX54GV2l6D+JnMPlSaAgFv/6sSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f24XUX+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f24XUX+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F21C4CEE7;
	Sat,  5 Jul 2025 17:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751737807;
	bh=UlQxor/ZrTo1LCopX/vs+QBnkrkfnY6J7q+nqa5X2vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f24XUX+m23bN8Hmsz3jagw7Q/aGUMDMsDJm9/A+gXpG+aiU8IR7acWQGda1f6YRQu
	 O5vPJ47LfdF1QwhCU6STQWLvEdZ6/847dJpoWR/IbnEcBws3eN06uJ95aAfnPp2tsB
	 6ETkcJyDuQ6g2eI9nX8ptCiG5qdZ/endL9+s2oJNgtKMaA9HnvQQMPxRWKfWkaXeA2
	 NRXHywTAoygU+Xq3sAJi1rq4eEu1S6zZK2osbK2aYi06wYQ7ZYezpmuhpBxP+RyIMa
	 7Sd7yrglH/Om3V3KtgLT1on3xpbOpw84+lb23bjFsjJOKE+G/gtVdsUseZEtdRkN2B
	 HVI8QZC/gipEQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/6] mm/damon/sysfs: use DAMON core API damon_is_running()
Date: Sat,  5 Jul 2025 10:49:58 -0700
Message-Id: <20250705175000.56259-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250705175000.56259-1-sj@kernel.org>
References: <20250705175000.56259-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core implements a static function to see if a given DAMON context
is running.  DAMON sysfs interface is implementing the same one on its
own.  Make the core function non-static and reuse it from the DAMON
sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       |  8 +++++++-
 mm/damon/sysfs.c      | 14 ++------------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bb58e36f019e..e1fea3119538 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -934,6 +934,7 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
+bool damon_is_running(struct damon_ctx *ctx);
 
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index dc0ee2dd55d3..5357a18066b0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1311,7 +1311,13 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 	return err;
 }
 
-static bool damon_is_running(struct damon_ctx *ctx)
+/**
+ * damon_is_running() - Returns if a given DAMON context is running.
+ * @ctx:	The DAMON context to see if running.
+ *
+ * Return: true if @ctx is running, false otherwise.
+ */
+bool damon_is_running(struct damon_ctx *ctx)
 {
 	bool running;
 
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1b1476b79cdb..79d65dcc9dd0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1189,16 +1189,6 @@ static void damon_sysfs_kdamond_rm_dirs(struct damon_sysfs_kdamond *kdamond)
 	kobject_put(&kdamond->contexts->kobj);
 }
 
-static bool damon_sysfs_ctx_running(struct damon_ctx *ctx)
-{
-	bool running;
-
-	mutex_lock(&ctx->kdamond_lock);
-	running = ctx->kdamond != NULL;
-	mutex_unlock(&ctx->kdamond_lock);
-	return running;
-}
-
 /*
  * enum damon_sysfs_cmd - Commands for a specific kdamond.
  */
@@ -1275,7 +1265,7 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 	if (!ctx)
 		running = false;
 	else
-		running = damon_sysfs_ctx_running(ctx);
+		running = damon_is_running(ctx);
 
 	return sysfs_emit(buf, "%s\n", running ?
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
@@ -1429,7 +1419,7 @@ static inline bool damon_sysfs_kdamond_running(
 		struct damon_sysfs_kdamond *kdamond)
 {
 	return kdamond->damon_ctx &&
-		damon_sysfs_ctx_running(kdamond->damon_ctx);
+		damon_is_running(kdamond->damon_ctx);
 }
 
 static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
-- 
2.39.5

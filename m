Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49237F8C6;
	Thu,  2 Jul 2026 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026372; cv=none; b=kcdsv+1sQGmYgN8Ufp/7WmjdbW/vkvS7JvgrL01HZ3haG6gp88LUQcc39F66PNQwNcmgvPZHK+VHWvBY2DUGFzty1juKDKN+KI9JcGcwyX3f16jsXzgZGQIkMBtTK8UHVOY5zNMUVZQ5BxqEYhXj/Df6rWGyhoPokCjWQ/puisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026372; c=relaxed/simple;
	bh=maFo7KaC3ao6+rOtSD6HCt6OD0glUxaK9+5PXE7Q4j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDHThisO9Nlm6dJD6ePjcbJ1egZB3zMmMUEePUF2uai0mynfRe+FCdQvxg8SJrcOFzwpBsZGMa9bH2JfqCZzqleEK8ebuBZBxkclCTS5t71eEGELTTr+YVwUKDcmTWtkYMpr+D3J6XrOyHV1uKo9XwRoTN8XN+YShlvKDFecqt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLqHNiG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLqHNiG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9790E1F000E9;
	Thu,  2 Jul 2026 21:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783026370;
	bh=BLtPouv7eTzT2uQvAh/J7SZwGEEh8mUIs2EK62lyYMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MLqHNiG4jTmma0r/z+ODi+4wtFuUkemyhU31jRk1mdVXizhYqIKdcBvWtEe7oCXHY
	 VAXS0VjqDCoWF9CYda3W96GxclBPydKhQ1mXAAbrRsvoGO5z58Gx2SNGPTl61cP4o+
	 YjNucIClMnYAs1Qgtk1gGmlZTwvcDa2herfCwNATqffW2TXPn6iCXS3dzUhewHA4pw
	 9FfEFyrZ4Z7ik+fVzzllJr24CXzjiLxDbeEKPXL5GRqEq/N4ZCI1uexU+1ul67WW83
	 h6EXWhOh6MKVK0jR5KxQ1QPOD6E21g0JD5rYJDhiMz/SB0lPEp8DDeO50FfqJ68Ytw
	 TgSkeBsjFacJQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 3/8] mm/damon/sysfs: remove duplicated commit input validity check
Date: Thu,  2 Jul 2026 14:05:45 -0700
Message-ID: <20260702210551.95167-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702210551.95167-1-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface does parameters validation-purpose
damon_commit_ctx() calls for parameters update.  Now the same logic is
embedded inside damon_commit_ctx() itself.  Hence, the validation in
DAMON sysfs interface is just an unnecessary duplicate.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6710b6d019bf5..e666dddf1feba 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2098,26 +2098,6 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 static struct damon_ctx *damon_sysfs_build_ctx(
 		struct damon_sysfs_context *sys_ctx);
 
-/*
- * Return a new damon_ctx for testing new parameters to commit.
- */
-static struct damon_ctx *damon_sysfs_new_test_ctx(
-		struct damon_ctx *running_ctx)
-{
-	struct damon_ctx *test_ctx;
-	int err;
-
-	test_ctx = damon_new_ctx();
-	if (!test_ctx)
-		return NULL;
-	err = damon_commit_ctx(test_ctx, running_ctx);
-	if (err) {
-		damon_destroy_ctx(test_ctx);
-		return NULL;
-	}
-	return test_ctx;
-}
-
 /*
  * damon_sysfs_commit_input() - Commit user inputs to a running kdamond.
  * @kdamond:	The kobject wrapper for the associated kdamond.
@@ -2127,7 +2107,7 @@ static struct damon_ctx *damon_sysfs_new_test_ctx(
 static int damon_sysfs_commit_input(void *data)
 {
 	struct damon_sysfs_kdamond *kdamond = data;
-	struct damon_ctx *param_ctx, *test_ctx;
+	struct damon_ctx *param_ctx;
 	int err;
 
 	if (!damon_sysfs_kdamond_running(kdamond))
@@ -2139,17 +2119,7 @@ static int damon_sysfs_commit_input(void *data)
 	param_ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
 	if (IS_ERR(param_ctx))
 		return PTR_ERR(param_ctx);
-	test_ctx = damon_sysfs_new_test_ctx(kdamond->damon_ctx);
-	if (!test_ctx) {
-		damon_destroy_ctx(param_ctx);
-		return -ENOMEM;
-	}
-	err = damon_commit_ctx(test_ctx, param_ctx);
-	if (err)
-		goto out;
 	err = damon_commit_ctx(kdamond->damon_ctx, param_ctx);
-out:
-	damon_destroy_ctx(test_ctx);
 	damon_destroy_ctx(param_ctx);
 	return err;
 }
-- 
2.47.3

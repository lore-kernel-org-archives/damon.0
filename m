Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390526E149;
	Wed, 26 Feb 2025 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551822; cv=none; b=FRVMePdHteG9swH9MTLCcCBHPvehaJ9RJflLb9rWSfq71A7sCWr29CivCF6oonWv14GwdgCxxlp/2t+8B+cKVwQ3VO2QkVkdunz32ssheR5x1nleefDw0idBJZuaHgi58vrQa9OPBL9WfyVsW2qxwwOZV7laRl7VDCjrddfTnTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551822; c=relaxed/simple;
	bh=T05PHV/b/RY6SE79bGJVruG1lJQyvBwcsDSu/WYUE0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqVStpBd8nRfKX1IC2cQZIu981BBo+zln3nY6scZshDGFQXC8Eb2GiBSgH7EfTPADdc1BSVHC5MnZjyHE/GgksnX6beZe2TkOL+CZw71BuxhZ4QrfyYX3UwEwnBBP+ujCi5w/5c6kSN4aaF9f4asldnboDBu6XGcJGEZVbHR0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou4Jlw/h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou4Jlw/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9491DC4CEEC;
	Wed, 26 Feb 2025 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551821;
	bh=T05PHV/b/RY6SE79bGJVruG1lJQyvBwcsDSu/WYUE0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ou4Jlw/h7uxzaJKHZrhqjlV2IAvmkNPu9L3ZopdDLUbEKqsSKUFC4oNZcwIN974nz
	 NOwvefrT1a5l7zV4szTYyn7Zz8Fg9RoYksLLzP+Gjjrf5oCH5MP88bgQhyPyubwqwJ
	 Itxtyz0qHmVmtj5hHo+bcvquT6H0jg1mOO//L6+Qz12uSC5u1ktkLRoENnpxDtLLoq
	 WYAOzzgdsSCZkd3SLqTaNCvfSMQ2RyRWGxD+tqkDFlsFYCZ3LQptMkp34co2a/3q8F
	 FIMek3ClqcJbhIexLUjLeW5TtbhKsNCcZuLbbItCEh6RELG9wYPT2UZ0svKOt5wDYa
	 2DNmGdrkiut6Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/13] mm/damon/sysfs: remove damon_sysfs_cmd_request_callback() and its callers
Date: Tue, 25 Feb 2025 22:36:44 -0800
Message-Id: <20250226063651.513178-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_cmd_request_callback() is the damon_callback hook functions
that were used to handle user requests that need to read and/or write
DAMON internal data.  All the usages are now updated to use damon_call()
or damos_walk(), though.  Remove it and its callers.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 62 ------------------------------------------------
 1 file changed, 62 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 166161f12c26..e5bcf019086f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1529,65 +1529,6 @@ static int damon_sysfs_upd_tuned_intervals(void *data)
 	return 0;
 }
 
-/*
- * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
- * @c:		The DAMON context of the callback.
- * @active:	Whether @c is not deactivated due to watermarks.
- * @after_aggr:	Whether this is called from after_aggregation() callback.
- *
- * This function is periodically called back from the kdamond thread for @c.
- * Then, it checks if there is a waiting DAMON sysfs request and handles it.
- */
-static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
-		bool after_aggregation)
-{
-	struct damon_sysfs_kdamond *kdamond;
-	int err = 0;
-
-	/* avoid deadlock due to concurrent state_store('off') */
-	if (!mutex_trylock(&damon_sysfs_lock))
-		return 0;
-	kdamond = damon_sysfs_cmd_request.kdamond;
-	if (!kdamond || kdamond->damon_ctx != c)
-		goto out;
-	switch (damon_sysfs_cmd_request.cmd) {
-	default:
-		break;
-	}
-	/* Mark the request as invalid now. */
-	damon_sysfs_cmd_request.kdamond = NULL;
-out:
-	mutex_unlock(&damon_sysfs_lock);
-	return err;
-}
-
-static int damon_sysfs_after_wmarks_check(struct damon_ctx *c)
-{
-	/*
-	 * after_wmarks_check() is called back while the context is deactivated
-	 * by watermarks.
-	 */
-	return damon_sysfs_cmd_request_callback(c, false, false);
-}
-
-static int damon_sysfs_after_sampling(struct damon_ctx *c)
-{
-	/*
-	 * after_sampling() is called back only while the context is not
-	 * deactivated by watermarks.
-	 */
-	return damon_sysfs_cmd_request_callback(c, true, false);
-}
-
-static int damon_sysfs_after_aggregation(struct damon_ctx *c)
-{
-	/*
-	 * after_aggregation() is called back only while the context is not
-	 * deactivated by watermarks.
-	 */
-	return damon_sysfs_cmd_request_callback(c, true, true);
-}
-
 static struct damon_ctx *damon_sysfs_build_ctx(
 		struct damon_sysfs_context *sys_ctx)
 {
@@ -1603,9 +1544,6 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 		return ERR_PTR(err);
 	}
 
-	ctx->callback.after_wmarks_check = damon_sysfs_after_wmarks_check;
-	ctx->callback.after_sampling = damon_sysfs_after_sampling;
-	ctx->callback.after_aggregation = damon_sysfs_after_aggregation;
 	ctx->callback.before_terminate = damon_sysfs_before_terminate;
 	return ctx;
 }
-- 
2.39.5

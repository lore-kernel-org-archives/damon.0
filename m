Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4E3ACA4E;
	Thu, 15 Jan 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490453; cv=none; b=Y+zDh5ngCoBJN9MmPuevf8MuZ2yq5LzvNITZAxGBVfvB2DymtxsbSxttV6QzF127LnR7UpBKfXHHp2zliLyHnMxnoG4h6hguTdULwRIkGvMmoOogOCF06j4yGzQzrJfn0HMFU4DYrDvPYlfqTh8caZE8MA1lXeahB7MaSURn1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490453; c=relaxed/simple;
	bh=1IPEhfIuLNwm0i05nT9ETMSk54stCMKIEwoga36jhG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAOTGrwwdgL7BpjCMCsh7BbYneGqrK53+8tz1BFM8e/AowjTwpX8sMejoQWnIKtN9uXlroo4QMY7oC+d9m8hjVsKLa4TcN++DeTR0gvxIcHhcV2MUJ1Qt4Qf8t7gzhaW6dPFtBJ7dMZWmgs7oSmCaZnNwlEqPFIxo5R8+t4KI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmUrtir3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmUrtir3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4916C19423;
	Thu, 15 Jan 2026 15:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768490453;
	bh=1IPEhfIuLNwm0i05nT9ETMSk54stCMKIEwoga36jhG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmUrtir3+hVR4Mbud547emvQzHs+RYh7LX8xdBcT2SrKDVGqkZTAuU1EFqltZIXKl
	 9uAk6zpfvcfInlVcqJcJru8oasDn4gdYgO4G4oPAl8eBozA+j/SPwWxbLNygI7Vf/h
	 zuxaqG75HrkZXQg9ffN1bfOenK3Me7Ds6xfAfDYfDg0h9A1gPs8jO/wx8c678ninhQ
	 9ig1Q/z/IElFee9dHwqy7wiczstggxeEOTgHwW6sdT/Bl5LdW1U7KRiLIF8B4o1XVQ
	 YVR7JVEQxpfpQOa1jDdvFkb7l1bOePJgdXjwxStmmHabVHVz0HoCITr8ano4xV/vuv
	 MRLxIRCfMeqTQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/5] mm/damon/core: implement damon_kdamond_pid()
Date: Thu, 15 Jan 2026 07:20:41 -0800
Message-ID: <20260115152047.68415-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115152047.68415-1-sj@kernel.org>
References: <20260115152047.68415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'kdamond' and 'kdamond_lock' are directly being used by DAMON API
callers for getting the pid of the corresponding kdamond.  To discourage
invention of creative but complicated and erroneous new usages of the
fields that require careful synchronization, implement a new API
function that can simply be used without the manual synchronizations.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 26fb8e90dff6..5b7ea7082134 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -972,6 +972,7 @@ bool damon_initialized(void);
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 bool damon_is_running(struct damon_ctx *ctx);
+int damon_kdamond_pid(struct damon_ctx *ctx);
 
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 729a5f7fac94..81b998d32074 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1442,6 +1442,23 @@ bool damon_is_running(struct damon_ctx *ctx)
 	return running;
 }
 
+/**
+ * damon_kdamond_pid() - Return pid of a given DAMON context's worker thread.
+ * @ctx:	The DAMON context of the question.
+ *
+ * Return: pid if @ctx is running, negative error code otherwise.
+ */
+int damon_kdamond_pid(struct damon_ctx *ctx)
+{
+	int pid = -EINVAL;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond)
+		pid = ctx->kdamond->pid;
+	mutex_unlock(&ctx->kdamond_lock);
+	return pid;
+}
+
 /*
  * damon_call_handle_inactive_ctx() - handle DAMON call request that added to
  *				      an inactive context.
-- 
2.47.3

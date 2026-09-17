Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CEC58FD2A;
	Thu, 17 Sep 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654943; cv=none; b=QxULL7sk6IcvbS6BNImdr+vN2fnsCuOc611etni5gd0NQ0XNmHuP/6kMoy3+ZzUXpnbYYbtCVaknRmUYBr4NIiLopnfeAQgsbo6oODW2LwCSktdSu/Vjb3lIKHkgENf1lQbAAF6xtEuQGyuYSGOMRktDMKQdV/coAlCzJvD/fRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654943; c=relaxed/simple;
	bh=lKpqzybvZ9hwDEn5zppDbcOvdMRte/Qiq/Xarpxk8U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTQjUfNbNcAw9snPoU//s06i5KEfAqk5aySSnKzli3Wbg8cWL3gychdcPacrZ2o8XntCpK51jCz3asLkTi/C9UFaLXz6LQgWMED6gtfAOGuQzWU5fFYmNiA4Ot6KbrJgkcW844/azCLqOQA65k8pjCb11KER1GEpApUgu2S/h0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eomREd/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eomREd/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1026B1F0089C;
	Thu, 17 Sep 2026 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654940;
	bh=w6dSI4kuA6F6vgFBpIvecMt6EtgI2oZu6oc7TQA5lks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eomREd/jqdFfEgIBTkw87GKHW8I0aNQbEYgqPC+XhMuQfF2kvqLQHuoDRkVWKW8Um
	 h/kWbDGPyuzYBZ9C0uO7GVGW9GkEayqY6gWg8tx/KLP0ob8veYHtN+HgVlApO0Nt/8
	 pashGIOoSOk27LBlcMGTWhdXFRBKtPQoIGzHA19aJ3BcK86worHf/tRgXwAfjZoy+9
	 H+Lkytu5tfiU2+lMFJRsJ+SEDBGG8vVOUKTzOxEegmp4KRpGy03h5ob5Di7vvErmuO
	 rlRcia4W1GnwI5pHxpDwSEpNjcLXIY6tmJhMcCLGum7zrR+2OitqMapuYcDiQXwIyN
	 Qj4Qyt1OaS6Cw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/10] mm/damon/core: document damon_call()/damon_start() race hang issue
Date: Thu, 17 Sep 2026 07:22:03 -0700
Message-ID: <20260917142210.90829-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917142210.90829-1-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's suppose damon_start() and damon_call() are executed in parallel
for the same DAMON context.  Then, damon_call() could show
ctx->damon_calls_obsolete set while ctx->kdamond is unset.  If
damon_start() sets ctx->kdamond before damon_call() starts the
cancelling, damon_call() can indefinitely hang.  No DAMON API caller
does such parallel execution of damon_start() and damon_call(), so the
issue doesn't exist.  But who knows what will happen in future.  Add a
clarification comment for caution.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c63b09d4a2d0d..2258b72da7a78 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2258,6 +2258,9 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
  *
  * When this function is failed, the @ctx is guaranteed to be stopped.
  *
+ * This function should not be called in parallel to damon_start() for the
+ * @ctx.  In the case, this function could indefinitely hang.
+ *
  * Return: 0 on success, negative error code otherwise.
  */
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
-- 
2.47.3

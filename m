Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A2379EE7;
	Mon,  6 Jul 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346803; cv=none; b=uukN1A4gVOa7okI/eFzFoLf94nVfikrBIEr/7IA538OT4LHY7bn/pVAubScA7JXy1RRaLeF1Xq6+/cnSdBsyrt6QU4X7fsHHi3RlUjNa598dRlcurGtcxwTeENfH5ScJCwj/RdwRR+EwvWjzvRDiEJp4jKxrROMnU3zPCXC98wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346803; c=relaxed/simple;
	bh=hsps4kp0iyx9VZBNJp3v8TVLhzkGxP8sojUovOZB7wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMMg6yqTDDZwPut4tf8ryFYGf+y3YAmTvHaokzxNFRhDRs96C50fZ+0xaeHyfuznkLG174dEz70E6TwR7SMSeKCFeINM0Wu3Z2EpZ2rjLc8/Ar5qCIUOhLwjPChi5hu9xhYqTN8uwn/iB1oMCfzhowbqcCCZBVneIyIjXFtP5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fbo1+XSl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fbo1+XSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509A21F00A3F;
	Mon,  6 Jul 2026 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346801;
	bh=3RIw27JTOSTlyfe8cMjSamOtT4EJIBcA1pGfiTgLcPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fbo1+XSlqvsC5wNxcRGB7fJ2IrKeLMrUvwyQ8FxRGAQaJxhTdhbSiZ4IvfwsD0UJq
	 NiYqLiFDd0QTPt/zoqZVjxpKRjOW4e2vHEgGFdZ+CeBTjkovHvxxoJouBDpDDdRUbg
	 GjXojLnQgN9fLEoty12+REDB6Fs9WTbG7Xq2EDs3NChteU0uh+2WvjhUS11b8Pp0lo
	 8gyDnBeboZ6wAjz+i+jw1FDLyLr1Zal+Gp0JHF0rKJCspRGdAiW6vBy/IV1K2lHgeo
	 o92uxG24BWmsEn/YXEQXK5tiIkhSFx0aa7Wnyel/7qLv3bTtqHvFZR6UyZrkJ0LIdZ
	 mHsEB8GAEDBlQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/11] mm/damon/core: wait ctx stop in damon_call() before reruning an error
Date: Mon,  6 Jul 2026 07:06:24 -0700
Message-ID: <20260706140628.87414-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706140628.87414-1-sj@kernel.org>
References: <20260706140628.87414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_call() failure means the DAMON context started its termination.
The termination is asynchronously done in kdamond thread.  The caller's
error handling should handle the race, too.  It is complicated and easy
to make mistakes.

Update damon_call() to ensure the context is stopped in the case, by
waiting until the completion is confirmed.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 08510bf9b38da..390e00b3685ef 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2010,6 +2010,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
  * @ctx has succeeded.  Otherwise, this function could fall into an indefinite
  * wait.
  *
+ * When this function is failed, the @ctx is guaranteed to be stopped.
+ *
  * Return: 0 on success, negative error code otherwise.
  */
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
@@ -2022,7 +2024,7 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 	mutex_lock(&ctx->call_controls_lock);
 	if (ctx->call_controls_obsolete) {
 		mutex_unlock(&ctx->call_controls_lock);
-		return -ECANCELED;
+		goto canceled;
 	}
 	list_add_tail(&control->list, &ctx->call_controls);
 	mutex_unlock(&ctx->call_controls_lock);
@@ -2030,8 +2032,14 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 		return 0;
 	wait_for_completion(&control->completion);
 	if (control->canceled)
-		return -ECANCELED;
+		goto canceled;
 	return 0;
+
+canceled:
+	while (damon_is_running(ctx))
+		schedule_timeout_idle(msecs_to_jiffies(100));
+	return -ECANCELED;
+
 }
 
 /**
-- 
2.47.3

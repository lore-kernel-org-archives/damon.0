Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0548377EA1;
	Sat,  4 Jul 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188708; cv=none; b=e2DtKNPa6fMt69QcMqA1Ie7B31jW7RjCR4I+C7PTsfcQxD4VyvE1E1V58uCXcyF1bC2T2Cq+P12yfK6Hd9ChfJk89K7jySrdqGtZF51ysd+ev3EFZHRKbfFhmr5bFvbrMjjZX2YJEZue6eN6fTY5yJfzNtmvCLyIkRJh11m4RaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188708; c=relaxed/simple;
	bh=MZGgNvuaa8bxK4jfLWpJi/xU2bA74tA5j421W7vJv4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HR2N79F/4efjrtyc0AhBzd6q1BVOodn1GSHwMQUF001po0iOlM23nZ7AWmxOMl64XMAhPS4AAvJKwROxlEzC3UJFEfbw8KHgO+1X+AgejhUvSd24a5QjQa8G2lvMEJpWIyK5INafu/IdOpQYG2ARgQEEWWLqZVGvfvtUYXv9lo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/haOgJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/haOgJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B541F00A3A;
	Sat,  4 Jul 2026 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188707;
	bh=isbLDdt8/jxUzGPY4kLimLdStIBUZ8pOdQulONakjEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T/haOgJ/l3SlKVBE/gVy6f9J5cKDozc/xs37Jq2ygZ3Mz4EpluBsL3hj4PUWfL2bR
	 7y2yhvo4kMu0GxHhPL5G9n9vx8xEEssA24NKmDeMJLz71wIOrqhPNQSKMDLWI3fTps
	 VlKqmfxlfZ4yNjuoVthR3jrcNXPTjo8BC6eV8EZFlmYEphtBCqIA0Eeeil2rEb1zcL
	 WZfHCN3smoCfkiHiUYkSTyBcs18JInyhif/eCCxzG816SJo/7fr2/G2Kf8AQZQ8J5a
	 vG4K9h5ghicITtM4d863bsrWkMYjGnoFfIpnyHP1nPTfpfPJZUdiDSx1jdGiGPxrHD
	 Pc2qzjbXGfLlg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/11] mm/damon/core: stop ctx in damon_call() before reruning an error
Date: Sat,  4 Jul 2026 11:11:32 -0700
Message-ID: <20260704181135.132956-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704181135.132956-1-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_call() failure makes the DAMON context to stop if it was running.
The stop is asynchronously done in kdamond thread, though.  The caller's
error handling should handle the race, too.  It is complicated and easy
to make mistakes.

Update damon_call() to ensure the context is stopped in the case.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1a6c30ae91711..5f16d2e13ebf7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2009,6 +2009,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
  * @ctx has succeeded.  Otherwise, this function could fall into an indefinite
  * wait.
  *
+ * When this function is failed, the @ctx is guaranteed to be stopped.
+ *
  * Return: 0 on success, negative error code otherwise.
  */
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
@@ -2021,7 +2023,7 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 	mutex_lock(&ctx->call_controls_lock);
 	if (ctx->call_controls_obsolete) {
 		mutex_unlock(&ctx->call_controls_lock);
-		return -ECANCELED;
+		goto canceled;
 	}
 	list_add_tail(&control->list, &ctx->call_controls);
 	mutex_unlock(&ctx->call_controls_lock);
@@ -2029,8 +2031,13 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 		return 0;
 	wait_for_completion(&control->completion);
 	if (control->canceled)
-		return -ECANCELED;
+		goto canceled;
 	return 0;
+
+canceled:
+	__damon_stop(ctx);
+	return -ECANCELED;
+
 }
 
 /**
-- 
2.47.3

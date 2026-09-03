Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ECA2BEC3F;
	Thu,  3 Sep 2026 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397424; cv=none; b=ebe//plXEYNP6xxR+8p4aph3b881ZkI8FydiW7NJQOEZi9UBc+f1R++egX3A9I6uz5FOAZEJw47nxyxVr20bFcOUHwf8Oc6Gt+AmkpXJRRisj3ERG0PZ4d3lcF2051ki59+qop0gDBfdjlv8gyGYrZWAb8RHhPIhFjNxMvboscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397424; c=relaxed/simple;
	bh=Slv7pumsn2CC0X+FQYZYLR2zRF9nh++Owdrkmb+6U+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbGNm0EqWEBwSmxX5eiwx+EJv0OF+E45/WyIxcdzT7XRnKPoGAklToEDJArxX4kb1KSd+2rF0uLIc6shlMQXFDX1OYWZNCy6ciC7vXIqAAOV7mnPw+kwfhOQRb+m9EpONdgL1a/8xcRYr8LZIGwFQBUkbNIaA1eaK/yZ0uokAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn7Rv6iv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn7Rv6iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA3B1F00A3D;
	Thu,  3 Sep 2026 01:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397422;
	bh=HJD5ZHvDFQYZJci1lPr3K8KnFdwPjoFcLlwtAdnyK30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nn7Rv6ivC7Qq3N9Q2O4N+b11S4V40oQFQ1DMEUSOc/E3rrnbSK2u4VNh6NhBmDPbJ
	 10Ukb3Lr8fBfgKaWUKILYwqQM2xEtwj+SXDP67kxC8hzc3zbqD3/4VSn81ZZjJRLrZ
	 Cg8UWDcIFvnQvHzeDr3NRAxkhCur9GAkwDSf+jvuKvuI23a0nQ6M+4PCJDags8pRss
	 G2bG6mEdeZboujbyG+BAjbPvX/AlPm3V6ATtCQ0zhBLQ5lE/BJ6dT+D575csVvzD1w
	 JL2pDlVCrXMyWoHhdoCJCvucgWP4w0Q6jIhN/vArJy/0JN4Qult420Z7OgKRbdNpk8
	 jUH2cCJd61QaA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()
Date: Wed,  2 Sep 2026 18:03:31 -0700
Message-ID: <20260903010334.93622-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903010334.93622-1-sj@kernel.org>
References: <20260903010334.93622-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_ctx->call_controls_obsolete is used to disallow damon_call()
requests when the request cannot be served.  The field is unset and set
when the context execution is started and terminated, respectively.  The
intention is to allow damon_call() requests only while the context is
actively being executed.

damon_ctx constructor, damon_new_ctx() unsets the field, though.  As a
result, passing the damon_ctx parameter that never successfully
damon_start()-ed to damon_call() can indefinitely hang.  The callers
should ensure to avoid the case.  Such parameter validation is not
always simple.  Actually such bugs in DAMON_RECLAIM and DAMON_LRU_SORT
have been found and fixed [1].

Set the field in damon_new_ctx(), so that DAMON API callers can pass the
context parameter to damon_call() without the additional check.

[1] https://lore.kernel.org/20260803134646.16640-1-sj@kernel.org

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 03407cf7f9646..56ec6f616fa9a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -933,6 +933,7 @@ struct damon_ctx *damon_new_ctx(void)
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
 
+	ctx->call_controls_obsolete = true;
 	prandom_seed_state(&ctx->rnd_state, get_random_u64());
 
 	return ctx;
@@ -2196,10 +2197,6 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
  * synchronization.  The return value of the function will be saved in
  * &damon_call_control->return_code.
  *
- * Note that this function should be called only after damon_start() with the
- * @ctx has succeeded.  Otherwise, this function could fall into an indefinite
- * wait.
- *
  * When this function is failed, the @ctx is guaranteed to be stopped.
  *
  * Return: 0 on success, negative error code otherwise.
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7418A3BAD9B;
	Thu, 17 Sep 2026 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617948; cv=none; b=UIweDc/aOM+GvpBNt6NVlbbytbiE2wz9scIOV31wIDrrdu1miVgUUOjZnmrfFU3d0kr14Mzoy89+YsD7LO2bktX15kSR7MKMtUmhgpnZAUGFzU9Q2RDyja2m/RVrYeUyyTw1Ig3ycns+6twER8+AV1voAVISeKKSPtL9k47RdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617948; c=relaxed/simple;
	bh=zSd+wfrLNBdoTYpJpypQJCgPEGzNzXZPKdCdD38W3Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iicFoLxKKuQeBV8KiaooTec8KOQS2HwvXjR+q+UDFFztQ2f4TncvI+d8oXnaIiOqNs8M2ZdPoWQXgmdeodgoYdRijqIDhnfRqvOE9lX6TjlwzXuZN64MYyZGmprvYrsrRYVyTYg4SBCE1dnhLkOzz/rsWrNUw9AdMonXVrsQ5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDrMbsUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDrMbsUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85021F0089C;
	Thu, 17 Sep 2026 04:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617947;
	bh=l/c0lu/EMv2gJrvNjrzhKVo1VbWsy1nBw4kXQJeK/aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDrMbsUuGSlCcvJd9rnxO7G4W6iOoXII7+66r3nRFIkXd/bRucgQslBSCC1PW3Dxl
	 wKA7zhuIIx40uXKulHo5dV6Qx/2BETdZg6+aQi12rTbhw9z3a0xgRAp07jfbntSLsv
	 6JBZXBXEtnAmai9lEDrv9/Xn0jXBVn2DGEQ0qXdtSkimoiTpZEUr/2ZwdLkphSOLlb
	 EHKUaD+noVqV5mtcHwvNgg4dR3aBXMc3+dtqLjSQ91pNVmnoxeK7PbV+p0SpKGgPT8
	 CXRTYhgxh6eiLET0ux6wZtKNYhvId0107jWKDBUdP5iZk9Z5nmgAW4tBifsZ3RuVFG
	 T6vUi45ghfNHQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 05/10] mm/damon/core: document damon_call()/damon_start() race hang issue
Date: Wed, 16 Sep 2026 21:05:31 -0700
Message-ID: <20260917040537.107341-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917040537.107341-1-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
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
index 9120a1b707b24..4687b909d42c9 100644
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

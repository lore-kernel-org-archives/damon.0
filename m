Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889D3C3BEF;
	Sat, 12 Sep 2026 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243705; cv=none; b=A0K9hByTqBCsFOxDRD9kBSZodg4pxWI8TTrPYOV0qbIsUGT8qGDlq9uSCFesGserPSo/JsOBDc53P/V6PkPvZqWM3ZpyRAyZbmKXs2c9L7xDbTcX22PAUaLKF5pDTckFPC9OCjB/zSoKp1S8fLd5SRf4YpMXQ7qbUex+N5bYokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243705; c=relaxed/simple;
	bh=xTjfs5kUa7x/iCo3n2Za6YcXKxyTeh0P4akSN9qz+Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFP8h3i0+UdNqqRgppMGcsHl0mvnotvVhkx2YFa+ubD113C1FtHuPpKsYyi7BIuzbEMYjypw0lXQMEfRMGFtJ9db0fG1ZCYPcbjNIIgQUff3rDO8rD3OKsc2MZhSkwBcJI2Y9xhfsGgdolXXB80Gwo/fWQJzbh4iWU7UBZl2v88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K51/4QtD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K51/4QtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DAD1F000FF;
	Sat, 12 Sep 2026 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243704;
	bh=80o1zjbsa4JPAD6h+nen9K5vfO8rOszkn9G9ncWmsSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K51/4QtDTuI+oO9+RACODBQv8TubJPnAUtItpnPP6GukNKjppgbjKYWcNGcqCZ6Yv
	 9VfBdalwvsB4kFJWZBKs/UUqhIT+aZjDy0kmv/40J69p1gLXyWm5gbaBfMlckAx8YI
	 N94b7jc5WVLsE4xfBn+SxUHy/9umzdyJgEmzk4Vw5nKQWTmSngH2RPElybq3mYEQeB
	 bSCm9D7/YAZ0e8FWFxmnHoHadjjOe/ztB1tMiYmxpICjWbT0gy3zg/G3KOp5ujn9l4
	 mBnNmfl4qJnXOv3DurRcnPbke2PQj2sc3dFQbsgeAawxU0OB32Iex431JNchtNjMoT
	 ZYdg/avyDDm6w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/9] mm/damon/core: document damon_call()/damon_start() race hang issue
Date: Sat, 12 Sep 2026 13:08:06 -0700
Message-ID: <20260912200814.145612-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912200814.145612-1-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's suppose damon_start() and damon_call() are executed in parallel
for the same DAMON context.  Then, damon_call() could show
ctx->damon_calls_obsolte set while ctx->kdamond is unset.  If
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
index dd27068cb83e3..080355b1f2d9f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2251,6 +2251,9 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
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

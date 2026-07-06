Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739E2BEC5F;
	Mon,  6 Jul 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346801; cv=none; b=J0xLcD7LpMYJgLjeGbCsdpPPazmBjEw191AEOwI+B5LDHcqdsp/RqoKitTvD33q7XJLpfyLGEgXXaspR/KkfsRTylEPc8wEFOygHHZDT0VuD88rc+ZawMYLbEIpfKoDydrz+2PbSZoSd9mfSxmd4FTR5NVRJcOr1RD33McUwXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346801; c=relaxed/simple;
	bh=7MyDB54GgGpdj+548nBYq+PEwE+ZWGPggaI0TD+l2Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdd0OOuKJMZCrjV8mW2diiI4GR0uknYrUgbOIPjFhm6X7lFwlTL3ERHLNlEDzsiyILfcIju+bgar2yNjP6YdHznNTkL22hfCth3H1o8p92C4LTdBHDpamwy/WweDy8lFu1kxEEdiMYsO4WNYohzybcAZR7LzwHefH/LUKMW6Pds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz1H3HQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz1H3HQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF4C1F00A3D;
	Mon,  6 Jul 2026 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346799;
	bh=r0kxycSRSEvbxy9pEgGpchLNtgv4/AHk+YSOYT0eb7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fz1H3HQh41ydM7hKyfjO1GXX+uKXdfQN2MNoCHhwxMU9GXYjTFwt7jL1Xn6FCrXi7
	 frNYTuzBC1Dy9pxuI79H92f4yBdSUzhM3QCNHpB5Sk/ZsO2mM8bbkQflO4AaUOMBmi
	 SKHFL4ib+Bp5R58zMqb2UMQ5qyORWolnSn+m2a0B10nTHqf4TTAX9eSqGy0Zoe5q6q
	 44444yDwo/I5+JKR4Y7ea5niffZ7XrPqgl5d0qL4Sfb2kzb1htXFD72mqHL1xMuVAy
	 4ubJjqmF01wlADyLN5Ol12f5gHQPlOiwHELMplVtOyYZHHTWMJKbzeoM5ddOabOofy
	 9iNI4Zf64A42Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/11] mm/damon/core: make damon_stop() never fails
Date: Mon,  6 Jul 2026 07:06:18 -0700
Message-ID: <20260706140628.87414-4-sj@kernel.org>
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

damon_stop() has no reason to fail.  It returns an error code only for
possible future changes that can make it fail.  Such a change has not
been made yet, and this only makes the error handling complicated and
confusing.  Ensure it returns no error.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d89a7f2faf350..84e400aa4e823 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1926,10 +1926,8 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 /*
  * __damon_stop() - Stops monitoring of a given context.
  * @ctx:	monitoring context
- *
- * Return: 0 on success, negative error code otherwise.
  */
-static int __damon_stop(struct damon_ctx *ctx)
+static void __damon_stop(struct damon_ctx *ctx)
 {
 	struct task_struct *tsk;
 
@@ -1939,31 +1937,24 @@ static int __damon_stop(struct damon_ctx *ctx)
 		get_task_struct(tsk);
 		mutex_unlock(&ctx->kdamond_lock);
 		kthread_stop_put(tsk);
-		return 0;
+		return;
 	}
 	mutex_unlock(&ctx->kdamond_lock);
-
-	return -EPERM;
 }
 
 /**
  * damon_stop() - Stops the monitorings for a given group of contexts.
  * @ctxs:	an array of the pointers for contexts to stop monitoring
  * @nr_ctxs:	size of @ctxs
- *
- * Return: 0 on success, negative error code otherwise.
  */
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 {
-	int i, err = 0;
+	int i;
 
-	for (i = 0; i < nr_ctxs; i++) {
+	for (i = 0; i < nr_ctxs; i++)
 		/* nr_running_ctxs is decremented in kdamond_fn */
-		err = __damon_stop(ctxs[i]);
-		if (err)
-			break;
-	}
-	return err;
+		__damon_stop(ctxs[i]);
+	return 0;
 }
 
 /**
-- 
2.47.3

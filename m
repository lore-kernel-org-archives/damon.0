Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7F230BD9;
	Sun,  5 Jul 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267314; cv=none; b=itVUqyzi5aPnWnjtnyH5dNfx9hGtliPvem3I9CGXXM4IwDi8KFoVrLjS+GNAvnQ0Z6XwdbVQJJ2ZGm1SSUAttJkzR5I4LGVMMTckWLCzjOEHfm5A3h6OUpRgSuaPYAl7BPzM9Mm25gNEmTfSigQcADGAoRVFrI0mS9IekkvF1t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267314; c=relaxed/simple;
	bh=7MyDB54GgGpdj+548nBYq+PEwE+ZWGPggaI0TD+l2Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3i6TibOz7lMfBKNGMm8V8fSiWbQKI978TA0OFgXZhmfur4DnprMyREOF8Hwcimn4AhsZvSBg+J73EsR4F7UIizPZRmag0DL9jmQAY9ekSoCC+pj4wYFTnh/Eurg/eRAhavaI4MK10AckVVv49kL0OTcwFthnU7wyr1sqiuIaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vrfb3/eS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vrfb3/eS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40F11F00A3F;
	Sun,  5 Jul 2026 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267313;
	bh=r0kxycSRSEvbxy9pEgGpchLNtgv4/AHk+YSOYT0eb7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vrfb3/eS3oTXaSESOFoXF2cvTgmNRmWdXTl44HgQ6d5akAmtgV80fNkhnD0UXaE18
	 lKls7LK4EcG1GPDF1h7BS9myKgqIw5JIhRvY03V6x6PERU6bfvThcS4B/L2lPWVXrh
	 +G2suOdU+4yoPIT0rZHGtS/3bi0r3NZ//OYWZl7rNeTpSQKmUDo2ajIzpN+xuzIsll
	 Qys4sPtOrpKD9YwRC8gCEEpI0WCvrIn1f7h/1qnfnuq10gaPvKLSirHcUq3q6KE7/j
	 gYrXOEFmDsQ2Zek+gDPo52IVyVnDqBRIwe9f+w2AoRMt+c7J/sQ5hDJWBEGw/x1mZH
	 F6h4SSt589bGA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 03/11] mm/damon/core: make damon_stop() never fails
Date: Sun,  5 Jul 2026 09:01:30 -0700
Message-ID: <20260705160142.97308-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705160142.97308-1-sj@kernel.org>
References: <20260705160142.97308-1-sj@kernel.org>
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

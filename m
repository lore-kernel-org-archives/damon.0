Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC5373BF4;
	Sat,  4 Jul 2026 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188706; cv=none; b=ETHl8xOu9uqN1LLQFPSMOUEQ2wd/JfKXo5TqIGuUe5F0PoiF2EEuAbXQXQZifmEVmWJez/ZxbSWzvEVTgTk/3jMDi2IAL3rIt79wKMWbsGjBSRxZTvwwLq8CUCG9zKDbiT6pRBRUQrTIhYT8ke/fJu/uUrL7nd46LN2JOKmQMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188706; c=relaxed/simple;
	bh=TIkQy7N8bL6SyQuE3dGXOHv2Q7SDqoA/rTDaotYIq24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8nb5eqIzrp7xfv4XA3VTXW7VQP0kf+vcAk9IVs2mzUgplB+MCtKCxguBBttnj9jo5cylZyslpHsHAVzyL/dThyLDruZ/TywPugZZByKt6His52EgUl2CUirtIwcEEJtWlUdcGn9G9H9WCz2i+KXXuQFyyy4OMQwG3JhQC6+5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duHAJKZl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duHAJKZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A641F00A3A;
	Sat,  4 Jul 2026 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188705;
	bh=TjebM2OgtNiNXvN1yKT2/Mbtr9u3LW+BP8Dj45hR6WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=duHAJKZlRh8gkpSHxn0maVrPXBXWSPe79zTVdhM7vaWgBlJD9LagcfE4p9BIz4lRj
	 KH0QOm4JOlbtBSUrsIvGIF6ItBYdoFgJ4ynnzpwFPkMlvv/Hte9FpY7/YILYIh6Yo/
	 S5zLPjKOIeghHHIUcgKQlWDXUqHiFMZctYls4xdc/1JX6CNdiJ0lF0Zdg4FPAA5hnr
	 4SJ0Mtu6nDovF8gADoKe5OXTirSL6oF92PRXqRsYEKRac1BkvEOyehBLPyomZAaN3U
	 lmMbcPPQnjYu/BIAkaUvEfF3IfEsD/594oCc0U+ZQdV4Hg0VXZrE6ZO2snpkPr+zo+
	 EBilMIBxxosNQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/11] mm/damon/core: make damon_stop() never fails
Date: Sat,  4 Jul 2026 11:11:26 -0700
Message-ID: <20260704181135.132956-4-sj@kernel.org>
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

damon_stop() has no reason to fail.  It returns an error code only for
possible future changes that can make it fail.  Such a change has not
been made yet, and this only makes the error handling complicated and
confusing.  Ensure it returns no error.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 16d9223c33a72..ef40aa44850ff 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1925,10 +1925,8 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
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
 
@@ -1938,31 +1936,24 @@ static int __damon_stop(struct damon_ctx *ctx)
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

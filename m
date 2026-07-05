Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5B2773F0;
	Sun,  5 Jul 2026 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267315; cv=none; b=UXoIoHuob8bdsav6+ZxJpFc96N1M5fTowQgnAm/iDZM/+MIfJUpbnp0+0ST3fYKtB6BgpGnLyA0ERek6M/UgkI+gr/ZJIgGZA7fsxuWgdPd6Rlb73QzN6mIrcov+p4AsHzoVz83cL+sRZodZDaJHVbKctrxQwhpTWIAurzXy9lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267315; c=relaxed/simple;
	bh=qA7aEmWvsXlBb5CZ0t0+ivvSN/TApACptnrIMsBXxj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOugKlfzA8bP/Tx+iEtxMHfLja7JFYQbPSJVOFfBKE/DzI5n8vQKlevJ7B0iq88fX369O+PA4tyfqn9/OV0PKClItsXudslc9ouTInYm3RXwCwvr/lBGkVLxPMdtZBLl9tcy6IsWAAaw9E6cYcJrcgkhz9PjhOQLP3yzW/Tv5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSIXgO6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSIXgO6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4131F00ACA;
	Sun,  5 Jul 2026 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267314;
	bh=h+1wlgb4/vhq8hic6IHVay1RAoaGPrWWDyvHtZVfeMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eSIXgO6Y39Jn3yR6Y83ITTi34aztQHPintIirt4pPS/K8UusGSbAGwLRqq2nXXiZv
	 KNToG+R5NR2v4tu+Hk2nDZF4kcL+MiopcqTNx9d1JxORowFWmPFO/tAZGvk0k52lP6
	 C0rTf4Sf9jN1RwfUaCxBnFu3Uoeq/DZwaK5kgMvDTs8oq9Gjg+LU23WrtuXhHn6Rzl
	 rgk3Mjrpp/Y7jgTI8V52UzyzoaLtaVZe86VEhQV8/+CYNHGp1QvYs6jxosj3zxtaHo
	 Hz8GyXpoDet0mPXcIMaYvqtuNDNMl4ruAbSpDkwk3sjopnz0B5jAidTGvJeMndamGe
	 f1tOVzfCIyBXQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 07/11] mm/damon/core: change damon_stop() return type to void
Date: Sun,  5 Jul 2026 09:01:34 -0700
Message-ID: <20260705160142.97308-8-sj@kernel.org>
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

damon_stop() always returns 0, and nobody cares.  Change the return type
to void.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 +-
 mm/damon/core.c       | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2661231c0ae82..19b7e839bde0b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1070,7 +1070,7 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 
 bool damon_initialized(void);
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
-int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
+void damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 bool damon_is_running(struct damon_ctx *ctx);
 int damon_kdamond_pid(struct damon_ctx *ctx);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 84e400aa4e823..08510bf9b38da 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1947,14 +1947,13 @@ static void __damon_stop(struct damon_ctx *ctx)
  * @ctxs:	an array of the pointers for contexts to stop monitoring
  * @nr_ctxs:	size of @ctxs
  */
-int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
+void damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 {
 	int i;
 
 	for (i = 0; i < nr_ctxs; i++)
 		/* nr_running_ctxs is decremented in kdamond_fn */
 		__damon_stop(ctxs[i]);
-	return 0;
 }
 
 /**
-- 
2.47.3

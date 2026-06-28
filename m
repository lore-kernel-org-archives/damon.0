Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7430DD2F;
	Sun, 28 Jun 2026 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684499; cv=none; b=Lj40A3MJGscBIhboRbwx0184nk2vUQr9BYclKOLEsJ8srbQk4SXXdaPudIbwp9iBn2QbeVB2eU63VR9sbdR1pyyIwtiyzfnO2zgIOwweBwwgf778Z73i9oujdytXsKM6p7qlxk41uQek/tI36acTyxkKu28E+FFPZFImdUSDDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684499; c=relaxed/simple;
	bh=9YU/SX0zRqtq6Zo1zhTEVOUGKxptIRrqWASfMKOkyP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsqnOU/RMSb5Ar6aLlo4L+ZeAOUP1Pc905+BtRPJO7dIyDYY32YGelCrLsvEUTQTK2UnwLPHSf97P1101OdPzDA+ISVq268TnyAMxEtTRRLNGq0RyiqBiIYkiQwgS3fWijYxnr20DzJp8Z9hmekqzZCS6eBhhu/+O88sstzUyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A0C1F00A3E;
	Sun, 28 Jun 2026 22:08:18 +0000 (UTC)
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/2] mm/damon: add a kernel-doc comment for damon_ctx->rnd_state
Date: Sun, 28 Jun 2026 15:08:04 -0700
Message-ID: <20260628220808.98931-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628220808.98931-1-sj@kernel.org>
References: <20260628220808.98931-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix below kernel document build warning:

    WARNING: ../include/linux/damon.h:909 struct member 'rnd_state' not described in 'damon_ctx'

Fixes: 9012c4e647df ("mm/damon: replace damon_rand() with a per-ctx lockless PRNG")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/4df95955-b255-4e5a-90c4-35db02f3111f@infradead.org
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 535f675625724..cfbbf8ba28f63 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -847,6 +847,7 @@ struct damon_attrs {
  * @pause:	Pause kdamond main loop.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
+ * @rnd_state:	Per-ctx PRNG state for damon_rand().
  */
 struct damon_ctx {
 	struct damon_attrs attrs;
@@ -904,7 +905,6 @@ struct damon_ctx {
 	struct list_head adaptive_targets;
 	struct list_head schemes;
 
-	/* Per-ctx PRNG state for damon_rand(); kdamond is the sole consumer. */
 	struct rnd_state rnd_state;
 };
 
-- 
2.47.3

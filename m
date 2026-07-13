Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1EB431E5F;
	Mon, 13 Jul 2026 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951129; cv=none; b=KhyznhK7UxDEch8eISFZEjFqGwGRxNRk1qKntwzco13w92FBTYCLvj+kOTgQBH3VUnPNmJSfbMKguFKLzgGhE8Uv8NTJdR7O7mfBO4i2DVX0RW3g1UXnsBbJmYkAJzudSJJ/3SqEpvuWqGRAEKoK/tDOTs2266/lCbuHYLiDN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951129; c=relaxed/simple;
	bh=nt1m4yOHpUkfhmuPI5sfQNBML1ejUt2LDcM7VHyWuzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WISEKQAFmxbI1oJiX4jTDQ1fwLkmWcZOw1uD0PiaLut1dMZWRjCdif4RvXC2IEpztZcEVKpcdCwHtqCEQwO2alp2JKyyU1nXIr6Vqqlf5Yc6PdOAiUHUNIP2nkPu0s8K5ZxdbifU5CuLbGozMe9uOHyQfiZwu7URIVw+9yBeMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euZHtD/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euZHtD/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A566E1F00AC4;
	Mon, 13 Jul 2026 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951127;
	bh=hhmDCI+ot7IL3VsT3pLzYBJmbk4njLZd345nGTc/fNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=euZHtD/aDvIZBDQjpyKLp0lEEVw3YHagyScpG6RM09WNsMcQ/ypT/C9GcVouODud+
	 8p5nPr2a84cQB1FrIzkdjnfj1SNgF6FfBFCRN/6/DUUCJcZqg06eeKx0pgLwhVFsAr
	 dXkjFMa3AYDXtLwtk0Ryh6Dvfw1KtBQcIzXUiEedRoAInwPVDYv+U+bsyRJUbX2rzc
	 t4aIw4thGprKvXHV/Wz+NL9338m7P/vHz7Q9nFG2eVUctNjPMVqjMkKvAbsp8aPn1a
	 93oyYPQkCN2QrwjSBR6/heoQ+mS1s0LprpOUeKW4L/tqjCvl731WSr0tEXZHCww9ju
	 METmJcFrUwk5g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 5/5] mm/damon/sysfs: read ops_id only once
Date: Mon, 13 Jul 2026 06:58:36 -0700
Message-ID: <20260713135838.32730-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713135838.32730-1-sj@kernel.org>
References: <20260713135838.32730-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_apply_inputs() reads ops_id twice.  It could race with
ops_id_store().  As a result, the min_region_sz could wrongly be set up.
Read it once.

The user impact is trivial.  Sane users ain't update the parameter in
parallel.  Even if it happens, only monitoring itself runs differently
than expected.  No critical consequences like kernel panic or memory
corruption happen.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260703172417.95426-1-sj@kernel.org

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b5fe036f78015..60a1a9e4ada34 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2094,14 +2094,16 @@ static inline bool damon_sysfs_kdamond_running(
 static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 		struct damon_sysfs_context *sys_ctx)
 {
+	enum damon_ops_id ops_id;
 	int err;
 
-	err = damon_select_ops(ctx, sys_ctx->ops_id);
+	ops_id = READ_ONCE(sys_ctx->ops_id);
+	err = damon_select_ops(ctx, ops_id);
 	if (err)
 		return err;
 	ctx->addr_unit = sys_ctx->addr_unit;
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
-	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
+	if (ops_id == DAMON_OPS_PADDR)
 		ctx->min_region_sz = max(
 				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
 	ctx->pause = sys_ctx->pause;
-- 
2.47.3

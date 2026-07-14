Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637347AF65;
	Tue, 14 Jul 2026 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037163; cv=none; b=JBHb7+2smFW53LxwW0Wl/+EY3boIiHA7zIL22dYsy1iENVaYUlP2uOiWP/jy1KpQkmtyEwSmrVk7UR7j3T5Jd0jr/e577ffKWTUnqz/4hEy7A3+HmC+VkATtU/gVNeuiESu3AnSM2v1LIgwFhdtPf2kETTsG1JASQHoMj4pjfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037163; c=relaxed/simple;
	bh=nt1m4yOHpUkfhmuPI5sfQNBML1ejUt2LDcM7VHyWuzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qISd9r+J7m2jx+cWyx95SVgNnxeFErvMreP/8QKee1n1UG4h+1oIFHxl3ruV8zcJZwklZKRiYP2IuUlnMvTeMdqJCBC6+ISzdRziFyeuIQtb19GfqI0DD+OnmWHLtIphzOsDeBJNTNlciX3d1wu6BbGW1tugesgwaDRXTxKRtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0KLQDgD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0KLQDgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374B31F00A3F;
	Tue, 14 Jul 2026 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037162;
	bh=hhmDCI+ot7IL3VsT3pLzYBJmbk4njLZd345nGTc/fNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d0KLQDgDpLeerstVYPZQr9U6UvUxQHOZeA3gGp96M0sHUHYIQvTLsOQu8j9ZkZjOD
	 Lovnt/dNpVbutyl7O51WD5VJYBEOgKrYFJjtMEoncELZe33ehRqbD+sSZiWgKYb4m2
	 wP5jZhnfLWN9umI+1wMHvD58d0IzCHJfg9r+nPLg2wTwZrhkecb7VwubPiq22IzErr
	 YAjwXNS1SmHclM456MNnuIKt8whSfSxja5+wfsMKqTzdQ6vqfb+pxXQ7/MXaNzlIOT
	 MUZUt7TAAI3Yos/2cya6zodYFjT0hf0O8Hr8wPKBDsmv9Q6RL6Q1YygDFB+cld3LSr
	 XAASuxfuqLPhg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/5] mm/damon/sysfs: read ops_id only once
Date: Tue, 14 Jul 2026 06:52:33 -0700
Message-ID: <20260714135236.92699-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714135236.92699-1-sj@kernel.org>
References: <20260714135236.92699-1-sj@kernel.org>
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

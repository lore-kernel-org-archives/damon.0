Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF915908C7;
	Thu, 17 Sep 2026 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654942; cv=none; b=Q1ka/pYhy1H3vWgg/dQbREnhiGhK8mNuhdSdnTH5V6IZVDBHIsFEZOsUuukmw/7+V63L6mmGk2Bcs+nX/NTNWMOrRdEoNW52URzMIVLa20MOYDYpiuQg5kxIvE5uQ4id/rjTDvsFYlfUpff5LJz3uScW6h+Xtw9axfj5tz7HutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654942; c=relaxed/simple;
	bh=7h/1R3QiQV2pJkqca3P/M/CALq4cAaHBIyysfS+QMZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6/JWn8PPBckmxOaWpMzZPRvwp+udX2+AlmjDzOnY6llx5EWQEj3QpJoC72VhnC0pyC9Gz+ZFGnPCYYKe0gZYAnT7evqNu9r0lDNRGeOHjKYpuAL3YX6jLiA1CGhgUvbYmZEO9KbYoNnNWlV1qzo/06IA7j8WQ+3wpez0JVySYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1hpqEWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1hpqEWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B693E1F00893;
	Thu, 17 Sep 2026 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654939;
	bh=WNxPb3XuWgcy0/vqXG1EDhrYQFj1MOLwj/rJkugHFUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1hpqEWpn31KrLILxhWCBo/lIaLA/WzcB+GWEsWclJ9eaByXVTLpKXFT79jsgU5Vy
	 vj+P4VWwlw1yYKdttn0iOBhl47oTAediQNbl5XUIxvn6kcCm4omfJpKLui6JnluBmq
	 zuX7tX2Y8+odZgbyYkyOW2klETk7FhwZo8NbUznZoTLpWGmKAJyHpoh7urajPDp9X8
	 H4jREz1CUgFL49RuCCfPhJFVxw5Dj3ExhIy10ccs3NXECT2QkgCpNUR5atvq2C4G0k
	 WCHfA1BjXVwXg8Um5F97DSGMmRktGhos4QiSk5djObLvCdyA10vL6+ZeNr6Rg2MLcu
	 an3F3bitdNnqg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/10] mm/damon/core: set damon_ctx->walk_control_obsolete in damon_new_ctx()
Date: Thu, 17 Sep 2026 07:22:02 -0700
Message-ID: <20260917142210.90829-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917142210.90829-1-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_walk() should be called for a damon_ctx context that has
successfully started at least once.  That's because
damon_ctx->walk_control_obsolete is initialized when kdamond starts.  If
the rule is violated, an indefinite wait can happen.  There is no
existing violation of the rule.

damon_call() had a similar rule, and it turned out keeping the rule is
not easy for damon_call()'s case.  Hence, commit 8023b5f47e09
("mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()")
added the initialization in damon_new_ctx() and removed the rule.

Keeping the rule for damos_walk() is relatively easier.  But having
slightly different rules for similar functions could be confusing.
Sashiko, for example, repeatedly asked questions about this.  Do the
initialization of walk_control_obsolete in damon_new_ctx() for
consistency.

[1] https://lore.kernel.org/20260915011614.102342-1-sj@kernel.org

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bc41ac7ecca43..c63b09d4a2d0d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -939,6 +939,7 @@ struct damon_ctx *damon_new_ctx(void)
 	INIT_LIST_HEAD(&ctx->schemes);
 
 	ctx->call_controls_obsolete = true;
+	ctx->walk_control_obsolete = true;
 	prandom_seed_state(&ctx->rnd_state, get_random_u64());
 
 	return ctx;
@@ -2308,10 +2309,6 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
  * passed at least one &damos->apply_interval_us, kdamond marks the request as
  * completed so that damos_walk() can wakeup and return.
  *
- * Note that this function should be called only after damon_start() with the
- * @ctx has succeeded.  Otherwise, this function could fall into an indefinite
- * wait.
- *
  * Return: 0 on success, negative error code otherwise.
  */
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
-- 
2.47.3

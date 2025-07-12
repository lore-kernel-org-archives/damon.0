Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A24295D96;
	Sat, 12 Jul 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349830; cv=none; b=aC8SvnUy/1QH2FVqkqD3uceMkYVWQjiRbinM0uVGm65U7keTT9w4/zNUqQa2cPErTeE9oDWm2oz7Xw1TFQq6hh7Vkv8+osIVQIJWkyGenwrayiFaOHEOcjE/WnSBnXBVE+VDidcAQb2aWquFL19t2FreCfvAtVYaypugzla6uSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349830; c=relaxed/simple;
	bh=WnNs9PvTSxpuHsXeKNYiQH21hri+QkB7YdUTcuWeAPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j96cfvylEWz8VJvfMCAEHSRhf+qjuYChVrqLVeZ5FPfmoYW0oXkUP4qVIFMkp2y/nGYlGNmf5PTcYd8/JDVOHOM688YNZA8GP8MUdd3xlJeEaYrhdsonHLZiNptVvWYLeuHG1x0wUSFrt0tJ5zkJB6m63bqP3NiUemgqujgXQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws49IYGo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws49IYGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE51EC4CEF1;
	Sat, 12 Jul 2025 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349829;
	bh=WnNs9PvTSxpuHsXeKNYiQH21hri+QkB7YdUTcuWeAPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ws49IYGooENIMBShzHJS2qwqqhXkR7Zuz+BYP6ebuoiAlWZok6MczK6dDFt4tZLYS
	 Y6U4IgrFCbB2vTEUk6NaY0ePC6vQYJ34XmLTvTqiMCOqvYewtNjc0+tPLs4YU5gwOR
	 E9cmJgucjSpKYHiRfWK6fwK5r3ACw4p4Z4MNHNgJRMfSya/gf2iX3BL4bYvWQ49j8p
	 woppfYoiQ3NGrRRZNE8D/FzxoKGpiLBTQNtu5pLdw2Q+pEG12y4wnhPbzEdrTRWxS3
	 wuWHNvhPK2iY6JLGT5O3+sae63zLkrnRoKc10gNlqmn/qIj732q6KXxPnCrj7b1B5V
	 utIrRfUt1N4gw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/14] mm/damon/core: do not call ops.cleanup() when destroying targets
Date: Sat, 12 Jul 2025 12:50:10 -0700
Message-Id: <20250712195016.151108-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712195016.151108-1-sj@kernel.org>
References: <20250712195016.151108-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_operations.cleanup() is documented to be called for kdamond
termination, but also being called for targets destruction, which is
done for any damon_ctx destruction.  Nobody is using the callback for
now, though.  Remove the cleanup() call under the destruction.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ffb87497dbb5..b82a838b5a0e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -550,11 +550,6 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next_t;
 
-	if (ctx->ops.cleanup) {
-		ctx->ops.cleanup(ctx);
-		return;
-	}
-
 	damon_for_each_target_safe(t, next_t, ctx)
 		damon_destroy_target(t);
 }
-- 
2.39.5

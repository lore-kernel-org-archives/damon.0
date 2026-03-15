Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C626B77D;
	Sun, 15 Mar 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608423; cv=none; b=JLdzhsQJ4TOm4YeGBSyBFJt4b7sYs498LmUUkuDrlg9JkFfeFpEqlHfnbQx0IfGByOvfWh+5syGw6buIMlkDE2ADHiAPXYs8kNlnmU0d7VILZLJVlcI2OtKMJeiWHekB63Y7x8HQ9ug8CUqcHWLsL1VPSvp1Fiy4TTchVH3qmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608423; c=relaxed/simple;
	bh=2Ts0pyl+UtHEQzIBfWhdhwzgiRHuVs9/Q4ZdnI3FxRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfJ7gGxjcKcMeMp5rHqxMHyEYnXDk18hsqAPk+iqzFLpFd3IUlTk/iGBBEgstab05F25Ozcb/qE6fDJKvWhownx0PYLSNUe5980KjJUFIdDD7g9Xq/Z90U/J5FJCENYOZdclE2rp7whi6LxSksPcQKheUz8ver54oZQf+/Ufsrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm6ND14r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm6ND14r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A70CC4AF09;
	Sun, 15 Mar 2026 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773608423;
	bh=2Ts0pyl+UtHEQzIBfWhdhwzgiRHuVs9/Q4ZdnI3FxRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bm6ND14rLgcPbSPnIIoteONEB6bgXcEmZWVRki0Fr3DRoi+IawOvHV/KpB7D5im1z
	 cbvWVc6vKg3+VkJTeIOlnwajo5AswOqle86S3bWlA073eaObXa4QMUVNQ5fldt/v96
	 0W0usSu8lBcELqlDL4RaPsECX81dLcFoWR5hKupviomobU7nbTco2Aoc2jKMIAkIeR
	 uwJfFBeeX5xR54/K1NGrBxmcT+mlCHoLJKsW+xaBPePBhRr7yNHN70SJfh4P/6WiJe
	 K6MxH1qZ5uM9wol+C08tP22+tI2FekDQhbrD911j3W8Cupkvqf8Bh3M1gRErsiOzVs
	 70tSmCtxdqfBA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Sun, 15 Mar 2026 14:00:00 -0700
Message-ID: <20260315210012.94846-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-1-sj@kernel.org>
References: <20260315210012.94846-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON supports only start and stop of the execution.  When it is
stopped, its internal data that it self-trained goes away.  It will be
useful if the execution can be paused and resumed with the previous
self-trained data.

Introduce per-context API parameter, 'paused', for the purpose.  The
parameter can be set and unset while DAMON is running and paused, using
the online parameters commit helper functions (damon_commit_ctx() and
damon_call()).  Once 'paused' is set, the kdamond_fn() main loop does
only limited works with sampling interval sleep during the works.  The
limited works include the handling of the online parameters update, so
that users can unset the 'pause' and resume the execution when they
want.  It also keep checking DAMON stop conditions and handling of it,
so that DAMON can be stopped while paused if needed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3a441fbca170d..421e51eff3bd2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -811,6 +811,8 @@ struct damon_ctx {
 	 * intervals tuning
 	 */
 	unsigned long next_intervals_tune_sis;
+	/* pause kdamond main loop */
+	bool pause;
 	/* for waiting until the execution of the kdamond_fn is started */
 	struct completion kdamond_started;
 	/* for scheme quotas prioritization */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index f9854aedc42d1..1e9f6aa569fd2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1331,6 +1331,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 		if (err)
 			return err;
 	}
+	dst->pause = src->pause;
 	dst->ops = src->ops;
 	dst->addr_unit = src->addr_unit;
 	dst->min_region_sz = src->min_region_sz;
@@ -2978,6 +2979,13 @@ static int kdamond_fn(void *data)
 		 * kdamond_merge_regions() if possible, to reduce overhead
 		 */
 		kdamond_call(ctx, false);
+		while (ctx->pause) {
+			if (kdamond_need_stop(ctx))
+				goto done;
+			kdamond_usleep(ctx->attrs.sample_interval);
+			/* allow caller unset pause via damon_call() */
+			kdamond_call(ctx, false);
+		}
 		if (!list_empty(&ctx->schemes))
 			kdamond_apply_schemes(ctx);
 		else
-- 
2.47.3

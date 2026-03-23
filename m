Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7778381AE2;
	Mon, 23 Mar 2026 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307743; cv=none; b=Tvu051IIHPyezemRHgpY552YThN4o9umq+cHu1DT1eypL7c8gVjQgkQ270/zgvYDj6eNyEaH3kIVZkYcVtDft653aLCgQNaWk7X9XEoQenig+L+NPw7uQDWwlgPfsZBTERff7iYEKC17pevqyBbqyM16nWzVMSGWUPkNBPxfHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307743; c=relaxed/simple;
	bh=R+OyX+2+xXzYOPMk7hH5cT/Fo0kVRBRvE8hVSDn6Zoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzXLA3e/EcYTiAKWqPYq+kfCLiQ1W2f+hM/oGXjtX06ifqTu36rgKppDHEwBRMYngjrKnFUsn048hcfaUs1U5P0fPH9o+bT34ziVfTqOOktz22VMplGsmdQ/hLDhQD+aGut75D65u5YqhcGj0xSbAVC9D1jjlBXNo/adY7eVouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCv48XIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCv48XIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3770C2BCB4;
	Mon, 23 Mar 2026 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774307742;
	bh=R+OyX+2+xXzYOPMk7hH5cT/Fo0kVRBRvE8hVSDn6Zoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCv48XIwG2VlpoTnqISMydw2TQW4JBJcbUbw+yjZ4YTzn8104rOdhJHZhNTAcj1+q
	 j/LiMTkFRVcSeEv9EdxiNdCUTQmpJgxxWHyz26hkzY+ZeoEd0IqBp7ddKtGuW5N4tS
	 BhHlj69mZp0t/YaRMHikJFeUTcMBSTjBhNl6eJlYtafVwas4ARPOr7E0ghwUjlW7Mc
	 QREBRETQAe2S92uvisW9m7M2RFUoEIqBYOj0AnVb92NRZ7yx6I6fTPlIf+4f1oARIX
	 8v7sU19F9gup3RsNgg3LFT4Zylaq+ztdvOxKFqyyBCdeaJrKMZwfcNgnLUWs9alNoB
	 +4QCmXgXaNEcA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Mon, 23 Mar 2026 16:15:26 -0700
Message-ID: <20260323231538.84452-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231538.84452-1-sj@kernel.org>
References: <20260323231538.84452-1-sj@kernel.org>
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
 mm/damon/core.c       | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 04c8a052fcfbe..65c8d5ef510fe 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -787,6 +787,7 @@ struct damon_attrs {
  * @ops:	Set of monitoring operations for given use cases.
  * @addr_unit:	Scale factor for core to ops address conversion.
  * @min_region_sz:	Minimum region size.
+ * @pause:	Pause kdamond main loop.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
@@ -838,6 +839,7 @@ struct damon_ctx {
 	struct damon_operations ops;
 	unsigned long addr_unit;
 	unsigned long min_region_sz;
+	bool pause;
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index db6c67e52d2b8..0ab2cfa848e69 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1349,6 +1349,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 		if (err)
 			return err;
 	}
+	dst->pause = src->pause;
 	dst->ops = src->ops;
 	dst->addr_unit = src->addr_unit;
 	dst->min_region_sz = src->min_region_sz;
@@ -3003,6 +3004,14 @@ static int kdamond_fn(void *data)
 		kdamond_call(ctx, false);
 		if (ctx->maybe_corrupted)
 			break;
+		while (ctx->pause) {
+			damos_walk_cancel(ctx);
+			kdamond_usleep(ctx->attrs.sample_interval);
+			/* allow caller unset pause via damon_call() */
+			kdamond_call(ctx, false);
+			if (kdamond_need_stop(ctx) || ctx->maybe_corrupted)
+				goto done;
+		}
 		if (!list_empty(&ctx->schemes))
 			kdamond_apply_schemes(ctx);
 		else
-- 
2.47.3

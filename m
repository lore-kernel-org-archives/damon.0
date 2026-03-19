Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC1397E9A;
	Thu, 19 Mar 2026 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897727; cv=none; b=tDsVvY4QX8ab26mQNMXFNsLFOD9feGXiqduBmpZCo4Qhwj/2lrYUoOC5i9Y0WzYaYqrq+XPgb+OGO+JfzZ+4vlXcIQ93PU+02CsW1gNU8TlpRN0fX4NfIRMpJFtMtc5Rfje7wM2U2JmEw6nK8RI1WcusE1hUuOh0B241xTWuamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897727; c=relaxed/simple;
	bh=/zdFcK8+rlUNIicMSIFp9XoXm7KV0c/o3PoVHHBf0RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncDN1oWR/HOorDfNHajulCIe6u12Qv0pKHQ1lf+o0Hwioa0se4AmsYGvKNgLNdJVqFqar4UJf+sYK/SApPewRVnrM8z+X3ej3jsdLje7mH6bwacKedcMqJR0A18BM9gtc7zedp3uMXKVYaXpwWP+RggyAL+J6e5V/SiaU3LBrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBhtADEU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBhtADEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41ED6C2BCB1;
	Thu, 19 Mar 2026 05:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773897727;
	bh=/zdFcK8+rlUNIicMSIFp9XoXm7KV0c/o3PoVHHBf0RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBhtADEUlW8MOKFTIYt/NyE7RkdX0oRjJ8zOtIIzeBYu0JQ6bRJEuy1aioKza4eb+
	 k/Agmpa+S3JyPFK6znbuyKEI5o75f4ScDOltix4MAQ+jeXprd3I5zRa27nXEu7hcad
	 jeJqto51aWv0IBSLgJ/1x4/VuF+Qc3IyrhB4kxWF6wdqp6+0hoICu34PlOZBcJL5rY
	 CZzoq/6vE4vM/Cy7jpMKT0PdOnNru/88LsRL9LjpwpVky8CTd5nKNyT4UEOmPzL89i
	 OxbTkAICViJcf19mlTBTrAWG2n59dPBYIJYP3cPsJ6MzRm8swXL3GGzKuQOHanwEiR
	 0xL2PBh3FzVtg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Wed, 18 Mar 2026 22:21:44 -0700
Message-ID: <20260319052157.99433-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-1-sj@kernel.org>
References: <20260319052157.99433-1-sj@kernel.org>
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
index 339325e1096bc..0b6cb63d64d0e 100644
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
@@ -2978,6 +2979,14 @@ static int kdamond_fn(void *data)
 		 * kdamond_merge_regions() if possible, to reduce overhead
 		 */
 		kdamond_call(ctx, false);
+		while (ctx->pause) {
+			if (kdamond_need_stop(ctx))
+				goto done;
+			kdamond_usleep(ctx->attrs.sample_interval);
+			/* allow caller unset pause via damon_call() */
+			kdamond_call(ctx, false);
+			damos_walk_cancel(ctx);
+		}
 		if (!list_empty(&ctx->schemes))
 			kdamond_apply_schemes(ctx);
 		else
-- 
2.47.3

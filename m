Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8DB19CD17;
	Thu, 19 Dec 2024 04:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581025; cv=none; b=mEhOeRhHmzDKSawB5rS88WiC7ld16B1Cvk359FiXFJQjlDNWqom3FvLMZT5uu1FopLWuqxCuFI98bV/uOGKGLPnboXjb1gvEzk9UOl7tUh354npeiiFk5FPbCKISyuXke5bZDLl+75jPIywKTymTLkI4Q6PZmVa7UvHl9iqdh0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581025; c=relaxed/simple;
	bh=cxxjnWzTe5muZlyce9kFDTQgXHn3SHgY8i5MGv2pqZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzzahoMiNObTiv9nxkHu3NiD8pk/9kVwAVeKPBmzfizcmskxoa56JNdX2e0GsXSBMhnfJerEFPk/IynUSJN3iHSNpwko2RC5HAy/1yYnGBcePIpqj3FsbeW9bDqxs1vycz2Zh4GkgY6Ym8JpjxsGcnKzj9thoz4OPQha97cpCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTssS2WH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTssS2WH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B53C4CEDC;
	Thu, 19 Dec 2024 04:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581024;
	bh=cxxjnWzTe5muZlyce9kFDTQgXHn3SHgY8i5MGv2pqZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTssS2WHa66nMxFXS8zkggEJKRiPlZhTv/5Zpsv2QxVDqaGQA7KH7vHCko5ztski9
	 OQUNAnp+dZB4iXhLf91mAESi/UjJPsCHf4hm4oa1aKv1fZAKrw9imbq2C4AJAtGHhn
	 Pm/XbpgXz8TKmBurz16QCq4Iko9WWZfU8KDyx6Kf3KCT+3PCt/3dkZr9aao31ut32R
	 ZNNjgsBhnwvAgruO6gbWm+XvlSl9FNcTmXLF8GJ20Hbig3tVW6ccrAgQlVF5ZK+h7D
	 ACT0lwhXKmci4+z4wTfVMPehGxkoulRuz6U+s9TYHvbrQdbCjCJ38PdPnuMPI2r3F1
	 jLOzvmSj+I2bg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/18] mm/damon: ask apply_scheme() to report filter-passed region-internal bytes
Date: Wed, 18 Dec 2024 20:03:14 -0800
Message-Id: <20241219040327.61902-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some DAMOS filter types including those for young page, anon page, and
belonging memcg are handled by underlying DAMON operations set
implementation, via damon_operations->apply_scheme() interface.  How
many bytes of the region have passed the filter can be useful for DAMOS
scheme tuning and access pattern monitoring.  Modify the interface to
let the callback implementation reports back the number if possible.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++--
 mm/damon/core.c       | 4 +++-
 mm/damon/paddr.c      | 2 +-
 mm/damon/vaddr.c      | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f66fa0ab9350..bff39c23f16e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -534,7 +534,8 @@ enum damon_ops_id {
  * @apply_scheme is called from @kdamond when a region for user provided
  * DAMON-based operation scheme is found.  It should apply the scheme's action
  * to the region and return bytes of the region that the action is successfully
- * applied.
+ * applied.  It should also report how many bytes of the region has passed
+ * filters (&struct damos_filter) that handled by itself.
  * @target_valid should check whether the target is still valid for the
  * monitoring.
  * @cleanup is called from @kdamond just before its termination.
@@ -551,7 +552,7 @@ struct damon_operations {
 			struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
 			struct damon_target *t, struct damon_region *r,
-			struct damos *scheme);
+			struct damos *scheme, unsigned long *sz_filter_passed);
 	bool (*target_valid)(struct damon_target *t);
 	void (*cleanup)(struct damon_ctx *context);
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d8c223954996..c7ae95d6b7ba 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1517,6 +1517,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	unsigned long sz = damon_sz_region(r);
 	struct timespec64 begin, end;
 	unsigned long sz_applied = 0;
+	unsigned long sz_ops_filter_passed = 0;
 	int err = 0;
 	/*
 	 * We plan to support multiple context per kdamond, as DAMON sysfs
@@ -1563,7 +1564,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		if (!err) {
 			trace_damos_before_apply(cidx, sidx, tidx, r,
 					damon_nr_regions(t), do_trace);
-			sz_applied = c->ops.apply_scheme(c, t, r, s);
+			sz_applied = c->ops.apply_scheme(c, t, r, s,
+					&sz_ops_filter_passed);
 		}
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index a9ff35341d65..3530ef9c80bd 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -477,7 +477,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
 
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
-		struct damos *scheme)
+		struct damos *scheme, unsigned long *sz_filter_passed)
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b9eaa20b73b9..a6174f725bd7 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -655,7 +655,7 @@ static unsigned long damos_madvise(struct damon_target *target,
 
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
-		struct damos *scheme)
+		struct damos *scheme, unsigned long *sz_filter_passed)
 {
 	int madv_action;
 
-- 
2.39.5


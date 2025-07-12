Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E399298CB7;
	Sat, 12 Jul 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349832; cv=none; b=SJkOmvQheqTrvCwKJT6eVkRhr/bO92war8w4k4M7cwPuKit6Dzij7z5c7Yz4C0BS0b5byD6Dn92m7E06wRvqjsfaLPV0qEG8tmqfA5h+1nArk+9MZOZTUrdLCw7YCkv8yldT09j0y3z10152ZSJ5QYD8atXh6BYJ2cSs9zLZduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349832; c=relaxed/simple;
	bh=fsU2gZbsgWMkSYRpc0h/oL/Vi1gtpWY17PNH7wEfRqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfJ09M24Izfii0D5PwdF8hY8z22otAHXCAIhUMnObsIJLsayGBP2zYaYr60BxzR/XJ87HPPIF7rQux2SrqvgIjnIECPoAy76GRPdV8pncaKjNjDcH7QCtfhn25UvD3z/V4C9hHJ8FNOL0ClYH7wVnhvMR6lCrelChUqfsUCW0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZjsH8Lu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZjsH8Lu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7960C4CEEF;
	Sat, 12 Jul 2025 19:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349832;
	bh=fsU2gZbsgWMkSYRpc0h/oL/Vi1gtpWY17PNH7wEfRqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZjsH8LuWln/avbZ2fC2i7o0sVDMaEqh0lYKe4Uob3y8Q3/oxuTt3XvV20Q0Mkdqb
	 fq5CjUPRamAzYp7UTe2jacxA1AaVazjjdF7uyNAWnL63n+tzWlj78NxwrutMU1I8Q+
	 /JRoCCwpdeZ8Ekl4sPoK5ORG3Z4JSgHN2Eq8LNa+EzFkj0SUFjJbgx7I5vhM3N0eC7
	 6amk7B1drrGlPxjjoC9Ehlrs7xtC6StO42TxD3xj/Y++HKpZcdOFub7ZlzKfgzNW4M
	 UBEQiqHNK+1piDXfEls6y6JcMYiD7+CgtLP3uZ+aoNqQibzQn7t1nh/P4sGEnehOhD
	 kplNSl9iKhd9A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/14] mm/damon/vaddr: put pid in cleanup_target()
Date: Sat, 12 Jul 2025 12:50:12 -0700
Message-Id: <20250712195016.151108-11-sj@kernel.org>
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

Implement cleanup_target() callback for [f]vaddr, which calls put_pid()
for each target that will be destroyed.  Also remove redundant put_pid()
calls in core, sysfs and sample modules, which were required to be done
redundantly due to the lack of such self cleanup in vaddr.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c      |  2 --
 mm/damon/sysfs.c     | 10 ++--------
 mm/damon/vaddr.c     |  6 ++++++
 samples/damon/prcl.c |  2 --
 samples/damon/wsse.c |  2 --
 5 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 678c9b4e038c..9554743dc992 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1139,8 +1139,6 @@ static int damon_commit_targets(
 		} else {
 			struct damos *s;
 
-			if (damon_target_has_pid(dst))
-				put_pid(dst_target->pid);
 			damon_destroy_target(dst_target, dst);
 			damon_for_each_scheme(s, dst) {
 				if (s->quota.charge_target_from == dst_target) {
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index f2f9f756f5a2..5eba6ac53939 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1298,13 +1298,9 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
-	bool has_pid = damon_target_has_pid(ctx);
 
-	damon_for_each_target_safe(t, next, ctx) {
-		if (has_pid)
-			put_pid(t->pid);
+	damon_for_each_target_safe(t, next, ctx)
 		damon_destroy_target(t, ctx);
-	}
 }
 
 static int damon_sysfs_set_regions(struct damon_target *t,
@@ -1387,10 +1383,8 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 	if (!damon_target_has_pid(ctx))
 		return;
 
-	damon_for_each_target_safe(t, next, ctx) {
-		put_pid(t->pid);
+	damon_for_each_target_safe(t, next, ctx)
 		damon_destroy_target(t, ctx);
-	}
 }
 
 /*
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 7f5dc9c221a0..94af19c4dfed 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -805,6 +805,11 @@ static bool damon_va_target_valid(struct damon_target *t)
 	return false;
 }
 
+static void damon_va_cleanup_target(struct damon_target *t)
+{
+	put_pid(t->pid);
+}
+
 #ifndef CONFIG_ADVISE_SYSCALLS
 static unsigned long damos_madvise(struct damon_target *target,
 		struct damon_region *r, int behavior)
@@ -946,6 +951,7 @@ static int __init damon_va_initcall(void)
 		.prepare_access_checks = damon_va_prepare_access_checks,
 		.check_accesses = damon_va_check_accesses,
 		.target_valid = damon_va_target_valid,
+		.cleanup_target = damon_va_cleanup_target,
 		.cleanup = NULL,
 		.apply_scheme = damon_va_apply_scheme,
 		.get_scheme_score = damon_va_scheme_score,
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 25a751a67b2d..1b839c06a612 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -120,8 +120,6 @@ static void damon_sample_prcl_stop(void)
 		damon_stop(&ctx, 1);
 		damon_destroy_ctx(ctx);
 	}
-	if (target_pidp)
-		put_pid(target_pidp);
 }
 
 static bool init_called;
diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index a250e86b24a5..da052023b099 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -100,8 +100,6 @@ static void damon_sample_wsse_stop(void)
 		damon_stop(&ctx, 1);
 		damon_destroy_ctx(ctx);
 	}
-	if (target_pidp)
-		put_pid(target_pidp);
 }
 
 static bool init_called;
-- 
2.39.5

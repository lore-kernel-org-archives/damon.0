Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4149E145;
	Fri, 25 Sep 2026 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341381; cv=none; b=f9/Acgf/HfhhUlLKkeYhvKngfnmtcf4VUwPIKmvIXh79KzC0zvfS/CEYwBb1gWtuzXii9bLCIS74AskiB9VWEnR0czcyqdW6GhWV8Umj6AIivKt9Oq8LUROIoN0MO3UA4FU++0+5OOaiualOZLZ8ktw+zNWmsx2LChxVQJNgKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341381; c=relaxed/simple;
	bh=pV6pLnY9VNbDFSg9wsmygELy03on28x8NoH07KyTAKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeFoP7O6BitJw73SmX6jBRltalTJQqozjPNGUUmolzhaThV8ztWOxzoKOvE0qIsElihjgrUYcqMlzrOWevxxS5pwOYZZdTuJobuZ115MXt2hxkqGgXzWTztgwK2myF/2QpWNAFlpk6r7PJwaaek3Hv9D3n8d5JIyfK81v81lxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNlscdXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNlscdXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2101F00898;
	Fri, 25 Sep 2026 13:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341379;
	bh=BSVHtbgr7nZGd5dozOxzx685KlCmq8P9tbgu4h3dnZU=;
	h=From:To:Cc:Subject:Date;
	b=WNlscdXN90cGNUO5qLV+qUylIQXV1twQZcwaPEvgzo893O5zSrhulbVIZMPPD3tSc
	 CIE1Zo+FPehfA5Tz9xtSJibZ4mI27225gJrdT3ACPUOw4CB+eb5bVuf0Gsh/BKTbVT
	 0p22ZY1mRW6pROBFRQYRQ0YvgnLT+Tzv9OqMSvHOSM6+5UpG7kgICT1jt42opK5SB8
	 hCsYDjXM0k7isT/nMvumZP84dZe24nNRwy0nTcUCUBoiCPNW5AKIJ8pXMv46aqpHxk
	 o9BRP3KxWIl/cyCBa3kZTurtFeRUOtzJOkMq1UOb0CptJiBb4ujOI/ItL+mUzq5d7Z
	 DBy7OymJdGuZQ==
From: Arnd Bergmann <arnd@kernel.org>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] damon: reduce stack usage further
Date: Fri, 25 Sep 2026 15:02:46 +0200
Message-ID: <20260925130254.4022227-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

In a previous patch, I had annotated kdamond_tune_intervals() as
noinline_for_stack in order to not exceed the stack frame warning
limit. Unfortunately, my current linux-next randconfig builds show
a similar problem again with clang-21:

mm/damon/core.c:3953:12: error: stack frame size (1288) exceeds limit (1280) in 'kdamond_fn' [-Werror,-Wframe-larger-than]
 3953 | static int kdamond_fn(void *data)

Do the same thing with kdamond_apply_schemes(), kdamond_merge_regions(),
and kdamond_split_regions(), which also have individually large stacks.
This should work to keep the deepest total stack depth down much more
as well as avoid the warning.

I also tried to reduce the complexity of kdamond_fn() itself by splitting
out the while() loop into a separate function. While this arguably led
to slightly more readable code, it had no effect on the total stack
usage and just made the new function the largest stack user and had
a nonzero risk of me getting the conversion wrong.

Fixes: 5a00cae64de1 ("mm/damon/core: reduce kernel stack usage")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/damon/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4687b909d42c..9803b459a0a4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3417,7 +3417,7 @@ static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
 	trace_call__damos_stat_after_apply_interval(cidx, sidx, &s->stat);
 }
 
-static void kdamond_apply_schemes(struct damon_ctx *c)
+static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
 	struct damos *s;
@@ -3573,8 +3573,9 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
  * while DAMON is running.  For such a case, repeat merging until the limit is
  * met while increasing @threshold up to possible maximum level.
  */
-static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
-				  unsigned long sz_limit)
+static noinline_for_stack void kdamond_merge_regions(struct damon_ctx *c,
+						     unsigned int threshold,
+						     unsigned long sz_limit)
 {
 	struct damon_target *t;
 	unsigned int nr_regions;
@@ -3718,7 +3719,7 @@ static void damon_split_some_regions(struct damon_ctx *ctx,
  * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
  * it.
  */
-static void kdamond_split_regions(struct damon_ctx *ctx)
+static noinline_for_stack void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	unsigned long nr_regions = 0;
-- 
2.53.0


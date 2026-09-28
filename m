Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2F484896;
	Mon, 28 Sep 2026 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584812; cv=none; b=mvyCfZnaPT2PBEYOigusZmkN9LGXnDaCDD0VZUSZFHp/UJp7yUEqsBMZFPqmlluN+2/HDy8z9eyFYSkDyP+x3uqNka67mhXjTsnx+Mas80vTK3b6wodOb/QMy3PWFTVX9rhC2H8ITgL2af/J+MvcBbeSyHrAwnvzRsVX7nrWzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584812; c=relaxed/simple;
	bh=Ux+XRLdHH3mqzmbeYYP+7+dygvmdySbKleSnyBkwwnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+mjHM9sU1AB/jYDYelexOHc6CNd5qPJN/SSHRJL8O4y5Kp2VYubY4WY8PjS2JkQisWyKezadV/lwLatVwSW9qM1ezs6nOTKIUZxEsblvx9TDfkL49Kw6DnCqt93cltcpTesBeE15kWvYZu/z52BIZF7DwGMOnpwSp8BEdFce14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjfX74fr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjfX74fr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878901F00893;
	Mon, 28 Sep 2026 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790584811;
	bh=bGJHJrOH+riYBdOov+lE8FQ5rx8dbnRY2szuLD404PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DjfX74frxAWYMyUFQtctBiJmVvoieVS4KbUstf41uWpfgYe9XU6SBJTiYPEKy05bW
	 Av6Wp2MbeN2MAsvyTLwige6CW21NJtEDMHa2kdPHER7QdvkknnBTXJOeCZp7q/it3u
	 NTpy71mDmE3en438Lq4teRmKUMT6yYkwMaoWwwUHGYL8Ah+dg3rnV8uw85z27obf7p
	 jmekeMJEeBwZuUXwjPAhfQg42yx3VaiHsbZDX7lUAIAnT9ey6SmZqIDRSmMSnIqwSO
	 zD7wRSvydvw4xPprUp8m9oyr53dTKoIyjDm7whej4IbvWgTpOJF0hoKWWlvoe6TEO/
	 +EKCMXDJ7ubmA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/3] mm/damon/core: reduce stack usage further
Date: Mon, 28 Sep 2026 01:39:56 -0700
Message-ID: <20260928083959.4030-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928083959.4030-1-sj@kernel.org>
References: <20260928083959.4030-1-sj@kernel.org>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260925130254.4022227-1-arnd@kernel.org
- Collect R-b: from SJ.
- Rebase to the latest mm-new.
- Update subject prefix.

 mm/damon/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 733025b36745..0e375f4445fd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3433,7 +3433,7 @@ static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
 	trace_call__damos_stat_after_apply_interval(cidx, sidx, &s->stat);
 }
 
-static void kdamond_apply_schemes(struct damon_ctx *c)
+static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
 	struct damos *s;
@@ -3589,8 +3589,9 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
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
@@ -3734,7 +3735,7 @@ static void damon_split_some_regions(struct damon_ctx *ctx,
  * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
  * it.
  */
-static void kdamond_split_regions(struct damon_ctx *ctx)
+static noinline_for_stack void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	unsigned long nr_regions = 0;
-- 
2.47.3

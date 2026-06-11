Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A40EEBB;
	Thu, 11 Jun 2026 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182630; cv=none; b=pCQKocz9Kx1heyOYxWF/ZA6ptaS6myztlE4ScC3/hRDearoxCCRmvj2Q+6ePiLPl4hK/aDHGkLfE5n8L6O1zk8AI6Ro8ZX+OFtbiEw9psI+c60t3tq4fIMtr2hmo4UGwIv5oQArZfUJd5iAueBZiOxIMxoMthCFtMNjH6tXk6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182630; c=relaxed/simple;
	bh=8W+W8HbSywvSgQ+qMkK1eRDKNFns8qNmN4+ZrDI8EO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bt5ztao+CZQIcuP2x+/Qdmi/AViqUix7U6B7dpAS5jkdh0DsmpX0guDG7j7f+mUFsyT4kMCr88r/DJmMMTk3pQm+MfGnMTJtG7/qUO678fSY4XKSU2q8miyPfGhdjKn0RB/eUHkYH+a4w+MbHC3Bm94US47YXdmeFa1KNYsYifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNazy/7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNazy/7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E5C1F00893;
	Thu, 11 Jun 2026 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182629;
	bh=geNwV4XsDcpW2nLuNQos/NDgwcU9+p+h0p71pBEkqdc=;
	h=From:To:Cc:Subject:Date;
	b=nNazy/7cpWAhMsGMZlG/ZznSRm6J7bfXp371Q8zmoJkEJWAokjfzD9k8J+LG7tk2b
	 N2o9B//dFurcQjRQqqjjwo8tXElpWAt1rrbfIM8+507W8El7JAA0VnzgkVqfOFPK//
	 OvRLWiVMeOX0O94sVIHJEtTGmE1I+T/cw3XruxlZlKAkjovqHp87erfzqmCveCuZQ4
	 SBHHCR+55dw4RLRS5eE+WHgizUoTrpUE9rp387H/ZNalmljdajI+O4zLkIJ5vd461t
	 GVrDtLHenw8CNVJ3Yx73uhq4C3/yrX+9jrDWqp0UBo4QHwP/f4eK8ZhQ0tIHEMWhI3
	 B34t1OZ76bnnA==
From: Arnd Bergmann <arnd@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] mm/damon/core: reduce kernel stack usage
Date: Thu, 11 Jun 2026 14:56:57 +0200
Message-Id: <20260611125704.3386176-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The main thread function has recently grown to the point of
exceeding stack frame size warning limits in some configurations.
This is what I hit on s390 with clang and CONFIG_KASAN:

mm/damon/core.c:3440:31: error: stack frame size (1352) exceeds limit (1280) in 'kdamond_fn' [-Werror,-Wframe-larger-than]
 3440 | static int kdamond_fn(struct damon_ctx *ctx)

The largest stack usage here is inside of the kdamond_tune_intervals(),
so by marking that one as noinline_for_stack, the functions individually
stay below the warning limit, though kdamond_fn() itself still uses
hundreds of kilobytes for some reason.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 265d51ade25b..69f38c48ac08 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2002,7 +2002,7 @@ static unsigned long damon_get_intervals_adaptation_bp(struct damon_ctx *c)
 	return adaptation_bp;
 }
 
-static void kdamond_tune_intervals(struct damon_ctx *c)
+static noinline_for_stack void kdamond_tune_intervals(struct damon_ctx *c)
 {
 	unsigned long adaptation_bp;
 	struct damon_attrs new_attrs;
-- 
2.39.5


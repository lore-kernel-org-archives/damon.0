Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B029B8C3;
	Sat, 12 Jul 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349835; cv=none; b=RVm4pDoPBru/mDujx5ig5xVRLXHS1p9jvQA5z9UxTggoU3kwmo2zH2UjJdJlOkoJyaWxmwqU6KN4GOubqSyM9xup1UyQGf1GoRSgCzmrEjciLoMIIZx1vn1PefAdeLnbZt2Xu9w3d+nWE7KeBsQzO2ocmP2rYK34YSvBr3ziybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349835; c=relaxed/simple;
	bh=WTjz/K1GFNo9usAZWWENvLqqlSxu80QiYvWGup6Il+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ey9no4Bgfzt5OORDuwBH6ln2r2t8Yx5oENxNYJyzhmDskTLqi2O6NbRrBio5mUoZVVjPmMsxoKBOzLKQ7g7kmHxJhIVsY9e6UuibWBIlJbOUqQEaUKLMvmlWWLVwMxvMnA9IZ8SE2xr8qT0WPdFARniivQa1KOXW+fJHEqAXt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWkGXT/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWkGXT/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0301FC4CEEF;
	Sat, 12 Jul 2025 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349835;
	bh=WTjz/K1GFNo9usAZWWENvLqqlSxu80QiYvWGup6Il+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWkGXT/YIsfyj9wuHfO1zUCsFKK6RTYxF4bWGCR9fEN/SuCmIoCK8vk1DTnWz9EQt
	 Iv5ZftO212rgxYD9gKmFXC332PjovWtSume4z5zwzI7vcYIBs+9upIGAh5fmFEUZ9C
	 HbjgaFCQZxNTfwyT6lFlsDhvjcbDfqVhvMfsYD2CWGvCCUdbQKyFJHSC2DAypx/Br5
	 MZcgRpkBnTt4ZIuqI2oGFArJv/UTohteUsB4dJfZumkkyHzH8wBEfctUdMZhfKB3fi
	 WZ8InS7s1bsZDwO/uSKfAYWSd3q/QkhqS9ondBRKk/YZTv7Z+S6CsrD2HZUjywyf5S
	 59Kpe/mRt/LTw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 13/14] mm/damon/sysfs: remove damon_sysfs_before_terminate()
Date: Sat, 12 Jul 2025 12:50:15 -0700
Message-Id: <20250712195016.151108-14-sj@kernel.org>
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

DAMON core layer does target cleanup on its own.  Remove duplicated and
unnecessarily selective cleanup attempts in DAMON sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b0f7c60d655a..cce2c8a296e2 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1361,17 +1361,6 @@ static int damon_sysfs_add_targets(struct damon_ctx *ctx,
 	return 0;
 }
 
-static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
-{
-	struct damon_target *t, *next;
-
-	if (!damon_target_has_pid(ctx))
-		return;
-
-	damon_for_each_target_safe(t, next, ctx)
-		damon_destroy_target(t, ctx);
-}
-
 /*
  * damon_sysfs_upd_schemes_stats() - Update schemes stats sysfs files.
  * @data:	The kobject wrapper that associated to the kdamond thread.
@@ -1516,7 +1505,6 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 		return ERR_PTR(err);
 	}
 
-	ctx->callback.before_terminate = damon_sysfs_before_terminate;
 	return ctx;
 }
 
-- 
2.39.5

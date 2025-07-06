Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DAC2C0313;
	Sun,  6 Jul 2025 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832039; cv=none; b=cerdTo9fg7rxh5JKnTeCviXUUsgJ+W3E5AC6yOpuOdlY9YR7O1lgkcDJfQNZxMZWa+T/p6QsDgnhrfwgqWFBPI8Gw58apvJ/tUBO2ZTnkTbl+kDojESq8EHl+tHS68RT7Z9B2ELttDFDXDZxKRrlW8q/Q823345CH2BhUPMF/ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832039; c=relaxed/simple;
	bh=WTjz/K1GFNo9usAZWWENvLqqlSxu80QiYvWGup6Il+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWXmURVnAmmdSwMMWESiMECaAc/s/2JbjTZ1z5hNSyjnlhV4QUms6JFpDDNHIXoVGTWvDKmkIGKIBbpkF0P76zZ/XsiVAnNJA6ArV9TwRdi5gdtmyzGe/Bo18/PM7M/OCwy33oTOp3dB6hXvzd4+cBCcbtvkhrugm77FoEMHG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQaNYsc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQaNYsc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7282C4CEED;
	Sun,  6 Jul 2025 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832038;
	bh=WTjz/K1GFNo9usAZWWENvLqqlSxu80QiYvWGup6Il+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQaNYsc6fn3ngQRZ2jaLffrLZywSHmBXYS3OohecqNN3vWUf8ZKMZpqQ8coi89zmQ
	 /GpY5J0YP8pIrQKow8qetlZdLd0tNhWKQr6bnFR3NqVQa+tfD7GZDGRpiAVTT6HNyd
	 8LSjoIGlIZl1Ktih9elHJEtYs2TaK7Si5AjVBMDfOZDXQPeuln8EczlBS3FFOQl+y3
	 ykPOJReVPPjm62z+0RVmN9xEdVmZgwh8SZ6lHVgV24J+EujHKnYeki+WyHewumYmVu
	 H9W53690nPfXue1vVtr/0iiC0UHsBIuCd/lZVY/f5TdzRT9Inl1twtQWZ/NTCxgQv/
	 E0Laeu9dPzZBw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 13/14] mm/damon/sysfs: remove damon_sysfs_before_terminate()
Date: Sun,  6 Jul 2025 13:00:17 -0700
Message-Id: <20250706200018.42704-14-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706200018.42704-1-sj@kernel.org>
References: <20250706200018.42704-1-sj@kernel.org>
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

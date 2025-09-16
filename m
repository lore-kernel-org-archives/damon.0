Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F7327B35D;
	Tue, 16 Sep 2025 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993724; cv=none; b=KiHVXrJPEebzoOYxqXMUu+zBYjww124I2dEgIg/Yxc5iVGjrRJtSfAJhaou0qt47VmXWOn/zLScN8spIgktkwLRq3v31CzaGOQFHABJtzRYGVXZwFGZjRhdYw/BGxbWdTILTnWLcCP1XPuyrhMjwKhoA8r790kMDYzT298TgJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993724; c=relaxed/simple;
	bh=4uQscG4mYr4g+dERacoLlCCtLcp3o3ScovLzzqmdpAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TaWXebTW+DjxHZLQliqPI5mCe7WWshKFNTvnhaRbwYDqePG0h/IFbkeUH0mDOMx7c1Dqu5dibfxTI4eYuBNmYVCw0gmMxh2nANk9i9o57nh7kyED9Y4fKLZNWwBGQE9SdKlrze763F/XJzoNCkJ/8dk18CVpQKekQGrK8eBYBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GswUYaDo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GswUYaDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39857C4CEEB;
	Tue, 16 Sep 2025 03:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993724;
	bh=4uQscG4mYr4g+dERacoLlCCtLcp3o3ScovLzzqmdpAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GswUYaDoamgG2C1fR5wV2glRHaeU2ehx1anVdkERZyRo8fOlc1aeI5cWSmpAXxkzY
	 QQ+fAztPPkjGPGDQDmwTywr6x+/ai7QaVZiQsW/tNsk+3STv0BOSUIFL++v5mNfPUV
	 1fDqc3qT9fr6vrYJr9YeIbQRUYHKUHTe4IE86+lejqcEFRhi4QTJrB5e17ngGfKgWA
	 J7DsbY3hyzBg2ViujYAtCqPhGghty1jWBjXovXvb2W80VXGnRTZ8mjvQ5k75SmKnCR
	 DPABkkkbjn5E8O+T8kW+rt8d5XCWHiv5+HjDu9Pg0mnB3l2d/Ow0O+kZgqOnMsrm5O
	 yYKPe1tJXw/Jg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/7] samples/damon/mtier: use damon_initialized()
Date: Mon, 15 Sep 2025 20:35:11 -0700
Message-Id: <20250916033511.116366-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916033511.116366-1-sj@kernel.org>
References: <20250916033511.116366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sample_mtier is assuming DAMON is ready to use in module_init
time, and uses its own hack to see if it is the time.  Use
damon_initialized(), which is a way for seeing if DAMON is ready to be
used that is more reliable and better to maintain instead of the hack.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index beaf36657dea..775838a23d93 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -193,8 +193,6 @@ static void damon_sample_mtier_stop(void)
 	damon_destroy_ctx(ctxs[1]);
 }
 
-static bool init_called;
-
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -208,7 +206,7 @@ static int damon_sample_mtier_enable_store(
 	if (enabled == is_enabled)
 		return 0;
 
-	if (!init_called)
+	if (!damon_initialized())
 		return 0;
 
 	if (enabled) {
@@ -225,7 +223,12 @@ static int __init damon_sample_mtier_init(void)
 {
 	int err = 0;
 
-	init_called = true;
+	if (!damon_initialized()) {
+		if (enabled)
+			enabled = false;
+		return -ENOMEM;
+	}
+
 	if (enabled) {
 		err = damon_sample_mtier_start();
 		if (err)
-- 
2.39.5

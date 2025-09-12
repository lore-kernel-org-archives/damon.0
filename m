Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7598C2356C7;
	Fri, 12 Sep 2025 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644799; cv=none; b=Xws2CB0NQumvExc/zRl8YxYcfiglDn+sVsXml7JEIxzTRmZUawHr/9blRQFdiceQUM9Jflmo5UdqT9regEVlgOt6aFFnY6pAFQNZMR50PR9p/QV37cpXxHU6Gbfq0Nlo89MtzeNGBdJyJRr4k+rUpBLw2yo0RAgDcQzKEReP5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644799; c=relaxed/simple;
	bh=8oAmMgNUvcFWbF3KtriZccsEdzvp1RE+WJ1o1RTAqkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WF4ORJzaOy4Ov3acJ/ZCJsc6aqfyq4ne1xA0KkOED+PtYEozIXbq95Vh/gsYSYyFL8QfRvtQExwb7XU3BzNw3jrrcjw3TPALIO8XWM62rQyGf3wSPUKNzlF8ZS/HYk6BgubvbXU7L41cXs7rrgZFEyRCj0JjgRIgBszkjPGkeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrQP2Ut0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrQP2Ut0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3470C4CEF9;
	Fri, 12 Sep 2025 02:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757644799;
	bh=8oAmMgNUvcFWbF3KtriZccsEdzvp1RE+WJ1o1RTAqkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrQP2Ut0hwY/MhhOlAvITAVSfwisKYhr7P7gIhhQlAo5rvPkQWR+COGMkiiKG0wrC
	 mixl2/Kg283jtZRQ4BPLkmIlSZwe+tJOR7Bv7RZVMAmG+eggPJPeCPGR/sjik3HL7O
	 GVtgRbvPCXn8Rid6/18Sr0DMDkMexf42L8UYny9Bvw0GT7bxJd5fpVOpkPzfDUB1/Y
	 +HICj2zVncflQ9k0b6LVXkKdJrXNRG0NGbFAYvD9k25ohKppNBb2UHiGlevfSXbupv
	 z/i9Eb3uKUPZ8rn4dsShJZ4+yOFbtllaswJuTDs847cTDOFdL1YqTyLLKybieSop8z
	 BqpNelbbs3EQQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/7] samples/damon/prcl: use damon_initialized()
Date: Thu, 11 Sep 2025 19:39:45 -0700
Message-Id: <20250912023946.62337-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912023946.62337-1-sj@kernel.org>
References: <20250912023946.62337-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sample_prcl is assuming DAMON is ready to use in module_init time,
and uses its own hack to see if it is the time.  Use
damon_initialized(), which is a way for seeing if DAMON is ready to be
used that is more reliable and better to maintain instead of the hack.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 0226652f94d5..b7c50f2656ce 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -122,8 +122,6 @@ static void damon_sample_prcl_stop(void)
 	}
 }
 
-static bool init_called;
-
 static int damon_sample_prcl_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -137,7 +135,7 @@ static int damon_sample_prcl_enable_store(
 	if (enabled == is_enabled)
 		return 0;
 
-	if (!init_called)
+	if (!damon_initialized())
 		return 0;
 
 	if (enabled) {
@@ -154,7 +152,12 @@ static int __init damon_sample_prcl_init(void)
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
 		err = damon_sample_prcl_start();
 		if (err)
-- 
2.39.5

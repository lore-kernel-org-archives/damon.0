Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F122126D;
	Fri, 12 Sep 2025 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644796; cv=none; b=KgKGlu8H4rtahGBfYXODTMO4/GgMq9U5NRC8ITpKxQnp5+MKgv2t5dYKnxyOxIyS5ZHxLXUQA1kW3ex4RzEfwzCjaoFIWyYjLpF1kFMrHBuN6NFfWPApNVxxHy7XFB5/5LUkZtO76u4Z5CgY2rBx+36xwQRnODcU8RSASxEET+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644796; c=relaxed/simple;
	bh=AfFc3OpSjbhPeNbz+Yb9iOakhYwHCt/NFSR70/mcjZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsfjlD8JxEbgjuvuhxHgOfF0OY8d/yeQLjnJJZche3NN7BL9rASkcbneVqkcgOnB45f0EO1bHM/IiNJWeS7LO1PIjIXScSKl34NjjZgywyqIaS1PYmLYpoCm0hlmdKoke5bOXodvDUlHVkdDfbp8cno3smxXdOIMWOVn7EUNeTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWP+WhWq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWP+WhWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90A3C4AF09;
	Fri, 12 Sep 2025 02:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757644795;
	bh=AfFc3OpSjbhPeNbz+Yb9iOakhYwHCt/NFSR70/mcjZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWP+WhWquO1WX/W82rEURByg7atdHpB5ysqv89RaQhsnxbQvxZStdufL/uh1AoBZu
	 vpCPX9mYSki8cWAg92PU0HBLGnpBT+PpOiEw76eKNpifgDBK1S8oxx+qBZEoHFbVV2
	 ILgkJTv48hnheIbuLKsm6tthD5Q5wO/swgwyNB0GYv5n0tTgMnavb/bY9PagPYmmj7
	 XU332+wz2ZApEFqPxkVu2iOsU7V5sidMbjGVUvwxCGFZOKS04OHojuSfhr67nyHIgR
	 72nIMdLxnC/XsTafgc6MQV86p9xZYKqbi43D/G01ckF9f7eRMLaZDMl0uqv+2wcugw
	 p5ZN6U3uoaYpg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/7] mm/damon/reclaim: use damon_initialized()
Date: Thu, 11 Sep 2025 19:39:42 -0700
Message-Id: <20250912023946.62337-4-sj@kernel.org>
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

DAMON_RECLAIM is assuming DAMON is ready to use in module_init time, and
uses its own hack to see if it is the time.  Use damon_initialized(),
which is a way for seeing if DAMON is ready to be used that is more
reliable and better to maintain instead of the hack.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 590f9d6c55ef..7ba3d0f9a19a 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -349,7 +349,7 @@ static int damon_reclaim_enabled_store(const char *val,
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
-	if (!ctx)
+	if (!damon_initialized())
 		goto set_param_out;
 
 	err = damon_reclaim_turn(enable);
@@ -372,8 +372,13 @@ MODULE_PARM_DESC(enabled,
 
 static int __init damon_reclaim_init(void)
 {
-	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	int err;
 
+	if (!damon_initialized()) {
+		err = -ENOMEM;
+		goto out;
+	}
+	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
 	if (err)
 		goto out;
 
-- 
2.39.5

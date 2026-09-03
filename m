Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A52DFF3F;
	Thu,  3 Sep 2026 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397651; cv=none; b=JJV0h3D370VKBASlULlGXbbySUzJtT/2oIx6CLXf2N7HKTsAgUAGWtcuhd37HXBlRzIvh5OhO8GqpdDmfJxufeEcPU0VkqtCmeq50yIwniqlDFb7/YqDS3zEdGBOQlB4n32vj5vZtnDmOerRz/0pnQqyRJIGlGWfCkU0puPq+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397651; c=relaxed/simple;
	bh=7BuePdqLsmCrpZcRRQjUY0RK2a5/39HdUmJOLbwdCNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ic3XL0d5r4Jjc9IXlVcfCZnqqQHItdJKD2/rUAA3qNO6ot028kWtlUUw9ryfjX0TBnIGFupwTpc9IF+AjH7oaa0GfBhg4srYf4urIV57aRfZ9yjzctjfLo+vVhYmX9L2EAXxtIMbYny1t0W4uq2gjK9qboiCY25N5QN1r/kvpmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGh6AA0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGh6AA0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3831F00A3E;
	Thu,  3 Sep 2026 01:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397650;
	bh=4SsJPfKsekeE5VptqHXgsGnvsq0lAUhbBGf4TqY9ku8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iGh6AA0pHU71NdvZh0YOA3rFuHLBh0+RJ6ntehGQFIdA3dHZJ2H3oD3+XPLYRSriF
	 LTEFCe6UfMTb9+tEdnICcKKV5oB9MjFdPfkc1xS9T/xhVPd2xJlAV8J3cvUAfGUHlP
	 vvzQXrli3zLDtSYA6HOZrUadW/uVdH2QHl6NDYA2l7J5zvF78Eav8fUXsYj5GAiBBP
	 M2nr6zPaKt8NqM6sStlOOQ7O8Yp3uR+jY0Dj4txCzJnpZvv02TKy4bAuwHlD9dycAZ
	 cGYn6aLuZt7I8CbZV1aH/y2OD4hqiDp1cZHaE3gm1EPsKpdluIyBeTOyCeU/606EU/
	 Zp9wmQVnjLgvw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] Revert "samples/damon/mtier: error out for zero quota goal target values"
Date: Wed,  2 Sep 2026 18:07:21 -0700
Message-ID: <20260903010722.94244-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903010722.94244-1-sj@kernel.org>
References: <20260903010722.94244-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a16fd3ad9d89b05475864da97327870464611736.

The commit was made to avoid zero damos quota goal target value, because
it can trigger division-by-zero.  Now the core layer handles the corner
case.  It returns an error for any attempt setting the aero
target_value.  The corner case handling in DAMON_SAMPLE_MTIER is hence
no more needed.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index bea45c87cc9be..27dc88bdf7a0e 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -161,9 +161,6 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	if (!scheme)
 		goto free_out;
 	damon_set_schemes(ctx, &scheme, 1);
-	/* zero target value causes division by zero in damos_quota_store() */
-	if (!node0_mem_used_bp || !node0_mem_free_bp)
-		goto free_out;
 	quota_goal = damos_new_quota_goal(
 			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
 			DAMOS_QUOTA_NODE_MEM_FREE_BP,
-- 
2.47.3

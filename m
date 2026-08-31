Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B749B1E2;
	Mon, 31 Aug 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188253; cv=none; b=QJ25ZUUSJFpxAyuMxdRjBI783ovNzibhTcBzzDprbN++mlI6ezijGSbU8YKXoU90gGW4h1ExXHcwd7yBHIca+aJZIVwwvYyUwrUGMkpEo2heWMZWLPxipGzthrfmTJPU60waiBuyZ/hFaK6l52Q0CH3iINtycwEmTuam3cuootg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188253; c=relaxed/simple;
	bh=U66EgBIXfzWZZtEx1tQdKrHAOcSaBAOVzOMEML/vW2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJprsxK8q6UcGBfHgAIEPF9ljdU6iY6z9EU49LRgRFC89vfFsfeyq18Texh4Rg9z9YLF1apeJ/+wvrmgMLTSlko+DiwrGrEIYruWmLbgAWGOCdylrIFzP9QAtV2aINaObJ3RF7dC1dRMl/uAG7Qu/7u6YDYcq386CT7xqv7z4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxCSK/lI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxCSK/lI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FC41F00A3D;
	Mon, 31 Aug 2026 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188252;
	bh=Z/q1Yeqt6RZSRYDCAAqabUKJ+epH72uUvgP43VjXaQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KxCSK/lI8mnji2zwaf/RVqvW+az04RzyWNdMfc3c+ybG4VfvWmsMx/AWEBnruTqlX
	 2gCeddu+zUitH+oCA8x+HaamRBjID4B13iry5qKRARgbwv97eM6fVxQDenNmLXqO7F
	 1XKpDbESRqGQX6T9L85R8Q8vu/G8X8leYnrIoqY7bEwTlrIT+ZU5+iHy0YOlTAhoQn
	 Ih6ij8ycmERAJhn/eA/1G1FI/0O/Unes5koZsCepWYjJ+APQDSkECLaBrNcpPxv3vL
	 hd3GasJn/yKKL4zkS48W8MGu0shMw0JhJYi9ZCGURAfymUsWrgrSlRFQXPvOLbJu1v
	 MFZWVPcKfyA1A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Cheng-Han Wu <hank20010209@gmail.com>
Subject: [PATCH v2 1/2] mm/damon/core: remove unused damon_targets_empty()
Date: Mon, 31 Aug 2026 07:57:21 -0700
Message-ID: <20260831145724.82387-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831145724.82387-1-sj@kernel.org>
References: <20260831145724.82387-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_targets_empty() has had no in-tree users since commit
5ec4333b1967 ("mm/damon: remove DAMON debugfs interface") removed
its last caller.

Remove the unused declaration and definition.

Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 1 -
 mm/damon/core.c       | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 310509455db13..9835b864a8db9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1056,7 +1056,6 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src);
 
 struct damon_target *damon_new_target(void);
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
-bool damon_targets_empty(struct damon_ctx *ctx);
 int damon_set_target_pid(struct damon_target *t, int pid);
 void damon_free_target(struct damon_target *t);
 void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3fa1b096c8330..043eb38de5fd3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -798,11 +798,6 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
 	list_add_tail(&t->list, &ctx->adaptive_targets);
 }
 
-bool damon_targets_empty(struct damon_ctx *ctx)
-{
-	return list_empty(&ctx->adaptive_targets);
-}
-
 /*
  * Assign the struct pid of the given pid number to the given target.
  */
-- 
2.47.3

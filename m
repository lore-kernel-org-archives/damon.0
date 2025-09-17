Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A012877F7;
	Wed, 17 Sep 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124846; cv=none; b=B7Sr8o8uMhpW6/wmxQUP7IBHafZlBS/o+KbP4DVQBq5PByEbHNqftXcwqBjoOJ3wFbsB7TyxnDbDrcoL1tnudC9aJUcWaxTzSG9Yzqa8gdRN4vrQbfoGLH3g27jtiTmQtNb1qtnyCx/YoyHxlgDbKZbizXTTtfiDJs0TSGxywwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124846; c=relaxed/simple;
	bh=Xn5cUrhSlYfU8D+L9SzM1MDf0JSuHHuyW2CfS7ldx4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fwNVBG0qsKCE8/2QZDxAxi356xmvGHAntuc5RZcpUFtYRq0cO7nait4bjv1Duq4DDS9XHSUnlEcG41vN0ZfLXYARKFk7xCto/Ifs5Wxn5BtrwE1VQHNDIFsW6CWPSlL79Jk3WNM3Brpa/DTzpshk50yJnY6Yy96/aHvIBbtW0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjphx54c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjphx54c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CA2C4CEE7;
	Wed, 17 Sep 2025 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124845;
	bh=Xn5cUrhSlYfU8D+L9SzM1MDf0JSuHHuyW2CfS7ldx4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjphx54ch07/tjRjFKkF3By6vtvpnEoUncKbAEpNlvByUm0k6NJiK3Av1UQUAvA7/
	 LneouAJG8afb9GBos2X2/BHT0+7oWwtTWaYdMGOH27C/1vsA8vR5XCj9KCRigfP3Bo
	 7ad72wYPbbvz18kBhYzdme8W+ABuQfkCcb/v0HGDCCeUNmkyXDIU8/Cwy0Njj9wTV5
	 Wt1hoamLPijmJsp5rkEo1Cnd2gpQGLnwFJLpr5vW83Y4IneF8pEqWZhH4R0jD5kiZb
	 AtwYwkRHy3ufNQZWQM/Ikvip8S9PgWIOiSxcdZ1uHjRAI4dMhBWDg1s/ormnLgbIwE
	 bLEcc8txhbO6w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH v3 11/11] mm/damon: add damon_ctx->min_sz_region
Date: Wed, 17 Sep 2025 09:00:41 -0700
Message-Id: <20250917160041.53187-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250828171242.59810-12-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 28 Aug 2025 10:12:42 -0700 SeongJae Park <sj@kernel.org> wrote:

> From: Quanmin Yan <yanquanmin1@huawei.com>
> 
> Adopting addr_unit would make DAMON_MINREGION 'addr_unit * 4096'
> bytes and cause data alignment issues[1].
> 
> Add damon_ctx->min_sz_region to change DAMON_MIN_REGION from a global
> macro value to per-context variable.
> 
> [1] https://lore.kernel.org/all/527714dd-0e33-43ab-bbbd-d89670ba79e7@huawei.com

I think I found an issue of this patch.  Please refer to the attaching patch
for details.

This patch is in the mm tree and not yet merged into the mainline.  Andrew,
could you please add the attached patch as a fixup of this one?


Thanks,
SJ

==== Attachment 0 (0001-mm-damon-sysfs-set-damon_ctx-min_sz_region-only-for-.patch) ====
From af4a31405f4d8c4e5b32f7244f0cdcf960dce30f Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 17 Sep 2025 08:31:54 -0700
Subject: [PATCH] mm/damon/sysfs: set damon_ctx->min_sz_region only for paddr
 use case

damon_ctx->addr_unit is respected only for physical address space
monitoring use case.  Meanwhile, damon_ctx->min_sz_region is used by the
core layer for aligning regions, regardless of whether it is set for
physical address space monitoring or virtual address spaces monitoring.
And it is set as 'DAMON_MIN_REGION / damon_ctx->addr_unit'.  Hence, if
user sets ->addr_unit on virtual address spaces monitoring mode, regions
can be unexpectedly aligned in <PAGE_SIZE granularity.  It shouldn't
cause crash-like issues but make monitoring and DAMOS behavior difficult
to understand.

Fix the unexpected behavior by setting ->min_sz_region only when it is
configured for physical address space monitoring.

The issue was found from a result of Chris' experiments that thankfully
shared with me off-list.

Cc: Chris Mason <clm@fb.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index fe4e73d0ebbb..883b0d886d68 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1435,7 +1435,10 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	if (err)
 		return err;
 	ctx->addr_unit = sys_ctx->addr_unit;
-	ctx->min_sz_region = max(DAMON_MIN_REGION / sys_ctx->addr_unit, 1);
+	/* addr_unit is respected by only DAMON_OPS_PADDR */
+	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
+		ctx->min_sz_region = max(
+				DAMON_MIN_REGION / sys_ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
-- 
2.39.5


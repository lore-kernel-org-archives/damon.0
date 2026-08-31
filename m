Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C94DB57C;
	Mon, 31 Aug 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186387; cv=none; b=dOXMWuFp+nlb17wg5Qz8t4pNxZgKr9v7c+jFMazqnsQFUomVgwiGnG/mxggY6YdtzLFrii7Eylu6eNsPkO41eVh3aRP9jiZwHxLX8C+8FOtkXQ6nIuPtIbVK/OOkyJ+Eb0s/yb89z2jqDdnjSZvVQsk0f8c9eSyhS7Y+A23pRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186387; c=relaxed/simple;
	bh=eydH6ZjzAqOngpgKfqYhz3xYjQQY7ugG8PooKaSRM+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uihii14zP5+8Kp3LMFaCddQDtypy3mLBgMGk+SBaXISMRx5U2RU5X4uiqd78D04uTaonCdPtFXrHb4KK7pE5b5zZuszZnPbMOeQKI8OlUb+Q/eCDZWD08B+RBSiX8l18Kx11JnuND/djSrSXd5ZbYodLk12ER7ky7+IMM+LbEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofv89aVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofv89aVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C751F00ADF;
	Mon, 31 Aug 2026 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186386;
	bh=++mDemjAm3frVYhBHw1yycvSVhXLn1wofYJdDWaaqD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofv89aVIYd0IbAdoYRts6tCrlsW/biaOf5xmsUAwpzPSRpgIs9Li1GKDDfQWI14Yb
	 nnk6MDzcjK6R/FR4tB182JY1qKk1vs1549StOht7tUz4YeFuUfI5tDZtBna2CypCHe
	 DGaLH/qRgrcC9PFGGGqARc8lR9t/QlmRJIASssB3Q4dKhmEjK+uwKCnACmz1E2yH++
	 mQFJWyWDCvdmRZbQgzbIFDjJxNzRl+TnuGvQClRTpbZDiNB4o8t6JDTkkuLDvvN+OE
	 6NOeWUCD05UHfY5cw5lGV9UEYz4qDnESis6u7yBZ2djBgHEi3AObxBKRtyjD0SDu2j
	 aWA/dW27t3FGA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Enze Li <lienze@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/7] samples/damon/mtier: add comment for struct region_range
Date: Mon, 31 Aug 2026 07:26:09 -0700
Message-ID: <20260831142611.77572-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831142611.77572-1-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Enze Li <lienze@kylinos.cn>

The mtier sample defines a local struct region_range using phys_addr_t
instead of damon_addr_range which uses unsigned long.  Add a comment
explaining the rationale: on 32-bit systems with more than 4GiB memory,
phys_addr_t will be 64-bit while unsigned long is 32-bit.

Signed-off-by: Enze Li <lienze@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260721070756.54435-1-lienze@kylinos.cn
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 samples/damon/mtier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index d1123ebbfab90..bea45c87cc9be 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -52,6 +52,11 @@ module_param(detect_node_addresses, bool, 0600);
 
 static struct damon_ctx *ctxs[2];
 
+/*
+ * Use phys_addr_t instead of damon_addr_range (unsigned long) for physical
+ * addresses.  On 32-bit systems with more than 4GB memory, phys_addr_t will
+ * be 64-bit while unsigned long is 32-bit.
+ */
 struct region_range {
 	phys_addr_t start;
 	phys_addr_t end;
-- 
2.47.3

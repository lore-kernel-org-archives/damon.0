Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632085;
	b=Jz4+SiWt3TzlVMX45txOdFwnvUaDfo6HZRaxVXcK8u9kYwZrUqMxki8EYLISk0638D4R
	 A9YF9Wce17m14sYE/uNyisDRf3ZPARTUWv9JKCglIlDW6Hdvl/QCsh6sBj9B0bTuEgsRT
	 M5kCLBP9EyjDngglxVtBYY6gHKeoAYaG4/Uaj+71tDKVpXbmd3e2sF8s62XgnVk7jCc4W
	 ZU4K+NrYBxxan/+Jh82hFPQHsBtIpTqu9kzufiXt76Q/6AlFEPku0Vf98MU3UcH2KIYTH
	 OCl12CyMFFAf9WHUkoa1ED2KLw1VQv3yAFUdZvW9KZncMM3KekgNL3IrsIaZCX6pjCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632085;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kjesFWiEFML4rVzuVYdu4iAghuO52PLQ0oTZPIBhKvg=;
	b=MO1dMyyWhIJr+hvTkPV1RvbNf2E/81IBd9p/TmO1PKV5eVReGRglhRwgX6IppFfogc2i
	 HPd/NgkfkppWKycmbSaI8+yo5Qo4NJyMtEClix9A4aw6Bz0r1AGTuMG6BkTvLUFOd1ZAR
	 VXyuHkIiVZmEHIsUpjcpgLOWlCTamndpMVte2acOBuLFC505umhhT5d6YEqnBlp/aCN2a
	 FhzzPR4q9aoTP1mZtVG1TT+KMD436nnFhymukS1ata5ai6b382pMwT+mcxPE0CTO5HS/Y
	 LDVxMjhSrI4Q8FLyq1lOcr0vpduazjI0KdAOij+2ee5x3Vs+V+v24OTVEEwfblIq9Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QswZGkVT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8760A0FDB;
	Mon,  2 Nov 2026 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QswZGkVT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357CF1F00A1A;
	Mon,  2 Nov 2026 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632085;
	bh=kjesFWiEFML4rVzuVYdu4iAghuO52PLQ0oTZPIBhKvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QswZGkVT5q5HQbBhg/cqAiBnSytNeCEt+MzKd4t2XsL+eH2BBH193OMepSCFiwW6h
	 EIGw5vCs85k9wFPzoFOIC8Mb3eYr3dw9kPQC7uDZVHdhs0BPC4qKHVOPChCbrB708p
	 9tUXS+9K3vrRx4ZWBZCM7geTQi/cukQtxSH0wp3D4vtnn81F1/wd59Pcu0gaj2pfQK
	 wLFrHo0LyE2Pm/WuaBI2neaOEYisozxX2kGss6J0kSShJWs7q0fDFl8cqDyAbX48QI
	 uTWBa+hxWg8xcJmgg2+ybj8mQuTcpTy8WzaLFhhMknmLlPz0I64Xmj/EeE5vMIHdEi
	 K41fs/H3P3cxA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/9] mm/damon/core: remove unnecessary zero-initialization in damon_new_ctx()
Date: Mon,  2 Nov 2026 07:07:48 -0800
Message-ID: <20261102150757.93058-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102150757.93058-1-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>

damon_new_ctx() allocates the context structure using kzalloc(),
which already initializes all fields to zero.

The explicit initialization of passed_sample_intervals,
next_aggregation_sis, and next_ops_update_sis is therefore redundant.
In addition, they are later initialized by kdamond_init_ctx() before use.

Remove the unnecessary assignments to simplify the code.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261016143733.320-1-adrianhuang0701@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 mm/damon/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7441cdea57dc5..9d54899004026 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -918,11 +918,6 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.aggr_interval = 100 * 1000;
 	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
 
-	ctx->passed_sample_intervals = 0;
-	/* These will be set from kdamond_init_ctx() */
-	ctx->next_aggregation_sis = 0;
-	ctx->next_ops_update_sis = 0;
-
 	mutex_init(&ctx->kdamond_lock);
 	INIT_LIST_HEAD(&ctx->call_controls);
 	mutex_init(&ctx->call_controls_lock);
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E8233711;
	Sat, 17 Jan 2026 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672385; cv=none; b=ZZrYjBNJiRnmEAu+P7iCNyEhzs0ad97Ff7Zi/nJVz5CN90oTK5UOiYONWaVf38SRUC8gYIi5oI7nVFGT5/E0ffdluC2kduCf2XWMulh1sME7JkkoF2PcaXc0UkTMIcNlbArFwyFS09VGUf4wBsbqbm2yz9oZB5ckLXk+p+anrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672385; c=relaxed/simple;
	bh=AH/DZBwYEbnLl/A558vtilxxCPLZZlZguhHUqR5KoKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxjLyFCr71TAxk/oxqUxjCH0KR2PkvVicmGx4wnJSquSX1qNb9fRxQM20ymXZSHt0xLLkiTtzYhjwIc4usdfSizjU1jQUsVK1CIB79Zm7QcTHbvYn68qCHo2AUBkAldW+mHBBhptupPePKaUPqpvNTmlWFQS1/vFZusQnV2LrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRo/RGFb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRo/RGFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3594C19424;
	Sat, 17 Jan 2026 17:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768672384;
	bh=AH/DZBwYEbnLl/A558vtilxxCPLZZlZguhHUqR5KoKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRo/RGFb2F1Gvvj5IoUxCZoRDJzJrhCdh704F49bhGjp7psN3RSMgSFfPTx5V5gxX
	 O8huFE/LLrRSypF/OgWTE4yjXVLTV6Sa4MQ+ylPhEPONuEpHmZEMqm7j2g0B6HKAlf
	 diUk1K/CyqRrUiJA7e5RM2L9/nnMN1M/GcGi7+PThcGvG/8yNEJbniYaYg6sw0Yg3b
	 MylR0Xq7YxkgxsHm06EYJ7Cx8kI/sjKrlJhfy2Lo6kycV6JkenhPbFQvy27aoDBf2/
	 ypSdQJ2r+AGAjcP817uLI0hkpjCeABas7o6uHL7wdA4fqjk9yUl5PJP8nn3AslCz7V
	 5s8mqpq/NrGRA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mm/damon: remove damon_operations->cleanup()
Date: Sat, 17 Jan 2026 09:52:48 -0800
Message-ID: <20260117175256.82826-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117175256.82826-1-sj@kernel.org>
References: <20260117175256.82826-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_operations->cleanup() was added for a case that an operation set
implementation requires additional cleanups.  But no such implementation
exists at the moment.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 ---
 mm/damon/core.c       | 2 --
 mm/damon/paddr.c      | 1 -
 mm/damon/vaddr.c      | 1 -
 4 files changed, 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e6930d8574d3..bd4c76b126bd 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -607,7 +607,6 @@ enum damon_ops_id {
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
  * @cleanup_target:		Clean up each target before deallocation.
- * @cleanup:			Clean up the context.
  *
  * DAMON can be extended for various address spaces and usages.  For this,
  * users should register the low level operations for their target address
@@ -640,7 +639,6 @@ enum damon_ops_id {
  * @target_valid should check whether the target is still valid for the
  * monitoring.
  * @cleanup_target is called before the target will be deallocated.
- * @cleanup is called from @kdamond just before its termination.
  */
 struct damon_operations {
 	enum damon_ops_id id;
@@ -656,7 +654,6 @@ struct damon_operations {
 			struct damos *scheme, unsigned long *sz_filter_passed);
 	bool (*target_valid)(struct damon_target *t);
 	void (*cleanup_target)(struct damon_target *t);
-	void (*cleanup)(struct damon_ctx *context);
 };
 
 /*
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 81b998d32074..53514cb712cf 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2859,8 +2859,6 @@ static int kdamond_fn(void *data)
 			damon_destroy_region(r, t);
 	}
 
-	if (ctx->ops.cleanup)
-		ctx->ops.cleanup(ctx);
 	kfree(ctx->regions_score_histogram);
 	kdamond_call(ctx, true);
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 4c2c935d82d6..9bfe48826840 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -373,7 +373,6 @@ static int __init damon_pa_initcall(void)
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
 		.target_valid = NULL,
-		.cleanup = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
 		.get_scheme_score = damon_pa_scheme_score,
 	};
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 23ed738a0bd6..40c73adf1946 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -1014,7 +1014,6 @@ static int __init damon_va_initcall(void)
 		.check_accesses = damon_va_check_accesses,
 		.target_valid = damon_va_target_valid,
 		.cleanup_target = damon_va_cleanup_target,
-		.cleanup = NULL,
 		.apply_scheme = damon_va_apply_scheme,
 		.get_scheme_score = damon_va_scheme_score,
 	};
-- 
2.47.3

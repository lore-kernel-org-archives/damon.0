Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32883370D47;
	Thu, 13 Aug 2026 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593013; cv=none; b=EZtfgefvv6UHp9/U16K4aCt0O0diLetsfM/+4Y99jiKO1zNkR00bCXIk0IVSkjv4r8b/xHDhZzf9VPOcBsgdKS6ymDUKOyExMllhYHGF//enuJk47aWIkT+757S0sK70rP7fIvVUWA4RBW81lblbeXXExmB7QARLOMbPJliI1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593013; c=relaxed/simple;
	bh=IzZH0KLtVQFZQRWLGKYTWw1G13IZ+dPrZMm6NGIzIUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGeACiVO2ORbnpHnoV0EWaaImd6oGX+MHIIUZyV6Rg9WT4kmYqkxUHZemuxPOYUbw+MHgXm9DTETKQstk/bg8KocZWPFtQUHGb+1fKuNVN3eOqs3J9rPV1aqextNUu2TKHRHAAjq/VFagrsQDOlgz6/rkZPS4pd+QzlvuqqRd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3FcusnP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3FcusnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D4A1F00A3A;
	Thu, 13 Aug 2026 03:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593009;
	bh=AIpHwpSSS3esAV2BDnJ9BAffq+YFA4gOCk++VRGi3uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H3FcusnPSKD7eR3+hfvXu3GeDcUbm4gEBBey02p7UEbMUK8JxSmPyxQ3dGc+w2QaZ
	 cte+MAnkoXvhiDbEXJjXUnEk9/Fy1NjaOzEqwHbCB3kouVGJIJrfdLBxnWtKVG9dks
	 rsblvXbYZkHeHuqoZQ8sgz43sSUPnuJipKzBiRFEkPFfs9IBMXxMH1VHeDWJ/NwR1C
	 bRUF6UHU4GNXneoDX+kDjGI5le4gJu+lTfNUmLYFSKHWoCweehU2zj/AK0yF67uV1J
	 FDQ/mbmNjXRSR6wz2F41lTL02PLhwFguE9mPamMVlXP1+VJ2mxxPn2IXUKE1e9iv/A
	 l6eIobiGU0wDA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()
Date: Wed, 12 Aug 2026 20:49:57 -0700
Message-ID: <20260813035001.97364-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813035001.97364-1-sj@kernel.org>
References: <20260813035001.97364-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_ctx->call_controls_obsolete is used to disallow damon_call()
requests when the request cannot be served.  The field is unset and set
when the context execution is started and terminated, respectively.  The
intention is to allow damon_call() requests only while the context is
actively being executed.

damon_ctx constructor, damon_new_ctx() unsets the field, though.  As a
result, passing the damon_ctx parameter that never successfully
damon_start()-ed to damon_call() can indefinitely hang.  The callers
should ensure to avoid the case.  Such parameter validation is not
always simple.  Actually such bugs in DAMON_RECLAIM and DAMON_LRU_SORT
have been found and fixed [1].

Set the field in damon_new_ctx(), so that DAMON API callers can pass the
context parameter to damon_call() without the additional check.

[1] https://lore.kernel.org/20260803134646.16640-1-sj@kernel.org

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5882f9c94c47f..5a92e4fac6d92 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -920,6 +920,7 @@ struct damon_ctx *damon_new_ctx(void)
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
 
+	ctx->call_controls_obsolete = true;
 	prandom_seed_state(&ctx->rnd_state, get_random_u64());
 
 	return ctx;
@@ -2178,10 +2179,6 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
  * synchronization.  The return value of the function will be saved in
  * &damon_call_control->return_code.
  *
- * Note that this function should be called only after damon_start() with the
- * @ctx has succeeded.  Otherwise, this function could fall into an indefinite
- * wait.
- *
  * When this function is failed, the @ctx is guaranteed to be stopped.
  *
  * Return: 0 on success, negative error code otherwise.
-- 
2.47.3

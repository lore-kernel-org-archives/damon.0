Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8BF3375C3;
	Thu, 28 Aug 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401169; cv=none; b=T1Gj4fRIhWcXkrOCEmCwAavEQI8RkDhMLO2b4ib30cP86niqgz5SK0lX3j7sbzteY3irHulEDbXyjCKMwahrpO2uIHkHwcI+cZkm2dsjtRxhJqNj5fDjx6oysWueV9gW0SiQMsBoiuzUYZMXcghgaYyTAX8RMkbxuURDU6yruKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401169; c=relaxed/simple;
	bh=V00Ezz8Ti9dBe1Ak1a5KDdHP0ELwfwe8yMUv7LlWbPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eh1iaQuGYLdcKp7GF8n5i2pZ2+2f0CfbtLNJc80sH3lw29069LLIwtQ9UW/SrWcpEX6qN+uRPQuiSOBlIXz/R6dF/a0tHhcBqwYOuuBo6MOlfCeoPxifZlgvVykTnvT2L8U5nhUh84y5sxRbgR0S9K55R9yv20zjBSdB4Z9eOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaUpxdvz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaUpxdvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66073C4CEED;
	Thu, 28 Aug 2025 17:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401168;
	bh=V00Ezz8Ti9dBe1Ak1a5KDdHP0ELwfwe8yMUv7LlWbPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jaUpxdvzwwym0dlXeMFT+KGkRyAyLcOmfh1XaxJ6PQ2LFMXvXYB06OBDEQdbjg4o/
	 fF9cV3X0q+tdhnJaLYSTQ6gPIeQX615Jskmq5ZEqz3AgoKz87zh8HndeImZRRCQ9JO
	 Z7sCkYsdwdS92Q5unjCX+cvUTbu2ynw9OTkrdmDQ9YCuF9vN0WQHKVnKlav/EYb+cA
	 ZOhCiPJhMHs0k2UD0Obf7mN2rq4gQsEwYt/icehBaA5sz3A+83wEcDg0BzFhQ9q9q1
	 xYEv36Vn+4vPlN8grelrrG3aVTrfKo3cSkBDOC54Eq3tOzdDG4GHkeY9wwfmTxBjmf
	 T5+YPJY6kiyJg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: [PATCH v3 01/11] mm/damon/core: add damon_ctx->addr_unit
Date: Thu, 28 Aug 2025 10:12:32 -0700
Message-Id: <20250828171242.59810-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250828171242.59810-1-sj@kernel.org>
References: <20250828171242.59810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases, some of the real address that handled by the underlying
operations set cannot be handled by DAMON since it uses only 'unsinged
long' as the address type.  Using DAMON for physical address space
monitoring of 32 bit ARM devices with large physical address extension
(LPAE) is one example[1].

Add a parameter name 'addr_unit' to core layer to help such cases.
DAMON core API callers can set it as the scale factor that will be used
by the operations set for translating the core layer's addresses to the
real address by multiplying the parameter value to the core layer
address.  Support of the parameter is up to each operations set layer.
The support from the physical address space operations set (paddr) will
be added with following commits.

[1] https://lore.kernel.org/20250408075553.959388-1-zuoze1@huawei.com

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 ++-
 mm/damon/core.c       | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d01bfee80bd6..6fa52f7495d9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -746,7 +746,7 @@ struct damon_attrs {
  * Accesses to other fields must be protected by themselves.
  *
  * @ops:	Set of monitoring operations for given use cases.
- *
+ * @addr_unit:	Scale factor for core to ops address conversion.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
@@ -788,6 +788,7 @@ struct damon_ctx {
 	struct mutex kdamond_lock;
 
 	struct damon_operations ops;
+	unsigned long addr_unit;
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5ac1433860a3..acea2964b9cc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -544,6 +544,8 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
 
+	ctx->addr_unit = 1;
+
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
 
@@ -1245,6 +1247,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 			return err;
 	}
 	dst->ops = src->ops;
+	dst->addr_unit = src->addr_unit;
 
 	return 0;
 }
-- 
2.39.5

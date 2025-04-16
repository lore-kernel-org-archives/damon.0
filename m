Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE525229B03;
	Wed, 16 Apr 2025 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777558; cv=none; b=kUhtwpHBL76o4uqLoU5QXieHF2C2+nzr3dTkp1nDuBozzCjVrOUvLG9b+3GsIdl/IcnzpmopvFtOsRViUnmvudEkG0DMB1FTMvS+7FqaFtyYdu+qAHXAJ3o7lkTPqIR0Rcw2XnYvFLmkkLw7ssP/uUhx9lVFi5xIbaxVBQDUQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777558; c=relaxed/simple;
	bh=DI/+42QRjozKh0I6c9tmubfnqOkscfgHWXe6sW2fWEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqh7B130OP56irL90l/bXlvBRdOEodfRNa4x98kwq41SsMPb2EJ7p5kEfxjDQt5lFLubyiEbw8RxXDkHKZZrmD5j1lGdWSSdQVD2j15vKIBDmkrL01BmuWlHQGQAWHIV+MryOM/KQm27U+3X93N8qGY7hltmBKHiu9HjKdRwFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBlHAFNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBlHAFNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A36C4CEE2;
	Wed, 16 Apr 2025 04:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777557;
	bh=DI/+42QRjozKh0I6c9tmubfnqOkscfgHWXe6sW2fWEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBlHAFNHA6AGteX/C6iyezt/7ympaayomg+4W7k6xu8PVng3whKJjnmjWkRAv6yqw
	 19Q0cOeyHNS4LQ4tZ6/n3KEgNeLQ9G294OWrSzuuVnDpbbsVpF1E/cnKjzpIqqBfqY
	 e+n3SOMpopHHFoM//vBjmRCMuzmAAzTLNeWtG0i3fGgR8yX1Weg5I3FfZnf5xTkz5M
	 QEpr4O6EuogBonhDDz4ZPq+8Xm4fCzfHeGwSE52rYR+FN6G9+fOckZ0DdLeIl7gj79
	 0nS3ZCn5xZcMuTYiNoLGmurHxP/97Te70wBA9lQUQzFqUiTS7zFtS/Zevj56xnXG7+
	 J21l1/ydYuQ2w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ze Zuo <zuoze1@huawei.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/10] mm/damon/core: add damon_ctx->addr_unit
Date: Tue, 15 Apr 2025 21:25:42 -0700
Message-Id: <20250416042551.158131-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416042551.158131-1-sj@kernel.org>
References: <20250416042551.158131-1-sj@kernel.org>
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
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ba3604cd4d60..4ea6f07f390b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -775,6 +775,7 @@ struct damon_attrs {
  * Accesses to other fields must be protected by themselves.
  *
  * @ops:	Set of monitoring operations for given use cases.
+ * @addr_unit:	Scale factor for core to ops address conversion.
  * @callback:	Set of callbacks for monitoring events notifications.
  *
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
@@ -817,6 +818,7 @@ struct damon_ctx {
 	struct mutex kdamond_lock;
 
 	struct damon_operations ops;
+	unsigned long addr_unit;
 	struct damon_callback callback;
 
 	struct list_head adaptive_targets;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 587fb9a4fef8..b78217ad3c5c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -535,6 +535,8 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
 
+	ctx->addr_unit = 1;
+
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
 
@@ -1150,6 +1152,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	if (err)
 		return err;
 	dst->ops = src->ops;
+	dst->addr_unit = src->addr_unit ? : 1;
 
 	return 0;
 }
-- 
2.39.5

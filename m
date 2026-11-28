Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795892441;
	b=QVThyP88rl+JD1DSXQ1fr0jBjTmD8w6LiFCCNhov9Ge4VgQAelDKMpeT1nx8OuGMIQIK
	 PQL8j/PkFd22X7Y7on06DTFYXjwJag/uryTBwbfU9BUqiCnG1/Kh4/LoftvYVIq6nA9pq
	 m6R3uOkQLWncs4u2qXj+ekzKLq/7FXfbBLqnjvfA29I1H+qToUUUcv8ZMRywk/yTxPP4Q
	 e+DrYlw18aiEB9rv1lzml4Wk3AhKBanfLRqA993m/qf+7HhjcJ3whx1EXgxIh0hEBP31Q
	 Fxtb/muVTGLWAyUoz7Z1JfOory0Mgvyawj1e/DixeoP+bsIC9qdisU5tEg0PKPQ+rrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795892441;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IxWeI1AnBPXcFCHBx5zggfRRWwnTXk9JMFJgB2yNHlM=;
	b=GA38H+eEJqeE2ZSduKsIdChE7iMvNcWZAHmADP5NGHZJps64wcHFXNlSP5CTTpFH1J92
	 dSO8CQNdswgUW9iQ2i11Iv1spG9MbXLVyF0FDNRpFoZpfgggzzlewI7Q+T53GUifUqWh0
	 aogVJRSxNXeOp306Nezq+Eoo/38Zk+dZPeYG3LBc1ItPlYTlxMwlD/fGkrktVb8WFL0+h
	 b9yxfNUDTaQpCF8L9uaztFxWkrtJZ2zbBYMgsuy6XsqyyHOLf5oeAX6QxcRoTFK+6Z85j
	 6dZ42rPLEhmwUcoiSo7pq5jJ54XionG2UMXWMlxpO9NTvH6UMOXzPWQH5kFQTfrhl+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q50MVvmT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC7606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q50MVvmT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890D11F000C1;
	Sat, 28 Nov 2026 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795892441;
	bh=IxWeI1AnBPXcFCHBx5zggfRRWwnTXk9JMFJgB2yNHlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q50MVvmTJAlDrORmVSD1wqUJhBJN/I5m2GJARgQbWAsM0tgT+lwoEhqnhldfw9+F8
	 2+yI6L4MgYVfrHQomffw4WLxG2QfsIspdzi7+kIeYBIhBjgnkbFiRT4w6DL5aEInRc
	 BJ950miShVX+n0xzHytdtmp8CGwcf5j2FispoNUhMtZ0OnhAEN9YthFynmtLxlbUM+
	 gLFEvEULzm2yMPxigZicHBGzBZ0WdyuApcG9o96SiRh9dfabBLlyrIZNyAvjuIrRf4
	 lHADUt7YUO+hCb8K3AcpsazkMfOUxxUZGKQ+aS+IKpSm1Iu6WrNbJoDNyvBOkGw5IB
	 BG3lPf+h6pDvg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 3/7] mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action
Date: Sat, 28 Nov 2026 11:00:28 -0800
Message-ID: <20261128190033.164440-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261128190033.164440-1-sj@kernel.org>
References: <20261128190033.164440-1-sj@kernel.org>
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

Support of DAMOS ops filter and sz_filter_passed support is up to each
operation set.  DAMON_VADDR supports both for only damos_stat action.
It intentionally does not support those for madvise-based actions
because applying filters could make it unnecessarily complicated and
expensive.  The vaddr implementation of migrate_{hot,cold} action does
support DAMOS ops filters but sz_filter_passed.  There is no real reason
to not support sz_filter_passed.  Add the support.

Pass the sz_filter_passed pointer to the filter applying logic and
accumulate the number.

Closes: https://sashiko.dev/#/bug/linux-986e8b64-8e65-4e32-970f-4d3ebdf8206e
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index fd649cd335c9..170f77f74e84 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -776,6 +776,7 @@ static bool damos_va_filter_out(struct damos *scheme, struct folio *folio,
 struct damos_va_migrate_private {
 	struct list_head *migration_lists;
 	struct damos *scheme;
+	unsigned long *sz_filter_passed;
 };
 
 /*
@@ -849,6 +850,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct damos_va_migrate_private *priv = walk->private;
 	struct list_head *migration_lists = priv->migration_lists;
 	struct damos *s = priv->scheme;
+	unsigned long *sz_filter_passed = priv->sz_filter_passed;
 	struct folio *folio;
 	spinlock_t *ptl;
 	pte_t *start_pte, *pte, ptent;
@@ -867,6 +869,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		s->last_applied = folio;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
 			goto huge_out;
+		*sz_filter_passed += folio_size(folio);
 		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
 				migration_lists);
 huge_out:
@@ -897,6 +900,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		s->last_applied = folio;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
+		*sz_filter_passed += folio_size(folio);
 		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
 				migration_lists);
 	}
@@ -975,6 +979,7 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	priv.migration_lists = kmalloc_objs(*priv.migration_lists, nr_dests);
 	if (!priv.migration_lists)
 		return 0;
+	priv.sz_filter_passed = sz_filter_passed;
 
 	for (int i = 0; i < nr_dests; i++)
 		INIT_LIST_HEAD(&priv.migration_lists[i]);
-- 
2.47.3

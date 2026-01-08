Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF323221FB6;
	Thu,  8 Jan 2026 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767835869; cv=none; b=MpEJojFbAaoQB4jtcKkWS8mAP7n69AISrLJmAuzL8IMkserJMEi5kv6iRtwYM+jnXRocw7ZLekMRpCL5BN91MSWg1poBfSvgwOFV//mMOeJ9UeTdtBttk/pPAqzcuzI/JJUrKmH2xXfuEK4a3TnFK31ggVuhNXN1kZqDNHcIVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767835869; c=relaxed/simple;
	bh=jqQybe765b7V3vpl7bLtb/2Dt7yGTpnbwerkN0QRAY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXuBzFk1qkPXqSKwQigfI3FN3syG3nGW2Ep61t3RVt1BGpK9D55VkwOGKTl9nocF8PPhoy5yV+/gZyUoS2HPT7HD7UVcmctWXeEANdD3GIM5WddsbxFXrDwwPBa7dOqjcHcONaIplqHOr/AnDQ9wTCRYzwcLuYRh1QpuWY5w+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTPXBHjM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTPXBHjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11192C4CEF1;
	Thu,  8 Jan 2026 01:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767835864;
	bh=jqQybe765b7V3vpl7bLtb/2Dt7yGTpnbwerkN0QRAY0=;
	h=From:To:Cc:Subject:Date:From;
	b=hTPXBHjMS37oqA9nTxNB/orN4bD6O0KQXXtvraQGHyYTlVNA4nrkAvNL/+lN0uasA
	 QkZcyCextiroPHZB1lHHBkMXYXd9gjYdhjF79O44Nv+nMlCYdB6DzHJUI14lTEsKhU
	 /LnZyrDWWskQoPqqKcAFZOrYqi9fVT7Tzpb8wlzYVR1Bjz4eqRH1wPaTFqvXjjQA08
	 xCbvHW3tWt+xkVo0DW8hCmXeUXjMCqAc9M7ZssOYBvjpqPACsPN+89Fq01G9Juy+4N
	 pzzGqvKg0/O2c3jymEsOKCfw1IWUjzvFH/5w+WTwMMs3kJgjrOHlWDUvqxOCzBUUHh
	 Oep+kHjOrWjYQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aaron Yang <yangqixiao@inspur.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3] mm/damon/paddr: initialize 'folio' variables to NULL for clarity
Date: Wed,  7 Jan 2026 17:30:38 -0800
Message-ID: <20260108013041.80601-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Yang <yangqixiao@inspur.com>

In damon_pa_mark_accessed_or_deactivate(), damon_pa_pageout(),
damon_pa_migrate(), and damon_pa_stat(), the local variable 'folio' is
declared but not initialized.

Initialize 'folio' to NULL to improve code readability and
maintainability.

Link: https://patch.msgid.link/20260104013255.16962-1-yangqixiao@inspur.com
Signed-off-by: Aaron Yang <yangqixiao@inspur.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Changes from v2
(https://lore.kernel.org/20260104013255.16962-1-yangqixiao@inspur.com)
- Wordsmith comment for the purpose of the change.

 mm/damon/paddr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 07a8aead439e..7d887a3c0866 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -156,7 +156,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 	LIST_HEAD(folio_list);
 	bool install_young_filter = true;
 	struct damos_filter *filter;
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	/* check access in page level again by default */
 	damos_for_each_ops_filter(filter, s) {
@@ -212,7 +212,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		unsigned long *sz_filter_passed)
 {
 	phys_addr_t addr, applied = 0;
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
@@ -262,7 +262,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 {
 	phys_addr_t addr, applied;
 	LIST_HEAD(folio_list);
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
@@ -295,7 +295,7 @@ static unsigned long damon_pa_stat(struct damon_region *r,
 		unsigned long *sz_filter_passed)
 {
 	phys_addr_t addr;
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	if (!damos_ops_has_filter(s))
 		return 0;

base-commit: 86666ce88b232c311d17ff74d74a2ef3215b9eb5
-- 
2.47.3

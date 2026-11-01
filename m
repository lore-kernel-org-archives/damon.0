Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553399;
	b=GtD91iT95qe2nO+hBif5jnj5wpfMgguuVecD/sIc1C9LAI/MMiMPNnnOjLQTn3X1AFi3
	 2zl7G0U4H5McaqaaFrfoqLb0ATDlfVa5W7lLNqs6CrVUvfLmymFAglQI0d3tivZYbgnK/
	 9rFNrZdf8ycOemBuf7l0grv9xCPD+h1T4h5chrm2sC/BCRrJCtjPZmFzuGoCNeDymFGl3
	 znmVyRgpAcw/rCztoKxLqRR97tp5sB42SbTpMqx23Z9hEl5p0GKpi4wovWSM5A02he0te
	 lz8fYzelhA2aDl4kvbNza5cWEv0BEKHDKlSw5dc74888FBesiK1mPZNXuh1njc6JbHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553399;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gY/iCu9E5Cwctk0xMV73TTepjgVS26fxiMdC6yjt3qQ=;
	b=4FRdy7cUv+e3VWMh19vM/Le8Ge0WyBSwbQSTiAAaQggAVg4uaebWoD//beJWcsJ/kUwN
	 9hRTSsGXVN2PfQTdtZW0F3HWn6KjiRs+7AMdl/3ztEKKXUyGVhfsJMwKChyF5fakbWjkV
	 NrHdSS/tnyfAK9JQr9Iwb3fbMxTI8xUNuByrTh1g5tzU0bGj0j0nZDsoBqICCGl6xLkvf
	 w6IZSQI7axurHDpu1qtCkV18BsEn0h61qQWqhtaCi6mv3+UGAL2W2FwiC2YG9luvqPQHC
	 COs7Pht9GFLQM1WioxPemJNSZsr+1o88zUPWfbxk45Fcs3wYc39bwAEaodSk2VcFQjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3nIKHnK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B0606A335;
	Sun,  1 Nov 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3nIKHnK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1876D1F00A1A;
	Sun,  1 Nov 2026 17:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553399;
	bh=gY/iCu9E5Cwctk0xMV73TTepjgVS26fxiMdC6yjt3qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f3nIKHnKutETK10+wjRGjPR+4SXlpJJGTlWtLynLWvfshUsh3PV7ySN632Xw3qMFZ
	 hMS620cTSQAMCEhDshe7oVfZhV3ZnFP3RphoST+FyVO17Pt6w0oXJsQBDrocAfnla8
	 f0ROXcajz7X6IxUwMHrB5ndODBkE0MJ5MOyNrUa3krHqW7QmRT53FC79vyCkpUXRti
	 xmpQE6uIKZd3LZoF6wkfhV0WQ5Fmi+xzi9tICVI1hDagPa5VFjU6FRsebw18SGsA24
	 Tme9SkcsEqDVu7mXEum26jXlGFqq0ivc+q29tNvirvytF5ECh9TrAMA6DlXIBUHCq1
	 /ZHz1h1EZZ5zg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 3/6] mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action
Date: Sun,  1 Nov 2026 09:16:26 -0800
Message-ID: <20261101171630.81477-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101171630.81477-1-sj@kernel.org>
References: <20261101171630.81477-1-sj@kernel.org>
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
 mm/damon/vaddr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b1d7bcf7305bb..6fd0e07b60705 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -776,6 +776,7 @@ static bool damos_va_filter_out(struct damos *scheme, struct folio *folio,
 struct damos_va_migrate_private {
 	struct list_head *migration_lists;
 	struct damos *scheme;
+	unsigned long *sz_filter_passed;
 };
 
 /*
@@ -846,7 +847,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct damos_va_migrate_private *priv = walk->private;
 	struct list_head *migration_lists = priv->migration_lists;
 	struct damos *s = priv->scheme;
-	struct damos_migrate_dests *dests = &s->migrate_dests;
+	unsigned long *sz_filter_passed = priv->sz_filter_passed;
 	struct folio *folio;
 	spinlock_t *ptl;
 	pte_t *start_pte, *pte, ptent;
@@ -865,6 +866,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
 			goto huge_out;
 		s->last_applied = folio;
+		*sz_filter_passed += folio_size(folio);
 		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 				migration_lists);
 huge_out:
@@ -893,6 +895,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
 		s->last_applied = folio;
+		*sz_filter_passed += folio_size(folio);
 		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 				migration_lists);
 	}
@@ -971,6 +974,7 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	priv.migration_lists = kmalloc_objs(*priv.migration_lists, nr_dests);
 	if (!priv.migration_lists)
 		return 0;
+	priv.sz_filter_passed = sz_filter_passed;
 
 	for (int i = 0; i < nr_dests; i++)
 		INIT_LIST_HEAD(&priv.migration_lists[i]);
-- 
2.47.3

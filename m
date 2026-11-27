Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818448;
	b=m+FaPeUfx2Ui8LpgNL17L93UQH6zVEESEPJOqd7AVoZJJNl7fagQEP1vdOGAVoMHSZDX
	 CYhLOnO+huN+Lxr/1UclMnsEWgUQLP0KPcs3iMHqU1ElX+eUoUcBaUcFn5dhCUDujVsYP
	 IxYIKTzVkmM9OAbRlFr6BzDY3W4+D1H9858yu39TO+izq9yphVOBPjwO52ZZpuJgi2/mv
	 oFDeIqPriaiYH7kqLt2OBJ43lYtlSp6pjrnYIT8H1OC1XwQZnSpVccZ++wFw/E/u26145
	 7ITvDhXUHRlmcsLrZVgp9u/ql71FqHesGmgRKieMfqj1Z4O/eI0IphLxXvPQjnoDdfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818448;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Pr59TfKsEQXmZYB8xZ9SJvEMJ1RSajI/gLHtLxiB0n0=;
	b=jWOJstDt5iqMOTp8t0lvZHywp3enR9CaHrvTHN4boUMCyX5/GTJH80m+Gmr5LwV9wqmV
	 a8nZBMAhgavkmVKxOBWGMPIPEnp2w7mAJYkcYyJxYMDZ4bPQ3KW9QvtcaQvH/jfKgIlZh
	 DtqpDWrU2Jjr4AuabCJBdvPqIjSzWJyECQH6iXQlvBtkJW0gFF/SQj81m/vcLX1JIKkLV
	 +LlLwBdYCtgWnpws5XXeDBKtvlXFZQZ3C6JNuyG7mRPU3XahNp78+5YcQeQSh05S12eDx
	 F0jzYGuWzb3mGrDfWFRwaH8+NHpCtDBcw3/DcpR+x7Ny82EjK0+cOjsLlAV6F/J7NiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWvDTCqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D3606A31E
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWvDTCqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120871F00893;
	Fri, 27 Nov 2026 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795818448;
	bh=Pr59TfKsEQXmZYB8xZ9SJvEMJ1RSajI/gLHtLxiB0n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JWvDTCqydCbTjeSN9O0anTQmaBtZ9IcQJ+9yOLRzeUQYgMpEIXb5b8tu3nD5dyEBY
	 f2VaOYCuHDrMDYBuMvm7aL/xqvNcyozA+e++GFy6nuZamj4NuYsfh/rU5G1Y3QGrjI
	 lIeC3oxSrQsteyiMa1hRTjVuSO2DzSHhElnIqJzBl9vzgi5nZiqkGIzRpBSGeEZVuP
	 aPvOwFJE9PB/DBdBut/xoZyFPuWwAehnpQH6I2OTHOhi4vqmm4Rpf+HPaci8SkNOOr
	 rbcCuzi64pWp2HHX+10jbG3LTcKjhr4pKVICm2y8tKUOubjINz86I7zwNOdAOUzifQ
	 PVLNz01dqysNQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 3/7] mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action
Date: Fri, 27 Nov 2026 14:27:14 -0800
Message-ID: <20261127222719.105510-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127222719.105510-1-sj@kernel.org>
References: <20261127222719.105510-1-sj@kernel.org>
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
index c8f93a19c840..721a23856ee1 100644
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
@@ -895,6 +898,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		s->last_applied = folio;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
+		*sz_filter_passed += folio_size(folio);
 		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
 				migration_lists);
 	}
@@ -973,6 +977,7 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	priv.migration_lists = kmalloc_objs(*priv.migration_lists, nr_dests);
 	if (!priv.migration_lists)
 		return 0;
+	priv.sz_filter_passed = sz_filter_passed;
 
 	for (int i = 0; i < nr_dests; i++)
 		INIT_LIST_HEAD(&priv.migration_lists[i]);
-- 
2.47.3

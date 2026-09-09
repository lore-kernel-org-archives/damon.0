Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931F5650F4;
	Wed,  9 Sep 2026 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962658; cv=none; b=EbvLpmk4B8kgabyjSg+JDMoHq69qaooj+E6yRFodMXeIkA9QXDL41OmcPivYIss/YV5HpuR3RfuyV++xAjbTddf0xdKJ6X2VXOk4gzlYnoOzWLTjbhCRvZf3I/7GgyTU4USlqowFNcS8fSZoP2DPB8b2Xfayi5/dv82LWBi1pKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962658; c=relaxed/simple;
	bh=E7fgarhF93UmeFS3xcsx89VbQHqmZiIyVfzBU35jzC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh941v0eqwve0QA3SZn8ARL3qxSogoU/cc6tC698ha4tO2wp/f2rhGUTJ1pSl20rgr1dl/mKn7YcX87CO5f5danYvvbzRbDcMCs1lSY5aqkJPtOC4EWxRNzzG6ZPy5brcKEbAxXZmg9FoqDY6oOdBB3StFArFCmqM+Jyj6dPWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcZwPB0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcZwPB0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BE01F00ACF;
	Wed,  9 Sep 2026 14:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962656;
	bh=fT43lELJTSuTapSRQfge6uMBnWbBQLknesZmv7ILLgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HcZwPB0qrB/sK2rmHLrOG8VFxqZzdxLD+Yrt5RErfNb3SK0iwJtfGaOZXUrzvLNma
	 XOF3Ujgi4A8RMqKAPK2Pb075WlT4Ix4xmTGxfSHxY3oIAC8EfggxNgFykJiZ4cihE4
	 nISmtQ6Ki/BTKWztzWUQRg0o/IRc3XFgAx+F7Hm5mxiz5m6vONdneB0axFrgf4yF/z
	 LvclTuxEFyJJJA2sO71mCPKllk4MvwtprPvzOIGyUGdf7M+YDFEyJ3OuvXc4qvDmAS
	 +RPMfxn3uTAdTGVWimMNfhCG3D3DCzdilmsR6SVS+LDwim0MoBfq8GaERlKd/juuzh
	 /HGeD0r5WOZHg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH REPOST 3/5] mm/damon/vaddr: support apply_probe
Date: Wed,  9 Sep 2026 07:04:05 -0700
Message-ID: <20260909140408.104699-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909140408.104699-1-sj@kernel.org>
References: <20260909140408.104699-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON virtual address space operation set (vaddr) is not supporting
apply_probe.  Add a minimum support.  Do not support hugetlb pages and
PGIDLE_UNSET filter type for simplicity.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 20f4784f17817..7c548ec0cf6b5 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -522,6 +522,128 @@ static void damon_va_prep_probes(struct damon_ctx *ctx, bool set_samples)
 	}
 }
 
+static bool damon_va_filter_pass(struct folio *folio, struct damon_probe *p)
+{
+	struct damon_filter *f;
+	bool pass = true;
+
+	damon_for_each_filter(f, p) {
+		if (damon_ops_filter_match(f, folio)) {
+			pass = f->allow;
+			break;
+		}
+		pass = !f->allow;
+	}
+	return pass;
+}
+
+struct damon_va_probe_walk_private {
+	struct damon_ctx *ctx;
+	struct damon_region *r;
+};
+
+static void damon_va_probe_folio(struct damon_ctx *ctx,
+		struct damon_region *r, struct folio *folio)
+{
+	struct damon_probe *probe;
+	int i = 0;
+
+	damon_for_each_probe(probe, ctx) {
+		if (damon_va_filter_pass(folio, probe))
+			r->probe_hits[i]++;
+		i++;
+	}
+}
+
+static int damon_va_probe_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	pte_t *pte;
+	pte_t ptent;
+	spinlock_t *ptl;
+	struct folio *folio;
+	struct damon_va_probe_walk_private *priv = walk->private;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	ptl = pmd_trans_huge_lock(pmd, walk->vma);
+	if (ptl) {
+		pmd_t pmde = pmdp_get(pmd);
+
+		if (!pmd_present(pmde))
+			goto huge_out;
+		folio = vm_normal_folio_pmd(walk->vma, addr, pmde);
+		if (!folio)
+			goto huge_out;
+		damon_va_probe_folio(priv->ctx, priv->r, folio);
+
+huge_out:
+		spin_unlock(ptl);
+		return 0;
+	}
+#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
+
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
+	ptent = ptep_get(pte);
+	if (!pte_present(ptent))
+		goto out;
+	folio = vm_normal_folio(walk->vma, addr, ptent);
+	if (!folio)
+		goto out;
+	damon_va_probe_folio(priv->ctx, priv->r, folio);
+
+out:
+	pte_unmap_unlock(pte, ptl);
+	return 0;
+}
+
+static void __damon_va_apply_probes(struct damon_ctx *ctx,
+		struct mm_struct *mm,  struct damon_region *r)
+{
+	struct damon_va_probe_walk_private arg = {
+		.ctx = ctx,
+		.r = r,
+	};
+	struct mm_walk_ops damon_probe_walk_ops = {
+		.pmd_entry = damon_va_probe_pmd_entry,
+		.hugetlb_entry = NULL,
+	};
+	unsigned long addr = r->sampling_addr;
+
+	if (!mm)
+		return;
+
+	damon_va_walk_page_range(mm, addr, addr + 1, &damon_probe_walk_ops,
+			&arg);
+}
+
+static unsigned int damon_va_apply_probes(struct damon_ctx *ctx,
+		bool set_samples, bool return_max_wsum)
+{
+	struct damon_target *t;
+	struct mm_struct *mm;
+	struct damon_region *r;
+	unsigned int max_wsum = 0;
+
+	damon_for_each_target(t, ctx) {
+		mm = damon_get_mm(t);
+		damon_for_each_region(r, t) {
+			if (set_samples)
+				r->sampling_addr = damon_rand(ctx, r->ar.start,
+						r->ar.end);
+			__damon_va_apply_probes(ctx, mm, r);
+			if (return_max_wsum)
+				max_wsum = max(damon_probe_hits_wsum(r, false,
+							ctx), max_wsum);
+		}
+		if (mm)
+			mmput(mm);
+	}
+
+	return max_wsum;
+}
+
 static bool damos_va_filter_young_match(struct damos_filter *filter,
 		struct folio *folio, struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, pmd_t *pmdp)
@@ -951,6 +1073,7 @@ static int __init damon_va_initcall(void)
 		.prepare_access_checks = damon_va_prepare_access_checks,
 		.check_accesses = damon_va_check_accesses,
 		.prep_probes = damon_va_prep_probes,
+		.apply_probes = damon_va_apply_probes,
 		.target_valid = damon_va_target_valid,
 		.cleanup_target = damon_va_cleanup_target,
 		.apply_scheme = damon_va_apply_scheme,
-- 
2.47.3

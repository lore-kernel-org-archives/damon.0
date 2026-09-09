Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB07563FCF;
	Wed,  9 Sep 2026 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962658; cv=none; b=Nd6h36s7pfijErg+tckDtdsoqbGv+fGKhyiWv6OVxZBXd5ryUHhIkOWJBGGtMjhbcM3C3ffQy9IumSraMIzpltK4Ok8zhDn3axzByHGTKo0ULvk/kdZlSUjQSe6IFycNjX/QOH5l+4rSMGJsZSABY2VEGnsES4yoQh0DhRJt6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962658; c=relaxed/simple;
	bh=fKrB/U0Fkc84EdTBQ6P2uNZCoUXlmjMlVMrrxMNAX2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okiWBUMgFvTPdYZetcXmkxFKGTJudFuZeTQYkZWEHkmZBjvL648PMCsWaI7/QM0UT86fnf1O2NFFLgnoZANQvRg1547XDXSNzv7nDpYKqW/IRwxLD961FVI4MkpVlMjA6+goTfZ7IpiA2/FCXFhuq2PRpcMBIjCvi2ERPjMHE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZV5HI9n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZV5HI9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C98E1F00A3E;
	Wed,  9 Sep 2026 14:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962656;
	bh=jEjB5+SmYpe1jV4B6kvt1MmnXfzrPfDtBLhTiuYoc8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZV5HI9ni1qoer7WyAzgqHcmDNXDCkP6yMaAYv82nIdNvytJfea+tswZdYH/n1kO3
	 xH7HiXbus+CJ24iXvAlS7zz0lwENIoJbFTO+7k8wHFv0svv2VFMyngh0Tua+XCQtpB
	 5MUrRIVoRkGncsFxs8GUMJy3gm0VfYD50LMM4KPxP9foxpkK2dCzb9KzieqYur3UTl
	 XPZ00hyL15YOnYCbN9O6hw2aKEafU+JExRoW8OiygrC51XPE5g2gM35psx4KhXauEz
	 q6Vsff2H6UqTxk+kbF0srjTUBtktHrEQJtd1lL1q2FnsG9HARhT4ubEgpeHNoePYL5
	 NZMGkA26dKDDg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH REPOST 1/5] mm/damon/vaddr: support prep_probes
Date: Wed,  9 Sep 2026 07:04:03 -0700
Message-ID: <20260909140408.104699-2-sj@kernel.org>
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
prep_probes.  Add the support.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index af9e1b82454cc..20f4784f17817 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -483,6 +483,45 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+static void damon_va_prep_probe_region(struct damon_ctx *ctx,
+		struct mm_struct *mm, struct damon_region *r,
+		struct damon_probe *probe)
+{
+	struct damon_prep *p;
+
+	damon_for_each_prep(p, probe) {
+		switch (p->action) {
+		case DAMON_PREP_SET_PGIDLE:
+			damon_va_mkold(mm, r->sampling_addr);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void damon_va_prep_probes(struct damon_ctx *ctx, bool set_samples)
+{
+	struct damon_target *t;
+	struct mm_struct *mm;
+	struct damon_region *r;
+	struct damon_probe *p;
+
+	damon_for_each_target(t, ctx) {
+		mm = damon_get_mm(t);
+		if (!mm)
+			continue;
+		damon_for_each_region(r, t) {
+			if (set_samples)
+				r->sampling_addr = damon_rand(ctx, r->ar.start,
+						r->ar.end);
+			damon_for_each_probe(p, ctx)
+				damon_va_prep_probe_region(ctx, mm, r, p);
+		}
+		mmput(mm);
+	}
+}
+
 static bool damos_va_filter_young_match(struct damos_filter *filter,
 		struct folio *folio, struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, pmd_t *pmdp)
@@ -911,6 +950,7 @@ static int __init damon_va_initcall(void)
 		.update = damon_va_update,
 		.prepare_access_checks = damon_va_prepare_access_checks,
 		.check_accesses = damon_va_check_accesses,
+		.prep_probes = damon_va_prep_probes,
 		.target_valid = damon_va_target_valid,
 		.cleanup_target = damon_va_cleanup_target,
 		.apply_scheme = damon_va_apply_scheme,
-- 
2.47.3

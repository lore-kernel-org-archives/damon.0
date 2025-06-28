Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1421B9C0;
	Sat, 28 Jun 2025 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129512; cv=none; b=Ay/xW8HokZ0iXP5GumjmGmboZzQPM44sAiKSCTk/vhNqHdNWtXvdnzFDEklXSTfI/gLFNiXTnqZAE6SliJXwUioqnPemsBzFhds49NBsXcQj6orHG8HrrroIHW20C1oUgpm8zwriGDExSnBdHp37m/Z2HvF1rSoioetdgdBE1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129512; c=relaxed/simple;
	bh=Cm6pjIFRAJZCOmn0gKgJd7u3o4zVBQh0I1eKxLttZ2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtlbNdaSzuxaqTGs0xKgtzCtu92NkDufJBIOmOioVKFIvYOO0PKGE76ftnZnm6O8m0pzFkpbNF1+HpbrpnaLbaZSW7BM51WfUUFGe/F87Zylgmb3GftFFq2JxR3SEO7kFieru6GS+h8l4o9kgZGSBYfIrFi3+tbc3qYWjadKzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHlL1odv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHlL1odv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC25EC4CEEF;
	Sat, 28 Jun 2025 16:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129512;
	bh=Cm6pjIFRAJZCOmn0gKgJd7u3o4zVBQh0I1eKxLttZ2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHlL1odvhMvpV20OVqcThHPTFW7G1vJcUpwFfR4j9Di3UifY/px4+4ofQcdwEQ8M3
	 jXFYEFTlNoxkuRq/nE5Vz1Al7wRDwJeT5mijjP9zcwv10k6N0hlvasfCAEuDqvgkPO
	 vcIbxH6L2bldpdCC17hR6/SlYcH+543iKT4uIo7KJKq6HpVHaqMuZwVWiSMM4fj4A7
	 /d5QFgZGEA222bSfDdn+yFr/HmQF+GZFehs/NqRLy2T5t94gFnyBssznM62W/xWijT
	 EQbHfPR1WUqObAATIMi6fxiiHcEe++BOY1vf8aDIh3ZrEUCBsjZkTI/rHnGCkavyiB
	 gO3d3c1D+3hzw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/11] mm/damon/paddr: activate DAMOS_LRU_PRIO targets instead of marking accessed
Date: Sat, 28 Jun 2025 09:51:37 -0700
Message-Id: <20250628165144.55528-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628165144.55528-1-sj@kernel.org>
References: <20250628165144.55528-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_LRU_DEPRIOD directly deactivate the pages, while DAMOS_LRU_PRIO
calls folio_mark_accessed(), which does incremental activation.  The
incremental activation was assumed to be useful for making sure the
pages of the hot memory region are really hot.  After the introduction
of DAMOS_LRU_PRIO, the young page filter has added.  Users can use the
young page filter to make sure the page is eligible to be activated.
Meanwhile, the asymmetric behavior of DAMOS_LRU_[DE]PRIO can confuse
users.

Directly activate given pages for DAMOS_LRU_PRIO, to eliminate the
unnecessary incremental activation steps, and be symmetric with
DAMOS_LRU_DEPRIO for easier usages.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index d4261da48b0a..34d4b3017043 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -474,8 +474,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 	return applied * PAGE_SIZE;
 }
 
-static inline unsigned long damon_pa_mark_accessed_or_deactivate(
-		struct damon_region *r, struct damos *s, bool mark_accessed,
+static inline unsigned long damon_pa_de_activate(
+		struct damon_region *r, struct damos *s, bool activate,
 		unsigned long *sz_filter_passed)
 {
 	unsigned long addr, applied = 0;
@@ -494,8 +494,8 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		else
 			*sz_filter_passed += folio_size(folio);
 
-		if (mark_accessed)
-			folio_mark_accessed(folio);
+		if (activate)
+			folio_activate(folio);
 		else
 			folio_deactivate(folio);
 		applied += folio_nr_pages(folio);
@@ -507,18 +507,16 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 	return applied * PAGE_SIZE;
 }
 
-static unsigned long damon_pa_mark_accessed(struct damon_region *r,
+static unsigned long damon_pa_activate_pages(struct damon_region *r,
 	struct damos *s, unsigned long *sz_filter_passed)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, s, true,
-			sz_filter_passed);
+	return damon_pa_de_activate(r, s, true, sz_filter_passed);
 }
 
 static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
 	struct damos *s, unsigned long *sz_filter_passed)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, s, false,
-			sz_filter_passed);
+	return damon_pa_de_activate(r, s, false, sz_filter_passed);
 }
 
 static unsigned int __damon_pa_migrate_folio_list(
@@ -803,7 +801,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_PAGEOUT:
 		return damon_pa_pageout(r, scheme, sz_filter_passed);
 	case DAMOS_LRU_PRIO:
-		return damon_pa_mark_accessed(r, scheme, sz_filter_passed);
+		return damon_pa_activate_pages(r, scheme, sz_filter_passed);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r, scheme, sz_filter_passed);
 	case DAMOS_MIGRATE_HOT:
-- 
2.39.5

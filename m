Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCEF371064
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424293; cv=pass; b=NR5/e1jSOr56B2PXXLbSp3aqZ3YAbXtKgaQVfdn3DS4KlZqhoka8GnoDxzHsZRFpCVjJs2My8Dt+2M2tIFdeKR/e0RXkBpkQLeijI/p5gFLC62+rz70aS7f/8sfmD8BnHbylQOmC1vqXh9WL9i1ksz7DLuQmGQ9lX5OWcMapGdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424293; c=relaxed/simple;
	bh=GxECTmSwkEpJNX80rGnPA6J6Kku114ULrI/ybXv2OSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ue1VYzT/3zI8zsTceZBDej59P7onlWCSBD6oAGWeGDaVFCRLiJ/neD+b9nbgqT1tD1uIpkppSTWUuH3C9O53Rndmwn2q2oAi0Wow6jvdnMhlgj/Jkalvx7lFVf5UIGGoG8VGp8Jj3f8s86V6pOrdOc9doQBVzLC2xcYafyIM/Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=fbVrU3DR; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="fbVrU3DR"
ARC-Seal: i=1; a=rsa-sha256; t=1774424286; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NRRI2Q0Ohsxx0HZ9KcDp6zyvPHeqLAD8MbQWobJSzSOE/ydMZV6B0Qb3+AagqDJG7LIpkr5uN8OQzmgKYvQCViLx+aKw+J7b2zwBpgXc04XZUhzIj4KEjT5HOaV8AFBaep51L93DnKfxaVfLx2yxaltz/8Fgl4lRqs5jXy6JjS0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774424286; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JRPi6sx9pUKCMoRSmLUMPuhiHVNdSdGX+Y2fr4B7g8Q=; 
	b=SQX+2LSyTaGlDmItVIdn4zXuHdyN0Zc1qYVz6nxrZBDa4RPDOpnB9cthjhIwPfAOZfiIZ58X/bncGxiHAsL6vwtq+Aw0mZIrt0m2iseCruRd7pfPmLkaFXh/cIud6y/ltaECDD3CltM4K4GRNFafb2U5lJOuG2hjFjPXqiIk2QA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774424286;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=JRPi6sx9pUKCMoRSmLUMPuhiHVNdSdGX+Y2fr4B7g8Q=;
	b=fbVrU3DRnQAeHOVx5L/kzLx+I+sP2XwtO95wcyZIj/KNc2wdzzzCtf0wG0AwRb4w
	nTSNMVqSZCiY9Hs+uWVcQa43JCWn5C6m9NaxPimXQ7Wkm490XcXLdpTdLv3bxhGZe0h
	F0oplsXpNI44yFRI+ItsWZt+FEEPO9+z66Puic1k=
Received: by mx.zoho.eu with SMTPS id 1774424283679760.5080198368752;
	Wed, 25 Mar 2026 08:38:03 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 3/3] mm/damon/core: move last_nr_regions from static local to damon_ctx
Date: Wed, 25 Mar 2026 07:38:00 +0000
Message-Id: <20260325073800.141756-4-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325073800.141756-1-objecting@objecting.org>
References: <20260325073800.141756-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

kdamond_split_regions() uses a function-level static variable to
remember the previous iteration's region count.  This is shared across
all kdamond threads, so one kdamond's region count leaks into another's
splitting decision.  Move the variable into struct damon_ctx so each
kdamond tracks its own state.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 438fe6f3eab4..85fe33ce7be4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -803,6 +803,8 @@ struct damon_ctx {
 	struct completion kdamond_started;
 	/* for scheme quotas prioritization */
 	unsigned long *regions_score_histogram;
+	/* for kdamond_split_regions() heuristic */
+	unsigned int last_nr_regions;
 
 	/* lists of &struct damon_call_control */
 	struct list_head call_controls;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6c1f738e265c..50e8bdeb70dd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2722,7 +2722,6 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	unsigned int nr_regions = 0;
-	static unsigned int last_nr_regions;
 	int nr_subregions = 2;
 
 	damon_for_each_target(t, ctx)
@@ -2732,14 +2731,14 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		return;
 
 	/* Maybe the middle of the region has different access frequency */
-	if (last_nr_regions == nr_regions &&
+	if (ctx->last_nr_regions == nr_regions &&
 			nr_regions < ctx->attrs.max_nr_regions / 3)
 		nr_subregions = 3;
 
 	damon_for_each_target(t, ctx)
 		damon_split_regions_of(t, nr_subregions, ctx->min_region_sz);
 
-	last_nr_regions = nr_regions;
+	ctx->last_nr_regions = nr_regions;
 }
 
 /*
-- 
2.34.1


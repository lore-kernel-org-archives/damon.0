Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C12407CED;
	Thu, 21 May 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374081; cv=none; b=J3irJvbzgTNxkALp4e0TcZQQ5iKsY1sGwLXg3Vugy97UG363MKtAFqXJe7OyYu3iFus5T1G07huSPTgM8Xtp9Ofn9eQ6wsaLYc1gA2tCcm9RN6RiPdbeIE02acyXZyVn37zawQBYB3u7I6M0+fPcrTFLRG08GtSm+A+/CCzhjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374081; c=relaxed/simple;
	bh=Io1W+l0y38wprpiIkcNjCK1tfQcAY0yDIRtRdd0LSw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jn64LAthbPg1C8B+0oKTY9JvJrJPi4SxBa3bLDrEC2MSABS2CkVgdjzlwmr/ETMyG6jQ5lhNBE29Ya9HuUM4ayVZlWnMzR7c8jz8Zgk2yriFQiUkRl9C/wexpyeWbhndlK8CApXwxNoyXU1vAV5QkE+z/HUtVjVEn9XgLAd14Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNydnoB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNydnoB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EC71F000E9;
	Thu, 21 May 2026 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374079;
	bh=ITBL4yRv8OcoOU4P8OrL5kgNMtEVib2v8kU4r8mcDLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TNydnoB6sIKWld1N3SMAnA8lttU37d6YABnmMJ4mfPU3329lt4Qoz5v3C//EYGJYK
	 drNbHedORmv86s+wMfzB+ODgCSqMNAuPxiOXsWALdW5IwhNAnNI/SNqz1Jfb1/zJMT
	 MEj4wegqn0OEFFqjzfbP9PZdjhd5w9BkR4SiSGqTNFjxYlkgcC6YB1gdq+8aCffDL2
	 365RMt3j7MwJvi/JAemUvRX/nVyEqe8JSvBA7Ch1ZXwIVwfxZrhHSE4u2bwZ9Yrrmy
	 kj0+3Ukw8DcPKg+lWQsbTGkd/sHUIZe0YbcJWvRCN+VcYt94XiVvY1jP38MriuIs0c
	 47QU+G1IFAA0Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 07/14] mm/damon/core: hide damon_destroy_region()
Date: Thu, 21 May 2026 07:34:17 -0700
Message-ID: <20260521143428.83157-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521143428.83157-1-sj@kernel.org>
References: <20260521143428.83157-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_destroy_region() is being used by only DAMON core, but exposed to
DAMON API callers.  Exposing something that is not really being used by
others will only increase the maintenance cost.  Hide it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 -
 mm/damon/core.c       | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3acca7deb1693..638ee65f88dcb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1013,7 +1013,6 @@ void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
 
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
 
-void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
 void damon_update_region_access_rate(struct damon_region *r, bool accessed,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 53b4bdd27b39d..8a9202937781c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -291,7 +291,8 @@ static void damon_free_region(struct damon_region *r)
 	kmem_cache_free(damon_region_cache, r);
 }
 
-void damon_destroy_region(struct damon_region *r, struct damon_target *t)
+static void damon_destroy_region(struct damon_region *r,
+		struct damon_target *t)
 {
 	damon_del_region(r, t);
 	damon_free_region(r);
-- 
2.47.3

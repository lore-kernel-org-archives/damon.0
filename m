Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB39477E55;
	Fri, 22 May 2026 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464438; cv=none; b=ffv1gSxeUe6ePZga6EseQO02QHgsJTqF4Hh8bQ72EPfxHRlWEoAwafJvN6Dh4alhi76KmoMiv7z9YBhv4l9phk8QtWZ8p9jQlf9ula9j09SYJRsgq+yshFOtVqboFpsaHeriwrZU9GXWm9IhZ0cVBuvyqHp8EFkfk93yhz8bbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464438; c=relaxed/simple;
	bh=2DRmI/tHp+praFYqzBIMl0KTx97leJxhLmEQMjiuHis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmzrenGMCtkxTeEJNe5IisCzA0t+TJSHOwaqtCmwo7XBf2juvnRVxY3Ow24k6mLrwgwBQ37N3SRd6ab7bjrGB9WIKYDbAmHOCtbMzcGRlZmWHXQlYyi7SPw/3X5SQuIssoORRlTo86PSctprn3DA0xQwtt8b40ChezF2M0e1JYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlmjDOdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlmjDOdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12A21F00A3F;
	Fri, 22 May 2026 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464437;
	bh=KBZztZ9CgAPOtUYZD/myJUluALlI19duYVzM65uSmUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VlmjDOdwSp7wC35g8KCXMA+63FgKXTc9F1fK9JJrixLW50FOPpSszFDV7j5844uwk
	 Dx7FKCNcRnshJEe45tBADG+FazFFlmv6/zLvBVIe+L+7v3ogedQeAFgwQmePcPZADl
	 MojlSWmMSp5W2DWVstld9uOLrLxGyo44brGLKIytwkDI5iOb8JMtI7c1RhQZGeNeYr
	 n5AsGlAqVdOCb5c/WWqCc/seAc50WWMdK0X5p8B+FbKO5frEqcYh/FdLgnDrsZryaO
	 ripTniyHRPOjA7TlsjdULC/xNQ3dm0z+lnzZYuznzwlah05t7uxafToLO9ULKbuEPU
	 0W8rczn/OLSgw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/14] mm/damon/core: hide damon_destroy_region()
Date: Fri, 22 May 2026 08:40:18 -0700
Message-ID: <20260522154026.80546-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522154026.80546-1-sj@kernel.org>
References: <20260522154026.80546-1-sj@kernel.org>
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
index 05682839e17ee..6f7edb3590ef9 100644
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

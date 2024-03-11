Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6B53807;
	Mon, 11 Mar 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189958; cv=none; b=DbQa1MZuvl4u3/94MAK/sBwk7WuZsdNdL7ojC1ORcap4b1J6CvcogpdaAPwCV4MvqJLiCQ6gwZ96ZX/icv/Y9+hxthWKqmQiOZwz9uVKTlyMQwVGdcRNSOvpoMZqwunAx+MCcNjttkkNv7qYN00ow3B+SJXDrWGO4xh9XvRnC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189958; c=relaxed/simple;
	bh=hs6WHjvRmbJudqL2dyXIyQo9wvOsoRsFOzjiQ+KCyr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrZwtGBbdqpFkWm0+j8/JRHSWOjbgSSZUYgC2e9wbx/vhUQwKDdyjHtotWrTVukG5XjCIFFnrxR1gmshJPcaW0Hav/fh4Mx8P+ArxOvz6xKvVgPeAGGN7YZA13X56cmBWD8PfL2tIfRRurVIGTR5RQSADxSTbINwpHx0ah5gB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLGmSRcn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLGmSRcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DA6C43330;
	Mon, 11 Mar 2024 20:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189958;
	bh=hs6WHjvRmbJudqL2dyXIyQo9wvOsoRsFOzjiQ+KCyr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLGmSRcnglAYFoU2dg75r1a8ysLh7ADCj/UW8G9z5COG6rYaR+oFko6vN9VFr0HdX
	 4SZcXS4bFb43mkNF98vNQx+WEswCo+05vvuffzq5yqSUZSkTl4as+le6RKnMR6dE6z
	 brQ6rl5Cw21Bzgqntp4cOov83EzMP9hRMrtIDP5X2kGvwsLTiVYq0x4F55dVgJyNTc
	 /hTvuGG7ALQGfh5WTTzWdXWKU1BgvJqyYu8vMMh+m4ur+ygHV0fUBVpfk/7oQuit74
	 vO/L0FIzD4tXZWhv5AAPmrdQbXVJNbH2NBYkV03VekMlczaoeAaLXulGrRlo2PdUmG
	 uxELAUxdm0z6Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/4] mm/damon/paddr: implement damon_folio_mkold()
Date: Mon, 11 Mar 2024 13:45:43 -0700
Message-Id: <20240311204545.47097-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311204545.47097-1-sj@kernel.org>
References: <20240311204545.47097-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_pa_mkold() receives a physical address, finds the folio covering
the address, and makes the folio as old.  Split the internal logic for
checking access to the given folio, for future reuse of the logic.
Also, change the name of the rmap walker from __damon_pa_mkold() to
damon_folio_mkold_one() for more consistent naming.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 25c3ba2a9eaf..310b803c6277 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -16,8 +16,8 @@
 #include "../internal.h"
 #include "ops-common.h"
 
-static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
-		unsigned long addr, void *arg)
+static bool damon_folio_mkold_one(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
 
@@ -31,33 +31,38 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
 	return true;
 }
 
-static void damon_pa_mkold(unsigned long paddr)
+static void damon_folio_mkold(struct folio *folio)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	struct rmap_walk_control rwc = {
-		.rmap_one = __damon_pa_mkold,
+		.rmap_one = damon_folio_mkold_one,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
 	bool need_lock;
 
-	if (!folio)
-		return;
-
 	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
 		folio_set_idle(folio);
-		goto out;
+		return;
 	}
 
 	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
 	if (need_lock && !folio_trylock(folio))
-		goto out;
+		return;
 
 	rmap_walk(folio, &rwc);
 
 	if (need_lock)
 		folio_unlock(folio);
 
-out:
+}
+
+static void damon_pa_mkold(unsigned long paddr)
+{
+	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+
+	if (!folio)
+		return;
+
+	damon_folio_mkold(folio);
 	folio_put(folio);
 }
 
-- 
2.39.2


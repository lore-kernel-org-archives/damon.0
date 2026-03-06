Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156B3D34B8;
	Fri,  6 Mar 2026 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810963; cv=none; b=URZZnkxl5H15vbkyvnN8UCHK0ZJXmuOA54Gb83vXz1+0k56Y0dkBi9i1EVmlw+FNFdP+vMJWlt2zhm4QQhsyHrWUY1yS6KKBAOa397Ru1kdPMMNIuROvc9eYnBYAwp4QP8LDZdY9+E9cFwoZ2I1EB+r1GaYveNcthw6dVz/ILkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810963; c=relaxed/simple;
	bh=nkxfWGkCfA0dtqbKfL4Ap5CeLN1/sVBbqbCyhGOAcDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnXr3l1MPHcDHwg2ocjfwee3sd1cZdbgEIjtCIefuMbaqnji90Os41k3bvMBq7lk779KQm4EY5QDAOsiCnkn6TCBA+VHVmddloa5WX6uSB+5/mqhlIu/aAMVjoQr3gN+K3PzIlyGdtSEMosvY+WpEu3bcIFa0cy/lR42KnPrsd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTwBZS3Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTwBZS3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE2DC2BCFC;
	Fri,  6 Mar 2026 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810963;
	bh=nkxfWGkCfA0dtqbKfL4Ap5CeLN1/sVBbqbCyhGOAcDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTwBZS3Ywjwpqlqnr8nhk08L75SfMhDHB4WzT16M7NuYTrQJIlaUTKZfBDOiS+pw2
	 fDwtv8mmP2D7r1Gou5jHf2qSpNnywfOIrhc+qV39j/smT78jJmZ5GP6JN2OkvvMg9a
	 MhSVsWx2x8lXbnKH1yactJ5jKHF9JPCTBAEvbbo/N2soBg4JMToN8dfzXqbfyS+uhb
	 K1gOBXizUYdI+3uoXPA82y0eZ/a5vuXls/fj4YeHucWcJ+4R9emUb3uj3OleMaZnZw
	 lHxNbETjbsa6RDapvwxLwIi3sqOwV/+ItxDiYIETwvmssFOvlRCvzWdJorGaMh4PSX
	 K714SKVWryJOA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/10] mm/damon/core: add damon_merge_two_regions() debug_sanity check
Date: Fri,  6 Mar 2026 07:29:08 -0800
Message-ID: <20260306152914.86303-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306152914.86303-1-sj@kernel.org>
References: <20260306152914.86303-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A data corruption could cause damon_merge_two_regions() creating zero
length DAMON regions.  Add a sanity check for that under
CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2b5aed89d449d..8a3738a17cdd9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2473,6 +2473,21 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	mutex_unlock(&c->walk_control_lock);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_merge_two_regions(
+		struct damon_region *l, struct damon_region *r)
+{
+	/* damon_merge_two_regions() may created incorrect left region */
+	WARN_ONCE(l->ar.start >= l->ar.end, "l: %lu-%lu, r: %lu-%lu\n",
+			l->ar.start, l->ar.end, r->ar.start, r->ar.end);
+}
+#else
+static void damon_verify_merge_two_regions(
+		struct damon_region *l, struct damon_region *r)
+{
+}
+#endif
+
 /*
  * Merge two adjacent regions into one region
  */
@@ -2486,6 +2501,7 @@ static void damon_merge_two_regions(struct damon_target *t,
 	l->nr_accesses_bp = l->nr_accesses * 10000;
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
+	damon_verify_merge_two_regions(l, r);
 	damon_destroy_region(r, t);
 }
 
-- 
2.47.3

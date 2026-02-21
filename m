Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACE5317715;
	Sat, 21 Feb 2026 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702596; cv=none; b=juh0IRQXGJ8wdktIMRrm5VIOvJGRxpa59co0+VjKWZRsg2hhWP6J/L4kKjt/yn8KWnMPWv/y0q+AD4h9aJ15c6o/a0sLrWiJilHggE/vWU2CzGRUOnGKSdeB2zq+ngW0y+IovUJOZMW1X8A42KraT1YhTGySqRvkVZvGnEPa9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702596; c=relaxed/simple;
	bh=hTJuo1zGiIhoE2C8xzUpqoPqVjI2PLBsSgMe7nKwEuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPNSfuAdgKoNLZm8plSYOAWFfQmUX0bTPVYL2FVE7evniXn2c8Hso2yRHw+3Atg0AeDlJJnHDa/CYh9+u7dGY4upF9dqc8coXL9e2MOHBQb/4iKZdLMDvhQm7CyeI89jfjqlB3d+rfV7JQ+IEDS+x3OwjG6neKZ051j8truiZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnBaaJmV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnBaaJmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86355C2BC86;
	Sat, 21 Feb 2026 19:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771702596;
	bh=hTJuo1zGiIhoE2C8xzUpqoPqVjI2PLBsSgMe7nKwEuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnBaaJmVPhcila4+rCDK54NN7dsnfuRDST8prP+m03KVFBp2tqmhkWLcRTInnG0LS
	 nAKLYddEBKRvToqQjwJ6/bZSSXCM2Uz8QW/JTmnOgWpNE5vjd2/JUsgpFshffTMY6w
	 vcgt5sVYNCtrnFkNqea18bzVmnOM3xZHZpErdI98da9aKquFUKWTsbdOzyzxCPCxYa
	 sOOtvRHA2SVlJc+NBbAFx9GAgm+y8JASF7N6oy3wisqS1v4n1XpNxlKT8349mTSKJp
	 vNqrNvFXGQGO4IQdSpqMtoQGdDJPqPkQZwsLOWOyJXu8WPapqPmfnQGGyAo4x+JW/Q
	 T2ffAmM8tnhdQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/10] mm/damon/core: add damon_nr_regions() debug_sanity check
Date: Sat, 21 Feb 2026 11:36:21 -0800
Message-ID: <20260221193629.19332-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-1-sj@kernel.org>
References: <20260221193629.19332-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_target->nr_regions is introduced to get the number quickly without
having to iterate regions always.  Add a sanity check for that under
CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7e03c3af03694..ede76e0789be3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -556,8 +556,30 @@ void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx)
 	damon_free_target(t);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_nr_regions(struct damon_target *t)
+{
+	struct damon_region *r;
+	unsigned int count = 0;
+
+	damon_for_each_region(r, t)
+		count++;
+	if (count == t->nr_regions)
+		return;
+	pr_err("damon_nr_regions(): t->nr_regions (%u) != real number (%u)\n",
+			t->nr_regions, count);
+	WARN_ONCE();
+}
+#else
+static void damon_verify_nr_regions(struct damon_target *t)
+{
+}
+#endif
+
 unsigned int damon_nr_regions(struct damon_target *t)
 {
+	damon_verify_nr_regions(t);
+
 	return t->nr_regions;
 }
 
-- 
2.47.3

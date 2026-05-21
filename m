Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084536A01A;
	Thu, 21 May 2026 03:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335642; cv=none; b=puo/jxUKMYlVkdpf8E3AC+vNhkb+MMvdlJRNpR1vdgE78Op2CInI3bwyWE5jaYdJhJ4mSzwhcVZw/EpETLnXw4vAbgib0KEP9dgkCOmrVWj6enqPuCbzbJqJJYzGGkvIUp5Sg+CRicYMDLL/IhUu1RjBI8dSxaXfQm2V2Hv0ToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335642; c=relaxed/simple;
	bh=HU4D50xUEXGTjEy1hYAKL14nhun18f8ZSclPBfAPuZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5fRgqR2jysffb79DJV/i4MhXNlpK8q5Koo3GwFf5IPS0n/EjxQYUQBP/X0GIEFWiwjOwGvl2a6Mpo/hvMvlgm2fwt54ty+HwHnHSKpeqh+9HL6ah2WwNZb92hT8098XhEClFRi9bAc+BZCIm0XKWil8y/qotZPdzrWNJSpIqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlwjjmAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlwjjmAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E561F00A3B;
	Thu, 21 May 2026 03:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335640;
	bh=CRNoWJlEPylYeAv7EKMrmhsVza1n4tj76p/bqvx4fJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dlwjjmAN5exUXxKzSr7aztzw1rqe/edAluNaa+H+ezpC15TEu0GqGdqUy8XYKqgdP
	 PZUYAzbZDo7IdEabFTcFJyZJUbMKynuFtEsMOAnPn1Q1qqiggl8cVHjYYZlserVIyK
	 OZRkOKRbDTAarYHDj7f5HANnhoigVurCbNnMSVB68inIcJmFNiykQ50AedJFDPTKBX
	 3v7amtV5PxRbKqS7AJrVF/pRDr9GA3z/X5indIio/MQ10oqWYACopnjaflhWau2ctR
	 ZkS4sZ44xiL0P2t//jcELeaDmjsB7o3n0FWfJA1+BSnEfkYnMTGV5ht8dj7/3AQiWA
	 lslVsudX3oU8Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 03/14] samples/damon/mtier: replace damon_add_region() with damon_set_regions()
Date: Wed, 20 May 2026 20:53:37 -0700
Message-ID: <20260521035349.87565-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521035349.87565-1-sj@kernel.org>
References: <20260521035349.87565-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtier DAMON sample module and DAMON virtual address operation set
(vaddr) unit tests are using damon_add_region() for setup of DAMON
monitoring target region boundaries setup.  But, damon_set_regions() is
designed for exactly the purpose.  All other DAMON API callers use the
function for the purpose.  Replace damon_add_region() usage in mtier
sample module with damon_set_regions(), for unifying the use case and
reducing the maintenance cost.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 775838a23d935..eb1143de8df17 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -75,11 +75,11 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	struct damon_ctx *ctx;
 	struct damon_attrs attrs;
 	struct damon_target *target;
-	struct damon_region *region;
 	struct damos *scheme;
 	struct damos_quota_goal *quota_goal;
 	struct damos_filter *filter;
 	struct region_range addr;
+	struct damon_addr_range range;
 	int ret;
 
 	ctx = damon_new_ctx();
@@ -120,10 +120,12 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 		addr.end = promote ? node1_end_addr : node0_end_addr;
 	}
 
-	region = damon_new_region(addr.start, addr.end);
-	if (!region)
+	range.start = addr.start;
+	range.end = addr.end;
+
+	ret = damon_set_regions(target, &range, 1, DAMON_MIN_REGION_SZ);
+	if (ret)
 		goto free_out;
-	damon_add_region(region, target);
 
 	scheme = damon_new_scheme(
 			/* access pattern */
-- 
2.47.3

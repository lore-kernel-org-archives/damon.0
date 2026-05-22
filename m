Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE217477E4F;
	Fri, 22 May 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464436; cv=none; b=au/nfF4GrObXehdhmuf1kSzhvHnBVrK+nbnquus1AdS5mFW2D7Hr51NYWnxNFhDLL9xdvWQtDtPhgFFKhsOl07q1C2PNAOlxLs+Tfr/RLICqJts3Lt7HUClRPF7LN7LeU3VPAL83k+ddaxIA1eJzrqu/P4GnxrKHVWlEyMduBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464436; c=relaxed/simple;
	bh=HU4D50xUEXGTjEy1hYAKL14nhun18f8ZSclPBfAPuZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBbBhI9a2CYoEnEk2avz4wFnlQmYxxo4qcRm4fbtiiyZPv9jgyA0bSVaLNaH3d99oiFu3hrfiGOfNezxRzeXR85sO5TPQiVnMtzAS4I68GWF3t0HN8vp7uOXqL/PSMwPgnTCe3Fbdeov1Hs+Lcv4cTd/H9bkDG8TpqLhWCVjbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ0C630G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ0C630G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED111F0155C;
	Fri, 22 May 2026 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464435;
	bh=CRNoWJlEPylYeAv7EKMrmhsVza1n4tj76p/bqvx4fJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IZ0C630GPvB3v3POgTGLrg8mKTcpDrl8Ln0Jsh8n9en4eZykTjRHOcgUAad78+7/I
	 2Fm8MJDfV3AzlEvvZvzeVVz380qaYjGY4/D0+LmNbdPFVwMihzlI6KzxZl+5pSqmHN
	 UzbLs6kx0NZhuUHL9ksz/uh2pDICzmeEX/Kw7YW88qX1yJcYK6Enfeeq/YR25hnyJs
	 1OKVehV0IY8jI5ejbhlM5+at1ew7csIx1WOWq9Uw3UL+w2ljH7OlxWiuy6wbDHvkqx
	 z1255h8aZrJ83WWbUT4oEbp3o91FInhEn1QTsF2GlfVGKXTuLYeZFxguFkEo2av3ck
	 CifIVrvKfBMpQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/14] samples/damon/mtier: replace damon_add_region() with damon_set_regions()
Date: Fri, 22 May 2026 08:40:14 -0700
Message-ID: <20260522154026.80546-4-sj@kernel.org>
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

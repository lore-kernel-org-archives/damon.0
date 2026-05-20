Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D81374E42;
	Wed, 20 May 2026 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258550; cv=none; b=fweFTT+V9tXlPupMpox7tiGm+zZM5ABySRFVkCmFDEdIrxCz/PAtSekgLvSaUIHN2CUT24dii61fEEwud9hbSYqF+X9JaLwGo7W29Ka+LlX46pJV3HdC8y8pZSV54B1X5Chkjxkq8kUAW98gjwNE008RDpPowQ2nJz2M9t+3eHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258550; c=relaxed/simple;
	bh=HU4D50xUEXGTjEy1hYAKL14nhun18f8ZSclPBfAPuZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3Zps7gApXuUgW8W9E1w+NEl62IGFxyacY7d8YsA8qpmPsG5HmFeme0Akw+dk0S79TPRXDBclZCaiCZ4amZzn1ZF4zpY3na1IB7XpAljtUXmnUix4/KCp8dniviX51o0jP+ZDxyN8AF5xnJSRMiXZ7J2kgaFsipMpiFM6286DbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwoCbvpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwoCbvpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845ED1F00897;
	Wed, 20 May 2026 06:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258548;
	bh=CRNoWJlEPylYeAv7EKMrmhsVza1n4tj76p/bqvx4fJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RwoCbvpTJSm+3gjcI+kXHqIadRx6WgRIL0CbfBz1U7AqVWHK3cxvJZmFyrN6ndDxM
	 KE2SNvJOIGqFGn7eQnkZblRsP16GQ4VkZ3dC94e+jWm9iWesUFSvyzBaLG2z87g+xo
	 CUB/7hxEIZg/guhyDPMNR6YKgm+cGukYESa71JCAZgws87Bf7d9X2t6P5G6sH4vPiF
	 LpGIo2sIKVoWwA4wvwULsy7rOzD9Ees0JgvFaYoLRt/KFEHTJK+4rqY21/rIjXQfxX
	 AgXRsPqU9R2B8Mj7NI1jup1/3se0G6/Cw8yR6j3H+ouuw/UtHtDn0aa8pouCGPR2m4
	 N3IP4pR3GNMUA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/14] samples/damon/mtier: replace damon_add_region() with damon_set_regions()
Date: Tue, 19 May 2026 23:28:35 -0700
Message-ID: <20260520062858.167011-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520062858.167011-1-sj@kernel.org>
References: <20260520062858.167011-1-sj@kernel.org>
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

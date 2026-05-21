Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03C3EF673;
	Thu, 21 May 2026 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374080; cv=none; b=I8xlEbtMJ0mz5fYS2AnBD0IpWSBuZ+PyuURzRtY/LD/OKYMSPSmMbVA+3buguyNkyFC21x71C4sOi20yCXS01r4wDyeQboeApMWpCTgDSMR1eKvERwYzqSXSLhO8YrjlPNY/hbCH57m1cMAaEwLJFzgsJfY1ehylNMkGFq8iFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374080; c=relaxed/simple;
	bh=HU4D50xUEXGTjEy1hYAKL14nhun18f8ZSclPBfAPuZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/HEKXLSI+4pumRDXaVNvE8tEZ6QfsYdZfPv3qgN3UW1sYZLgQbtoV3AFab+7BOcSFGfHu5r6ltk4pMPRRxM4T3yF+cCodwdn47PCAbatU69QX+10oHbZi2Rqt+L3MJhifzB1g/kKA4zq2fykIHT7NF1Fk3dyclKM+6AjBBWRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQJ0siWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQJ0siWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554841F00A3C;
	Thu, 21 May 2026 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374078;
	bh=CRNoWJlEPylYeAv7EKMrmhsVza1n4tj76p/bqvx4fJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RQJ0siWssrYWvg/DGI5+vQwOu7nENn2+wcgZV/fjpbB4EuWj7PszjrEKwKbU3ibkT
	 /bvopnQnWIleF5nL8HOX0wGPRdtLSo0Vw05get+n+DV6yA9blh8EAIeBX2hXh8jGxw
	 P/Xi2iu9sgB0QpTZYh1ci1g6TD36vQD+bgR4l4Jol5dNKr4bDXLhbStD3lUGtGozMk
	 aCKFQ6LiqlYE3BA3j55pXTcmPmkikxvTfJzoq9hzX4vDk5DdImd+IO/w6FcSQZpK05
	 bHp+C1uYYFKRVasUmlTn9z2WPo73H73W+ASKXakuNWieK9buVSsw4+383suNdFwWFo
	 BdtXduN5bN1tA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 03/14] samples/damon/mtier: replace damon_add_region() with damon_set_regions()
Date: Thu, 21 May 2026 07:34:13 -0700
Message-ID: <20260521143428.83157-4-sj@kernel.org>
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

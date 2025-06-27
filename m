Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4AB2E9EC9;
	Fri, 27 Jun 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042012; cv=none; b=gSR2xTOqHylmhMmsvRzyM3pNat1vDwCVAzWom/Yxt3+/PxqOCO8ypTaLqVQCb7otdKgynG4+tovl17qrZ6JDBe4aaMG5rHBnFo55ZsJfr/XRt/lDSIJ4LAMjveOHDwjLHj+T8xND83ndzom5Cqg3lpggR4Pai/bwAXiB1PPglV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042012; c=relaxed/simple;
	bh=WFhAKwhDV0tYJDjNHwHxrmRVh8mM0OQx2XhK1ipVWb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UC96sLdbeYuGqvn3TCliSka75AKuMJKlcg2VA8M4HkqmKkbLlMV5bjoCZKBCiOgmA8basLAbhkMuCYF1px6/GQQZxYEBJSlIOuWYc7Jzo6iNqbCqjIjx90A4x2kw2kLmyx+LkxnrV2BCfxT7R1ufAJ5LtaYrsVJhqGsq4OmGGxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvELLEMt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvELLEMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13231C4CEE3;
	Fri, 27 Jun 2025 16:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751042012;
	bh=WFhAKwhDV0tYJDjNHwHxrmRVh8mM0OQx2XhK1ipVWb0=;
	h=From:To:Cc:Subject:Date:From;
	b=AvELLEMtW9jgJU3jVQbc/o9w3TRJ2g8otBKa1jWoKxnYTgdKg+ohECLGFouptLwGt
	 gjqW/SpKF89QWgmy0w7fKEqGSkD59rwIHvYVE/zZyFj12hb463CHlLe0Vbh0VdPTGp
	 j8azFk3T0pBvrnjWG/aOWhfiDsJKW+2PesglAxnTfhz/0dM7j5kD4asbJVeZ+vQ8ZS
	 Bek2nrdPf8TtIaCKTznnhlAqDA7K7w8kCtrQgzzcdb59EN7Mcu+2IKy9hSON4Uyd1S
	 jNCkBiqak3GsnM/JwPXTIgtxk91ct4EMfs3/xNr8Ci8wYZooy6aZV5NSEDMn42I0Vi
	 6Odf68oC/IeHw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yunjeong Mun <yunjeong.mun@sk.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH RESEND] samples/damon/mtier: add parameters for node0 memory usage
Date: Fri, 27 Jun 2025 09:33:29 -0700
Message-Id: <20250627163329.50997-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunjeong Mun <yunjeong.mun@sk.com>

This patch changes the hard-coded quota goal metric values into sysfs
knobs: `node0_mem_used_bp` and `node0_mem_free_bp`. These knobs
represent the used and free memory ratio of node0 in basis points
(bp, where 1 bp = 0.01%). As mentioned in [1], this patch is developed
under the assumption that node0 is always the fast-tier in a two-tiers
memory setup.

[1] https://lore.kernel.org/linux-mm/20250420194030.75838-8-sj@kernel.org/

Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
Link: https://patch.msgid.link/20250619050313.1535-1-yunjeong.mun@sk.com
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 36d2cd933f5a..f3220d6e6739 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -24,6 +24,12 @@ module_param(node1_start_addr, ulong, 0600);
 static unsigned long node1_end_addr __read_mostly;
 module_param(node1_end_addr, ulong, 0600);
 
+static unsigned long node0_mem_used_bp __read_mostly = 9970;
+module_param(node0_mem_used_bp, ulong, 0600);
+
+static unsigned long node0_mem_free_bp __read_mostly = 50;
+module_param(node0_mem_free_bp, ulong, 0600);
+
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp);
 
@@ -112,7 +118,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	quota_goal = damos_new_quota_goal(
 			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
 			DAMOS_QUOTA_NODE_MEM_FREE_BP,
-			promote ? 9970 : 50);
+			promote ? node0_mem_used_bp : node0_mem_free_bp);
 	if (!quota_goal)
 		goto free_out;
 	quota_goal->nid = 0;

base-commit: 12c066f7860c9b980fdc8ccad1f98425b3344bf0
-- 
2.39.5

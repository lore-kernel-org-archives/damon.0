Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676893B3890;
	Tue, 28 Jul 2026 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216499; cv=none; b=cj4akbG3yXWLh1Nvy52tQEtFektQvB4QkpiUydHK+j0nIFxalHl37SGqUvcPufK2w0zRptuLtIFyr29k2hdeGPQGuozEODhMfBiNGKpX3OwIhRsEORL3H3HDHmONFnSgrz+ViJlolusv0ICHKn+TrsDVPtas3G7BTnUN3SmdGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216499; c=relaxed/simple;
	bh=QvrrtTuipE6vH5VaWbRqnsyzw1mOG22KKMfL8Qk2C24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfK5Q9JINPpydT44LBh5bgY43DrLBiXUaBKNfLU7dCC7Quqc05K+nlEKaZJelfx07eXWVVLNT5yXHpwkpwbMCLBSdw5oY00y84KdvgM3dvXWyakQuEQF3iTq1K35bS2CMqqwiZmX25Bu+Z08L9VGtGDCawPLLaLrud05kanXzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjFRzyjd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjFRzyjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193F21F00A3E;
	Tue, 28 Jul 2026 05:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216496;
	bh=RY+XUIrZiXuiiU/vLhDSc4ARUS4lqpakXQtTFBEewHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bjFRzyjdG5LHd5EUvFIoWNyN4kpPMaYO/ictZ42J3ZPo0TO1vRPw0Yqew/ntKVxOX
	 LvzObgtO+Zde+G93ldx7g/NRy2kBAhuz+PqC86HvXR6zHUNTxClVg+6v3Wq0VVQj5Z
	 ugyEAd5vsITgYsUnNJ/sn/s4ZpSjskb8JlX5lRvmOpHtuEe5h06urBHgZ707ysJDKL
	 F/MopnTA3ocJnG1V20vhexwkNusWFMJwVLFOSq5p+6yhH+IWVt5316SuGLglC+emMd
	 PoUNugxLt/HRZR03iK8U6ywXRobEi8/gv1jYtHg6KkgQDsXqLrESZabqbetnUB16AF
	 fKBp0p1JoNHyw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/10] mm/damon/core: use damon_nr_samples_per_aggr() for max merge threshold
Date: Mon, 27 Jul 2026 22:28:00 -0700
Message-ID: <20260728052811.192712-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728052811.192712-1-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_merge_regions() open-codes max region merge threshold
calculation.  What it does is fundamentally the same as
damon_nr_samples_per_aggr() but missing a few corner cases.  The
unhandled corner cases should be rare and make only a negligible level
of monitoring results degradation.  But having the inconsistency could
increase future maintenance burden.  Use the dedicated function.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f7c9b94b6436b..4169268d94416 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3470,8 +3470,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	unsigned int max_thres;
 	bool count_age = true;
 
-	max_thres = c->attrs.aggr_interval /
-		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
+	max_thres = damon_nr_samples_per_aggr(&c->attrs);
 	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-- 
2.47.3

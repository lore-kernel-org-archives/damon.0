Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B242BE044;
	Sun,  6 Jul 2025 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751830339; cv=none; b=cloKxzHCuk3TzIS3B1ULnAt3M8jwIgltsao+Okq5fbGn7F+VQA2d++SEh+ZonnTcDKVJSsdowAggKzQSVJXyMXqIrg/miskPs6Z8/s+9L+AfLEOSdxItPl1SbdPyBzpHNDvL/M2cs74XeiTvrr40b0zrO4yTr+MKxuDGcltJBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751830339; c=relaxed/simple;
	bh=WC8o13MdyLXSnn3QYHivVgrcO/OQGT6f7JW9k71JMmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sav4oOm65B2XeHBldx6n2y0ZYrCY5XaS90bRD6u/SbfXSE0dkl+I4sGWIhkVMwJGtpRrzq8qA4y7e5E5O53hBpNlS40ylWhFTT+nmmqLI8woGZoWqQkuCCE5efoVc8ICMA33jwkmiFPNGN7RlEQYFnD1Jm6h2QkcgJaBlXkwoIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTcsFcHe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTcsFcHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2E3C4CEED;
	Sun,  6 Jul 2025 19:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751830337;
	bh=WC8o13MdyLXSnn3QYHivVgrcO/OQGT6f7JW9k71JMmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTcsFcHeGBuTCVMgzEV9IqQPrvIQNoUIc1770mFyAGnibmeRz3G0wR7UntkY9x2Rq
	 nwSSP2k5J6zU14YCzE2GNp0ayirLuKwHy+/4bwPdxlh6gIA8QvnyEnThFJZXERj8JX
	 /V/AzzM0jIsNwj7VKMX8s8AMUpG5+SbhepCeD7yO9vtE4D8QaC/G0p/pmkq0rzeet0
	 a+9Gi7Dl+dKKBCxQ1THkmtzs7Hn4yI7kMipkJWNXRKF8iEbFJRDkgwlhijWK+xww1v
	 NfOqrtNlvNPRcFcgm2G7QFW9G7FaQt90kms3kictnzG0V1eKkxyrogDDRJJHFoYE1D
	 m6qFX/phjWiQg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/6] mm/damon/reclaim: use parameter context correctly
Date: Sun,  6 Jul 2025 12:32:07 -0700
Message-Id: <20250706193207.39810-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706193207.39810-1-sj@kernel.org>
References: <20250706193207.39810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_reclaim_apply_parameters() allocates a new DAMON context, stages
user-specified DAMON parameters on it, and commits to running DAMON
context at once, using damon_commit_ctx().  The code is mistakenly
over-writing the monitoring attributes and the reclaim scheme on the
running context.  It is not causing a real problem for monitoring
attributes, but the scheme overwriting can remove scheme's internal
status such as charged quota.  Fix the wrong use of the parameter
context.

Fixes: 11ddcfc257a3 ("mm/damon/reclaim: use damon_commit_ctx()")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index c91098d8aa51..0fe8996328b8 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -194,7 +194,7 @@ static int damon_reclaim_apply_parameters(void)
 	if (err)
 		return err;
 
-	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
+	err = damon_set_attrs(param_ctx, &damon_reclaim_mon_attrs);
 	if (err)
 		goto out;
 
@@ -202,7 +202,7 @@ static int damon_reclaim_apply_parameters(void)
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
 		goto out;
-	damon_set_schemes(ctx, &scheme, 1);
+	damon_set_schemes(param_ctx, &scheme, 1);
 
 	if (quota_mem_pressure_us) {
 		goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
-- 
2.39.5

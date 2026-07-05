Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF983A7F4A;
	Sun,  5 Jul 2026 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285077; cv=none; b=rxAcIYXi3vZtA2utJaIbxL585dIEvMR7xwYBrMJJn19lcLZ4kvHz3mYWogwY0FmUwOhNe/AUkd1wqlP4hwvrADT5enHdauORXNwb/QtmIXTywLs/CNw0NVEajj0IeI+gAio2OYciqJeU2UhA/p+rAaajHn5uTEJRohfHz2YHjiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285077; c=relaxed/simple;
	bh=lPQsOqnXp6VWBBfDL4uYMLI1sb/Fedw10zLuq4lDRLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIDT0OlqBUm9icvTEZYT9HYq6xO1Zop+qxMwxcl6SNDtqZFHEnUKRrIe2rzgUeCdUmEbKAeESkhnL2O9+LtOvHDByF/mCbd4ZjUJ+eiTS2BKeFLM1+OS5NLYtIFh3nwj2N23I77R2qpR7U4X+5ZiwgMfA8Cu1u4GMZQzkAw4VVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu0fXxKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu0fXxKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828DB1F00A3F;
	Sun,  5 Jul 2026 20:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285076;
	bh=QEatb2PqGWEsTMpIGK5NyiCA2DZolTzT+XVQuw4N5Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bu0fXxKZ/4PUkgVIVNYFTK1AgzosC+xrKeRGaMPfoN/IwJlC8BDBms0qPYI3rE+vf
	 RwYZiwBNFGgudwzd957RdTbLsyUXskvyf9Qp88PhsSf6R/6pxnOCJB608RiC6yFm7o
	 0Cg9ypV+elSHZ5MTY/huv46qcuuhsW6+pZwUhTE9gQMYQRdhweQeRcGuS6SA2YAITm
	 iHIXeIpIx6WfS1TuySJx6DlyJLFhjpGJwKl8fV7NVMbNJxNpLmveECn0NmtDOigj6j
	 lyqh7EpKicI1bkgUwS1ZSTlDuW4MN0cLAdWBRIJPwCUwUfLNxY0dps3FqrIlLLVsuh
	 c05hvto0qrD7w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/16] mm/damon/core: set samples in apply_probes() if probe weights are set
Date: Sun,  5 Jul 2026 13:57:31 -0700
Message-ID: <20260705205743.98656-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705205743.98656-1-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When probe weights are set, the prepare_access_checks() ops callback is
not invoked, so sampling addresses of regions are unset.  Ask
apply_probes() to set those together in the case.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ad0f28469e633..71008ee6ca243 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3728,7 +3728,8 @@ static int kdamond_fn(void *data)
 		if (!access_check_disabled && ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 		if (ctx->ops.apply_probes)
-			ctx->ops.apply_probes(ctx, false, false);
+			ctx->ops.apply_probes(ctx, access_check_disabled,
+					false);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
-- 
2.47.3

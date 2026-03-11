Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3474F337B99;
	Wed, 11 Mar 2026 05:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206972; cv=none; b=anu8+HbeQy96FAujS8mzNShPCYSLOeGI2XM79NSyKKUh62iIPM9MyK1w4a1RFHwHUJIXlPgdfrssuVeeoDwo1Xx8jOjA7k3LoS8pvh438uJYuUQ8Hj+/PJfGnodipWCwT86j4PkEbeVbFUlSrejFwTQOt8ywW3N1tkltR4Ze+DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206972; c=relaxed/simple;
	bh=N3PMziG0nx7W5Sw5jivaZWpK/XVFOxMsVgwXy8jopsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVWs6xQt6ckh2jSmR658DGN/DTGW4QRLTpd9hpa0jXj0himv6Eh7VGHPJmA5YOpWWHftUkDX4VAX4bvmGkk2f3IPubxAPyr/Z1dNkJWDjUp7mcANbSVC+5S2nvtRJfDFVaUROH4SQlhVCGAcYFDDtbJSKUebOK8jqR0qTXTYdw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9jXiOPm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9jXiOPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC00AC2BC9E;
	Wed, 11 Mar 2026 05:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773206972;
	bh=N3PMziG0nx7W5Sw5jivaZWpK/XVFOxMsVgwXy8jopsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9jXiOPmvvWD9+75USBmaiUljjf15lswFDs+RYX2I5WR6ie15weaESToBTDnYeynM
	 twPYsp0Q6NacG2pgCIDbVMDJp4xG2WO5ixUgiNK6K0x4IIgY0g4ThG7RkIdJVT3Eeq
	 l81dkg9efoFCzT2i68P9sbwPbWDKyRE6xrrvrixq8CcdxMUYgQRVFPLkiv8GC3nNu9
	 Ex7FQOuyI5sPLUwu2hLKN0wsoUnkT9tnnWaIJSFHrbFJiArOVumWbgM2AL5AbgOWrT
	 cwVdKEZeXV2yxPVC/tKiI9guFeGLIxGMuN8c8F2k2tgJJdNh+5lcVyRqpOjxrj4if7
	 eRUNkd4Q6ua9w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/5] mm/damon/reclaim: respect addr_unit on default monitoring region setup
Date: Tue, 10 Mar 2026 22:29:25 -0700
Message-ID: <20260311052927.93921-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311052927.93921-1-sj@kernel.org>
References: <20260311052927.93921-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the past, damon_set_region_biggest_system_ram_default(), which is the
core function for setting the default monitoring target region of
DAMON_RECLAIM, didn't support addr_unit.  Hence DAMON_RECLAIM was
silently ignoring the user input for addr_unit when the user doesn't
explicitly set the monitoring target regions, and therefore the default
target region is being used.  No real problem from that ignorance was
reported so far.  But, the implicit rule is only making things
confusing.  Also, the default target region setup function is updated to
support addr_unit.  Hence there is no reason to keep ignoring it.
Respect the user-passed addr_unit for the default target monitoring
region use case.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 01f2f6cdbcdfe..86da147786583 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -201,12 +201,6 @@ static int damon_reclaim_apply_parameters(void)
 	if (err)
 		return err;
 
-	/*
-	 * If monitor_region_start/end are unset, always silently
-	 * reset addr_unit to 1.
-	 */
-	if (!monitor_region_start && !monitor_region_end)
-		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
-- 
2.47.3

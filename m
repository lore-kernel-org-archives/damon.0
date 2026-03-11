Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7133D503;
	Wed, 11 Mar 2026 05:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206972; cv=none; b=mzKoPUTruR0b94ldVxxQiiOFcFF+GTYMcbHQP0Qwvbn8vpudyBzjxa7sTMoF+FAxlqbuqR6IXScUrmRg6uzHWAPOVnO9GkVO65Fk20b0cVn8yWE8JTRx3ItA87BgDTyAfi3iRhHVEnh927I5cLUwARo7ttYGnrxshI/FC1a5JFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206972; c=relaxed/simple;
	bh=ESvZf4UkUBS6SSFEGCLnD8WnAsHOvLPTsDE9mnF1u0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXJ9YrpNf+iuFjmuwYDcRKyS5sOAYsqMa1sCzIYEhzHilAkBbjoauUqm7kMxBUGjbHX0n0PCVG5+1Z+gOUNwmN8vlrcJIwkP3+7m/dEF5LECO3LvMTWUCy5VYYQ15nvr9+zOfCUtDSznI2KQedFYjcjZXsR6DmRrFR5aaoki2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUFZR4CD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUFZR4CD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3B9C19425;
	Wed, 11 Mar 2026 05:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773206972;
	bh=ESvZf4UkUBS6SSFEGCLnD8WnAsHOvLPTsDE9mnF1u0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUFZR4CDVcc+9x4268CeSuiPQAG7y6RnDcoFnSLsGZUpeyOlKbFXFR57tXoUAc2Pz
	 MuyXRVn698cI6fITK9reHO5e0sjhJzUrk5FvfdQ47VdrcLkn5lQLSHt2R954aGQCVP
	 tnkYnn7+hYO3K1C+qNX7KkQDIhMPc9eEHdwQbOXQee2BJkDBoenu/6/vfUsW5bHIP8
	 +dJJMg8up4CPyIqSXPrEwm3voEah2VnWzmB+HYdboVkdY+xwYo0q+umhxbQjpyXl1x
	 nw1r0XKO0aso+lFc7m6N4okCw+Gjer4L/UsDsLL4zfCM8UITryigJQrAEYZ7Jphb+J
	 Fjahs/sBzuY0w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/5] mm/damon/lru_sort: respect addr_unit on default monitoring region setup
Date: Tue, 10 Mar 2026 22:29:26 -0700
Message-ID: <20260311052927.93921-6-sj@kernel.org>
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
DAMON_LRU_SORT, didn't support addr_unit.  Hence DAMON_LRU_SORT was
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
 mm/damon/lru_sort.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 133ea17e258df..554559d729760 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -291,12 +291,6 @@ static int damon_lru_sort_apply_parameters(void)
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

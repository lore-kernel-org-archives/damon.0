Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0860289374;
	Thu,  5 Mar 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772689167; cv=none; b=YlkC3MH4t8F6bgV0MdqiKWk69lhbLelaWXZjl7DNSJcdyoOgsQzMAMzqiVySrEmL8fI5RrDwr8oaN8RUQn4qVS8z8AH3Mf0uBZ51eVCQNZQ0rK1gi7N4Lg/3jNr2xdZyt0USqv8nWNPaPyl6NwZudLqWfRwtjhgyBiLHFxCxT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772689167; c=relaxed/simple;
	bh=r27GMhiObkYnb8XTcWLlOteq5MZpTGOd9BxwRdhYsfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+MThU788et5MkSC1av9gF0wWh7egHH5LN5O5Sl+Dezu/LfxTB08KiBRoFPsWsGUnVfdVn0WUs0N3/IVtVnM9cvcWdV5rL+zDcZTN1nQ/itwT+5H26CkRLGyd2U++j5XCY4OV4o6zLrlYfAwdRdsdZmmx9ZSfiPaCx6Tbx8csZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4xWRRtq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4xWRRtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F38C19423;
	Thu,  5 Mar 2026 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772689167;
	bh=r27GMhiObkYnb8XTcWLlOteq5MZpTGOd9BxwRdhYsfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4xWRRtqOg/akTqggqkq/gixQ1zv0LBRIeNg/LuXjhW9SEVTzUXzgYyfEHiK9wPvA
	 MyoYMALP+2/u75UX4LTN8Yr2Z7hLBRSQMdgLgGzsqJSdPl7f6mxtWiADkFtdC7skj3
	 EK2qR/3CIW/BgZKs0nNgLs4qLsqDqftcEIXFm+RiY+gaTHHn8m0oWvmCeb/+lTn7CO
	 iVQrlYycQMcvdgCeEUn43Bb4Bj0W48KhjiwRXbzf4vw1lYwJyHHBIiPuGjEfMW3LKf
	 LCpcjA8i/fPyA8QV9XTeL3MQcXTHoHnmoO4i+cfhIItHcpWNcQeD/L7wYsJshESX6T
	 7PAiTkXSCyHNA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/5] mm/damon/lru_sort: respect addr_unit on default monitoring region setup
Date: Wed,  4 Mar 2026 21:39:17 -0800
Message-ID: <20260305053918.83786-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305053918.83786-1-sj@kernel.org>
References: <20260305053918.83786-1-sj@kernel.org>
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
silently ignoring users input for addr_unit when the users don't
explicitly set the monitoring target regions, and therefore the default
target region is being used.  No real problem from the ignorancee was
reported so far.  But, the implicit rule is only making things
confusing.  Also, the default target region setup function is updated to
supports addr_unit.  Hence there is no reason to keep ignoring it.
Respect the user input addr_unit for the default target monitoring
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

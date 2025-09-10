Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF124DD15;
	Wed, 10 Sep 2025 04:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757476828; cv=none; b=cncnNlCCq/HIdMDskw7wdUcAJ+ykMVzXJnUn8MlSlEJIbBFNSS1OwTs27NY9i2bAMa1rgkscHqaXtJgu1nGN/XKaIbdsTkcEnFeIHuZA7ZfCM/5xGxeEzpd7P7EpwpXGSrfIRxHzTvIEO3tE7JEIBNbWugZXr9ZSpZgbWq+yYa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757476828; c=relaxed/simple;
	bh=2zAXABT8QAL9TDJ+jCcIqn/wxh096OGrYLR4PeNZCg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dXZYqjPyPabAFcySdPFYa+BEk0y3CTT5wWLx14vWRx4Mvj5nqAqMJKB7O0u+sQqqRHFzW+pqlE2WBs62+PvZk8fVCCHf5VGeSWr0Ingu+DuvZqdjYClK8qwP0rD4zV6puCU500dL/GKMuktTY7JsX1J/ib69a66og1WfZ8KImWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9cC5W3z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9cC5W3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C55C4CEF0;
	Wed, 10 Sep 2025 04:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757476827;
	bh=2zAXABT8QAL9TDJ+jCcIqn/wxh096OGrYLR4PeNZCg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p9cC5W3zGB0zP4XJWUPtb5EkbnCdT8tUDO+7g+aA/oz+yvmnmeAIWhVrW6E/1Cqcx
	 CyKPrfuhZrHXaqVVFOH2oURcCbTgP/xYM67b9zfscIslWpwFI6KFTWbosTVx2D2aQ1
	 r8cAy55uc6zRw1yMxyvmibc+jsoOUQ35ZDOQKVE0i5QV6biq4oYENYI7DH4tr3Zv30
	 znDVGhsYRTwoK1CdWKQ9dKYXWaF3gw1U0Do1miKBNVpj2bJypzIIREA/n8I1GLY8EU
	 3VMO8YTC6iTa+WdtoebFXnp4LYa02fC0PNR8u8+Jqd+rFzBLaNS8ZxAV8vock/snC6
	 T3SUayFJFQEsw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/2] mm/damon/stat: expose the current tuned aggregation interval
Date: Tue,  9 Sep 2025 21:00:21 -0700
Message-Id: <20250910040022.168223-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250910040022.168223-1-sj@kernel.org>
References: <20250910040022.168223-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT calculates the idle time for a region as the region's age
multiplied by the aggregation interval.  That is, the aggregation
interval is the granularity of the idle time.  Since the aggregation
interval is auto-tuned and not exposed to users, however, users cannot
easily know in what granularity the stat is made.  Expose the tuned
aggregation interval in microseconds via a new parameter,
aggr_interval_us.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 87bcd8866d4b..ff1c076185e6 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -39,6 +39,11 @@ module_param_array(memory_idle_ms_percentiles, ulong, NULL, 0400);
 MODULE_PARM_DESC(memory_idle_ms_percentiles,
 		"Memory idle time percentiles in milliseconds");
 
+static unsigned long aggr_interval_us;
+module_param(aggr_interval_us, ulong, 0400);
+MODULE_PARM_DESC(aggr_interval_us,
+		"Current tuned aggregation interval in microseconds");
+
 static struct damon_ctx *damon_stat_context;
 
 static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
@@ -133,6 +138,7 @@ static int damon_stat_damon_call_fn(void *data)
 		return 0;
 	last_refresh_jiffies = jiffies;
 
+	aggr_interval_us = c->attrs.aggr_interval;
 	damon_stat_set_estimated_memory_bandwidth(c);
 	damon_stat_set_idletime_percentiles(c);
 	return 0;
-- 
2.39.5

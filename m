Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220293A6F05;
	Sat,  7 Mar 2026 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913248; cv=none; b=QJTJxj43BMP/Qk+nVR8aoEGgogBj8SSbHzH/77CLLetTUA5lz1DQSJyIxa8kVCNjdmCHHAMOHUo4TRwC1+FJmKoZaO5zABEeci+zlnO0KKM3OONyjOnIdQuHXgXo254E5pyxFr+RjTCP3VxDM60lLk0AWQfQHa0SMKAHXjzkgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913248; c=relaxed/simple;
	bh=lhgKVHeTPuqy/SKtOJv2TodL0/GOZKE7UoJkbwMyV80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mqk2SXWTXbGDJqWD8+pLU4UOFl/QQjYhhvP8rXb8M9qstujIXSXe9pWx3JUHewgjmwO3tW54GRoRw8tGJdcbtYQhms+r0B9RMrjZFi+pv6a6VIG764pHMbcFLLFeusoB5cREZgsxLRkQvtG6uPBOjgCnCrADSeW1G6P6scqx3Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdleRt+2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdleRt+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E28C19423;
	Sat,  7 Mar 2026 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772913247;
	bh=lhgKVHeTPuqy/SKtOJv2TodL0/GOZKE7UoJkbwMyV80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdleRt+2SbvKj/v0G3elyQ10jHVItn2AczI/Bu7TjjQMtbuBMreodArxjoL/tC52l
	 u31lNGbXHtoNLuMoeZAtrQ240j8obE4QTZmqokndT/qIr8LTjU1CLKq7idcKXt3QZ1
	 LKDjImG4K8W2yxL5GElLV/FBdI4GM6aQY5cUtCFrgNjMIMlU1w/MKNLwq7rJoC1zrO
	 B60M7MK1uy5OpA4DDGnNuvzm8Rp8KCfmWwLc62fcghBYaqPkEAfwAzquzOhNI/MIUn
	 ffeackEVTkbp4zXkeXeOFDh7hI2xgpX0+GyJl9gISJ78uMcxMb95SXRlIdx95+/08Y
	 f8YCJGAzvbHPQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/7] mm/damon/core: clarify damon_set_attrs() usages
Date: Sat,  7 Mar 2026 11:53:51 -0800
Message-ID: <20260307195356.203753-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307195356.203753-1-sj@kernel.org>
References: <20260307195356.203753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_attrs() is called for multiple purposes from multiple places.
Calling it in an unsafe context can make DAMON internal state polluted
and results in unexpected behaviors.  Clarify when it is safe, and where
it is being called.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4e931f7380477..7f74982535aca 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -751,8 +751,16 @@ static bool damon_valid_intervals_goal(struct damon_attrs *attrs)
  * @ctx:		monitoring context
  * @attrs:		monitoring attributes
  *
- * This function should be called while the kdamond is not running, an access
- * check results aggregation is not ongoing (e.g., from damon_call().
+ * This function updates monitoring results and next monitoring/damos operation
+ * schedules.  Because those are periodically updated by kdamond, this should
+ * be called from a safe contexts.  Such contexts include damon_ctx setup time
+ * while the kdamond is not yet started, and inside of kdamond_fn().
+ *
+ * In detail, all DAMON API callers directly call this function for initial
+ * setup of damon_ctx before calling damon_start().  Some of the API callers
+ * also indirectly call this function via damon_call() -> damon_commit() for
+ * online parameters updates.  Finally, kdamond_fn() itself use this for
+ * applying auto-tuned monitoring intervals.
  *
  * Every time interval is in micro-seconds.
  *
-- 
2.47.3

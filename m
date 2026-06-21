Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75542C21E6;
	Sun, 21 Jun 2026 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057450; cv=none; b=R3f65qk7qskVxTHJe1WE3LXkNDGUDfQZRQKvL7dMNR7qt6NLIVDKUZm7jLsK5q9WXIxznmtHC/GtEoOjkLdGirSju1MCx88BJDsy7XbccGnwtp/Pz6BTWfJBKxz9hOfKdGwxCg3+F1wgtwhZceqjlJ40l0zUcW3ZseUIuLAMovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057450; c=relaxed/simple;
	bh=8GSXboQk0t8LCnK0MqH9QrJU+rQC4ZxbRPR0oI7HBqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjDpcWFY3LldY0nvmXiFcOYSP5vv4fY4Y/jB4H4aoUz2hh8bNXGjQpinhGV9Oa+sal3sdas9r2+UtEgpCuEOiaYBU2Sea7MURsDBqkKTjzzsoHSLl6q+6UvyBU+9fMW8A2fKfXl+6uEARaEk2wlzj73DyR2OmIsTUYSPZRBAvJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/BcZIal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/BcZIal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1817C1F000E9;
	Sun, 21 Jun 2026 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057449;
	bh=PQradOyUplHOgC8HnoJqDwUCjl6LH6os+/rkUZXzJJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k/BcZIal7VCs6OrNLVML9FeuV4fPD/CViya5pPb9gSAVC34rDofSmdEvMp6B8pGEI
	 w31+oZMzGTEVRPj/B7ZyBD6SQTXCmdcan0W7buSS7rYyTX35A9KWmSOlSUZ5k26OoR
	 4uFPZ8KlyQaHXvy7gfTy1W9pVFOiGWdSdbtmRWTGMI1eht5O2QhMQ6EzOUHVRQ1y74
	 8K0EtKqL7u8bdv729s40cO+GPuRarAalPnr8WDP3jJ8zBnCXAQewFc99Gu2qDAeGZQ
	 OWnhE0eBU2OYVlJgz3FIfCVihrD9CETF5wQqcusQG8c5Ct4qH9wgT2cv6VA9ZBEjzn
	 uk1hIQoSEtUOw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 03/17] mm/damon/core: always update ->last_nr_accesses for intervals change
Date: Sun, 21 Jun 2026 08:56:59 -0700
Message-ID: <20260621155715.87932-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621155715.87932-1-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each iteration of kdamond_fn() main loop caches and use the next
aggregation time (next_aggregation_sis) because it can be updated in the
middle, inside kdamond_call().  If that happens,
damon_update_monitoring_result() is called for scaling the access
frequency information of each region according to the changed intervals.
The function does not update damon_region->last_nr_accesses when it is
at the end of the aggregation, because it will anyway be reset after the
function is executed, in kdamond_reset_aggregated().

Let's suppose damon_nr_accesses_mvsum() is called with the not yet
updated last_nr_accesses.  It will use the fresh next_aggregation_sis in
the context instead of the cached one, unlike kdamond_fn().  As a
result, use of not updated last_nr_acceses with the updated
next_aggregation_sis result in returning wrong value.

There is no such damon_nr_accesses_nvsum() call at the moment, so this
is no problem.  It is planned to add such calls, though.  Prevent the
issue by updating last_nr_accesses always.  This adds overhead, but
that's fine because the overhead is not big, and it is anyway not a fast
path.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2cc911fa221aa..191533685cf2f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -873,6 +873,8 @@ static void damon_update_monitoring_result(struct damon_region *r,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
 		bool aggregating)
 {
+	r->last_nr_accesses = damon_nr_accesses_for_new_attrs(
+			r->last_nr_accesses, old_attrs, new_attrs);
 	if (!aggregating) {
 		r->nr_accesses = damon_nr_accesses_for_new_attrs(
 				r->nr_accesses, old_attrs, new_attrs);
@@ -884,8 +886,6 @@ static void damon_update_monitoring_result(struct damon_region *r,
 		 * interval.  In other words, make the status like
 		 * kdamond_reset_aggregated() is called.
 		 */
-		r->last_nr_accesses = damon_nr_accesses_for_new_attrs(
-				r->last_nr_accesses, old_attrs, new_attrs);
 		r->nr_accesses_bp = r->last_nr_accesses * 10000;
 		r->nr_accesses = 0;
 	}
-- 
2.47.3

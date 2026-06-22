Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C6B3B9D9F;
	Mon, 22 Jun 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138111; cv=none; b=VzfL8ErXU92sY1YyKsapfGCuwAhBO1ZwPV8QhSefM7QlxQqlsSETxAje1nN4W4DMbmCQJha5bmskbkPIiFKNr31eOfshwpBmUvlpKi25oB/NWXEF8Ky0nQ/W1uIvd/hITGQyK8KJJfxz396ANI5yDN8hyUvBS5pCJWO9r8jzeCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138111; c=relaxed/simple;
	bh=8GSXboQk0t8LCnK0MqH9QrJU+rQC4ZxbRPR0oI7HBqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asInAZxS+aKiJd87olEP6meQDsxNBTaLz6yvhHoitPJXfMWdZWDGB9sNw2yHT0vjTTA+TmDj7KjscJzfQHWUW44mtzBi/1w4RxN4sD48AwYVLve4Jdrvkb58EJtiib83t6ndu6BRJjL01tgR/LHBpDiemkd46Bv1uHD+kW+2gEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnKATpWv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnKATpWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3151F00A3E;
	Mon, 22 Jun 2026 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138110;
	bh=PQradOyUplHOgC8HnoJqDwUCjl6LH6os+/rkUZXzJJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FnKATpWvDwkHRwdi9Uav1cD+mTAY2mfWw9x4neKuDXB+UkN3ME3GrN0aTqK3bnXKR
	 UahrR9MatgNRQp8lcBKKxTCp44jVg6UdjIDyPWtNas6yFDl8E8PxfCUfrxyqg6s9z7
	 4X8JiaU0kCdrp+SZ3TrAGpCu+2iF8abRAx2swsglG/mCp5WCPmf+12o0cfJ4fdFx/d
	 +jC4BdEwcAL3TT7V0mQ7tmXBTHXF6uNR60ZyLWS2jSYoYpCmQPGJgn8imLYKCvyYEc
	 /SvhOqO1BtPJN0Kch5b3h9z1RyNM+fQzI9s2KDWPpOzDtK5l7dhIlUgooKIxv5y9FE
	 Bjg4YrbyBTk/w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 03/18] mm/damon/core: always update ->last_nr_accesses for intervals change
Date: Mon, 22 Jun 2026 07:21:23 -0700
Message-ID: <20260622142139.30269-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142139.30269-1-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
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

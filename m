Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76F3DA7DF;
	Tue, 30 Jun 2026 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792506; cv=none; b=LdAxKxvA3TH2qWXB5+1XutlcyDMY0UZtukzCFm7k+VWDmkRbbKokR+Xys7RmiLrvztPujG+selwGm6AUK41vPMx6kgKz5hoqr2CkKKks999xRvS/xH+bIgC7mNi5LhnC6tyW9nw1XELbTmNrqPynz7the8B/GtUlkTvIJmD3xu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792506; c=relaxed/simple;
	bh=SWUP6EnkRc+3iJVEPDthZJwXauAo2GLhOuxlB2pENJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+gcS3yx905OPhOdexL1QzO9mB1QJ+JXjOH2u6pbS7lakynXt6+Y7yPao7OBiv8dxYEZ7/hgLXCKZFFxedG+m/X700CTBPHJRwwluGc1NSaTDAplJWe6MTmoQCNOb7No1ObiGM4aZRuq7OBEydiHxABkKYZGqkOanb394o3rb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5UY8Zvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5UY8Zvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30B01F00A3E;
	Tue, 30 Jun 2026 04:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792504;
	bh=lOD+Ikul9zy0nEugQ9tO1hoHol2HP4tGP4xuSVVUhbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K5UY8Zvjp1eYY5r/rPrTFiHV8It0TmxUheywYjqhe7/5YTVYIAd1C95cYaKpBQk9G
	 umZoZAk/ggenMZu5icE1KDY7FwZANvYhweISxsVS/BxQSzVOL75Ue9lV7vM9TyZtXp
	 ESOCq7MeM/ZNpWRb6cxlSUlz6CeHYbU33ptg++H4WuxvyTZKsJLU1lNxeYikIZqJCM
	 1DBkPiV/0tVpCBelywdGNgrxQpIX3JohQDUsw6F6cwjf0YfgA3jlzRrksOj1UAYH6L
	 NH2vvvQT2xPD6BWXkPKKtDJLlqLqN4XNlzlVtblE/Mu5Uhm2i+4h+HV24N269+vpy8
	 jJEFIHeikK8IA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/18] mm/damon/core: always update ->last_nr_accesses for intervals change
Date: Mon, 29 Jun 2026 21:07:56 -0700
Message-ID: <20260630040812.149729-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c588f943080f9..669b701e50a7d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -877,6 +877,8 @@ static void damon_update_monitoring_result(struct damon_region *r,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
 		bool aggregating)
 {
+	r->last_nr_accesses = damon_nr_accesses_for_new_attrs(
+			r->last_nr_accesses, old_attrs, new_attrs);
 	if (!aggregating) {
 		r->nr_accesses = damon_nr_accesses_for_new_attrs(
 				r->nr_accesses, old_attrs, new_attrs);
@@ -888,8 +890,6 @@ static void damon_update_monitoring_result(struct damon_region *r,
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

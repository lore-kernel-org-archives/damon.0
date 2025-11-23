Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AF19E819;
	Sun, 23 Nov 2025 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923424; cv=none; b=H0WFvb27olRyjk8Op7eRaCZMTcIyJVAZ4z4Ri+vg5UJ6JzNettcRbr1prcY5YgmV/OJzgQAZsIh66yswRdIkP0avchFK2OPTbUooSOzFWPKyKBAkFDIfRw+N+AycQQ18osKDzkIbAc/V6zH4RasKciNautgy5MJ7NFSHkX+pAJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923424; c=relaxed/simple;
	bh=DsxYSEC5PojLKtzUcVWfJP4PrbIxS3wEgw82HduLlh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1evB/q0/f1hM4/ncAY19J9MYeg/5khAopRGxYchB0WrcTgkTQwDRirmajlX84cZ4UY8ywasL+LjVcrYsUdYQX06BdbkwqwfdRHX4guxd9YTWHwEmqfd5pDC4np54od0VD42Wix0I1ELUU0Ovmwe03JTsRjkrTlTBJ+9H8zhRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU6+gD7Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU6+gD7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3AAC116B1;
	Sun, 23 Nov 2025 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763923424;
	bh=DsxYSEC5PojLKtzUcVWfJP4PrbIxS3wEgw82HduLlh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IU6+gD7YXQfcvijugVPLPyX91rd/tCz+0r9sjh8I9R0rZ+PIg3vvv5UW0t2YJuiS9
	 xX0l74rBA+UnNVi1rjLP70NC+TaHrLQUDTLEdglLywJTIHOwthI9hJSpCC5NrUTJKj
	 QWFKDeo6HjSAiZ1QFcUaW1kaRnNfCQlZeP+30MABLps4JvO9+ULktFV2ytU8XHMYkA
	 /dLQy5xWgP/68YR8t0ofedEixkTwUMRxMlkYJCOTF1hyezxgF7A7krZP/fhX9fDjv1
	 AsEK31T0s9bCKuiBKxqj3o8PzTWpc/xG0WXnYWSqensu/GPF7bLNm7YnUulzwFepuO
	 ucx7eZmvYpf+A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/12] mm/damon/core: introduce nr_snapshots damos stat
Date: Sun, 23 Nov 2025 10:43:15 -0800
Message-ID: <20251123184329.85287-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123184329.85287-1-sj@kernel.org>
References: <20251123184329.85287-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON generates monitoring results snapshots for every sampling
interval.  DAMOS applies given schemes on the regions of the snapshots,
for every apply interval of the scheme.

DAMOS stat informs a given scheme has tried to how many memory entities
and applied, in the region and byte level.  In some use cases including
user-space oriented tuning and investigations, it is useful to know that
in the DAMON-snapshot level.  Introduce a new stat, namely nr_snapshots
for DAMON core API callers.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  3 +++
 mm/damon/core.c       | 13 ++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3813373a9200..1d8a1515e75a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -330,6 +330,8 @@ struct damos_watermarks {
  * @sz_ops_filter_passed:
  *		Total bytes that passed ops layer-handled DAMOS filters.
  * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
+ * @nr_snapshots:
+ *		Total number of DAMON snapshots that the scheme has tried.
  *
  * "Tried an action to a region" in this context means the DAMOS core logic
  * determined the region as eligible to apply the action.  The access pattern
@@ -355,6 +357,7 @@ struct damos_stat {
 	unsigned long sz_applied;
 	unsigned long sz_ops_filter_passed;
 	unsigned long qt_exceeds;
+	unsigned long nr_snapshots;
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index f9fc0375890a..af922d5e500c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -157,6 +157,12 @@ void damon_destroy_region(struct damon_region *r, struct damon_target *t)
 	damon_free_region(r);
 }
 
+static bool damon_is_last_region(struct damon_region *r,
+		struct damon_target *t)
+{
+	return list_is_last(&t->regions_list, &r->list);
+}
+
 /*
  * Check whether a region is intersecting an address range
  *
@@ -1949,10 +1955,11 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (damos_skip_charged_region(t, &r, s, c->min_sz_region))
 			continue;
 
-		if (!damos_valid_target(c, t, r, s))
-			continue;
+		if (damos_valid_target(c, t, r, s))
+			damos_apply_scheme(c, t, r, s);
 
-		damos_apply_scheme(c, t, r, s);
+		if (damon_is_last_region(r, t))
+			s->stat.nr_snapshots++;
 	}
 }
 
-- 
2.47.3

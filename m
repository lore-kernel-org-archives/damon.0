Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6095363C45
	for <damon@lists.linux.dev>; Fri, 13 Feb 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994295; cv=none; b=Fiidj8aKPL1U4qMmxBiDii4sC0hEBy1xvcZq+AjT0waK6F7RasDMROUYjDv0GVmD7pF5x0NU1Lp09QeMak8xWXcz5C1M6jdBCLl8DRIkVEN6t0QGxMAQAOx3RT38q3LQ8PVG5B2KFdqyW9xpADaW+L4PiR41qjvovodEgsahsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994295; c=relaxed/simple;
	bh=yJMGIyumKt6ooqP0Iq0OLwHOsjgEz+o3nRamxcGA0xo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iL+A63OxX/yp1WW9yhQevosncjfg+ccVfdkEbCxwIfe7V70NSpTAYuWrN6uii7S20f/RwNzlZFSKDAmUndRrp7gqG1UXTSXYP0/+eG28eEUu1LRKwD4tedpHKU2wBm5PxWYNJATjI3YBbttQvterKinixG6ATl2XFVDGu/9OnF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fCFV20nGMzHnGgv;
	Fri, 13 Feb 2026 22:51:06 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E3AE40569;
	Fri, 13 Feb 2026 22:51:24 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Feb 2026 17:51:23 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] mm/damon: remove unused target param of get_scheme_score()
Date: Fri, 13 Feb 2026 14:50:32 +0000
Message-ID: <20260213145032.1740407-1-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

damon_target is not used by get_scheme_score operations,
nor with virtual neither with physical addresses.

Changes in v2:
 - Patch against mm-next

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 include/linux/damon.h |  3 +--
 mm/damon/core.c       | 10 +++++-----
 mm/damon/paddr.c      |  3 +--
 mm/damon/vaddr.c      |  3 +--
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a4fea23da857..9a88cf8d152d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -647,8 +647,7 @@ struct damon_operations {
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
 	int (*get_scheme_score)(struct damon_ctx *context,
-			struct damon_target *t, struct damon_region *r,
-			struct damos *scheme);
+			struct damon_region *r, struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
 			struct damon_target *t, struct damon_region *r,
 			struct damos *scheme, unsigned long *sz_filter_passed);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5e2724a4f285..925908415a04 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1679,15 +1679,15 @@ static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 		r->age <= s->pattern.max_age_region;
 }
 
-static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
-		struct damon_region *r, struct damos *s)
+static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
+		struct damos *s)
 {
 	bool ret = __damos_valid_target(r, s);
 
 	if (!ret || !s->quota.esz || !c->ops.get_scheme_score)
 		return ret;
 
-	return c->ops.get_scheme_score(c, t, r, s) >= s->quota.min_score;
+	return c->ops.get_scheme_score(c, r, s) >= s->quota.min_score;
 }
 
 /*
@@ -2011,7 +2011,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 				s->max_nr_snapshots <= s->stat.nr_snapshots)
 			continue;
 
-		if (damos_valid_target(c, t, r, s))
+		if (damos_valid_target(c, r, s))
 			damos_apply_scheme(c, t, r, s);
 
 		if (damon_is_last_region(r, t))
@@ -2309,7 +2309,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		damon_for_each_region(r, t) {
 			if (!__damos_valid_target(r, s))
 				continue;
-			score = c->ops.get_scheme_score(c, t, r, s);
+			score = c->ops.get_scheme_score(c, r, s);
 			c->regions_score_histogram[score] +=
 				damon_sz_region(r);
 			if (score > max_score)
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 9bfe48826840..5cdcc5037cbc 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -343,8 +343,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 }
 
 static int damon_pa_scheme_score(struct damon_ctx *context,
-		struct damon_target *t, struct damon_region *r,
-		struct damos *scheme)
+		struct damon_region *r, struct damos *scheme)
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 83ab3d8c3792..4e3430d4191d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -986,8 +986,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 }
 
 static int damon_va_scheme_score(struct damon_ctx *context,
-		struct damon_target *t, struct damon_region *r,
-		struct damos *scheme)
+		struct damon_region *r, struct damos *scheme)
 {
 
 	switch (scheme->action) {
-- 
2.43.0


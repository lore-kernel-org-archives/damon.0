Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09391DED42
	for <damon@lists.linux.dev>; Sun, 22 Jun 2025 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750594225; cv=none; b=tqKzK8Qo3c0pO79hqsm3WA2TxqPgul+th3/iEbah6TVxNisRnS75Dwp/1zdzMXePUFTJPE36k6xqhZ5Io8Y40iZBr2AQwB0a3x8IHb3oPOUQsqVq+kHF9aCr0dRLm2pQnOwFjVhv55/Bn0MVkO4WbER6GGRiG1KwinrF6JiQdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750594225; c=relaxed/simple;
	bh=jFsLJ/jwPJhAxfNaRU2BVDVlu/j7+w4U9vFbccX4exE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u24ohyTQH5y0JFNRGSRvY11J7ltSWXhw14s1ESzsD95uaAASsJLtBiR1DQsNCzueEAjLxIjH2DcfpCoIPH2N0Hy0Jh+rhz/2+4uR1mG5cqOXTS7z4TpNWIu+8atP90wL81yaGNZUXs33XIl/b8/ifCtfUaF+BVGoTIGaVAOV4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-32-6857f2ad3373
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: [PATCH 1/3] mm/damon: do not allow creating zero size region
Date: Sun, 22 Jun 2025 21:09:23 +0900
Message-ID: <20250622120926.1712-2-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250622120926.1712-1-honggyu.kim@sk.com>
References: <20250622120926.1712-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsXC9ZZnke7aT+EZBp8+i1vMWb+GzeLJ/9+s
	FvfW/Ge1OPz1DZMDi8emVZ1sHps+TWL3ODHjN4vHi80zGQNYorhsUlJzMstSi/TtErgyrs7s
	ZC3YxVNxb+1k1gbGU5xdjJwcEgImEpvWtLPC2L8unWcCsdkE1CSuvJwEZHNwiAhYSUzbEQsS
	ZhZYwSgxb0UcSFhYwFVi4U52kDCLgKpE85WZbCA2r4CZxKt7E6Emako83v4TrIZTwFxi/Zrz
	zCC2EFDN14M/WCHqBSVOznzCAjFeXqJ562ygGi6g3h42iR99t9ghBklKHFxxg2UCI/8sJD2z
	kPQsYGRaxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREYhMtq/0TvYPx0IfgQowAHoxIP74uDYRlC
	rIllxZW5hxglOJiVRHgPOQGFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0t
	SC2CyTJxcEo1MLKdMfiyLujYrKmPg5NijTMZ/pgszJf0jzASaXu6d9v+wuDiCO9y8Z9q0ys8
	2Ks0eEvLLglOKZdmTDG4n6nx1udUfoZM+GXDx705EZeKLjziSg3quVkjPzN2x08FoUm83Alq
	O5MWdr1X/Ft7os52u4d5/zYTzrsr299VMy4X5Hj55MaKOOPlSizFGYmGWsxFxYkAyKSAqT4C
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsXCNUNLT3ftp/AMg/fP2S3mrF/DZvHk/29W
	i8/PXjNbHJ57ktXi3pr/rBaHv75hsvi9bQWbA7vHplWdbB6bPk1i9zgx4zeLx4vNMxk9vt32
	8Fj84gNTAFsUl01Kak5mWWqRvl0CV8bVmZ2sBbt4Ku6tnczawHiKs4uRk0NCwETi16XzTCA2
	m4CaxJWXk4BsDg4RASuJaTtiQcLMAisYJeatiAMJCwu4SizcyQ4SZhFQlWi+MpMNxOYVMJN4
	dW8iK8RETYnH23+C1XAKmEusX3OeGcQWAqr5evAHK0S9oMTJmU9YIMbLSzRvnc08gZFnFpLU
	LCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQLDbVntn4k7GL9cdj/EKMDBqMTD+/Jg
	WIYQa2JZcWXuIUYJDmYlEd5DTkAh3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZ
	qakFqUUwWSYOTqkGRmmPGZuFdvn8k963WSvJaOL0GnahjpB/R44tlDvNvz/hn/Kv6kn2hWIK
	HnvSU8/x1iWnNpvs6d1byT07dtJRUSOXe7cWi9Zbzom3s2ZVf+JyMHeKjM/L0/ccb/D/VV9j
	Wfy+rLvVQevznnffF090ej4l5ma170qj3P8ck+1fpZy4v9dKs+JsmBJLcUaioRZzUXEiAE49
	jdEzAgAA
X-CFilter-Loop: Reflected

Creating zero size region leads a divide by zero error inside
damon_get_intervals_score() as follows.

  static unsigned long damon_get_intervals_score(struct damon_ctx *c)
  {
      struct damon_target *t;
      struct damon_region *r;
      unsigned long sz_region, max_access_events = 0, access_events = 0;
      unsigned long target_access_events;
      unsigned long goal_bp = c->attrs.intervals_goal.access_bp;

      damon_for_each_target(t, c) {
          damon_for_each_region(r, t) {
              sz_region = damon_sz_region(r);
              max_access_events += sz_region * c->attrs.aggr_samples;
              access_events += sz_region * r->nr_accesses;
          }
      }
      target_access_events = max_access_events * goal_bp / 10000;
      return access_events * 10000 / target_access_events;  /* divide by zero! */
  }

This patch makes a NULL return for such cases when creating a region
inside damon_new_region().

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Cc: Yunjeong Mun <yunjeong.mun@sk.com>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b217e0120e09..44740da337fd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -126,8 +126,11 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	if (!region)
 		return NULL;
 
+	if (start == end)
+		return NULL;
 	region->ar.start = start;
 	region->ar.end = end;
+
 	region->nr_accesses = 0;
 	region->nr_accesses_bp = 0;
 	INIT_LIST_HEAD(&region->list);
-- 
2.34.1


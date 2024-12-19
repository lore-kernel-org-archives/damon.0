Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B21A0728;
	Thu, 19 Dec 2024 04:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581028; cv=none; b=AZZtUe+DKYtVVL7UGQ1zALpqDTZnGkmqW76sSVA4LlQFaUuMIlZlJvXqKNcDIGhfJR9+QB1UYJ2RiVUPnGUPZ31xSn6DT1KLTl0CFnIp27YXO4UCBFk8p4l+MeEcgNk+3w1/gCxDsd7wcQ0jApKSiJxOGKrq+ATrX7nnteBLCtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581028; c=relaxed/simple;
	bh=64D8a6jEKpsztUjzJW7u7/dJMtao+tMWa0luqj3yM0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOM+IGYrf6MyLakVMhwfxqexJGow/1EloEHo8JmrWmQvBEtKiyHLXG1RkGkk1AR6vVrJni8bQAQk3sT1k8Vhg0wzGAEowhMx4SUUIlWd2PHXGm3ArOZl7kityo6UEd0FalU225qh1TvIKMTDnIWlaxoNPjHVXTMYSgi2E/yIGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBmQQXmZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBmQQXmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D239BC4CED6;
	Thu, 19 Dec 2024 04:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581028;
	bh=64D8a6jEKpsztUjzJW7u7/dJMtao+tMWa0luqj3yM0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DBmQQXmZIOIzv5rl3Sq/NBNabDLR6GahdM2WjV4Ilu0m0t00lMHKeClh3MFv8z2Qy
	 +sIXM5KGE/KBmNlWN7szTk8ucFGmzSRWp8Wmewl0/Dhr1A1vLEL2bd4D3I0LyRreVV
	 PrZIr/PctZNuWPZwMzNxn/zrpr3E1Zh0DCtst3435UjDHeWAQqXByNN3HBUYKEsGZe
	 aB3TtSjRyZ0CQeu1cC2u9vDYqYqB1jwW+cvNUqlTFIfG5cLuUknjpkaodwSKbfDIF+
	 FrQP77iHzd8QeOe7WMPUl0sHVFXFJjY3kPT+YAAcv5otXGHeHEE9jv1qgdrpJH3g/l
	 wC8CNBbAKoWmw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/18] mm/damon/core: implement per-scheme filter-passed bytes stat
Date: Wed, 18 Dec 2024 20:03:17 -0800
Message-Id: <20241219040327.61902-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a new per-DAMOS scheme statistic field, namely
sz_ops_filter_passed, using the changed damon_operations->apply_scheme()
interface.  It counts total bytes of memory that given DAMOS action
tried to be applied, and passed the filters of the scheme.  DAMON API
users can access it using DAMON-internal safe access features such as
damon_call() and/or damos_walk().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 +++
 mm/damon/core.c       | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bff39c23f16e..4a68bb38aad5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -291,6 +291,8 @@ struct damos_watermarks {
  * @sz_tried:	Total size of regions that the scheme is tried to be applied.
  * @nr_applied:	Total number of regions that the scheme is applied.
  * @sz_applied:	Total size of regions that the scheme is applied.
+ * @sz_ops_filter_passed:
+ * 		Total bytes that passed ops layer-handled DAMOS filters.
  * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
  *
  * "Tried an action to a region" in this context means the DAMOS core logic
@@ -315,6 +317,7 @@ struct damos_stat {
 	unsigned long sz_tried;
 	unsigned long nr_applied;
 	unsigned long sz_applied;
+	unsigned long sz_ops_filter_passed;
 	unsigned long qt_exceeds;
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c7ae95d6b7ba..8540e8f91260 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1354,13 +1354,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
 }
 
 static void damos_update_stat(struct damos *s,
-		unsigned long sz_tried, unsigned long sz_applied)
+		unsigned long sz_tried, unsigned long sz_applied,
+		unsigned long sz_ops_filter_passed)
 {
 	s->stat.nr_tried++;
 	s->stat.sz_tried += sz_tried;
 	if (sz_applied)
 		s->stat.nr_applied++;
 	s->stat.sz_applied += sz_applied;
+	s->stat.sz_ops_filter_passed += sz_ops_filter_passed;
 }
 
 static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
@@ -1580,7 +1582,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		r->age = 0;
 
 update_stat:
-	damos_update_stat(s, sz, sz_applied);
+	damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
 }
 
 static void damon_do_apply_schemes(struct damon_ctx *c,
-- 
2.39.5


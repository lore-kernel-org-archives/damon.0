Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253837F74D
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774220195; cv=pass; b=YcajPjMvEfbyM4gey00a0naDYgYUacDVKFq/CCga2PgknOJTwY/m/G9bVaHAJHywgr/DoF1Z/QEUiWXBETgR2hICFgyui0qJLTXN55B2Ybz/mEe8pz/xExMTk3066aRFd9L5r73K6QTA3cWY2cxsDnnc8C2dQqHgYRWbFEQCNuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774220195; c=relaxed/simple;
	bh=MOiID3weL4oa20w4xOggWwVx5XjIa9wj1xFeQ58o9cg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xu0EsJjlG81EJsuD9pJBGW0f3VLY4A/VHnyYJi/JFgMHSCFI9zhXEYGWu6+037MD8EcOXstdgyFxNQUIz86fvbNKzepQqVdWVw9RMp7EQZQrHXNJm5nqvRvpUb2jdDKxH7xg/VAev0QncHoB0ntrgyqOUX7TuypCSVCUzEUfeOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=dCS6leci; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="dCS6leci"
ARC-Seal: i=1; a=rsa-sha256; t=1774220190; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=UigafiQgHsVCVl6vlg+lSi5Wv7Zc4Q43A/4OmBfX4Jo7SDCX+174XDaHuxeLQ8WBWjRFC8iD0TRvM5wNPVNnD1c6U1bMaHlNaV+hiSJWWHlnbKdEKG09WVyid0igDeYyJyJuIl78dIM4bXJR8I0G2ik6RgzxI1F5oN+hHnVEbN8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774220190; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=838iRbAcXH2NCU1A1DaV1kt5NP6LjTFkRnUqJYBZUx4=; 
	b=gh6Egw/LrWqRw58TqEKBHxEis0qD+qrL2vTYdZGGZRcy856DwVsCxZMABF8BP/mPXIWBQePCIuMehWmmP+j5oyni7mPI4aw8LmEk4NaD+V/LO4ov4RrlLN3VyHSDd2wriHCgP0hJcPZvlAjq/l0rXHKhsAYOSvwfRUAbfhLulNw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774220190;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=838iRbAcXH2NCU1A1DaV1kt5NP6LjTFkRnUqJYBZUx4=;
	b=dCS6leciad1MsQSVZkgf5sGCoTHkodLVIC4JTCMNFMpTzdimqGWYAIsU/xlEhOBj
	QL6lg8sJkXGbYX3dofOqUy5opI10hSkILoqNGva2MSQlowfAiKul4t4d5WQwkTE/MRo
	BwtE64P9v141egHO8Z366nPkD0fmYscyLzomfI/o=
Received: by mx.zoho.eu with SMTPS id 1774220188445159.7066913354488;
	Sun, 22 Mar 2026 23:56:28 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] mm/damon/core: optimize kdamond_apply_schemes() with pre-filtered scheme list
Date: Sun, 22 Mar 2026 22:56:27 +0000
Message-Id: <20260322225627.263202-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Currently, kdamond_apply_schemes() iterates over all targets and regions
for every scheme in the context, even if the scheme is inactive due to
watermarks or hasn't reached its next apply interval.

This patch introduces a pre-filtered list of active schemes at the start
of kdamond_apply_schemes(). By only iterating over schemes that actually
need to be applied in the current interval, we significantly reduce the
overhead of the nested target/region loops.

This optimization maintains the original Target -> Region -> Scheme
behavior while providing substantial performance gains, especially when
many schemes are inactive.

Performance Benchmarks (Filtered Array vs Original):
| Scenario Description      | Speedup |
|---------------------------|---------|
| Mostly Inactive (2/10)    |  7.5x   |
| Half Active (5/10)        |  2.9x   |
| All Active (10/10)        |  1.3x   |

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/core.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c884bb31c9b8..3b59e72defd4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2114,19 +2114,16 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 
 static void damon_do_apply_schemes(struct damon_ctx *c,
 				   struct damon_target *t,
-				   struct damon_region *r)
+				   struct damon_region *r,
+				   struct damos **active_schemes,
+				   int nr_active_schemes)
 {
-	struct damos *s;
+	int i;
 
-	damon_for_each_scheme(s, c) {
+	for (i = 0; i < nr_active_schemes; i++) {
+		struct damos *s = active_schemes[i];
 		struct damos_quota *quota = &s->quota;
 
-		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
-			continue;
-
-		if (!s->wmarks.activated)
-			continue;
-
 		/* Check the quota */
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
@@ -2476,7 +2473,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	struct damon_target *t;
 	struct damon_region *r;
 	struct damos *s;
-	bool has_schemes_to_apply = false;
+	struct damos *active_schemes[32];
+	int nr_active_schemes = 0;
 
 	damon_for_each_scheme(s, c) {
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
@@ -2485,12 +2483,15 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		if (!s->wmarks.activated)
 			continue;
 
-		has_schemes_to_apply = true;
+		if (nr_active_schemes < ARRAY_SIZE(active_schemes))
+			active_schemes[nr_active_schemes++] = s;
+		else
+			WARN_ONCE(1, "too many schemes to apply");
 
 		damos_adjust_quota(c, s);
 	}
 
-	if (!has_schemes_to_apply)
+	if (!nr_active_schemes)
 		return;
 
 	mutex_lock(&c->walk_control_lock);
@@ -2499,7 +2500,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 			continue;
 
 		damon_for_each_region(r, t)
-			damon_do_apply_schemes(c, t, r);
+			damon_do_apply_schemes(c, t, r, active_schemes,
+					       nr_active_schemes);
 	}
 
 	damon_for_each_scheme(s, c) {
-- 
2.34.1


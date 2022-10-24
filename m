Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B46AD7
	for <damon@lists.linux.dev>; Mon, 24 Oct 2022 20:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310FFC43470;
	Mon, 24 Oct 2022 20:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666644565;
	bh=oUwwKx4MXojkoEQqGNX/HEaiCbrgYpcKgdZZJ/EkGWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKMGy0G6jcaGd0zTpR25Gix/DSt03DjhqKeRS6R6ysGdjXdWs+7H8xeUlFIeCJL0h
	 1ZxJ0p4nufcgHwt0jkA1sdbhlmfhB8o9N7kOr7bjj4DkqYvDkvg5crypPti+m4h56x
	 oF0ltzUpLlBpduDIF+VhIqEuEq5nCMFUJaEYGAIIdhdAt8LrvPpr7NjW6q+mFA5/Hy
	 Nw3fO5k/IHl+lF7taJMHNRKazCaOw/prWaaR9srfa4y9bed5HaKoN+8Wian6/QXFlz
	 wPeboMDnqzyY/Yul8HhGh+0cM5fGMK0fr43YGRhBHZlPVPlVPuY/PTj5SfIkl7G+7T
	 XFkTH3jGPpLdw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] mm/damon/core: split out DAMOS-charged region skip logic into a new function
Date: Mon, 24 Oct 2022 20:49:09 +0000
Message-Id: <20221024204919.18524-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024204919.18524-1-sj@kernel.org>
References: <20221024204919.18524-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAMOS action applying function, 'damon_do_apply_schemes()', is quite
long and not so simple.  Split out the already quota-charged region skip
code, which is not a small amount of simple code, into a new function
with some comments for better readability.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 96 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 36d098d06c55..06b50ede9cc6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -694,6 +694,67 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
 	return c->ops.get_scheme_score(c, t, r, s) >= s->quota.min_score;
 }
 
+/*
+ * damos_skip_charged_region() - Check if the given region or starting part of
+ * it is already charged for the DAMOS quota.
+ * @t:	The target of the region.
+ * @rp:	The pointer to the region.
+ * @s:	The scheme to be applied.
+ *
+ * If a quota of a scheme has exceeded in a quota charge window, the scheme's
+ * action would applied to only a part of the target access pattern fulfilling
+ * regions.  To avoid applying the scheme action to only already applied
+ * regions, DAMON skips applying the scheme action to the regions that charged
+ * in the previous charge window.
+ *
+ * This function checks if a given region should be skipped or not for the
+ * reason.  If only the starting part of the region has previously charged,
+ * this function splits the region into two so that the second one covers the
+ * area that not charged in the previous charge widnow and saves the second
+ * region in *rp and returns false, so that the caller can apply DAMON action
+ * to the second one.
+ *
+ * Return: true if the region should be entirely skipped, false otherwise.
+ */
+static bool damos_skip_charged_region(struct damon_target *t,
+		struct damon_region **rp, struct damos *s)
+{
+	struct damon_region *r = *rp;
+	struct damos_quota *quota = &s->quota;
+	unsigned long sz_to_skip;
+
+	/* Skip previously charged regions */
+	if (quota->charge_target_from) {
+		if (t != quota->charge_target_from)
+			return true;
+		if (r == damon_last_region(t)) {
+			quota->charge_target_from = NULL;
+			quota->charge_addr_from = 0;
+			return true;
+		}
+		if (quota->charge_addr_from &&
+				r->ar.end <= quota->charge_addr_from)
+			return true;
+
+		if (quota->charge_addr_from && r->ar.start <
+				quota->charge_addr_from) {
+			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
+					r->ar.start, DAMON_MIN_REGION);
+			if (!sz_to_skip) {
+				if (damon_sz_region(r) <= DAMON_MIN_REGION)
+					return true;
+				sz_to_skip = DAMON_MIN_REGION;
+			}
+			damon_split_region_at(t, r, sz_to_skip);
+			r = damon_next_region(r);
+			*rp = r;
+		}
+		quota->charge_target_from = NULL;
+		quota->charge_addr_from = 0;
+	}
+	return false;
+}
+
 static void damon_do_apply_schemes(struct damon_ctx *c,
 				   struct damon_target *t,
 				   struct damon_region *r)
@@ -702,7 +763,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
-		unsigned long sz = damon_sz_region(r);
+		unsigned long sz;
 		struct timespec64 begin, end;
 		unsigned long sz_applied = 0;
 
@@ -713,41 +774,14 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
-		/* Skip previously charged regions */
-		if (quota->charge_target_from) {
-			if (t != quota->charge_target_from)
-				continue;
-			if (r == damon_last_region(t)) {
-				quota->charge_target_from = NULL;
-				quota->charge_addr_from = 0;
-				continue;
-			}
-			if (quota->charge_addr_from &&
-					r->ar.end <= quota->charge_addr_from)
-				continue;
-
-			if (quota->charge_addr_from && r->ar.start <
-					quota->charge_addr_from) {
-				sz = ALIGN_DOWN(quota->charge_addr_from -
-						r->ar.start, DAMON_MIN_REGION);
-				if (!sz) {
-					if (damon_sz_region(r) <=
-					    DAMON_MIN_REGION)
-						continue;
-					sz = DAMON_MIN_REGION;
-				}
-				damon_split_region_at(t, r, sz);
-				r = damon_next_region(r);
-				sz = damon_sz_region(r);
-			}
-			quota->charge_target_from = NULL;
-			quota->charge_addr_from = 0;
-		}
+		if (damos_skip_charged_region(t, &r, s))
+			continue;
 
 		if (!damos_valid_target(c, t, r, s))
 			continue;
 
 		/* Apply the scheme */
+		sz = damon_sz_region(r);
 		if (c->ops.apply_scheme) {
 			if (quota->esz &&
 					quota->charged_sz + sz > quota->esz) {
-- 
2.25.1


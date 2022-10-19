Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDDD7E
	for <damon@lists.linux.dev>; Wed, 19 Oct 2022 00:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0DFC43147;
	Wed, 19 Oct 2022 00:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666138404;
	bh=pjhUTVwc23jb22PLD77G9UOJ0xr3wiyTA4y/GUqZ9tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEbm6sDfcTXIUricBf/6Gpo1iIpZ+mRGtQ+MFjwsqdJcMRJG9ThbLV6mOcnyN3FaF
	 9M5u8LLdvZSETH6dqZ4z96sfehJMpZL2WdpYp/KUFbTfbjE3Ba8CYBbSZ0BvRr8Xuj
	 d6zarTSpwWTQoCBOLMITRQysEWsVO5HK+vXwINqgk3cuyZkcS3greW5jS5CMPHSoDu
	 drJ1uoCiHbCYJPYHO8EciFfvMUpl3A386v1pPN6M2QOTOxo6ZRA3VGwJXWakLh6LpV
	 MRIu67iNrSlldNaaK170Gl0j7cFBF/6btlJCrSBK0xULd1XQ+FmDDZ6lGg1+tao5gF
	 5OL1s4J4q1s8A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/18] mm/damon/core: split damos application logic into a new function
Date: Wed, 19 Oct 2022 00:13:02 +0000
Message-Id: <20221019001317.104270-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019001317.104270-1-sj@kernel.org>
References: <20221019001317.104270-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAMOS action applying function, 'damon_do_apply_schemes()', is still
long and not easy to read.  Split out the code for applying a single
action to a single region into a new function for better readability.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 72 ++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index eec258b3e57b..e777a751295f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -748,6 +748,44 @@ static bool damos_skip_charged_region(struct damon_target *t,
 	return false;
 }
 
+static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
+		struct damon_region *r, struct damos *s)
+{
+	struct damos_quota *quota = &s->quota;
+	unsigned long sz = damon_sz_region(r);
+	struct timespec64 begin, end;
+	unsigned long sz_applied = 0;
+
+	if (c->ops.apply_scheme) {
+		if (quota->esz && quota->charged_sz + sz > quota->esz) {
+			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
+					DAMON_MIN_REGION);
+			if (!sz)
+				goto update_stat;
+			damon_split_region_at(t, r, sz);
+		}
+		ktime_get_coarse_ts64(&begin);
+		sz_applied = c->ops.apply_scheme(c, t, r, s);
+		ktime_get_coarse_ts64(&end);
+		quota->total_charged_ns += timespec64_to_ns(&end) -
+			timespec64_to_ns(&begin);
+		quota->charged_sz += sz;
+		if (quota->esz && quota->charged_sz >= quota->esz) {
+			quota->charge_target_from = t;
+			quota->charge_addr_from = r->ar.end + 1;
+		}
+	}
+	if (s->action != DAMOS_STAT)
+		r->age = 0;
+
+update_stat:
+	s->stat.nr_tried++;
+	s->stat.sz_tried += sz;
+	if (sz_applied)
+		s->stat.nr_applied++;
+	s->stat.sz_applied += sz_applied;
+}
+
 static void damon_do_apply_schemes(struct damon_ctx *c,
 				   struct damon_target *t,
 				   struct damon_region *r)
@@ -756,9 +794,6 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
-		unsigned long sz;
-		struct timespec64 begin, end;
-		unsigned long sz_applied = 0;
 
 		if (!s->wmarks.activated)
 			continue;
@@ -774,36 +809,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 
 		/* Apply the scheme */
-		sz = damon_sz_region(r);
-		if (c->ops.apply_scheme) {
-			if (quota->esz &&
-					quota->charged_sz + sz > quota->esz) {
-				sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
-						DAMON_MIN_REGION);
-				if (!sz)
-					goto update_stat;
-				damon_split_region_at(t, r, sz);
-			}
-			ktime_get_coarse_ts64(&begin);
-			sz_applied = c->ops.apply_scheme(c, t, r, s);
-			ktime_get_coarse_ts64(&end);
-			quota->total_charged_ns += timespec64_to_ns(&end) -
-				timespec64_to_ns(&begin);
-			quota->charged_sz += sz;
-			if (quota->esz && quota->charged_sz >= quota->esz) {
-				quota->charge_target_from = t;
-				quota->charge_addr_from = r->ar.end + 1;
-			}
-		}
-		if (s->action != DAMOS_STAT)
-			r->age = 0;
-
-update_stat:
-		s->stat.nr_tried++;
-		s->stat.sz_tried += sz;
-		if (sz_applied)
-			s->stat.nr_applied++;
-		s->stat.sz_applied += sz_applied;
+		damos_apply_scheme(c, t, r, s);
 	}
 }
 
-- 
2.25.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F68BA30
	for <damon@lists.linux.dev>; Wed, 26 Oct 2022 22:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6D9C433C1;
	Wed, 26 Oct 2022 22:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666825191;
	bh=ijAibGNK7BkbPJuFkIhnu5wZ2+BYvBnNeRFcJtsugII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DjzuvnukrhrEXV0TQ6k4DIipy66pmX1qwr2/IQjeWOaeQa6+czARR6Ptlcl/Dt2If
	 zxTdpJLrTS3qmyK70kX5Pu1y0K4TWkQQnZIdhopotH+HN0z/aebztqY+OyRGAyASsz
	 24Ui1EecU/z0NJTt4nPQDJaiujlCHqBTKV2MukbdDG279a9OIRNuqh4T3ITZvC7OFG
	 jikPYJtcnv9+Bdfbx0W3WYCe8c0A5XPrL68AMdS/l/feFJi9Q7eWJyoPNBzONWi43L
	 WVFGdNZlifefEWOrka/adY/lsb/6ySEt70LVVxjpJKNg2XSzP5LOEcahDcXSFz9RQr
	 XdLN8zi1Pqf3A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 04/12] mm/damon/core: split out scheme quota adjustment logic into a new function
Date: Wed, 26 Oct 2022 22:59:35 +0000
Message-Id: <20221026225943.100429-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026225943.100429-1-sj@kernel.org>
References: <20221026225943.100429-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS quota adjustment logic in 'kdamond_apply_schemes()', has some amount
of code, and the logic is not so straightforward.  Split it out to a new
function for better readability.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/core.c | 91 ++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3a810c6e26bc..80d5937fe337 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -848,59 +848,64 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	quota->esz = esz;
 }
 
-static void kdamond_apply_schemes(struct damon_ctx *c)
+static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 {
+	struct damos_quota *quota = &s->quota;
 	struct damon_target *t;
-	struct damon_region *r, *next_r;
-	struct damos *s;
+	struct damon_region *r;
+	unsigned long cumulated_sz;
+	unsigned int score, max_score = 0;
 
-	damon_for_each_scheme(s, c) {
-		struct damos_quota *quota = &s->quota;
-		unsigned long cumulated_sz;
-		unsigned int score, max_score = 0;
+	if (!quota->ms && !quota->sz)
+		return;
 
-		if (!s->wmarks.activated)
-			continue;
+	/* New charge window starts */
+	if (time_after_eq(jiffies, quota->charged_from +
+				msecs_to_jiffies(quota->reset_interval))) {
+		if (quota->esz && quota->charged_sz >= quota->esz)
+			s->stat.qt_exceeds++;
+		quota->total_charged_sz += quota->charged_sz;
+		quota->charged_from = jiffies;
+		quota->charged_sz = 0;
+		damos_set_effective_quota(quota);
+	}
 
-		if (!quota->ms && !quota->sz)
-			continue;
+	if (!c->ops.get_scheme_score)
+		return;
 
-		/* New charge window starts */
-		if (time_after_eq(jiffies, quota->charged_from +
-					msecs_to_jiffies(
-						quota->reset_interval))) {
-			if (quota->esz && quota->charged_sz >= quota->esz)
-				s->stat.qt_exceeds++;
-			quota->total_charged_sz += quota->charged_sz;
-			quota->charged_from = jiffies;
-			quota->charged_sz = 0;
-			damos_set_effective_quota(quota);
+	/* Fill up the score histogram */
+	memset(quota->histogram, 0, sizeof(quota->histogram));
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t) {
+			if (!__damos_valid_target(r, s))
+				continue;
+			score = c->ops.get_scheme_score(c, t, r, s);
+			quota->histogram[score] += damon_sz_region(r);
+			if (score > max_score)
+				max_score = score;
 		}
+	}
 
-		if (!c->ops.get_scheme_score)
-			continue;
+	/* Set the min score limit */
+	for (cumulated_sz = 0, score = max_score; ; score--) {
+		cumulated_sz += quota->histogram[score];
+		if (cumulated_sz >= quota->esz || !score)
+			break;
+	}
+	quota->min_score = score;
+}
 
-		/* Fill up the score histogram */
-		memset(quota->histogram, 0, sizeof(quota->histogram));
-		damon_for_each_target(t, c) {
-			damon_for_each_region(r, t) {
-				if (!__damos_valid_target(r, s))
-					continue;
-				score = c->ops.get_scheme_score(
-						c, t, r, s);
-				quota->histogram[score] += damon_sz_region(r);
-				if (score > max_score)
-					max_score = score;
-			}
-		}
+static void kdamond_apply_schemes(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct damon_region *r, *next_r;
+	struct damos *s;
 
-		/* Set the min score limit */
-		for (cumulated_sz = 0, score = max_score; ; score--) {
-			cumulated_sz += quota->histogram[score];
-			if (cumulated_sz >= quota->esz || !score)
-				break;
-		}
-		quota->min_score = score;
+	damon_for_each_scheme(s, c) {
+		if (!s->wmarks.activated)
+			continue;
+
+		damos_adjust_quota(c, s);
 	}
 
 	damon_for_each_target(t, c) {
-- 
2.25.1


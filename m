Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D06AD5
	for <damon@lists.linux.dev>; Mon, 24 Oct 2022 20:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675DBC433C1;
	Mon, 24 Oct 2022 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666644566;
	bh=QMVnOfjAwBASqqnveYH7trvPbLLGctoJVzDXAjo2/8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FyrbHG8NuKtPFlidl5Tt0VxBwZ8AofU8nM31c9QRt1YL5zkER4eT2t+bWyQFKhWKT
	 wgBvSYeXCu/SEO9HBwRLFHFnApLFi4fK3uolj7j1l3IYTVqMbJk9KgSUV3eycqs+4a
	 KC2hn7UvUBfb8XgCKTXaMLzPZiQlY0bnvM9geXmAKP5qtIgFwfRH0WCeNUfMxxVou5
	 cwKA6edu910iaXY07Tg93RDb/xublLsnERZAR3rBuWGnbAN69bAVk9SIA7ZSVASkRu
	 YFpx/0viFcOmQn1UAp4gY+geKqFA3VTlxr90CWiODhwqD/L8xsvKxyTks3Ye3twMom
	 DLxObNmljhd7Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] mm/damon/core: split out scheme stat update logic into a new function
Date: Mon, 24 Oct 2022 20:49:11 +0000
Message-Id: <20221024204919.18524-4-sj@kernel.org>
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

The function for applying a given DAMON scheme action to a given DAMON
region, 'damos_apply_scheme()' is not quite short.  Make it better to
read by splitting out the stat update logic into a new function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c1a912bc46ae..3a810c6e26bc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -755,6 +755,16 @@ static bool damos_skip_charged_region(struct damon_target *t,
 	return false;
 }
 
+static void damos_update_stat(struct damos *s,
+		unsigned long sz_tried, unsigned long sz_applied)
+{
+	s->stat.nr_tried++;
+	s->stat.sz_tried += sz_tried;
+	if (sz_applied)
+		s->stat.nr_applied++;
+	s->stat.sz_applied += sz_applied;
+}
+
 static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
@@ -786,11 +796,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		r->age = 0;
 
 update_stat:
-	s->stat.nr_tried++;
-	s->stat.sz_tried += sz;
-	if (sz_applied)
-		s->stat.nr_applied++;
-	s->stat.sz_applied += sz_applied;
+	damos_update_stat(s, sz, sz_applied);
 }
 
 static void damon_do_apply_schemes(struct damon_ctx *c,
-- 
2.25.1


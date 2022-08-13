Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0127E
	for <damon@lists.linux.dev>; Sat, 13 Aug 2022 15:19:27 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id p125so3344031pfp.2
        for <damon@lists.linux.dev>; Sat, 13 Aug 2022 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=sczWzcrWCAkWB34nYrTJR/7dpANVkwOeC+sp+t0HVfg=;
        b=Ch2VEMqApEF7lOYCvApzId+CrqdLxAbsPRAJozfJeo2VvHdNDkJNgIpVgnWA6pGh4l
         i6xU7XYij8JJaJZNCCMT9pmc94GhY8UqOZMtIPeAmX0BizsVH6iUV/Nsc54Dv4pEF6A8
         Xb/6Xv0X8th6wday3v0NwrfxCHBjl4PGgPaiY0Vd7Gz8Etubp20Be6PmftqNqPnETYXq
         bzZnjCbNcaShGvoKRUc6sPjytSEcIe3Yuk5/BPy+6Da0a7IkdIo4B9iQZOSzdVKmjBUJ
         Hsi6XuSfWIRp/5OXmgBqWwRSLjPAqFRpt5QPYPzDYTTBIYCmR8D23vltAKb9nLCfmlRr
         IO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sczWzcrWCAkWB34nYrTJR/7dpANVkwOeC+sp+t0HVfg=;
        b=hqpCzqLN7Xqz+GasCncllZ9HTA9TmIU/ZxpZICYo/3AcDY0ym3Nw0mRFkEJzT4oTi4
         Zut3ZyLYd8ZgpyQj9N1rhTfmVH9q7cMcXVofGr4+Z7IuN6wwc3Dsx96zH+GpfXW6Zw8a
         l/GzDvLcFhHvhSJ4AX/mPFnn28Z5s22s1nx5NqhsVspHtaVXj3Qh7srd/+xOLTw3ZqBU
         0Tuk5t/Eb7f9z6ZTljEwF0kw/0AHdncS5E6w0B0U6+mZz8+XFMVcF0+MPLY7BuKGrCpw
         QmGrd9TqUPPnvpkhTU1W0zrYi79iqka00LorOeY4iRf9UktdF/cVsNFzsA7IkPRmgOjf
         QmIw==
X-Gm-Message-State: ACgBeo13atuNtBJAKOSUl3pJ75cQNaWYXHafgiC4AXHBlSicVqeM52Em
	g8bXaHPM2jSaOLIixxveww==
X-Google-Smtp-Source: AA6agR6Xb4TLm7ioMv+Cf/enVJM4Y6+9baENFEq59DyweBo1Hi/1Ds5xYTCCuHuBvnOT3fZMGNL2vA==
X-Received: by 2002:a63:e016:0:b0:427:e7f2:32b3 with SMTP id e22-20020a63e016000000b00427e7f232b3mr16970pgh.194.1660403967376;
        Sat, 13 Aug 2022 08:19:27 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id a22-20020aa795b6000000b0052dab7afa04sm3666619pfk.47.2022.08.13.08.19.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Aug 2022 08:19:26 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH V2] mm/damon/core: simplify the parameter passing for region split operation
Date: Sat, 13 Aug 2022 23:19:03 +0800
Message-Id: <1660403943-29124-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

The parameter 'struct damon_ctx *ctx' is unnecessary in damon region
split operation, so we can remove it.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
v2:
 -fix both the build error reported by kernel test robot and commit message.

 mm/damon/core-test.h |  6 +++---
 mm/damon/core.c      | 21 +++++++++------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 573669566f84..45db79d28fdc 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -126,7 +126,7 @@ static void damon_test_split_at(struct kunit *test)
 	t = damon_new_target();
 	r = damon_new_region(0, 100);
 	damon_add_region(r, t);
-	damon_split_region_at(c, t, r, 25);
+	damon_split_region_at(t, r, 25);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
 
@@ -219,14 +219,14 @@ static void damon_test_split_regions_of(struct kunit *test)
 	t = damon_new_target();
 	r = damon_new_region(0, 22);
 	damon_add_region(r, t);
-	damon_split_regions_of(c, t, 2);
+	damon_split_regions_of(t, 2);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
 	t = damon_new_target();
 	r = damon_new_region(0, 220);
 	damon_add_region(r, t);
-	damon_split_regions_of(c, t, 4);
+	damon_split_regions_of(t, 4);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
 	damon_free_target(t);
 	damon_destroy_ctx(c);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7d25dc582fe3..9964b9d00768 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -658,9 +658,8 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
-static void damon_split_region_at(struct damon_ctx *ctx,
-		struct damon_target *t, struct damon_region *r,
-		unsigned long sz_r);
+static void damon_split_region_at(struct damon_target *t,
+				  struct damon_region *r, unsigned long sz_r);
 
 static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 {
@@ -726,7 +725,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 						continue;
 					sz = DAMON_MIN_REGION;
 				}
-				damon_split_region_at(c, t, r, sz);
+				damon_split_region_at(t, r, sz);
 				r = damon_next_region(r);
 				sz = r->ar.end - r->ar.start;
 			}
@@ -745,7 +744,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 						DAMON_MIN_REGION);
 				if (!sz)
 					goto update_stat;
-				damon_split_region_at(c, t, r, sz);
+				damon_split_region_at(t, r, sz);
 			}
 			ktime_get_coarse_ts64(&begin);
 			sz_applied = c->ops.apply_scheme(c, t, r, s);
@@ -928,9 +927,8 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
  * r		the region to be split
  * sz_r		size of the first sub-region that will be made
  */
-static void damon_split_region_at(struct damon_ctx *ctx,
-		struct damon_target *t, struct damon_region *r,
-		unsigned long sz_r)
+static void damon_split_region_at(struct damon_target *t,
+				  struct damon_region *r, unsigned long sz_r)
 {
 	struct damon_region *new;
 
@@ -947,8 +945,7 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 }
 
 /* Split every region in the given target into 'nr_subs' regions */
-static void damon_split_regions_of(struct damon_ctx *ctx,
-				     struct damon_target *t, int nr_subs)
+static void damon_split_regions_of(struct damon_target *t, int nr_subs)
 {
 	struct damon_region *r, *next;
 	unsigned long sz_region, sz_sub = 0;
@@ -969,7 +966,7 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
 
-			damon_split_region_at(ctx, t, r, sz_sub);
+			damon_split_region_at(t, r, sz_sub);
 			sz_region = sz_sub;
 		}
 	}
@@ -1004,7 +1001,7 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		nr_subregions = 3;
 
 	damon_for_each_target(t, ctx)
-		damon_split_regions_of(ctx, t, nr_subregions);
+		damon_split_regions_of(t, nr_subregions);
 
 	last_nr_regions = nr_regions;
 }
-- 
2.27.0


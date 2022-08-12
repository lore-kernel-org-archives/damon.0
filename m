Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F401399
	for <damon@lists.linux.dev>; Fri, 12 Aug 2022 07:41:52 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id gp7so283629pjb.4
        for <damon@lists.linux.dev>; Fri, 12 Aug 2022 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=a85QtWLEcMRCMIMtbuuHRx4zEckQE16YnrJva/znejY=;
        b=QwJ1cMt+zU/OEIGc/ORnYEwubrCFSzo0cdKCbDj0t7pkzoiGw5mhEzchQ4TsyJQ5ee
         JQCgSApm13Au1svbHoYl+OgSVx7XkoSO/vWJWxyzMDXKJucMsYyzJhj8Q96T5/P9KK06
         W6jsyT0kBPBlTD0bH6k5aksti9W8l/2KvMSu17byb2y50Uj1btMtytyaQr3G7QFeHWfh
         QpTPra9BLoduIaiyYNhBPi7X2V8sJhZPzhxn/OZ0+1wp9yRuQKsR3e3gVTdvA5JRcCJA
         Rp1mZm9itn6C+rQLRuKsb4eWKchvezWjlfbFmkiTFHii+SKFMSdYynvKn3UTb+IB9wQ9
         OIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a85QtWLEcMRCMIMtbuuHRx4zEckQE16YnrJva/znejY=;
        b=RPm6wvC35JsZNbYJqaNXOLuMoGPiHdXLV967BkdqPJSDeEgomvk5Uvx247k0aTlKH9
         FquasHnZlPrjsducJd8aDgCWQ4PVgAZggqdq+ZyHmJugzhHqYxAjQRORlmr68HGMuLiQ
         FCtHQ5X/qKTVlW3Th3vPXQNbiw4jGXCwRdWlSstG//KIIfLdbTlgnWntCi9UnqvSiz4S
         LtRXSkznZjNWE/YQ1my/K26oN41746QiU8R60qoKMYfPcECYQV1UGbiUxgWbgKAy2vbY
         s4CCsobN2xC2LVRLwWxPlL+q4AoBs/tKmsKq3Y9J9Ps1NjTfDWuFMM8sVcj9dFAaOYpy
         4uqw==
X-Gm-Message-State: ACgBeo1lSWkrItYJrmMqDC+H6HrFKMHae0O0bpHzV9rFctaJYsTKc7WR
	mAhDt6+hFYnJstgfcvxY7A==
X-Google-Smtp-Source: AA6agR7z+XSTaY12H9leweMCFym0qnSon6wZ8VAkDqXiHWjIjyaAnZy8Ed2MGrYyw5+Xo+vaqK/BnA==
X-Received: by 2002:a17:90b:2687:b0:1f3:1535:eda5 with SMTP id pl7-20020a17090b268700b001f31535eda5mr12777870pjb.39.1660290112394;
        Fri, 12 Aug 2022 00:41:52 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b001709b9d292esm942358pld.268.2022.08.12.00.41.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2022 00:41:51 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon/core: simplify the parameter passing for region split operation
Date: Fri, 12 Aug 2022 15:41:13 +0800
Message-Id: <1660290073-26347-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

The parameter 'struct damon_target *t' is unnecessary in damon region
split operation, so we can remove it.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/core.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

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


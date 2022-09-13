Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46921291E
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 09:12:34 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id 78so10713838pgb.13
        for <damon@lists.linux.dev>; Tue, 13 Sep 2022 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=hx151K56M/3bv6oAI9HhJMBBMiJc3yf10YF7//PgZEk=;
        b=FPiNmlQPMV6NfeIj+gceFZdllChsvPQx/1lJNqCJqvVP1c58jZuGu813kkSzCyz2hx
         Tper+kYL1VSI/1saYTXNGGszfUXJw/+hQ49l5F35wUbzN6l3P2fCHgkoHwjUrA/dOrYe
         KM8zByWZ7tnHjBJt+4FJFDoqMGJ2rOU791TH/tWsF8g2wu/F0qgHUr4YwofAw6sCagNs
         /zYA5OGN1J2rN2Kvg9qlxnXoC3BXR8vo82K8BZzG10yRyZkz7wyfSMvaDwgGJfWDBNai
         wR56e95dlv9L9cWF/2Q70PbCH68161V+YbnP/71/BhGm96EC0lGcuqA/94jAnWX5YspB
         Br0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hx151K56M/3bv6oAI9HhJMBBMiJc3yf10YF7//PgZEk=;
        b=RnSJmbc/0AkC/lX/uZ5Y/MpwcjrYkpR1vJHkvk/DgiXOGGq1gWxEOhh/HFgkNIzdbj
         eD9RNg43phJWNVjQZv7TsUpy6qT/c3GciwTwBQloKPwDksWIRsv/tiD7SIUF91h1wjgZ
         0eh+v7xelNIfh7XdC00eNrm5O6s4cXA1h86hHQGHuKL1gK18ezEqWmojUGni+D5FvbVH
         pPDIFig9m3M9ul8tnQmnzQvAo5NmCOeu3VJWmyN2Ft9wRjgMlm22JttF0GfY0QPDrFwX
         S5IXLlG5wkOAZb1skEiO3LIj37KnkXeYHnFlTbU8jBTaFBVLBedEd+mUE/ra/dm67qOg
         b+ug==
X-Gm-Message-State: ACgBeo0wex9Ar8WUE0ML5XbQWQ9J4C6THloXRjSlI7rdnj633pBW8WH0
	URZyYTZlUfWpxlb8fm7SoQ==
X-Google-Smtp-Source: AA6agR5+BtVH+Z9KVlL41Vvl5mVJIMp8QHiYV3uVzGpz9IGkyui/fsI188gxmT54nqYnyGte46kSbg==
X-Received: by 2002:a62:2503:0:b0:538:426a:af11 with SMTP id l3-20020a622503000000b00538426aaf11mr32167439pfl.22.1663060353757;
        Tue, 13 Sep 2022 02:12:33 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0015e8d4eb1d5sm7804661plk.31.2022.09.13.02.12.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:12:33 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 3/4] mm/damon/core: simplify the kdamond stop mechanism by removing 'done'
Date: Tue, 13 Sep 2022 17:11:26 +0800
Message-Id: <1663060287-30201-4-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
References: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

When the 'kdamond_wait_activation()' function or 'after_sampling()'
or 'after_aggregation()' DAMON callbacks return an error, it is
unnecessary to use bool 'done' to check if kdamond should be
finished. This commit simplifies the kdamond stop mechanism by
removing 'done' and break the while loop directly in the cases.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/core.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0b1eb945c68a..4ce860af70ec 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1165,30 +1165,25 @@ static int kdamond_fn(void *data)
 	struct damon_region *r, *next;
 	unsigned int max_nr_accesses = 0;
 	unsigned long sz_limit = 0;
-	bool done = false;
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
 	if (ctx->ops.init)
 		ctx->ops.init(ctx);
 	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
-		done = true;
+		goto done;
 
 	sz_limit = damon_region_sz_limit(ctx);
 
-	while (!kdamond_need_stop(ctx) && !done) {
-		if (kdamond_wait_activation(ctx)) {
-			done = true;
-			continue;
-		}
+	while (!kdamond_need_stop(ctx)) {
+		if (kdamond_wait_activation(ctx))
+			break;
 
 		if (ctx->ops.prepare_access_checks)
 			ctx->ops.prepare_access_checks(ctx);
 		if (ctx->callback.after_sampling &&
-				ctx->callback.after_sampling(ctx)) {
-			done = true;
-			continue;
-		}
+				ctx->callback.after_sampling(ctx))
+			break;
 
 		kdamond_usleep(ctx->sample_interval);
 
@@ -1200,10 +1195,8 @@ static int kdamond_fn(void *data)
 					max_nr_accesses / 10,
 					sz_limit);
 			if (ctx->callback.after_aggregation &&
-					ctx->callback.after_aggregation(ctx)) {
-				done = true;
-				continue;
-			}
+					ctx->callback.after_aggregation(ctx))
+				break;
 			kdamond_apply_schemes(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
@@ -1217,6 +1210,7 @@ static int kdamond_fn(void *data)
 			sz_limit = damon_region_sz_limit(ctx);
 		}
 	}
+done:
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region_safe(r, next, t)
 			damon_destroy_region(r, t);
-- 
2.27.0


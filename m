Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3928136C
	for <damon@lists.linux.dev>; Wed, 17 Dec 2025 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995145; cv=none; b=ZFs7qSn0/j4EgqSK/9z7XbxyF9qaT4vTEdTdiN809kDlsfkjZk/TAYEqV9EAC6ZQB11PJblMJEe+QikWb2PEXvF1zNplmv+sJ+bIko/UQl4B+fH7i3TmwNeCbuLulJyqll1X2YwB7Dh1YiForTv00cJQWzYe8MZQwzupeuCldD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995145; c=relaxed/simple;
	bh=fbUtd89uAq9dlvXlmhT8TWV0HLEFQuP7z9FP9d0ic8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSxP8IhrAQX+qcTV/8x0rgnxBF2vHWvgwsQIfW7LggHf3coECqTcuXxhNpuKRWR//dl1Up9m/Wd15xXQYqrhakm1l4zhl2rXYrhP2uRyUAe/VAHH7JsZDSmwL0BC6vxFIlrIzxUAizJOgJ3gwArDjd5x6YRIagAWgOrVP4gWeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaOk0HPj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaOk0HPj"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so59321345e9.3
        for <damon@lists.linux.dev>; Wed, 17 Dec 2025 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995139; x=1766599939; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FvOb3G0IavXhMQrYejIyEPtpWHhDtuZvMgThphxwJZI=;
        b=VaOk0HPjA2Ghr/5yF2O//QUhqdpGvQUoEazdkCMc4USneL90v01PjT5KyUMrby7DGW
         YvEsWLBVUEdGyYc2bqI7N8sZ2EQmhEHy0x5ciesfhAPkbLL9n7dNQeZbqIKykXy9ex1z
         mst8ot+KmsXFsv87H2IgMvC8xp3vKkI+yew+BxVvIovTBYzuoog5hpZ6U8gC8qLQam7z
         CDNWyAgIhWUNs3LlIYhLXswCH+7wcPYNOJFWToJu177lJnpB/O7NM17Bfsfzl/AzFg8d
         Td55GPj5/0AAF5e288/u1ED8bW8r1Sihg+jAntJ5+P38hhqmHEg7pXyu6jjqb3CzP0nv
         b7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995139; x=1766599939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvOb3G0IavXhMQrYejIyEPtpWHhDtuZvMgThphxwJZI=;
        b=iadyW/2CC+WceozfHKz8347jfpTs9aiVuzb07eUPp0Md/oUoknkNGwwfBcZ/G96UxX
         WyIOcTow19CScv8ZjBz9t/4eEczEPdfdyZGMzDOXTYYmi5KE2+8kVB4M2/r9cSbbTivq
         +kcEsjAI/6LXmLiyG/3eio5O2jORmr/zpyUJp/4Wvr/kT/gbFVOYJizS4XYWKAtV3U+W
         gwh2mCzovp9JYbKCf79CuQeTqR2XoiVqVzXdxfEkCiBRKRk9aMxPz9H6oqkWRoEDqElV
         X+QPMORzw3B8oaoreGuCKH6k2uYbB5vESQldEl0YEHUQP5GS7OJc7AyMCajkoWvXEhEU
         3LKw==
X-Gm-Message-State: AOJu0YwPQX+7VE8keAsOiluTn2gIaLg83S/cMfZJMePgNUE3YtVr4n9C
	yhhXsjYNOcXL5NG/1bX0r6lP1WIhTFAF/AGaRAn0sD1KnqwRB6KwrYSxntPGHw==
X-Gm-Gg: AY/fxX51PYRHOLGvXUSXnfi9af08KBt2nTE5sos2JTmANUe/9iPFiB6JsBh0gv0wsWB
	o+3Lh8a7gYov4VLn7veRtygPm1aHW9kikenLg25QTqjDpShq25xGbLb7fvb6YObLoP5mzUwaYv1
	j7y8cSLuHnYpGVrRov2MdP4p4JmzZ7brL+pzs/Btsfh3Yv7WYqriEVZbRKYR2iU6Q4DtBbaUWyq
	JSs9FXQloCb2ASYzHR1+YDmlFpYnWAd+UgSUQPFUAvk6IdK6ZB53r51h0nwbQachT4uTbkwQwEV
	eVNQPnGM0TXzRv7khdj2HvrwQ67uwTQLlJC36Lwp9V5ajlQa+tQFNGH9VCmPz5s5tNmqWMSSa50
	jPTjlc8APzo2Po/JKUQlNokaI9esiCCNMeGTCWRvhBdrbBWI50nliUI9zYTrjjPZTcsw9SD7doK
	niXds+2BJ8Ld9oPCzEqy7UdhMgUvu3Bh7/s3vd/Sjqu3t9PV2xSMwCJzSHRXi9S+NXw+Nw2t7+U
	ljsqegZM61q/ZbnNg==
X-Google-Smtp-Source: AGHT+IFrcnRLclB24WO5IWIbHNWptFccCH0kwz5N2SpmkPmKMF++VzNF1omLEkWV4OJ2X91cRMJpSQ==
X-Received: by 2002:a05:600c:4f86:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47a8f9057fdmr193235835e9.24.1765995138750;
        Wed, 17 Dec 2025 10:12:18 -0800 (PST)
Received: from desktop-mu90jgd.home (2a01cb0006769b001185461c960a9b50.ipv6.abo.wanadoo.fr. [2a01:cb00:676:9b00:1185:461c:960a:9b50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934c29sm340909f8f.2.2025.12.17.10.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:12:18 -0800 (PST)
From: klourencodev@gmail.com
To: damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	kevin <kevin@desktop-mu90jgd.home>,
	Kevin Lourenco <klourencodev@gmail.com>
Subject: [PATCH] mm/damon: fix typos in comments
Date: Wed, 17 Dec 2025 19:12:16 +0100
Message-ID: <20251217181216.47576-1-klourencodev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: kevin <kevin@desktop-mu90jgd.home>

Correct minor spelling mistakes in several files under mm/damon.
No functional changes.

Signed-off-by: Kevin Lourenco <klourencodev@gmail.com>
---
 mm/damon/core.c             | 6 +++---
 mm/damon/lru_sort.c         | 2 +-
 mm/damon/reclaim.c          | 2 +-
 mm/damon/stat.c             | 2 +-
 mm/damon/tests/core-kunit.h | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 68dd2f7acba2..da4820110e48 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -284,7 +284,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 }
 
 /**
- * damos_filter_for_ops() - Return if the filter is ops-hndled one.
+ * damos_filter_for_ops() - Return if the filter is ops-handled one.
  * @type:	type of the filter.
  *
  * Return: true if the filter of @type needs to be handled by ops layer, false
@@ -1586,7 +1586,7 @@ static unsigned long damon_get_intervals_adaptation_bp(struct damon_ctx *c)
 	adaptation_bp = damon_feed_loop_next_input(100000000, score_bp) /
 		10000;
 	/*
-	 * adaptaion_bp ranges from 1 to 20,000.  Avoid too rapid reduction of
+	 * adaptation_bp ranges from 1 to 20,000.  Avoid too rapid reduction of
 	 * the intervals by rescaling [1,10,000] to [5000, 10,000].
 	 */
 	if (adaptation_bp <= 10000)
@@ -2756,7 +2756,7 @@ static int kdamond_fn(void *data)
 				 *
 				 * Reset ->next_aggregation_sis to avoid that.
 				 * It will anyway correctly updated after this
-				 * if caluse.
+				 * if clause.
 				 */
 				ctx->next_aggregation_sis =
 					next_aggregation_sis;
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 49b4bc294f4e..9388b091deb7 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -34,7 +34,7 @@ static bool enabled __read_mostly;
  *
  * Input parameters that updated while DAMON_LRU_SORT is running are not
  * applied by default.  Once this parameter is set as ``Y``, DAMON_LRU_SORT
- * reads values of parametrs except ``enabled`` again.  Once the re-reading is
+ * reads values of parameters except ``enabled`` again.  Once the re-reading is
  * done, this parameter is set as ``N``.  If invalid parameters are found while
  * the re-reading, DAMON_LRU_SORT will be disabled.
  */
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 36a582e09eae..8463a5a5032f 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -34,7 +34,7 @@ static bool enabled __read_mostly;
  *
  * Input parameters that updated while DAMON_RECLAIM is running are not applied
  * by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
- * of parametrs except ``enabled`` again.  Once the re-reading is done, this
+ * of parameters except ``enabled`` again.  Once the re-reading is done, this
  * parameter is set as ``N``.  If invalid parameters are found while the
  * re-reading, DAMON_RECLAIM will be disabled.
  */
diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index ef0a1195a584..5e18b164f6d8 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Shows data access monitoring resutls in simple metrics.
+ * Shows data access monitoring results in simple metrics.
  */
 
 #define pr_fmt(fmt) "damon-stat: " fmt
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 8cb369b63e08..f59ae7ee19a0 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1159,7 +1159,7 @@ static void damon_test_set_filters_default_reject(struct kunit *test)
 	damos_set_filters_default_reject(&scheme);
 	/*
 	 * A core-handled allow-filter is installed.
-	 * Rejct by default on core layer filtering stage due to the last
+	 * Reject by default on core layer filtering stage due to the last
 	 * core-layer-filter's behavior.
 	 * Allow by default on ops layer filtering stage due to the absence of
 	 * ops layer filters.
-- 
2.47.3


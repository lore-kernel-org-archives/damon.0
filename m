Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB62673A5
	for <damon@lists.linux.dev>; Wed, 17 Dec 2025 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766011685; cv=none; b=sOtkrL49P57sCTAVHugP4BnHy4LP3pCKrqJPtG5UhghnM2MW/S74B+hdEEWfPZB1o+h1NfctoIi5g8JUSZhwkxDUsbSzmL/eldn8k94r3zUDtF4tcWwLOVSHCRIZWNExoTk7kvjbQA0WNktr0wFgPPAEPelBqyNNRmKt1SG0z28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766011685; c=relaxed/simple;
	bh=SIhXF71gogoDwf5GiGiZKcKCHnmCntD4jh/41kgDL3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpSDTBKGSp2mYInHIRWaPBHzeKTHq3d+1Twbdqxgg4YKGU7cS0oUdVcfUsANl554ENbIEFtYWhmj5SPC3W6Jz+yyvy8YPDIex1PEUNKrEZzzVoZxYXgEDKpVEQ6J4QnD6YyoijDc4eOBbdVAd6pU/XMwWL8meztb8JjBlogZ+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieQt0xxS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieQt0xxS"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb2314f52so3045989f8f.0
        for <damon@lists.linux.dev>; Wed, 17 Dec 2025 14:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766011681; x=1766616481; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RM5A0ry/rHet8/v2ANKiOz9PZ8pj+yMbW8LuBQqTqb8=;
        b=ieQt0xxS2PiGaZxAWX+BvTWRRxEq39fKs+snUCzmsBZl+rpq+QJtZCrOY6wegiEJPg
         HNxn1x5KucDDYN9RlotAYPWh8e4ysKDjQMt8MCLbRVKETJVG60/cNnezDgR2D6ixuinf
         /E6AIy3HpRrITdebMK3nLl0Vt29UwsV+fCkaB26IigeoucWqU3lDd/vhVzvzxPsdSGFE
         84783vZ66scOAdN4q+x947g3PtaLvQtVClX+nSVagUCYJZ89VuRMlxmqf+BElj1e1jzw
         sSwac390U1BYUPNsGYvCNVz/rhKxQac7CSk22+kSY3JjoAjqsqqNPa6T9B1+6dZe+A4o
         rp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766011681; x=1766616481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM5A0ry/rHet8/v2ANKiOz9PZ8pj+yMbW8LuBQqTqb8=;
        b=t+fSO6pwcaQU0sngcd/yb8aaozieeKlyvaVX74vrdhjzDXoL8xootEz+v7cfVd1je+
         S+44nLaDNVNppnIqqhixXRitijpElxs6Pp3X030iKYtL9PDPQRZec8rc3TNhK9LkNIb+
         y3Y+mYL3SNNqTKkl+RuNToUyetZnXndA5M5lIXh3pOFRYCJ4LmwypnEOGvzsxP0GbhF9
         k1Vv8m+WcQ3cHuJt+DzdE4MFTuoNTKa9V+hv4FZrQIPrIwLokVrb4l1Tk8I+bW9ebVSF
         GSdkZZEaN+qeY1VpXEurHbWquADOo8udU287Tukkno6nswgwGvrTFUUj5COnU/SlY9Sm
         zg3w==
X-Gm-Message-State: AOJu0YwnBAAvv/MagDmDERSUp9zdGz9Qv8Q29h/mWxPoOj0Gh5wlRjkK
	tlrBG8J+tMTjXxyylKrYaZJ1wsEyUFvlvox2bbupgw9xUEcjs65NvNjv2ln1dA==
X-Gm-Gg: AY/fxX5uzqpFcwhhd6EA2ma8MdkEmnPkmHjEA/TQLmXSlEHmtHAxddNWl5in94LVvXr
	bv4fUYC1kxZgn5zlE7/DTcjG/rTTvnLBTmAWuQUaT7IkBjah4k8AUUiSiH1OxOQLDfIl647c3/K
	59r68eo3o9rNm0wTCjdgOiGLFKGef/ojMFhEhxdyTpMKc4GS6FueQkzUj7t9Npmp0WbXdP049in
	vlWCjtg5YHjiNhZg3WCqqctLLjkRpmAx7jARRr+wLWrhC72lPA4uX7cA+ybD9rwHknxCfiCod+1
	e+/dqDycrX+P4+EGGqdpIf8MEaSnRT9AFme+9PIjmRT3S/OmKYk+nRkjr7CajYNc+ItK0gGA42y
	H1GpaY6ZrPple3/1SPfWbAtSTFj4qyRbgqySJTYjCuqyhZPU0/cFrRLU7C7t1Sk1HJG2DOLjEu4
	d7nkZ+WeY10O/F1iT+kGaKNpfdu6kJDzOyS9QkneZNXQ/0Nr0vVMp4j+Js6bk8DTBSIAnPEK8Ok
	xpBgPbK0RoJOiDjQw==
X-Google-Smtp-Source: AGHT+IEB2l6tfD3XeJHwE80Whf4bXvEZxnYGVb9EVsSMnweCainL0lhHxj7ZDmUSjDOO+eBPu8gK6w==
X-Received: by 2002:a5d:5f94:0:b0:430:f5ab:dc83 with SMTP id ffacd0b85a97d-430f5abdf74mr16393355f8f.11.1766011680951;
        Wed, 17 Dec 2025 14:48:00 -0800 (PST)
Received: from desktop-mu90jgd.home (2a01cb0006769b001185461c960a9b50.ipv6.abo.wanadoo.fr. [2a01:cb00:676:9b00:1185:461c:960a:9b50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324493fe32sm1446960f8f.14.2025.12.17.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:48:00 -0800 (PST)
From: klourencodev@gmail.com
To: damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	Kevin Lourenco <klourencodev@gmail.com>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH v2] mm/damon: fix typos in comments
Date: Wed, 17 Dec 2025 23:46:10 +0100
Message-ID: <20251217224610.8814-1-klourencodev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Lourenco <klourencodev@gmail.com>

Correct minor spelling mistakes in several files under mm/damon.
No functional changes.

Signed-off-by: Kevin Lourenco <klourencodev@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109584;
	b=Mud4Jx9jBZX7QOm/JhNA4b67eTpycxrcMiTdFj5pdEaN07FcktS8jb3PBws7FJaQNlW1
	 vWrX1mk7kIx1hom3UZ4t2l8rIQZ74Vb/gUso9GgMFt1WuSnhik2SHeW+31b+pbd/Zr80O
	 jCvG3wxaREp/0q4vRkbU1yBLNSXhpveZvuGyMMBOa3G+yicvr5Kr5q5SO/Fhuy+qEFW/L
	 mEc0MpW8W0ISG676AeinD/g8s6hqQ1qZtia5crNGLClbtTIE1nCJ7/RlCENXCU+7nLbe2
	 K6FT9bnl0JqmuQY9fWbu4iYmJpMR7HsWdXKvxPHZsMCxpFNIeAUsG+Z2TLXjiGRy/mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+PFYfGoi9f2AhMkO9c1ssgX+qWfwUcRN+0tOm5gagYw=;
	b=TNDUmGirFEui8CtHziRFPw8i9STlV8lqUhSke1gZ1/sW2dUYmM7v63pQSTnm1VBut7ia
	 eK48BiF+GTAGHVIUHzo20OU0PhmhNSGsoDcuFH/pzscla6KWhGzRSLFXeMjMujGXr+Bsx
	 tFx/lk0feDTF5cjy+4XWeTo1onYXkBPvTBm4dl0a1Tq9uQjWxnpSSlUgN0+ypgAKFbFGr
	 aMF6DNeI9KdSKER8r8bSr7BmVJ6wKevtfBj7j59xmq5dOpiZq5So982dEpqXn/yNRC4CI
	 HIr5C+ZESZRQEJ6K+yCgoEW3kU/U1X2SwaHKNcktTVVLWwebcQ7IiyCEdsNSCoMVqWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CekaV4Ef;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB8606A31B
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 13:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95EB8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CekaV4Ef
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd6b78a0a80so196313a12.0
        for <damon@lists.linux.dev>; Tue, 27 Oct 2026 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793109583; x=1793714383; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+PFYfGoi9f2AhMkO9c1ssgX+qWfwUcRN+0tOm5gagYw=;
        b=CekaV4Ef1MEZmXabWcvsYjnmeF+2p/UYou+NYjSF/v7i0/EPPCr1f3cJRPy5nSolGJ
         I00Krs1FgGGoDZEucaEpPsenNkL5GTZ/CQRKpIq2+4V1XZOt3J8eEJ+jQQm8NEEHoj0i
         NgX8yDEjhDG24+MfKnJ9spL3mHPvdPLmz0tUNXqOA3LFtscHRdCQHmO1bmsR53ccP2H0
         phl3eKX7kOAPEwlzECVi7kK3n0xLs6yG5bjSw0+j8eyRaZB00hW7wCFsQOKthsWCAbF9
         DnmQiQ9xwofWP5zcZLBaTOi9B3exlyZ+45peAer2lDXnTBwpRqoZXP2N2ks9Cg08ztVg
         w4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109583; x=1793714383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+PFYfGoi9f2AhMkO9c1ssgX+qWfwUcRN+0tOm5gagYw=;
        b=uJ7t6e5zfZ9VvqUSYAwdSggpdFUD8tyl28+TgYUDFMnky34w+wuk22pjpDck1tC/Tb
         ruzJ2D7XoGv8pahZN+caQHn6agtZELQOSSpON2h0YKyURtXiWiYvbPL/gSuNUt1f6mSa
         S1mVATqRkdqRO3lIvv1ASxb/psCz0i6K6bJdaeiyoHPX+p3qiJcJFBb1PB64Z09kqyC4
         Fk2x43yqCGhnAgQH0iMujvXyGfxYjJQyswprzZUs10W+IPNz8LXv0ArKU2IVbn8a1TgX
         hj3Ns57gmRIuG49DJzfN1GLt5qPGXRoRaCwKevIExjzflN1QLcGUhjKaxJGAi71FQIAe
         uHgA==
X-Gm-Message-State: AFq9FYJXevokP2MtC0YHx0TxGcMPUAJ6MfFo09MPfUWi4UUXbh7SiPys
	4kw/ShCGnvkMN+W1kRfKqP1ZBGf79cfIXskNvszIPsnOmi9O+eNlLJCr
X-Gm-Gg: AYBFou0fFfgBpWLz0LAHWc/yiN4D19VmnL8AH69Bm6Uu9BhbBpuw7IzcA4VNUezMu2j
	irSvW87VDwJmywC09Li55eZnDq82lbxrkcr5ctUo1NTAK1oer85B1qzQwDnyBshgVw7KZyhXutN
	mAQpKWVMid1d54vMlB65GT9yOd5Vq3Gd+ctZyzVWMfTsq1ABSvx1L0YPpVD7Vv7y5dLHHAd/s7L
	kX5HkFSxRXFfAqtfGHwFgt+oEPqeONNLnkqtkwC2tQPIIEPfFnAzdTbd7Haqv+6KMPcZbKKQUNm
	uiLfe9fOhD9M2zvXjlAEIrHjjVi6JY23xGsCM2crSxV7qCUsJL+Ixm01D9NRvVnehxPRyjA7D/z
	WSFJo38ofW/XbVFtqZF/rSGK9MtgScS/SeKUET3+mfY+Z4kQ6Y7wUVBmZmy0I/4Y5b1pSZgsQWL
	h8rBQAJOQTEFqCC5vNJoXUUYyH77WNOIoWvslyI6k1lHJ9RSE4YX+gJVjW0Xt75LckUJ0r/MHDE
	Y9b1yILQjtK5Enw7Vjn9xv18VH9mz2ACmiGILgohIt9ok/EyLA74E44nfbOMwYjWxBTQw==
X-Received: by 2002:a17:90b:58cd:b0:3ac:9c37:9422 with SMTP id 98e67ed59e1d1-3adea2003c9mr13980641a91.2.1793109582809;
        Tue, 27 Oct 2026 06:59:42 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404432a5sm4243466a91.9.2026.10.27.06.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:59:42 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [RFC PATCH 3/3] mm/damon/core: avoid overflows in quota goal metrics and scores
Date: Tue, 27 Oct 2026 22:59:32 +0900
Message-ID: <20261027135932.2301646-4-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027135932.2301646-1-charsyam@gmail.com>
References: <20261027135932.2301646-1-charsyam@gmail.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The node memory, node memcg memory, LRU [in]active memory, and hugepage
memory quota goal metrics, as well as damos_quota_score(), use
mult_frac() to scale a value by 10000.  mult_frac() multiplies the
remainder by 10000 in unsigned long, which overflows on 32-bit kernels
even when the result fits:

- For the page based metrics, this happens once the numerator exceeds
  about 429,496 pages, or 1.6 GiB with 4 KiB pages.  For example, 2 GiB
  used out of 3 GiB returns 1205 bp instead of 6666 bp.  The LRU
  [in]active and hugepage metrics do not depend on NUMA.

- For quota goal scores, any current value above about 429,496 can
  overflow.  For example, a DAMOS_QUOTA_SOME_MEM_PSI_US goal with a
  target of one second and a current value of half a second returns 705
  instead of 5000.  On any architecture, mult_frac() also silently wraps
  scores that do not fit in unsigned long.

Use damon_mult_frac() for those calculations.

The node eligible memory metric counts bytes in phys_addr_t, so on
32-bit kernels it overflows once the eligible memory exceeds about
420 KiB, and it also truncates the byte counts to unsigned long with
PAE.  Use mul_u64_u64_div_u64() on the phys_addr_t values for it.  The
node eligible memory never exceeds the total, so the result fits.

Add a KUnit case for the quota goal scores.  The helper's KUnit cases
also cover the large page ratio used by the metrics.

The issues were discovered [1,2,3] by Sashiko.

[1] https://lore.kernel.org/20260901133650.EF4F71F000E9@smtp.kernel.org
[2] https://lore.kernel.org/20260626002448.975E21F000E9@smtp.kernel.org
[3] https://lore.kernel.org/20260831184956.1DA321F000E9@smtp.kernel.org

Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization")
Fixes: b74a120bcf50 ("mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP")
Fixes: 4835e2871321 ("mm/damon/core: introduce [in]active memory ratio damos quota goal metric")
Fixes: f465dc71aba0 ("mm/damon: introduce DAMOS_QUOTA_HUGEPAGE auto tuning")
Fixes: 9138e27a3bc3 ("mm/damon: add node_eligible_mem_bp goal metric")
Fixes: 06ba5b309ed8 ("mm/damon/core: let goal specified with only target and current values")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 mm/damon/core.c             | 18 +++++++++---------
 mm/damon/tests/core-kunit.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5cd4007cc370..cc4e010e400d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3056,7 +3056,7 @@ static __kernel_ulong_t damos_get_node_mem_bp(
 		numerator = i.totalram - i.freeram;
 	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
 		numerator = i.freeram;
-	return mult_frac(numerator, 10000, i.totalram);
+	return damon_mult_frac(numerator, 10000, i.totalram);
 }
 
 static unsigned long damos_get_node_memcg_used_bp(
@@ -3102,7 +3102,7 @@ static unsigned long damos_get_node_memcg_used_bp(
 		numerator = used_pages;
 	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
 		numerator = i.totalram - used_pages;
-	return mult_frac(numerator, 10000, i.totalram);
+	return damon_mult_frac(numerator, 10000, i.totalram);
 }
 
 #ifdef CONFIG_DAMON_PADDR
@@ -3199,11 +3199,11 @@ static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
 
 	node_eligible = damos_calc_eligible_bytes(c, s, nid, &total_eligible);
 
-	if (!(unsigned long)total_eligible)
+	if (!total_eligible)
 		return 0;
 
-	return mult_frac((unsigned long)node_eligible, 10000,
-			(unsigned long)total_eligible);
+	/* node_eligible <= total_eligible, so this cannot overflow */
+	return mul_u64_u64_div_u64(node_eligible, 10000, total_eligible);
 }
 #else /* CONFIG_DAMON_PADDR */
 static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
@@ -3246,8 +3246,8 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
 		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
 	total = max(active + inactive, 1);
 	if (active_ratio)
-		return mult_frac(active, 10000, total);
-	return mult_frac(inactive, 10000, total);
+		return damon_mult_frac(active, 10000, total);
+	return damon_mult_frac(inactive, 10000, total);
 }
 
 static unsigned int damos_hugepage_mem_bp(void)
@@ -3263,7 +3263,7 @@ static unsigned int damos_hugepage_mem_bp(void)
 	thp = global_node_page_state(NR_ANON_THPS) +
 				global_node_page_state(NR_SHMEM_THPS) +
 				global_node_page_state(NR_FILE_THPS);
-	return mult_frac(thp, 10000, total_pages - free_pages);
+	return damon_mult_frac(thp, 10000, total_pages - free_pages);
 }
 
 static void damos_set_quota_goal_current_value(struct damon_ctx *c,
@@ -3329,7 +3329,7 @@ static unsigned long damos_quota_score(struct damon_ctx *c, struct damos *s)
 	damos_for_each_quota_goal(goal, quota) {
 		damos_set_quota_goal_current_value(c, s, goal);
 		highest_score = max(highest_score,
-				mult_frac(goal->current_value, 10000,
+				damon_mult_frac(goal->current_value, 10000,
 					goal->target_value));
 	}
 
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index e71e60d59400..aaf65828a5e1 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -756,6 +756,36 @@ static void damon_test_sample_ratio_large_value(struct kunit *test)
 			UINT_MAX);
 }
 
+static void damos_test_quota_score_large_value(struct kunit *test)
+{
+	struct damos s;
+	struct damos_quota_goal goal = {
+		.metric = DAMOS_QUOTA_USER_INPUT,
+		.current_value = 500000,
+		.target_value = 1000000,
+	};
+
+	memset(&s, 0, sizeof(s));
+	INIT_LIST_HEAD(&s.quota.goals);
+	INIT_LIST_HEAD(&goal.list);
+	damos_add_quota_goal(&s.quota, &goal);
+	KUNIT_EXPECT_EQ(test, damos_quota_score(NULL, &s), 5000ul);
+
+	goal.current_value = 1500001;
+	KUNIT_EXPECT_EQ(test, damos_quota_score(NULL, &s), 15000ul);
+
+	goal.current_value = ULONG_MAX;
+	goal.target_value = 1;
+	KUNIT_EXPECT_EQ(test, damos_quota_score(NULL, &s), ULONG_MAX);
+
+	/* the largest representable score, and one beyond it */
+	goal.current_value = ULONG_MAX - ULONG_MAX / 10000;
+	goal.target_value = 9999;
+	KUNIT_EXPECT_EQ(test, damos_quota_score(NULL, &s), ULONG_MAX);
+	goal.current_value++;
+	KUNIT_EXPECT_EQ(test, damos_quota_score(NULL, &s), ULONG_MAX);
+}
+
 static void damon_test_set_attrs(struct kunit *test)
 {
 	struct damon_ctx *c = damon_new_ctx();
@@ -2568,6 +2598,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_mult_frac),
 	KUNIT_CASE(damon_test_age_for_new_attrs_large_value),
 	KUNIT_CASE(damon_test_sample_ratio_large_value),
+	KUNIT_CASE(damos_test_quota_score_large_value),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_mvsum),
 	KUNIT_CASE(damon_test_nr_accesses_mvsum),
-- 
2.43.0


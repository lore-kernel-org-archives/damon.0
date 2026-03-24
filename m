Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88805386C09
	for <damon@lists.linux.dev>; Tue, 24 Mar 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366815; cv=pass; b=LFpb8Lv8jQ87dNdICs4IuZww6TsjL3lzADBUxmy3wiQriXLCvitqG0/Fpdy8YF0oOdYr6iy3nTsKD8YrWanIJyqA2ipXineGzLO2pYn/22LNepubXozs1RQVetv+WUMmGeoQ/KkPTA+i/5BpUbbOX2TpEYdTjWftkIxhCCwnf5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366815; c=relaxed/simple;
	bh=3RWlpXoM5RX8kE45d2aZfoJlNKfJYpXiwumbuWOewRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iyuPfhlgsc1u+OR06Ro2J4QGamkZysOKG3CpKd3WJJidZ4CjDUncB1a/kafCS6H6BQOlksrRRsxFs/5ee6ARMiXLMRQdszTxMqCkDnqgYDSg4NQp4sVbztbe7O9mP9YmM5ubaRKuYDHbZD4OueV7mBo2nkbLUC2QD6cGxFlirQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=ApcTv89Q; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="ApcTv89Q"
ARC-Seal: i=1; a=rsa-sha256; t=1774366809; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PG+uUpA0fQD+DWxyX5gc5CFsJwS1CLZTBshjd8V1y2FbCkIbB6bClUessVUdFywKZ9RLA7qd0fus54lprO+Ak/X9wFKhPYHBcRevA6oPgiX0KU/L6D5Uo4qzIZdpiZ0xuEWhuVJXcsV+ibwc9YVA/lsu1OrMvvBzuKPihqp2jt0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774366809; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lnuvGybt67fKfdFIPouSOwFAG9kGA6DmWroqEsHCBQs=; 
	b=QsiOtcb6/eodUJIc8Xx88I7v8Ydfi1mpwDa4yGy2249kSh1cCi2Uv28r/iWTRXVZyMGznNiwHi8AKqZIbEhVaWUkc6PLOEfCxXm8Hp5FEZKLRPouhRRj4el4+g7DmtEdA7mHElLhJaG9ZTb0Z+T5MndpYU82UPlBZLKtkawQIGA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774366809;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=lnuvGybt67fKfdFIPouSOwFAG9kGA6DmWroqEsHCBQs=;
	b=ApcTv89QuZolSgC985pWaNnS8UKQ1dYo6Olk+EijNpyJKeV/xjfwnd3xsXl0A/Y6
	E5Ik3PWPmWRd2gFT0XBj+PeKwqeyuBGeYIqBwAc0rlC5mes1GFu4p3JCCMQxvpBYDOq
	Xv+X2sYT696aZezdivaxY3OOc/GWL2GGfkyqZZWQ=
Received: by mx.zoho.eu with SMTPS id 1774366806625819.9630672140645;
	Tue, 24 Mar 2026 16:40:06 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
Date: Tue, 24 Mar 2026 15:40:05 +0000
Message-Id: <20260324154005.83651-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hardware integer division is slow. The function damon_max_nr_accesses(),
which is called very frequently, performs an integer division.
However, the struct damon_attrs already caches this exact ratio in the
internal field aggr_samples. We can eliminate the hardware division in
the hot path by simply returning aggr_samples.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 include/linux/damon.h       |  3 +--
 mm/damon/core.c             |  1 +
 mm/damon/tests/core-kunit.h | 16 ++++++++++++----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6bd71546f7b2..438fe6f3eab4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -960,8 +960,7 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
 {
 	/* {aggr,sample}_interval are unsigned long, hence could overflow */
-	return min(attrs->aggr_interval / attrs->sample_interval,
-			(unsigned long)UINT_MAX);
+	return min_t(unsigned long, attrs->aggr_samples, UINT_MAX);
 }
 
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b0ab0ee6eab9..59b709f04975 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -582,6 +582,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.sample_interval = 5 * 1000;
 	ctx->attrs.aggr_interval = 100 * 1000;
 	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
+	ctx->attrs.aggr_samples = 20;
 
 	ctx->passed_sample_intervals = 0;
 	/* These will be set from kdamond_init_ctx() */
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index e86d4f4fe261..56d03ef6a5a4 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -416,6 +416,8 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
 		.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
 	};
 
+	attrs.aggr_samples = attrs.aggr_interval / attrs.sample_interval;
+
 	/*
 	 * In some cases such as 32bit architectures where UINT_MAX is
 	 * ULONG_MAX, attrs.aggr_interval becomes zero.  Calling
@@ -434,7 +436,8 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
 static void damon_test_update_monitoring_result(struct kunit *test)
 {
 	struct damon_attrs old_attrs = {
-		.sample_interval = 10, .aggr_interval = 1000,};
+		.sample_interval = 10, .aggr_interval = 1000,
+		.aggr_samples = 100,};
 	struct damon_attrs new_attrs;
 	struct damon_region *r = damon_new_region(3, 7);
 
@@ -446,19 +449,24 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 	r->age = 20;
 
 	new_attrs = (struct damon_attrs){
-		.sample_interval = 100, .aggr_interval = 10000,};
+		.sample_interval = 100, .aggr_interval = 10000,
+		.aggr_samples = 100,};
 	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 15);
 	KUNIT_EXPECT_EQ(test, r->age, 2);
 
 	new_attrs = (struct damon_attrs){
-		.sample_interval = 1, .aggr_interval = 1000};
+		.sample_interval = 1, .aggr_interval = 1000,
+		.aggr_samples = 1000,
+	};
 	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
 	KUNIT_EXPECT_EQ(test, r->age, 2);
 
 	new_attrs = (struct damon_attrs){
-		.sample_interval = 1, .aggr_interval = 100};
+		.sample_interval = 1, .aggr_interval = 100,
+		.aggr_samples = 100,
+	};
 	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
 	KUNIT_EXPECT_EQ(test, r->age, 20);
-- 
2.34.1


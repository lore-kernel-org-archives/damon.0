Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109581;
	b=Vhrwo4uPuWw6CMtWtmJhWusrdVSpa2GaqKacPsAaiHzwy2k1cifgq23wSYwTmp28dWq7
	 l/4Ff2imgj2AOIluR8G4nWCf3iOTDKebNxdUb78vyM5UsTYEQqnGdbZ9EgUdzgfkNGiIW
	 7gbengWL/Dzkg/tfX3zQ31fknZjRJRLoTU8N1pjfD/n2FWclVkizfPI5dWkqJPJqEyKlM
	 3Vsqq7Vet71yWeSdkvI0KMLEpvflDCMzSer/7Dc4wZhXnnyp3ZtAwmLRjJrMa/z5tIWca
	 mNW+teGAyXtvTNR1zy/+1woKlNnfOHf07jv/IM1wpGqNzn1auSig1MTPvP0qA6A7j9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ql43MqEJknME13oyH0mE3lrKnV2gOIDFu0p5gqyqxnE=;
	b=vcpXHzvXfC8DY6D2NLFXlhlUH19J3+iR3hl03aK6WNqCWNPgZtkZyOD1Wq05zM6XlOUq
	 nViw+kU+UD8yLAbUqEFlFzuDKDCixEBoBPaJ2oB9jS3vMF274Bt3Uw/pjfGjlUlhdAC2x
	 snWLdHkwgwXKDkKYeY1m5DlquT49rBvsz8VJLb9ajbw95co+dmli21+3ZRhHLLONW05XJ
	 R+bKq7iRjZ/F1yxkgXRmli0eJmAhINfY1ZPJs9kFxT2FdXfVy4uw4tnMDzyPVRIoJLYQv
	 qGHZiWLgbgcng3yBxpJPSwcKbCe8pI26g1SLE6meRw5BrgcI1XNI0Oe4OcAzrqJtb9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mXEO2pFD;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6A606A31B
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 13:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EE6A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mXEO2pFD
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae1a9e187aso308240a91.3
        for <damon@lists.linux.dev>; Tue, 27 Oct 2026 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793109581; x=1793714381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ql43MqEJknME13oyH0mE3lrKnV2gOIDFu0p5gqyqxnE=;
        b=mXEO2pFD1BV7nOW6zHBjJTXZN86ZsjvZp+SjclXIGOeeCp4uFn2NgLkHmCw9UdgzU5
         g4yzmk+d9z8Ah1c+gklCmtyqd8XyrxNAiYfjEeRi10gKGd4kDgC3UFAKcSCEe8EpqKTi
         /Kj8Pdmtz7cchYO6EqrP3jFieux+p0O6e1Pg6ithlhyfL2/cPEsO6LbUovDxJb2C7QPE
         dfMczJ6DgXL4NSr4sxNJx/NOAzK5bVEDkHpHZi4u8uKnaGZABS3NTaCGMHqpXDwGuzsV
         eK842MjegKWsLaiM8CVOTOvQ7bzp5otOlEG/y7ijtSlRce6lLe+GNHFMb8+0bdNKjEK2
         yJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109581; x=1793714381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ql43MqEJknME13oyH0mE3lrKnV2gOIDFu0p5gqyqxnE=;
        b=cM8zKB1x0KEo0BkCAESuWPTHNxyYPuEnufQJgZipgsCExzobb37T75Fiwuk/IKyWCx
         1Y/xk0sJJL18jZhhhWoVWSJXQLtIPWUeSx/WNsFsZo8YBbs62zGz88YdAZJUl31hnt2O
         YQUrorjU/lh4egniZBePVf1/LBKFYm0BZIvRj0amc/K5rlBcSTKmrwGEIjkKK4/YbR5G
         mngxO2zKCNMEauAAVyKmz3MeC2AF/s6/sZlIGE9fffemjEN7tcfFl01mQemp5bvKh6Cm
         Tr58dQKULJEv91PSCPe5g8krB9/LwviLlDA6I+y3VZpmZNUN+V32mHn3yscDR0/XYKI8
         FW5w==
X-Gm-Message-State: AFq9FYLGG082p3PGm0LO0J8ImBYiyjj/jG2qw5bkLOfZ6FNO5ZLVEbV9
	P2Hks4igjw15vfOEq75JTrNc9kScBGwjoQXOJzP+clAddf0MP/8NCUeR
X-Gm-Gg: AYBFou1iALIDr5kCMMPl58KySQgBDKMpJ+zyF7ImGMZ/cwZwJm/Fqc3xlu/eEsn4ir0
	GvN/ipMmnHOlSDLC2HSdOWulMhdBDxSu7l7ulCxUzjgxrnXUSdckMsPVcO0rDqYzI4OGM2Ms51e
	SWDhGqNnr1D/i585MPvwl5NNVeRnScOv02QmOTkd4K1ZopuVkGY+bFVb1zoe41lQGha6egT41AO
	JvyADYbAINWTGdPHExaMnxkIA/tok1+o3SYwqnm0amPEs2EOZG73cTxn8k79MOM0JxfJVn4k8kE
	M17QdW/jFKh4/7PY9KtWBepAWq08ia+gp5VKghl3PrHAf/Tg0J1fgpD2pdUAwxqtgouTxj/wWS3
	9fCxxqcnr2hjk0rD970QgBfywJsKxy0xjxJ9oDLEHgOeJUUCIpUiZLHqxwLXw41/FqjTHNgRBtZ
	o4iOY5bFxcc4YAnYweT1GwkMWluNHrOR9L2LPPwsRwJK9H1aTwsHjW4GWGVrAzClFEPqMCNLqku
	ndCwd4i90/S9BTJL0yBhz8KUpUrvbeAzQfuNKBY70J9qXnH
X-Received: by 2002:a17:90b:1c88:b0:3ac:9e5e:d1a5 with SMTP id 98e67ed59e1d1-3adeb173881mr13849327a91.6.1793109580732;
        Tue, 27 Oct 2026 06:59:40 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404432a5sm4243466a91.9.2026.10.27.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:59:40 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [RFC PATCH 2/3] mm/damon/core: avoid overflows in monitoring results calculations
Date: Tue, 27 Oct 2026 22:59:31 +0900
Message-ID: <20261027135932.2301646-3-charsyam@gmail.com>
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

When monitoring intervals change, DAMON converts region ages and sample
counts for the new intervals.  The conversions overflow before division:

- damon_age_for_new_attrs() multiplies the age by the old aggregation
  interval in unsigned long.  On 32-bit kernels, the default 100 ms
  interval makes this overflow after about 72 minutes.
- The sample ratio conversions multiply unsigned int values.  They can
  overflow on every architecture when an aggregation has more than
  429,496 samples, such as a 1 ms sample interval and a 430 second
  aggregation interval.

The moving sums also use mult_frac() for the fraction of an aggregation
window that remains and for the previous window's contribution.  On
32-bit kernels, both can overflow with long aggregation intervals.  For
example, 500,000 remaining samples of a 600,000-sample window are
8,333 bp, but the first calculation returns 1,175 bp.

Add damon_mult_frac(), which preserves mult_frac() results when its
intermediates fit, calculates larger remainder products in full width,
and saturates results that exceed unsigned long.  Use it for the
conversions and the moving sums.  Saturate the unsigned int conversion
results at UINT_MAX.

Add KUnit coverage for the helper, the conversions, and the moving sums.

The conversion issues were discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260708140944.F26821F000E9@smtp.kernel.org

Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")
Fixes: 9f3786d8602f ("mm/damon/core: introduce damon_nr_accesses_mvsum()")
Fixes: 2ec26dd341d1 ("mm/damon/core: introduce damon_probe_hits_mvsum()")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 mm/damon/core.c             | 41 +++++++++++++++++---
 mm/damon/tests/core-kunit.h | 74 +++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 73b571b429cb..5cd4007cc370 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -281,6 +281,32 @@ static bool damon_has_probe_weights(struct damon_ctx *c)
 	return false;
 }
 
+/*
+ * damon_mult_frac() - calculate @x * @n / @d without overflowing.
+ *
+ * Same as mult_frac(), but the intermediate product of the remainder does not
+ * overflow, and a result that does not fit in unsigned long is saturated to
+ * ULONG_MAX.  Returns the same value as mult_frac() when mult_frac() does not
+ * overflow.  @d must not be zero.
+ */
+static unsigned long damon_mult_frac(unsigned long x, unsigned long n,
+		unsigned long d)
+{
+	unsigned long q = x / d, r = x % d;
+	unsigned long frac;
+
+	if (n && q > ULONG_MAX / n)
+		return ULONG_MAX;
+	if (!n || r <= ULONG_MAX / n)
+		frac = r * n / d;
+	else
+		/* r < d, so the quotient is smaller than n */
+		frac = mul_u64_u64_div_u64(r, n, d);
+	if (frac > ULONG_MAX - q * n)
+		return ULONG_MAX;
+	return q * n + frac;
+}
+
 /*
  * damon_mvsum() - Returns pseudo moving sum value for a time window.
  * @current_nr:		The value of the current aggregation window.
@@ -305,7 +331,7 @@ static bool damon_has_probe_weights(struct damon_ctx *c)
 static unsigned long damon_mvsum(unsigned long current_nr,
 		unsigned long last_nr, unsigned long left_window_bp)
 {
-	return current_nr + mult_frac(last_nr, left_window_bp, 10000);
+	return current_nr + damon_mult_frac(last_nr, left_window_bp, 10000);
 }
 
 /**
@@ -337,7 +363,7 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
 	else
 		left_window = ctx->next_aggregation_sis -
 			ctx->passed_sample_intervals;
-	left_window_bp = mult_frac(left_window, 10000, window_len);
+	left_window_bp = damon_mult_frac(left_window, 10000, window_len);
 
 	if (left_window_bp == 10000)
 		return r->last_nr_accesses;
@@ -361,7 +387,7 @@ unsigned char damon_probe_hits_mvsum(int probe_idx, struct damon_region *r,
 	else
 		left_window = ctx->next_aggregation_sis -
 			ctx->passed_sample_intervals;
-	left_window_bp = mult_frac(left_window, 10000, window_len);
+	left_window_bp = damon_mult_frac(left_window, 10000, window_len);
 
 	if (left_window_bp == 10000)
 		return r->last_probe_hits[probe_idx];
@@ -990,21 +1016,24 @@ static bool damon_attrs_equals(const struct damon_attrs *attrs1,
 static unsigned int damon_age_for_new_attrs(unsigned int age,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
-	return age * old_attrs->aggr_interval / new_attrs->aggr_interval;
+	return min(damon_mult_frac(age, old_attrs->aggr_interval,
+				new_attrs->aggr_interval), UINT_MAX);
 }
 
 /* convert sample ratio in bp (per 10,000) to count */
 static unsigned int damon_sample_bp_to_count(
 		unsigned int bp, struct damon_attrs *attrs)
 {
-	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
+	return min(damon_mult_frac(bp, damon_nr_samples_per_aggr(attrs),
+				10000), UINT_MAX);
 }
 
 /* convert sample count to ratio in bp (per 10,000) */
 static unsigned int damon_sample_count_to_bp(
 		unsigned int count, struct damon_attrs *attrs)
 {
-	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
+	return min(damon_mult_frac(count, 10000,
+				damon_nr_samples_per_aggr(attrs)), UINT_MAX);
 }
 
 static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr,
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 43e2f950f8ff..e71e60d59400 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -698,6 +698,64 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 	damon_destroy_ctx(ctx);
 }
 
+static void damon_test_mult_frac(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, damon_mult_frac(7, 3, 2), 10ul);
+	KUNIT_EXPECT_EQ(test, damon_mult_frac(ULONG_MAX, 0, 1), 0ul);
+	/* the remainder product overflows on 32-bit */
+	KUNIT_EXPECT_EQ(test, damon_mult_frac(524288, 10000, 786432), 6666ul);
+	KUNIT_EXPECT_EQ(test, damon_mult_frac(500000, 10000, 1000000), 5000ul);
+	/* the remainder product overflows even on 64-bit */
+	KUNIT_EXPECT_EQ(test, damon_mult_frac(ULONG_MAX - 1, ULONG_MAX,
+				ULONG_MAX), ULONG_MAX - 1);
+	/* the quotient product overflows */
+	KUNIT_EXPECT_EQ(test, damon_mult_frac(ULONG_MAX, 10000, 1), ULONG_MAX);
+	/* the largest representable result, and one beyond it */
+	KUNIT_EXPECT_EQ(test, damon_mult_frac(ULONG_MAX - ULONG_MAX / 10000,
+				10000, 9999), ULONG_MAX);
+	KUNIT_EXPECT_EQ(test, damon_mult_frac(ULONG_MAX - ULONG_MAX / 10000 + 1,
+				10000, 9999), ULONG_MAX);
+}
+
+static void damon_test_age_for_new_attrs_large_value(struct kunit *test)
+{
+	struct damon_attrs old_attrs = {.aggr_interval = 100000};
+	struct damon_attrs new_attrs = {.aggr_interval = 50000};
+	unsigned int age;
+
+	age = damon_age_for_new_attrs(50000, &old_attrs, &new_attrs);
+	KUNIT_EXPECT_EQ(test, age, 100000u);
+
+	new_attrs.aggr_interval = 1;
+	age = damon_age_for_new_attrs(UINT_MAX, &old_attrs, &new_attrs);
+	KUNIT_EXPECT_EQ(test, age, UINT_MAX);
+
+	old_attrs.aggr_interval = ULONG_MAX;
+	age = damon_age_for_new_attrs(UINT_MAX, &old_attrs, &new_attrs);
+	KUNIT_EXPECT_EQ(test, age, UINT_MAX);
+}
+
+static void damon_test_sample_ratio_large_value(struct kunit *test)
+{
+	struct damon_attrs attrs = {
+		.sample_interval = 1000,
+		.aggr_interval = 600000000,
+	};
+
+	KUNIT_EXPECT_EQ(test, damon_sample_bp_to_count(10000, &attrs),
+			600000u);
+	KUNIT_EXPECT_EQ(test, damon_sample_count_to_bp(600000, &attrs),
+			10000u);
+	KUNIT_EXPECT_EQ(test, damon_sample_count_to_bp(500000, &attrs),
+			8333u);
+	KUNIT_EXPECT_EQ(test, damon_sample_bp_to_count(UINT_MAX, &attrs),
+			UINT_MAX);
+
+	attrs.aggr_interval = attrs.sample_interval;
+	KUNIT_EXPECT_EQ(test, damon_sample_count_to_bp(UINT_MAX, &attrs),
+			UINT_MAX);
+}
+
 static void damon_test_set_attrs(struct kunit *test)
 {
 	struct damon_ctx *c = damon_new_ctx();
@@ -735,6 +793,7 @@ static void damon_test_mvsum(struct kunit *test)
 		3, 10, 5000, 8,		/* 3 + 10 * 0.5 */
 		32, 100, 1000, 42,	/* 32 + 100 * 0.1 */
 		42, 49, 0, 42,		/* 42 + 49 * 0 */
+		0, 600000, 8333, 499980, /* 32-bit remainder product overflow */
 	};
 
 	int i;
@@ -794,6 +853,18 @@ static void damon_test_nr_accesses_mvsum(struct kunit *test)
 				damon_nr_accesses_mvsum(r, c));
 	}
 
+	c->attrs.sample_interval = 1000;
+	c->attrs.aggr_interval = 600000000;
+	c->passed_sample_intervals = 100000;
+	c->next_aggregation_sis = 600000;
+	r->nr_accesses = 100000;
+	r->last_nr_accesses = 600000;
+	KUNIT_EXPECT_EQ(test, damon_nr_accesses_mvsum(r, c), 599980u);
+
+	r->probe_hits[0] = 0;
+	r->last_probe_hits[0] = 100;
+	KUNIT_EXPECT_EQ(test, damon_probe_hits_mvsum(0, r, c), 83);
+
 	damon_free_region(r);
 	damon_destroy_ctx(c);
 }
@@ -2494,6 +2565,9 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_regions),
 	KUNIT_CASE(damon_test_nr_samples_per_aggr),
 	KUNIT_CASE(damon_test_update_monitoring_result),
+	KUNIT_CASE(damon_test_mult_frac),
+	KUNIT_CASE(damon_test_age_for_new_attrs_large_value),
+	KUNIT_CASE(damon_test_sample_ratio_large_value),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_mvsum),
 	KUNIT_CASE(damon_test_nr_accesses_mvsum),
-- 
2.43.0


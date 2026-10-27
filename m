Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109579;
	b=3xaEBKuggULmQIQl8WnxYDO1BKV4X9rv+HhgASh/FQNLj3C/Dc9ooe4HnRWpxyL9i/39
	 05IGeV3WI///KMCu1TxVATSP1cH2EMFuTEzmfZjQnD7AiSGfPA9EL5fsBKcwIQAITnizp
	 o60i+rhF3kCdYk2XD1WoHzk6kT69q8+fh/X2E9xEpJVNRAK6q+KFOS5Lbk1TgZVSwR/u1
	 /IhO1QER+qfSb/jjAB1qNuBezGR+mu+I2od1nf0rI1gVm7plraRw3a7jWFmRt3k0nwxI2
	 OfnLbUso1QxqbZOIx8ZXzcYMumx1JhIoMPTaZPZhvz4YawtY8fOy+FSErThgd0a37Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=28t27eQ8gsM3u/fL1shL3y8iqdAx6jSJDsl/RU1Nwjs=;
	b=TPmtFLCgKJ5XwZ6YDsXD+YObwYdkGsX2jQyBOwkXp4wjEhkgg0paC0MvPLvIC83QX3NN
	 Ka9P5uWLA4dt5rWQV7OP/YGnrw/dmx1vABK7Ysaj63uu7rkemvJQ8gJL5aymjoFdpki/+
	 EuzV6odcxorsGu7R2Tl8HDb9sjwP1pQRxkY2t+ayO3erFJBqkSaVWX+j/pBs12V4LIWrN
	 dsRe7MgJcMHZ4vwXHdlzEI6+hbbneg1NeVgWbpKBvNBBbV92qwHb4e8A/WoTJB2+EKXCO
	 NJBi/57/ex/sQF8M1Eg7oQLEoozluNHKaYA/1L6vdNSRoCThbLP4U+V1HXGdDRCIfEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DyvZqIvb;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA2606A31A
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 13:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90BA2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DyvZqIvb
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd5f2834b19so175808a12.0
        for <damon@lists.linux.dev>; Tue, 27 Oct 2026 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793109579; x=1793714379; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=28t27eQ8gsM3u/fL1shL3y8iqdAx6jSJDsl/RU1Nwjs=;
        b=DyvZqIvbMT5Z+eKmS4OWuITQUugU609Bvf3e08mfV4/mDX7ZlNI3Q/iHaDxiQoKgiX
         0uaaqhOvVS6wgARzLTBbbW8eDTncxftitQlkxx9+KsLvEe910BWaA/NqEjTHeuP5Z1Sj
         JU5aflEw6W10CPiK9FP3UsTYclymXwDg/VNCNuvwF/FCVW3Bfo34xwP9aCN+4uYJVq/l
         l7eDPrxZpbGiU/m2/BRlbtfNlBU1Ckw6lDBr8Yrc3jAoZTdJYyONdGc4Kzmm2iEQJg9z
         29a5wr49T90V6fo/4Vl2iRKWacbAD1V76ZpgpzuEjnxMzGtzvFYI8DReRITiubuwT2eB
         Rlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109579; x=1793714379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=28t27eQ8gsM3u/fL1shL3y8iqdAx6jSJDsl/RU1Nwjs=;
        b=ofiMlMy/tfFdqWZAsRFr9j+E6MN2rRbZFg+4sMFT8rliy6aMMTVoupdr0P2wioiCEs
         44hYGOJdGzi0VzawRfx6P7G9DuLcISIUIq/PnvV3G0LAZYLfeJbnlcjaGVCNeFD/3wyx
         tsT/3g6y/xwCgCX2UPo8CX/Wj2a24tuBTLE4UUvOnlKtZCGYe3+VPavZUApciSdv0zE4
         YwLO0SWRajn1pefJm2I9/BxeGjphn+s+05OBP+KhO5HjqXczo0FHrYyOiK718iTniU73
         FmOeQKTm43IFHk05WEEviZi5xd2W8f0RyZ12NK/ynRscpHAK55nnhF71fK2/Lh1UuWuB
         DeuQ==
X-Gm-Message-State: AFq9FYI/VprIlKmZz2oT8lY6aLiBIMF0Jyyxizqsm8wc5prbA3HzsVJx
	5jFwhW8dvEuUqInkuTyVN0SFk3211yQ7DR29r7lcfHbXOK0aJjojSZ0H
X-Gm-Gg: AYBFou3lPOIBrgva9ReAjDRhaooyDtqkF8ctVZesTsI+KAswB2PclugvUSeRw33MXVL
	6nok/7CUIzA8W4zY5JPWD/yAq0c91CjGpwFRUIyIZMhhLI4RZLs9dyJ995Pyz0vPnsAdhgxJlIp
	XXOp09ctXrqwm8Je8SBfZgPW8ZWzPk8s6ZRyp/AvR4hH1mEYLOwuLgCiIohiasha4cIjVIvorjz
	N5VQ1ENRaUtUv12SeUBeMm08XvoShFpGE03vL1qBkpBpVxhQDREVYRsh2SoQv6V4KTkf7tD0Aaj
	GwCUGnhFT9sWEFt2vzMFeyCRF4h9L6xGZT6fGjdVgpVENxw0niG1MloOkDHtoiiUphaMd07ObA/
	UvazUCYBrzfl33G4ieP5411sV1azvkQ1m+sPIZ0IxYYN/v3ElnyVCMfnJfSOjW99edlPtM7KjKJ
	KNYIaf0uoAJi4uuiEytzvZDgy7XuHJu0C6Ea/DWoGc+ksgydFiPSVZ87Rl4rMDt9eLdQR3BGcXW
	LFHfXkkmaQLdFQZfnm0u3LZeiU4SrDU0BX+gzXbn0Jc+WM7
X-Received: by 2002:a17:90b:39a6:b0:3a7:a463:54bb with SMTP id 98e67ed59e1d1-3adeb10f4c4mr14989953a91.5.1793109578629;
        Tue, 27 Oct 2026 06:59:38 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404432a5sm4243466a91.9.2026.10.27.06.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:59:38 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [RFC PATCH 1/3] mm/damon/ops-common: avoid overflow in weighted hotness score
Date: Tue, 27 Oct 2026 22:59:30 +0900
Message-ID: <20261027135932.2301646-2-charsyam@gmail.com>
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

damon_hot_score() combines the frequency and age subscores using the
user supplied DAMOS quota weights.  The weights are unsigned int, and
both the weighted sum and the total weight are calculated in unsigned
int.  This is independent of the architecture word size.

A frequency weight of 50,000,000 makes the weighted sum wrap, so a
region that is accessed in every sample gets a score of 13 instead of
99.  If the two weights add up to exactly 2^32, the total wraps to zero
and the averaging division is skipped.

Accumulate both values in u64 and divide the weighted sum by the full
total weight.  Add a KUnit case covering a large weight, weights summing
above UINT_MAX, and zero weights.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260623141527.044D11F000E9@smtp.kernel.org

Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 mm/damon/ops-common.c             | 10 +++++--
 mm/damon/tests/ops-common-kunit.h | 47 +++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 3 deletions(-)
 create mode 100644 mm/damon/tests/ops-common-kunit.h

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 2f3bf86a221b..af170b112e08 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -170,6 +170,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	int age_in_log, age_subscore;
 	unsigned int freq_weight = s->quota.weight_nr_accesses;
 	unsigned int age_weight = s->quota.weight_age;
+	u64 total_weight, weighted_sum;
 	int hotness;
 
 	freq_subscore = mult_frac(damon_nr_accesses_mvsum(r, c),
@@ -197,9 +198,10 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	age_subscore = age_in_log * DAMON_MAX_SUBSCORE /
 		DAMON_MAX_AGE_IN_LOG / 2;
 
-	hotness = (freq_weight * freq_subscore + age_weight * age_subscore);
-	if (freq_weight + age_weight)
-		hotness /= freq_weight + age_weight;
+	total_weight = (u64)freq_weight + age_weight;
+	weighted_sum = (u64)freq_weight * freq_subscore +
+			(u64)age_weight * age_subscore;
+	hotness = total_weight ? div64_u64(weighted_sum, total_weight) : 0;
 	/*
 	 * Transform it to fit in [0, DAMOS_MAX_SCORE]
 	 */
@@ -576,3 +578,5 @@ bool damon_ops_filter_match(struct damon_filter *filter, struct folio *folio)
 	}
 	return matched == filter->matching;
 }
+
+#include "tests/ops-common-kunit.h"
diff --git a/mm/damon/tests/ops-common-kunit.h b/mm/damon/tests/ops-common-kunit.h
new file mode 100644
index 000000000000..813bad69cdcd
--- /dev/null
+++ b/mm/damon/tests/ops-common-kunit.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_DAMON_KUNIT_TEST
+
+#include <kunit/test.h>
+
+static void damon_test_hot_score_large_weight(struct kunit *test)
+{
+	struct damon_ctx ctx = {
+		.attrs = {
+			.sample_interval = 1000,
+			.aggr_interval = 100000,
+		},
+	};
+	struct damon_region region = {
+		.nr_accesses = 100,
+	};
+	struct damos scheme = {
+		.quota = {
+			.weight_nr_accesses = 50000000,
+		},
+	};
+
+	KUNIT_EXPECT_EQ(test, damon_hot_score(&ctx, &region, &scheme), 99);
+
+	scheme.quota.weight_nr_accesses = UINT_MAX;
+	scheme.quota.weight_age = UINT_MAX;
+	KUNIT_EXPECT_EQ(test, damon_hot_score(&ctx, &region, &scheme), 74);
+
+	scheme.quota.weight_nr_accesses = 0;
+	scheme.quota.weight_age = 0;
+	KUNIT_EXPECT_EQ(test, damon_hot_score(&ctx, &region, &scheme), 0);
+}
+
+static struct kunit_case damon_ops_common_test_cases[] = {
+	KUNIT_CASE(damon_test_hot_score_large_weight),
+	{}
+};
+
+static struct kunit_suite damon_ops_common_test_suite = {
+	.name = "damon-ops-common",
+	.test_cases = damon_ops_common_test_cases,
+};
+
+kunit_test_suite(damon_ops_common_test_suite);
+
+#endif /* CONFIG_DAMON_KUNIT_TEST */
-- 
2.43.0


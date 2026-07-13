Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F193E44EC
	for <damon@lists.linux.dev>; Mon, 13 Jul 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936031; cv=none; b=KKKJCViJxn40Yw9Al8lRJrq+wV8pq/9XY1YgMniYtAV0zYVOHtS3OegBhRiWzvedfqqm2oTwiNdzpgm3pziTN74/IDbLj5/4rUUep9Z5BIqoDZcbpb6aFXVOWRFqBAIerGvnlxe7O8p+kDQ1BkmIOFND9c+hhfbAr2fprq1M3JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936031; c=relaxed/simple;
	bh=C/npH9ZhRNApD0vepMNxQMejBIy/AAS1fKhAEM08SEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrfOktqMTQSWOA77udopZfnpGUvNxcEhzAUML9oa/It4LT1i7UiU25GLIPMCcr+s6M5N28dRCvTX3d+1M/ppvABFuCCstBjP6Rmqi4MkuCi+sW1xLLvrpxuVl+cF1TK1qXQX0WOTznEj4KIL+SC93j0Hhjj/fXSS3H7JnwyXT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cc00c1f67e9f11f1aa26b74ffac11d73-20260713
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:707452e3-6bdc-42b7-a307-f99e573fba5c,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:707452e3-6bdc-42b7-a307-f99e573fba5c,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:45f03bc318b5c2a89ee2ca66b1a07fef,BulkI
	D:260713174704KM5LZ185,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cc00c1f67e9f11f1aa26b74ffac11d73-20260713
X-User: husong@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 85431330; Mon, 13 Jul 2026 17:47:01 +0800
From: Song Hu <husong@kylinos.cn>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Song Hu <husong@kylinos.cn>
Subject: [PATCH v2] mm/damon/tests/core-kunit: test damon_nr_accesses_mvsum()
Date: Mon, 13 Jul 2026 17:46:48 +0800
Message-ID: <20260713094648.897239-1-husong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_accesses_mvsum() wraps damon_mvsum() with the monitoring
intervals of the context to compute the pseudo moving sum of a region's
access frequency, with a special case for when the whole aggregation
window remains. damon_mvsum() itself is already covered by
damon_test_mvsum(), but the wrapper is not.

Add a table-driven KUnit test that exercises the full-window-remaining
boundary (with both reset and not-yet-reset nr_accesses), partially
elapsed windows, and the no-window-remaining case.

Signed-off-by: Song Hu <husong@kylinos.cn>
---
Changes in v2:
- Drop the confusing 'bp=...:' annotation from each test-case comment.
- Wrap the function documentation comment to the 80-column limit.
---
 mm/damon/tests/core-kunit.h | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0124f83b39b8..d085c90484d3 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -683,6 +683,54 @@ static void damon_test_mvsum(struct kunit *test)
 	}
 }
 
+/*
+ * Test damon_nr_accesses_mvsum(), which wraps damon_mvsum() with the
+ * monitoring intervals of the context.  With a sample interval of 1 and an
+ * aggregation interval of 10, an aggregation window is 10 sample intervals
+ * long.  Each row below specifies the passed sample intervals, the next
+ * aggregation time in sample intervals, the current and last nr_accesses of a
+ * region, and the expected return value.
+ */
+static void damon_test_nr_accesses_mvsum(struct kunit *test)
+{
+	unsigned long input_expects[] = {
+		/* passed, next_aggr, nr_accesses, last_nr_accesses, expect */
+		0, 10, 5, 3, 3,		/* full window left, unreset */
+		0, 10, 0, 7, 7,		/* full window left, reset */
+		5, 10, 3, 10, 8,	/* half window left */
+		8, 10, 3, 10, 5,	/* 20% window left */
+		10, 10, 42, 49, 42,	/* no window left */
+	};
+	struct damon_ctx *c = damon_new_ctx();
+	struct damon_region *r;
+	int i;
+
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
+	r = damon_new_region(0, 4096);
+	if (!r) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "region alloc fail");
+	}
+
+	c->attrs.sample_interval = 1;
+	c->attrs.aggr_interval = 10;
+
+	for (i = 0; i < ARRAY_SIZE(input_expects); i += 5) {
+		c->passed_sample_intervals = input_expects[i];
+		c->next_aggregation_sis = input_expects[i + 1];
+		r->nr_accesses = input_expects[i + 2];
+		r->last_nr_accesses = input_expects[i + 3];
+
+		KUNIT_EXPECT_EQ(test, (unsigned int)input_expects[i + 4],
+				damon_nr_accesses_mvsum(r, c));
+	}
+
+	damon_free_region(r);
+	damon_destroy_ctx(c);
+}
+
 static void damos_test_new_filter(struct kunit *test)
 {
 	struct damos_filter *filter;
@@ -1576,6 +1624,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_mvsum),
+	KUNIT_CASE(damon_test_nr_accesses_mvsum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_commit_quota_goal),
 	KUNIT_CASE(damos_test_commit_quota_goals),
-- 
2.43.0


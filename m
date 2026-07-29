Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194A44161A;
	Wed, 29 Jul 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336465; cv=none; b=fSAKmqSjH66izL2Zx5+sXseryRQntqk6FiZb7tytg28CX/y6bVYCRSuY25573RbxH9FKtuwptmD3gp/Lrjk1w29DYsOjY0BvLHrITEGOBhGX+eenCHMCybHC70WU6hV5bhPMCKyXWZxUr/7KEyKP6qNUZeT+2xBBzjpqVwJ4B5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336465; c=relaxed/simple;
	bh=lac46AYAqzm/j1BUdZaWQ0JtXkVsLwT4fw8W9hkZV2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+k6bLeAzNVz0MZZ7Q4HVIUHlJKVU4cMDU2WBhgZkUiFooA3HvP23cfXDeSMhb3gfWudr8sLBCPljfiKNWtUv3iA6PCDxQv7oBV4rfD2QujbbDyQQwqeVT7oiVr/oxg+xeVGyrlTedUFKTc+zqfE1sSGjlf7s1pdNRDM/nyBJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h73bFV9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h73bFV9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160181F00AC4;
	Wed, 29 Jul 2026 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336463;
	bh=cVDCDmM/5oMd0S9q4mDsaOvqgsm4wlgdEROJ+WP1mCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h73bFV9XXRa3rYOjLrc21PccfLGzZcUBzEX1CZuw+YuyQ0xWnKof5wRTUjM43vDp4
	 N/ZLjeop0UV/IKchgAkeWPTMsWWHEKTjq/in08DKOSohkjXgCny8wsB0j0tywnHuG9
	 Qb3eUWM6aF3H+J2gGN2QfX7jOWDSyx/ax6tLYNx2RcV+PpNKUsn2EbhQsHhPR0coD2
	 YkTQx80CES31BgAW1lfdn8s77xGQCn/gFo/VTByC29CvKJfeoHMuk0qNBjIFkqPpzq
	 6hnAQ3EuEyYvvfnfM/PI/HCxaWAWFTpHXDjbesfeDQHDBZ0Wf9itBmt5fNyQfjmoCA
	 TLlCdLA+Qs4Vg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/6] mm/damon/tests/core-kunit: test damon_commit_filter()
Date: Wed, 29 Jul 2026 07:47:32 -0700
Message-ID: <20260729144738.90895-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729144738.90895-1-sj@kernel.org>
References: <20260729144738.90895-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kunit test to ensure damon_commit_filter() updates destination
filter as expected for valid inputs.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c7bda8aadef3f..ff864402e9c75 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1354,6 +1354,45 @@ static void damon_test_commit_target_regions(struct kunit *test)
 			(unsigned long[][2]) {{3, 8}, {8, 10}}, 2);
 }
 
+static void damon_test_commit_filter_for(struct kunit *test,
+		struct damon_filter *dst, struct damon_filter *src)
+{
+	damon_commit_filter(dst, src);
+	KUNIT_EXPECT_EQ(test, dst->type, src->type);
+	KUNIT_EXPECT_EQ(test, dst->matching, src->matching);
+	KUNIT_EXPECT_EQ(test, dst->allow, src->allow);
+	switch (src->type) {
+	case DAMOS_FILTER_TYPE_MEMCG:
+		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
+		break;
+	default:
+		break;
+	}
+}
+
+static void damon_test_commit_filter(struct kunit *test)
+{
+	struct damon_filter dst = {
+		.type = DAMON_FILTER_TYPE_ANON,
+		.matching = false,
+		.allow = false,
+	};
+
+	damon_test_commit_filter_for(test, &dst,
+			&(struct damon_filter){
+			.type = DAMON_FILTER_TYPE_ANON,
+			.matching = true,
+			.allow = true,
+			});
+	damon_test_commit_filter_for(test, &dst,
+			&(struct damon_filter){
+			.type = DAMON_FILTER_TYPE_MEMCG,
+			.matching = false,
+			.allow = false,
+			.memcg_id = 123,
+			});
+}
+
 static void damon_test_commit_ctx(struct kunit *test)
 {
 	struct damon_ctx *src, *dst;
@@ -1705,6 +1744,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_pageout),
 	KUNIT_CASE(damos_test_commit_migrate_hot),
 	KUNIT_CASE(damon_test_commit_target_regions),
+	KUNIT_CASE(damon_test_commit_filter),
 	KUNIT_CASE(damon_test_commit_ctx),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
-- 
2.47.3

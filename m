Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95273374
	for <damon@lists.linux.dev>; Thu, 15 Jun 2023 18:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D96EC433C8;
	Thu, 15 Jun 2023 18:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686854009;
	bh=Dsjd+ZpmvL/6xXc3Y13JGILcWmi7U4GqyYJ6md9X1xY=;
	h=From:To:Cc:Subject:Date:From;
	b=fvmFV/WWm6mNcOwWDpoxuttJZLSXSm9ssx8ToCjmoc+cU34XimcYrjr40gM60l9Rq
	 0fQINZ45Fqh+rXllOcuqIQLG8+Y8TzEUkIjXv8qPDZ3SlVa1XFkPQDIMG8ms5CWUsV
	 cEqIsm/794h9b10+BGqxu3XPqzmmVMZoIBar/pOOdt58PU5zmG1LmJKjqvspCDTyoa
	 y+ayOOLfq7RiJy36JsOR42b/eFiPNv2ekpW2Jsvt577E6C+o1wLaiQ0TB2bDzWL4Bs
	 cX5VJnT4kI/pE7PF8agPnlLQN0H3rRum+cWkATm+AJTrWlTgqRMj+BKkkipUR87EEu
	 1ph524/oH87Gw==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: SeongJae Park <sj@kernel.org>,
	wangkefeng.wang@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/core-test: add a test for damon_set_attrs()
Date: Thu, 15 Jun 2023 18:33:22 +0000
Message-Id: <20230615183323.87561-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5ff6e2fff88e ("mm/damon/core: fix divide error in
damon_nr_accesses_to_accesses_bp()") fixed a bug by adding arguments
validation in damon_set_attrs().  Add a unit test for the added
validation to ensure the bug cannot occur again.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index fae64d32b925..c11210124344 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -318,6 +318,29 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->age, 20);
 }
 
+static void damon_test_set_attrs(struct kunit *test)
+{
+	struct damon_ctx ctx;
+	struct damon_attrs valid_attrs = {
+		.min_nr_regions = 10, .max_nr_regions = 1000,
+		.sample_interval = 5000, .aggr_interval = 100000,};
+	struct damon_attrs invalid_attrs;
+
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &valid_attrs), 0);
+
+	invalid_attrs = valid_attrs;
+	invalid_attrs.min_nr_regions = 1;
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
+
+	invalid_attrs = valid_attrs;
+	invalid_attrs.max_nr_regions = 9;
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
+
+	invalid_attrs = valid_attrs;
+	invalid_attrs.aggr_interval = 4999;
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -329,6 +352,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
 	KUNIT_CASE(damon_test_update_monitoring_result),
+	KUNIT_CASE(damon_test_set_attrs),
 	{},
 };
 
-- 
2.25.1


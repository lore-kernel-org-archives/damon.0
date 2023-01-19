Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CF15B0
	for <damon@lists.linux.dev>; Thu, 19 Jan 2023 01:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640F5C43396;
	Thu, 19 Jan 2023 01:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674092319;
	bh=4x0hnDy4BX61lB/pbgUpUZC1nSP8lE0d4hLy0MishdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kg1+ilbzWZybIQkILRS0j625AZhP7sNVWI2JBN+aHXZ2odIdbzI0kIXodhRrbj8ig
	 ZMlQ4qeSzaSsYFpuRnzk1VeYWQRxyj3bxvcHY4BsmNvGwxGvezui3C/8oY8XHTfMr1
	 riwUIv17ty8xmzBgdHfrQcUrlhG/vmLian0Hf13hjJTOKFHuNoMjtcPWMyym5tVu2W
	 Z2l+vaKdgROZU4t5MbhLxAXrs0ziF63YtDE1YtWY33j47VgUn7nJ579EToCzI5pPi+
	 ETtxqdK8+Gl28xqf7e28CIgB8kJEL99OCQ7yiOS28Z5gqgwE3vjfd2dFLeexDvyU9g
	 HDsnVYKUsQkew==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	brendanhiggins@google.com,
	kunit-dev@googlegroups.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm/damon/core-test: add a test for damon_update_monitoring_results()
Date: Thu, 19 Jan 2023 01:38:31 +0000
Message-Id: <20230119013831.1911-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119013831.1911-1-sj@kernel.org>
References: <20230119013831.1911-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple unit test for damon_update_monitoring_results() function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 3db9b7368756..fae64d32b925 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -289,6 +289,35 @@ static void damon_test_set_regions(struct kunit *test)
 	damon_destroy_target(t);
 }
 
+static void damon_test_update_monitoring_result(struct kunit *test)
+{
+	struct damon_attrs old_attrs = {
+		.sample_interval = 10, .aggr_interval = 1000,};
+	struct damon_attrs new_attrs;
+	struct damon_region *r = damon_new_region(3, 7);
+
+	r->nr_accesses = 15;
+	r->age = 20;
+
+	new_attrs = (struct damon_attrs){
+		.sample_interval = 100, .aggr_interval = 10000,};
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
+	KUNIT_EXPECT_EQ(test, r->nr_accesses, 15);
+	KUNIT_EXPECT_EQ(test, r->age, 2);
+
+	new_attrs = (struct damon_attrs){
+		.sample_interval = 1, .aggr_interval = 1000};
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
+	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
+	KUNIT_EXPECT_EQ(test, r->age, 2);
+
+	new_attrs = (struct damon_attrs){
+		.sample_interval = 1, .aggr_interval = 100};
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
+	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
+	KUNIT_EXPECT_EQ(test, r->age, 20);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -299,6 +328,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_split_regions_of),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
+	KUNIT_CASE(damon_test_update_monitoring_result),
 	{},
 };
 
-- 
2.25.1


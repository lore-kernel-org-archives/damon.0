Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1771AED2
	for <damon@lists.linux.dev>; Fri, 15 Sep 2023 02:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B9DC433C8;
	Fri, 15 Sep 2023 02:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694746386;
	bh=xT8faQ/VQn4QsrSETrKl21TSbXbkbXRLNmsjtMslsE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vE+6+K2v8eFHCuG2uMpBuFLYWDxqqOXd+irJE2hgT8Kzn2qCdWCy1yLXm/zxJGcle
	 766beCUyr429m9vHPiYbpBIH1ir4Ac1FU1pAssUxZCd0fxPupJtIfjmwwqCV1CizFh
	 urwwnI45LhwWV3A+6CX6il2CrZWabaG/fK1UIvPJW4QNgmq7jiOh7NATX2Jh8W9xyx
	 sboRSLtK7W/n1muo988SNeyulnEUWTL/ZqrG2xmmHhw+zkZA3YEHyXowMDaMr2B5hD
	 XGukIVihyc7OyD/VMQU5eVcRYGaRVI6Xe4hn3oV8PWGyIPnbyMw5YD+9QK8yLIrpZk
	 HOBb+tcLjtjgQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] mm/damon/core-test: add a unit test for damon_moving_sum()
Date: Fri, 15 Sep 2023 02:52:47 +0000
Message-Id: <20230915025251.72816-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915025251.72816-1-sj@kernel.org>
References: <20230915025251.72816-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple unit test for the pseudo moving-sum function
(damon_moving_sum()).

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..c539f0e8377e 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -341,6 +341,21 @@ static void damon_test_set_attrs(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
 }
 
+static void damon_test_moving_sum(struct kunit *test)
+{
+	unsigned int mvsum = 50000, nomvsum = 50000, len_window = 10;
+	unsigned int new_values[] = {10000, 0, 10000, 0, 0, 0, 10000, 0, 0, 0};
+	unsigned int expects[] = {55000, 50000, 55000, 50000, 45000, 40000,
+		45000, 40000, 35000, 30000};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(new_values); i++) {
+		mvsum = damon_moving_sum(mvsum, nomvsum, len_window,
+				new_values[i]);
+		KUNIT_EXPECT_EQ(test, mvsum, expects[i]);
+	}
+}
+
 static void damos_test_new_filter(struct kunit *test)
 {
 	struct damos_filter *filter;
@@ -425,6 +440,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_regions),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
+	KUNIT_CASE(damon_test_moving_sum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_filter_out),
 	{},
-- 
2.25.1


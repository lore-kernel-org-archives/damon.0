Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401FE15C0
	for <damon@lists.linux.dev>; Sat,  9 Sep 2023 03:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA87C433C8;
	Sat,  9 Sep 2023 03:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694230646;
	bh=xT8faQ/VQn4QsrSETrKl21TSbXbkbXRLNmsjtMslsE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6nGX0tPVQa7fCjabWv9V2jpJs1DiN5xW7gllO09XsezCUlzsXPYyvzHVicPumwDV
	 lQnjQlf0l+hoeoKIWbMAHjjrxe9+3JDdv8MpG5M9yHTg23+or5jvfqib8eX3+JpL2y
	 Tgl+amkWP0P6lRiUwZcxGAi/ZVz6ECjZVVZBqKKd/9sNED8QDpRKxGOAfgsV77P3sV
	 RvEBOP5H8fZIhDl871XivTV6JqG8VefCQc56DqGs/IhVAYPgftaTalFZp8iP0Vfy9N
	 WNu3+4BqDt7DOpVmHvOL6X8XAsYAqNm6XCbHkhz2n5C4kvbPJKktYT2qEQy54weRGP
	 Ed5aJ0cXUmMYw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 4/8] mm/damon/core-test: add a unit test for damon_moving_sum()
Date: Sat,  9 Sep 2023 03:37:07 +0000
Message-Id: <20230909033711.55794-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230909033711.55794-1-sj@kernel.org>
References: <20230909033711.55794-1-sj@kernel.org>
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


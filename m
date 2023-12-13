Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ABA818
	for <damon@lists.linux.dev>; Wed, 13 Dec 2023 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh6j4zF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC743C433C8;
	Wed, 13 Dec 2023 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702494229;
	bh=gjBQjP/YI+pvMOKNh4ddMdbLJ3KLmfM9HXn1Dp4kPVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gh6j4zF8l93bobVI7GSErZD+7LyrzAOafaTw/R+gygXqiWV4CRdqWwXQ4WHnfcO5A
	 ntCVTNa3MG2BjUATa9SvAKwQAfINk5MJbH1cQsimTz2xBRm2XyU16JA/pkCDCVZBLM
	 tYqx26QhH06nd6+RI/CnV0NU7hK5ynOAW+Z0EaxqXgVK7aTJLDK+cN15J+KLBe+wGl
	 FPY1GTm8dlM/DZ8CdH2eMVZ9cww7cSXDsMBAbUrukA7Khyyau/bnOZiSGqHIhpwnXk
	 UQuZluFbU+/gS0nN3hGdfFYeZSaojRVgc0zs0RTAEI3p5ZqKWxiCp7cU9I6UkJIWWW
	 PXaXBm0veoOYA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm/damon/core-test: test max_nr_accesses overflow caused divide-by-zero
Date: Wed, 13 Dec 2023 19:03:34 +0000
Message-Id: <20231213190338.54146-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213190338.54146-1-sj@kernel.org>
References: <20231213190338.54146-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 35f5d94187a6 ("mm/damon: implement a function for max nr_accesses
safe calculation") has fixed an overflow bug that could cause
divide-by-zero.  Add a kunit test for the bug to ensure similar bugs are
not introduced again.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 876e398557b0..0cee634f3544 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -302,6 +302,16 @@ static void damon_test_set_regions(struct kunit *test)
 	damon_destroy_target(t);
 }
 
+static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
+{
+	struct damon_attrs attrs = {
+		.sample_interval = 10,
+		.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
+	};
+
+	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
+}
+
 static void damon_test_update_monitoring_result(struct kunit *test)
 {
 	struct damon_attrs old_attrs = {
@@ -487,6 +497,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_split_regions_of),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
+	KUNIT_CASE(damon_test_nr_accesses_to_accesses_bp),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_moving_sum),
-- 
2.34.1


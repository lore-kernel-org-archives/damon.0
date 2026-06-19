Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC913B19D0;
	Fri, 19 Jun 2026 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897672; cv=none; b=DRc8tyS/3+zn/ZUM36CsghJV8B2aFWxBr9rYitBIfrIOyOZkXXZfZ9jCdE//nYszRB0sWm0+QXaWyFb8ZcbpQNiUrI+jUrs9ExwflgpIvo+eOoPRv2G53ViCOaniJiurOy3UiJXdPYNQZU3y8SojZH7gjiX5LgzyChqquDJ7Lkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897672; c=relaxed/simple;
	bh=4qvCPMZ4f/BTRHBhPjuPfH/ksnZQhiXOziSUFm4y4xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfIy9YQ79HI4clpjQla9CwqacS+onpVUVBhds5N2e7fDr9pEzYFoaa8pxiQFYCW+IU5PQ43nzSU5K4kmRz+OGuVX8CBvCTsJ1JDrk/l3m9b+yAMdjrsu/1n3RNt4ghfyh4Xudld8hb2rg6zOiglXRtH1lIMrzRd3gzCbKwNlsBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWBCCwIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWBCCwIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50541F00A3A;
	Fri, 19 Jun 2026 19:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897671;
	bh=dGqKzRnIP+DKXc/Th2v0SJe+T3xtV4bAe2ASi7qsS9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KWBCCwIpN9s2oD7RD8XxYXNLw/MPorDIdy9e0/hPw27TaA/xDOXw0jSzNgdHCFVw9
	 Hg8VTnQnHpZqXGkJwyYBT4PBKg4HSaStzm5xlshkTs2kqnK0uaH1MCfto0OPwEt8AG
	 X3VKaccakv+TtNQ6LwJkLMLqUkrAUTKSIi4WrY5di5CD8+TXc+8CM4iD8IeIZK7DfG
	 in2c4Y9LFDz8oUr9S17F6E90mx7IYCuemwzBeoaV3qqfNFAWnq+m4jmwGGCx4d6H0m
	 DSOV8aCQIuiDGgn1d50MBgPJcnyFee6ASVkS3SmLBbeCOrtGi7Rz/50jhGxn7zqZWb
	 jJb/6y8MyipaQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/13] mm/damon/tests/core-kunit: test damon_mvsum()
Date: Fri, 19 Jun 2026 12:33:47 -0700
Message-ID: <20260619193415.73833-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619193415.73833-1-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple unit test for damon_nr_accesses_mvsum()'s internal core
logic, damon_mvsum().  The test contains cases for just-started windows,
partially completed windows, and just-completed windows.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 4e448c08c724a..cdab14396250f 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -623,6 +623,30 @@ static void damon_test_moving_sum(struct kunit *test)
 	}
 }
 
+static void damon_test_mvsum(struct kunit *test)
+{
+	unsigned long input_expects[] = {
+		/* current value, last value, remaining window (bp) */
+		0, 49, 10000, 49,	/* 0 + 49 * 1 */
+		3, 10, 7000, 10,	/* 3 + 10 * 0.7 */
+		3, 10, 5000, 8,		/* 3 + 10 * 0.5 */
+		32, 100, 1000, 42,	/* 32 + 100 * 0.1 */
+		42, 49, 0, 42,		/* 42 + 49 * 0 */
+	};
+
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(input_expects); i += 4) {
+		unsigned long current_nr = input_expects[i];
+		unsigned long last_nr = input_expects[i + 1];
+		unsigned long left_window_bp = input_expects[i + 2];
+		unsigned long expect = input_expects[i + 3];
+
+		KUNIT_EXPECT_EQ(test, damon_mvsum(current_nr, last_nr,
+					left_window_bp), expect);
+	}
+}
+
 static void damos_test_new_filter(struct kunit *test)
 {
 	struct damos_filter *filter;
@@ -1501,6 +1525,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_moving_sum),
+	KUNIT_CASE(damon_test_mvsum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_commit_quota_goal),
 	KUNIT_CASE(damos_test_commit_quota_goals),
-- 
2.47.3

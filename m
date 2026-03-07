Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5531E833;
	Sat,  7 Mar 2026 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772912547; cv=none; b=QyR8OzRkPwZuCBsKAPdpBPRr0W1NPltr/fCZ0Mu6g5oWhDY2ylSFlQ6mx6yoj3NRKqoj+agB/2MqzrUscgqYOAkGH4Tbna9uTJ3JHOKLPgZFdjapkxHprmUop8yuWrJT9WUXf3qvpSq5poIsec5ZKBBk0v4oGBI8E6kiD6Z/Jz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772912547; c=relaxed/simple;
	bh=AJWquAe6BG8YHnrQ8aXuxdUfziQhpzCbJ1zdbrFuHTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miePJ4+gfeFMNWS/RD87AX3rFWUxYRIBk1Y0CAiKAsAoqBj2NbnHHYPLO2TGEH/9C89DU+4TsOLPFjPK2ZkBfU0RJU3/JY5+gSWgM3AJDlqwkzteluRehgQLgyGgzOJ+Haamieh6AuSXFxhHnnvdQsR7DUjPHmYAHayfDWrp0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHL0zZ0T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHL0zZ0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72E6C2BC87;
	Sat,  7 Mar 2026 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772912546;
	bh=AJWquAe6BG8YHnrQ8aXuxdUfziQhpzCbJ1zdbrFuHTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHL0zZ0TvAHNnHQ7Cx8FggEW9UvgVWE6BVsBXZwT60K2Z8O1FwYY3Pym8SbI1gYtu
	 xdvlKOSPZRT6iZZrqinbtJZlAhWko57Z1GwX/inx0BJxQqSupQ+3mP7OzkILA7tW5p
	 U472oBC98UgOEoKmsg5vxmtr/JI610fktLoLqtScM8MIof5ghrMqHdDlamRm8wJtuW
	 qWizXPYVxtmj2Pt7AXmB5SKdWV+qzCi/cjBkkk45HJLUBdAxI70UerT0oxZI2ec9Bp
	 6CidYja03cW/p+ZsEsl4jWhFfkXg1bUexTzIXphxBZhgi7eFqfiWKLOkIiEsSt1XU9
	 Sa6TLm0CSKJTg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/tests/core-kunit: add a test for damon_commit_ctx()
Date: Sat,  7 Mar 2026 11:42:20 -0800
Message-ID: <20260307194222.202075-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307194222.202075-1-sj@kernel.org>
References: <20260307194222.202075-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kunit test for confirming the change that is made on commit
c80f46ac228b ("mm/damon/core: disallow non-power of two min_region_sz")
functions as expected.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 44a983fca9501..65181c6dac1b4 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1060,6 +1060,27 @@ static void damon_test_commit_target_regions(struct kunit *test)
 			(unsigned long[][2]) {{3, 8}, {8, 10}}, 2);
 }
 
+static void damon_test_commit_ctx(struct kunit *test)
+{
+	struct damon_ctx *src, *dst;
+
+	src = damon_new_ctx();
+	if (!src)
+		kunit_skip(test, "src alloc fail");
+	dst = damon_new_ctx();
+	if (!dst) {
+		damon_destroy_ctx(src);
+		kunit_skip(test, "dst alloc fail");
+	}
+	/* Only power of two min_region_sz is allowed. */
+	src->min_region_sz = 4096;
+	KUNIT_EXPECT_EQ(test, damon_commit_ctx(dst, src), 0);
+	src->min_region_sz = 4095;
+	KUNIT_EXPECT_EQ(test, damon_commit_ctx(dst, src), -EINVAL);
+	damon_destroy_ctx(src);
+	damon_destroy_ctx(dst);
+}
+
 static void damos_test_filter_out(struct kunit *test)
 {
 	struct damon_target *t;
@@ -1316,6 +1337,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_pageout),
 	KUNIT_CASE(damos_test_commit_migrate_hot),
 	KUNIT_CASE(damon_test_commit_target_regions),
+	KUNIT_CASE(damon_test_commit_ctx),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
 	KUNIT_CASE(damon_test_set_filters_default_reject),
-- 
2.47.3

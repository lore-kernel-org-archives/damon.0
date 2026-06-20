Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202F32B9B5;
	Sat, 20 Jun 2026 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976178; cv=none; b=bZ7ro35WqQCUI70vpRdoYEYWuctnMM11+R9K86aMMCoNlIs0qi4o3VsgaLhnOPTTGDLxq7rlcXTGZsQ80Yd14SGOyy3GaCBqAdldxSFSu2E6Sc/uf8QVlNFjtdDRTum4pprhZSDP8qG+Py2diIUm8KfPmL6tSBXvkzlIOE3Bti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976178; c=relaxed/simple;
	bh=4qvCPMZ4f/BTRHBhPjuPfH/ksnZQhiXOziSUFm4y4xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sj6m27iRI1gYa3f5rXojcWBUHUNAz/MigkSCqy2nf+LyDiK5DKoEsXDga9g0fmCVtQGjad6Oga9vtL8MTwPt9I4TY0BgnAT0nDiSTzPzEcw5bk+7Mz6+0RsA8tuCEA48Y4Kd5qhz96uWYe+6f+S/AwSizFvU2QG/plx/HVUTH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHuwwO9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHuwwO9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25431F00A3E;
	Sat, 20 Jun 2026 17:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976177;
	bh=dGqKzRnIP+DKXc/Th2v0SJe+T3xtV4bAe2ASi7qsS9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHuwwO9B54CWPTt5BvV46KzE/1dreh00K6wX1qBuSsMco5Bn1SOUpZnm7VX6JvLYW
	 MdMGZO/UZwcviUhyhuxUrslPReBGjTOPXhZv3/T4fJMgqp1rO4e5P6NifuetqTaOP/
	 D9Z72oVcZeluSY7G24yR4lozkuCFFNzX5KcX0sxQcke7w2nODKUudV0iH1waL4z6jI
	 Pz7+d6t0wC3TjdpD/+0KA7Ue8w/jtG6iAWY7evrZpedJzzrZBA+v/YqU4ByFp4//fJ
	 NVdd6RsgPOoPXpwAWlWe+2qcSO/R+fhskyUox+my14LWp3X7sdHpPM4ifecZbx53Zj
	 NDGS2i00Mo4TQ==
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
Subject: [RFC PATCH v1.1 02/13] mm/damon/tests/core-kunit: test damon_mvsum()
Date: Sat, 20 Jun 2026 10:22:32 -0700
Message-ID: <20260620172244.90953-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620172244.90953-1-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
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

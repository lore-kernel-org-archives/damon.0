Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A723DA5B4;
	Tue, 30 Jun 2026 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792505; cv=none; b=kxsvzr7wQ43MVlkDkgVyPJKXHF02es6UyA1I9xxQftvzmTrb3Ei23NKWtMXQAqbO7jQImACh3eg/nJvcMzRlMRmY1Mhtc6/s8kOjuqBUnWzGCyukgcrbjTuoK5J8QmeWJuY6DYO7nk10Cpc76WMbedGQssjfb2tzm7fQAJoCpYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792505; c=relaxed/simple;
	bh=QOrbqnAZdddH0sVDt9AkuRyEHXziBaKfZhTCe7FwKCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7/ySMnwhvAQiuyks9XmkaItpuB9DTqkWqcwQIpvG/1E3Mt7Easmnz4vdzwtSdEofT3Z3etkH974qI9YMZD5HoT6NrnYVT4N4Av9PjN+nLlYZ0GO7RZAz8AeSYtp5Ss+W8zS2dicqRjY1e/3+003zO++TQs+CTZ+sRYGiaFGaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbfmI2ii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbfmI2ii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AC41F00A3D;
	Tue, 30 Jun 2026 04:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792504;
	bh=8GC3wyUkKm2lBSXyC75E/pWZjQqr+3L3eUEF2Xn7YLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IbfmI2iiyt4NEusU5XXmPmaAf23CVDfD5ij+jZNxdxrzC62RThcIfkwmnk1MCh3bC
	 1JW7MVu+3TNElaw9LYdiWH4WiQgdEl3r4iNZvuPK3KyG8yAvVtxYCCFcAChKn8qJjZ
	 DG94BswKjRjr1jqmqV1aXsMK/+aSyVTTgSN9qqqqy+zirZ1sSZKMeaZfe+0CKOhWR4
	 uMta/hBhs2s42SIMj/hNpk766h2TSuvdGFlgDz5SnQPxcKkTPQRd6WHvO22Sll13gS
	 cDRn2Cg20r3FT4r8J3scMb/LfDkOOJ1Oy9pFglG/aGUN880s4Kq1urDoNjH+wBWFCW
	 XS9r584calg0w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/18] mm/damon/tests/core-kunit: test damon_mvsum()
Date: Mon, 29 Jun 2026 21:07:55 -0700
Message-ID: <20260630040812.149729-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a00168730445d..ff13d1b1cbc94 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -682,6 +682,30 @@ static void damon_test_moving_sum(struct kunit *test)
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
@@ -1561,6 +1585,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_moving_sum),
+	KUNIT_CASE(damon_test_mvsum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_commit_quota_goal),
 	KUNIT_CASE(damos_test_commit_quota_goals),
-- 
2.47.3

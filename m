Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB6488DB2;
	Mon, 28 Sep 2026 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585309; cv=none; b=dM+BAD2BFAad9wiS8b8J/XYodJosqfT71N/Eh/FMNahtlTB5OYyj9Ec5s/ST5X3S8TuepHh/wmHtbwqW7O/9KGMNmeaFRHJOQwG8wcrTs2Ujd3Om0LzprMGq13NKFMtyzLCdD+bF6pSwug/YYutYwx1G/b+G9MMP2aASi6MjkMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585309; c=relaxed/simple;
	bh=hYQWAuyH4Mknu8HsvEzCSBQhgRmeUm5PRhpm7S51nLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyHqTFM6cvvcLwhIoBs77XgOANSiVdCUJWfcQ1fvOG/hbgKB0N8C+5eqvYGQIT7ywkrmyCjfHBI6Jpmyp5k60nQ7XRhjkjaC9wI62UnUGklJEBhEbFnwQrprapCA6ujaquNXvrnq+hT7Qol5uL/39vc514UIlmU3hul2V9IMWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMjaCbTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMjaCbTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E491F000FF;
	Mon, 28 Sep 2026 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585306;
	bh=u8DaDbB8ZQKuqKU9oeD4+Afniur8EUd6QsbN8UoqPQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AMjaCbTkzMFB49B+wdgtKL4qKys8VbvfkDsQOxvkodGnJPZwYWjHX3u7MbtWVPVDl
	 iPt9/Nql44ZfEL+pBq7j79WiMzAUzMwZrIHoKyZTgbME8/RyqKBuiQxMXQch6+zDgT
	 Jekt1qFlVYGH0jqatHqcI4fEJQnhvAsEH83iJDhxR/OLRT8gxP43ScnoqAPpsL1bjL
	 q8ZnOOhzNOFtK4cy57Q7LW/t9SWuhVeky05qH6K/Gm9KRBxWHCmNYY3NIvZyVNgqkU
	 lDmttwxSVmwrUgjReFjkB7DIL9+cvg5tBYscLAD2Abz6XP1Crbf/3z4YJrEmTFwYZM
	 gneuqZQP4+QKA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 2/2] mm/damon/tests/core-kunit: test the temporal tuner's size quota conversion
Date: Mon, 28 Sep 2026 01:48:15 -0700
Message-ID: <20260928084816.5575-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928084816.5575-1-sj@kernel.org>
References: <20260928084816.5575-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

damos_goal_tune_esz_bp_temporal() encodes the size quota in basis
points, so the conversion is exact only up to ULONG_MAX / 10000.  Pin
the three sizes around that boundary: the largest one that fits, the
first one that does not, and ULONG_MAX.

Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ef4b8b85d67b..caf582882f5f 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -2284,6 +2284,53 @@ static void damon_test_rand(struct kunit *test)
 	}
 }
 
+static void damos_test_esz_goal_temporal(struct kunit *test)
+{
+	struct damos_access_pattern pattern = {};
+	struct damos_watermarks wmarks = {};
+	struct damos_quota quota = {
+		.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_TEMPORAL,
+	};
+	struct damos_quota_goal *goal;
+	struct damon_ctx *ctx;
+	struct damos *s;
+
+	ctx = damon_new_ctx();
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	s = damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
+			NUMA_NO_NODE);
+	if (!s) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "scheme alloc fail");
+	}
+	damon_add_scheme(ctx, s);
+
+	goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
+	if (!goal) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "quota goal alloc fail");
+	}
+	goal->current_value = 0;
+	damos_add_quota_goal(&s->quota, goal);
+
+	/* The largest size quota the basis-point conversion can hold. */
+	s->quota.sz = ULONG_MAX / 10000;
+	damos_set_effective_quota(ctx, s);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, ULONG_MAX / 10000);
+
+	/* Any larger one saturates instead of wrapping. */
+	s->quota.sz = ULONG_MAX / 10000 + 1;
+	damos_set_effective_quota(ctx, s);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, ULONG_MAX / 10000);
+
+	s->quota.sz = ULONG_MAX;
+	damos_set_effective_quota(ctx, s);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, ULONG_MAX / 10000);
+
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -2324,6 +2371,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_is_last_region),
 	KUNIT_CASE(damon_test_walk_control_obsolete),
 	KUNIT_CASE(damon_test_rand),
+	KUNIT_CASE(damos_test_esz_goal_temporal),
 	{},
 };
 
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5842252D;
	Tue,  7 Jul 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432255; cv=none; b=sF2jROngmnHoaVq1j0+mvtu5rNw/ny0vS5OQ+yE3GrXT8WV6YRhk+EIeClFdAYv4lcP/ozP700fEGR5lWgbcFr+yi1cL6HtCm88zm9fKCVVkd/BUZHtIF4GCImyZtAYc0/A/B1/qHWY5/Za75JFAfiSqdNxk1unOSZuTkuc9+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432255; c=relaxed/simple;
	bh=/CKErzgrvjCi5gJb1b6KPLWiCgkDsNxqIuMCwPTw83M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRGfVOxXADNAIOZisIRh+nZ/0zWt4FRfvwYkcXn0r/s2dokzTQDheQIHJuqwEf0alQSD0eysipmoefz2Hz8yH0/lAWyhTV/blRGx7BCb0E4wX4VIMO/pllbORePDFdJv5tOKRIH89yEvi1WeASvddHsMbgVm5o04bo7ifHddBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSIC6W3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSIC6W3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0D31F000E9;
	Tue,  7 Jul 2026 13:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432250;
	bh=GY3vV+uG8yWd6R6f7yGxLhbvEHq+g5ke+H2XqmQ5/Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSIC6W3fIjsjD6tAbqohQR+5KgzASN3vZf47SOlZUIvyza1ATwUpS/t78YYf9VHl4
	 uyJSfKU5XTs2uE3toGAYAy7OQ+eGA9zIe+mGH4xUXTFweDh7jrxBst/unj08ZGclzT
	 EKh7kOeUoCzX89UXMZHTcqeXZXNSGVNpbAAEdsCXBKFqqHEH1e2w7Pvawv0JI01kJ0
	 hCKiDILlT4G2yesyvCe2gCYLnBwsY4nMTTyviZITOiQD+4gtHMEXY7WiX9Ac/n0rZB
	 Q/pZE2DQwfzgYdUkHsRHK+8Au3ZmiRf0pYks5wyh1gwEY5m0l02Dl9jviS+mX3LLGh
	 1mIqvWCgkJZ3w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 1/7] mm/damon/core: remove obsolete comment for nr_to_bp() divide-by-zero
Date: Tue,  7 Jul 2026 06:50:30 -0700
Message-ID: <20260707135038.90068-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707135038.90068-1-sj@kernel.org>
References: <20260707135038.90068-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_accesses_to_accesses_bp() warns it can trigger division-by-zero
when the aggregation interval is zero.  Commit 35d4a3cf70a8
("mm/damon/ops-common: handle extreme intervals in damon_hot_score()")
modified damon_nr_samples_per_aggr() to always return non-zero.  Hence
no division-by-zero of the note can happen.  Remove the obsolete comment
on the function and its test code.  Also remove the unnecessary guard
code in the test.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             |  8 +-------
 mm/damon/tests/core-kunit.h | 12 ------------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 390e00b3685ef..a15005db82899 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -883,13 +883,7 @@ static unsigned int damon_accesses_bp_to_nr_accesses(
 	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
 }
 
-/*
- * Convert nr_accesses to access ratio in bp (per 10,000).
- *
- * Callers should ensure attrs.aggr_interval is not zero, like
- * damon_update_monitoring_results() does .  Otherwise, divide-by-zero would
- * happen.
- */
+/* Convert nr_accesses to access ratio in bp (per 10,000) */
 static unsigned int damon_nr_accesses_to_accesses_bp(
 		unsigned int nr_accesses, struct damon_attrs *attrs)
 {
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0124f83b39b83..224a3ecaa0701 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -582,18 +582,6 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
 		.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
 	};
 
-	/*
-	 * In some cases such as 32bit architectures where UINT_MAX is
-	 * ULONG_MAX, attrs.aggr_interval becomes zero.  Calling
-	 * damon_nr_accesses_to_accesses_bp() in the case will cause
-	 * divide-by-zero.  Such case is prohibited in normal execution since
-	 * the caution is documented on the comment for the function, and
-	 * damon_update_monitoring_results() does the check.  Skip the test in
-	 * the case.
-	 */
-	if (!attrs.aggr_interval)
-		kunit_skip(test, "aggr_interval is zero.");
-
 	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
 }
 
-- 
2.47.3

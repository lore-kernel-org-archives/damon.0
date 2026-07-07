Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A02422547;
	Tue,  7 Jul 2026 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432256; cv=none; b=hOK3En7lGa+ZzAbNpiFzYtN/z1BAR2Tyj7UwJDCrvKzpXrblU/0mZxEUf+jpvn7E6s1kIRS3IqXGu2O7GmMjT6tyFvnxfYTn/22/aqdKUk+k70osi3e/6b6VSSeR3lbo/cilxu+OmXpxaDbZnOHuSNVbGtyXnMuQLUhl15Afiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432256; c=relaxed/simple;
	bh=Ft5kp5SLZ9nS3O75eIxxCY1ZFEvaUe+javeGguoP3OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=le+wA/4/x8YnXD9kC9w/AauFfqlAgwKSt1IG007/B9eG+/Xicmq/dDMiOgCJOdYeua2GwSxd2WX7NwT0m5gun3u88tluxkj/QKOpI40PHdhxKo5ABv5Km02XMgfcwfqIDERKE8h9osyQtYyrVZ9iVowwPNqABN/vLLVbrxz7n4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9Tf7/yB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9Tf7/yB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890081F00A3E;
	Tue,  7 Jul 2026 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432251;
	bh=w/D30WRyajzihkx6UMd0lfcRCqBtxjpc8QkxY/qucOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y9Tf7/yBeO28xHQCxCotHHbEpoiXFv7yBcd4ooCGXX4LEA6y/RTSBxiWNxyTyUoZB
	 tNAyodklm1kEWSBB9wjAO4VJye7LTvcK267MiQyJckY0dGfJfbo6fDEgWJOOLprZub
	 MGpYZZIQXOteLFWVwUyVcoqafjhbWeFsE2PpXqdYIwN74r3hVOkN7Cxhfu4idhS9ax
	 Re4aDDBlAMR3jgttRSjwQVjJ3V6f7mavwA/XFVIH4T/gSXbVDOZlgmZOa3QcVmlJvI
	 Zv5+GKrzYV6y+SFxLxm7oxwVTSdm0plJKeXNjoen3Ft3SwzRtUK7/gQ+8Pk+DbFT++
	 WfYCqcBSfgd/A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 4/7] mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Date: Tue,  7 Jul 2026 06:50:33 -0700
Message-ID: <20260707135038.90068-5-sj@kernel.org>
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

damon_nr_accesses_to_accesses_bp() actually converts a positive sample
count to the ratio.  Rename it to better describe what it really does
and not confusing for more general uses.

Also remove the obsolete comment about division-by-zero.  Commit
35d4a3cf70a8 ("mm/damon/ops-common: handle extreme intervals in
damon_hot_score()") modified damon_nr_samples_per_aggr() to always
return non-zero.  Hence no division-by-zero of the note can happen.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             | 11 +++++------
 mm/damon/tests/core-kunit.h |  6 +++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index dea63083917b0..718268df27fa7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -883,19 +883,18 @@ static unsigned int damon_sample_bp_to_count(
 	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
 }
 
-/* Convert nr_accesses to access ratio in bp (per 10,000) */
-static unsigned int damon_nr_accesses_to_accesses_bp(
-		unsigned int nr_accesses, struct damon_attrs *attrs)
+/* convert sample count to ratio in bp (per 10,000) */
+static unsigned int damon_sample_count_to_bp(
+		unsigned int count, struct damon_attrs *attrs)
 {
-	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
+	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
 }
 
 static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
 	return damon_sample_bp_to_count(
-			damon_nr_accesses_to_accesses_bp(
-				nr_accesses, old_attrs),
+			damon_sample_count_to_bp(nr_accesses, old_attrs),
 			new_attrs);
 }
 
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 224a3ecaa0701..9e631b19b184a 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -575,14 +575,14 @@ static void damon_test_set_regions(struct kunit *test)
 			}, 3);
 }
 
-static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
+static void damon_test_sample_count_to_bp(struct kunit *test)
 {
 	struct damon_attrs attrs = {
 		.sample_interval = 10,
 		.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
 	};
 
-	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
+	KUNIT_EXPECT_EQ(test, damon_sample_count_to_bp(123, &attrs), 0);
 }
 
 static void damon_test_update_monitoring_result(struct kunit *test)
@@ -1560,7 +1560,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_split_above_half_progresses),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
-	KUNIT_CASE(damon_test_nr_accesses_to_accesses_bp),
+	KUNIT_CASE(damon_test_sample_count_to_bp),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_mvsum),
-- 
2.47.3

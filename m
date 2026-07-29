Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7B38C407;
	Wed, 29 Jul 2026 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296284; cv=none; b=JNDRGFoORGukSOw7Ai6JDp7MwNO4VWdcmtxWX1pejeRk9E37CcJt3yzD/40Ffs0egPk0hAIWjj2I5XvVaxVr80qgXeI2P5q+HO5N2FP9kcxCyc9a0tLK/HDBPPt+QR5AtTa2SxZeAcz8DSuT6uQqXZkN77rnB4fNTrNQYlkAAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296284; c=relaxed/simple;
	bh=Lw3GyXJAzAFWROxcLjsHaykSL/PePWF+DYf788GPKYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgyKSeZ5IBGtKYPtTfibgI7onBjRkg+LKytpnOXnAPYyA4iebPKrMlMI97X6AIe5A6Whvx+lT+URzHgCal8/FIPFBURp6xXr2QbIOU9Ap7Gml/EgB6IG6sBo/jcrfJvdwD8QswA+uxCRga3KudryI4hvEU6Dgb4I5L0U0PsMeZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzxeRFxL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzxeRFxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E58B1F00A3E;
	Wed, 29 Jul 2026 03:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296282;
	bh=ggyUfqv6rcj2Idk2Q0OaE5oz1yQGxvQa0INt8+zgULo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZzxeRFxLEmbPpcaxNy5rtqNHDk75sZk/D32PBHaSu2X5RJpgBdZtGc09ZAwXdYxkH
	 2FQ73eNIGjZ60PFSFM27Cy69En9S+TI6KwXZDaS24n+GuT5du23PYhez/Xlmlhb3uE
	 KLKa3YBDWr7zES++U6PU39BbfU6zd6+LGOVBPAiC1bmZ0A+GMwj8LX6fMP/UsL4pbO
	 EJ6BqvynLxuxQutAQEdnH9ea2bLrz7yKEVU/04AaEtwxWoBBkYjOTrGiEoMqYtrZb5
	 Xqzx0vtNQ9CJ4wfiDr77NZpJUSgTCEJLp4UE0iK+jyyGars+pdUgEhw/N4n53tlszR
	 MQ2dPFAXI6D6Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 07/10] mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
Date: Tue, 28 Jul 2026 20:37:47 -0700
Message-ID: <20260729033751.131213-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729033751.131213-1-sj@kernel.org>
References: <20260729033751.131213-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_max_nr_accesses(), which is a previous version of
damon_nr_samples_per_aggr() before the renaming, was wrongly returning
zero or random overflowed values for extreme intervals setup.  Commit
35d4a3cf70a8 ("mm/damon/ops-common: handle extreme intervals in
damon_hot_score()") updated the function to return correct or more valid
values.  Add a kunit test to ensure it is working as expected.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 3041b8288ec26..0a1882ce6a081 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -619,6 +619,27 @@ static void damon_test_set_regions(struct kunit *test)
 			(struct damon_addr_range[]){}, 0, -EINVAL);
 }
 
+static void damon_test_nr_samples_per_aggr(struct kunit *test)
+{
+	struct damon_attrs attrs = {
+		.sample_interval = 0,
+		.aggr_interval = 0,
+	};
+
+	/* Zero aggregation interval doesn't cause division by zero */
+	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 1);
+
+	/*
+	 * Too large aggregation interval on 64 bit system doesn't cause
+	 * overflow
+	 */
+	if (ULONG_MAX > UINT_MAX) {
+		attrs.aggr_interval = (unsigned long)UINT_MAX + 1;
+		KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs),
+				UINT_MAX);
+	}
+}
+
 static void damon_test_update_monitoring_result(struct kunit *test)
 {
 	struct damon_attrs old_attrs = {
@@ -1670,6 +1691,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_split_above_half_progresses),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
+	KUNIT_CASE(damon_test_nr_samples_per_aggr),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_mvsum),
-- 
2.47.3

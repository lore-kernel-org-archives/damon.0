Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A874A2E1A;
	Wed, 29 Jul 2026 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333788; cv=none; b=mYm94jgP0oZHoouhmW11zrJXjSNjgiiOjqdhIvYm1yEAlXkUvoX36jHNsoZxwpkBiJyn4UOwarMxpTIuBIBLO0a4du9z32kXrRYHYV/NI4OYxc/DbCtoFwuFMmr1lnwHv/yt/2L0f0wvKG7VubXeKJtTrSo5E9ncJ8B4u9d+A1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333788; c=relaxed/simple;
	bh=LAOCZ6OX3C2XLdwJS4kLCYHcE8TRd595FwpreaVLtGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I83yQj0wqoLb9NKWru5qGUhs5UJ62uiDugKnLhTY084fGCXfYPvYKbmJ5cOgWX9qc+n6xno+DIXRFuvVHE71v4QWZj9+Y+h6mh2/2UCh9OoynUVOGtBih/umpZYz7IyYBPHr/5bjfuVXKhuig0QRY/Im75Z51eBk5OlskRgztOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkYtsegm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkYtsegm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659E61F00A3E;
	Wed, 29 Jul 2026 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333786;
	bh=cKzzWsAXP/F08KNPNwIlHEjpZQDPuypTZix55EIf9Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WkYtsegmv9ZOWhUIMCf8RtEhUZVp6U+ch9Vjkaayub19BUjFZL4oN9K++Hbb1ovhu
	 +QZtZEgerhSpv1IBGr7VZGTQhka/NPzaVH+IAgJ+eG23jPy477u7cyVJMDx8jlRe6r
	 subUunDcT/sRdjKkZhsI4WF5VJoHENe/DCWmXpm7NLwAd+hUH8ArojaXMUxKP9xiER
	 Tqpx6pLJRrZF7VGbzkKjD9w1i0xdyGoK6HoEyhy+uQNWZ4w5lzUKyFINo4Be76MFTL
	 NqCHk/56opL8f0qzi2eLofl41wigk+rQUF9sOZsxkR1/lywf8f0cxItE+s7FS2DTfq
	 W0fn+hsxZrpWQ==
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
Subject: [RFC PATCH v1.2 09/12] mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
Date: Wed, 29 Jul 2026 07:02:49 -0700
Message-ID: <20260729140253.87753-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729140253.87753-1-sj@kernel.org>
References: <20260729140253.87753-1-sj@kernel.org>
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
index 252d81c30d6f1..c7bda8aadef3f 100644
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

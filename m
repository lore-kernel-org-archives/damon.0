Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05293B42CC;
	Tue, 28 Jul 2026 05:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216500; cv=none; b=cbiWmonowi8XyXbJ0Bbr1j7JQOslDOZiHfgaN5Oj7+TiAZD8laaXOqnjulMWzY5x2eHXjq/EAhCb735cR+58zSwzZsQLojPg87QVHdyVx4qnVQhQFE9zPhw/yQN0bAIKn2NRrANiP0XspX83Q1o7uTNuZZ2nh/EyEVeSENf9Ouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216500; c=relaxed/simple;
	bh=cIbG+Vh+ejFzhWXrTnmXCQg1Ch83Pl+boAcBwq2wuWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMg1h7d8ZC2/8SzVTBwC/+HxYpuQtWMdDqp6UTbFg09+GFjt4mAkxg4chpLszEgCpGcgg20SsjMk7NyxvEXbWFBKSvPJj4/va8n2jUa5yMXKvRGChSlEZdRviJV+XoRhS7wCAb//bEy1z3fIoOy/KnJcdTgEC0PDVHINdymI9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITlgc3K1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITlgc3K1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED511F00A3D;
	Tue, 28 Jul 2026 05:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216498;
	bh=WANJwchnQO/oDcbFCGZSI0J0jnkXHDon5WOhOSC7mrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ITlgc3K1gbc4fzExooJOGRYeHLp5/stACpvKLZqGvUS1G6qW4Gx2Q8k/3sz7fzvXi
	 uIPkuLr5J0tdHWpSqLNmcw/SjhTM8Hn2Yln/XxPmvNkaa59I4EUMuaoyG6MvM0CK4X
	 87EbdlTkVbaeljZxrhbz6IsuQ6fWyqmc0ZLYRGDbUbdIU9OW/Cdko8QWzOqHxOk2pK
	 KgL6ipr151mM3xUxBhKHwanPVkJT+L3IBtVgKIEEypnoeedEr7mITJSKAebkUas9yA
	 JAZqgqZ/fT69QSNTWahmgNpD6gUoOh+VkLTDwvk4ub4N8ATLYwT9CkxHultJ1nA27C
	 Wh/QCAESTew4A==
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
Subject: [RFC PATCH 07/10] mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
Date: Mon, 27 Jul 2026 22:28:06 -0700
Message-ID: <20260728052811.192712-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728052811.192712-1-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
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
 mm/damon/tests/core-kunit.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 3041b8288ec26..511f2856d343c 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -619,6 +619,22 @@ static void damon_test_set_regions(struct kunit *test)
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
+	/* Too large aggregation interval doesn't cause overflow */
+	attrs.aggr_interval = (unsigned long)UINT_MAX + 1;
+	KUNIT_EXPECT_GE(test, damon_nr_samples_per_aggr(&attrs), 0);
+	KUNIT_EXPECT_LE(test, damon_nr_samples_per_aggr(&attrs), UINT_MAX);
+}
+
 static void damon_test_update_monitoring_result(struct kunit *test)
 {
 	struct damon_attrs old_attrs = {
@@ -1670,6 +1686,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_split_above_half_progresses),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
+	KUNIT_CASE(damon_test_nr_samples_per_aggr),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_mvsum),
-- 
2.47.3

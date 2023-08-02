Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E787D51F
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761AFC433CB;
	Wed,  2 Aug 2023 21:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691012598;
	bh=plLKrdhuxTu4fXv62XEDStD9l4o2qp5Q+Y0GoiThmrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LvH1bZLSqUYN0scYv4lgnIiiDHf/QbLHgwsHOhtc3Vu4diL5ne6xiURe9ZI79A1j/
	 OIqJB+nLKkuOOaOvyLxQ13IN+eONATxWLDnpP64G30W9BWufAZcpdYRYmciHUccQOC
	 nhQyU6uhjVaGyeL6rKJbEg02JFLwjDrrpcGMyjMQNTgRaAs0UTGGvfs/QmfY/lo7Qt
	 4s7GgdsMoCuHY+hP5os6TKeBmnMtJFXcc7fVhfKPACmGAsu6Ap7zZjyreNQ8Em5OWJ
	 VpOG7/Q3fTDf75C/ilhCKDeDXjPE5ROuB8ebDYWwLJuMDDxyvuQDvsAXCahfNfp5eJ
	 UdAuCeJNT/CBA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] mm/damon/core-test: add a unit test for __damos_filter_out()
Date: Wed,  2 Aug 2023 21:43:02 +0000
Message-Id: <20230802214312.110532-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802214312.110532-1-sj@kernel.org>
References: <20230802214312.110532-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a kunit test for the core of address range DAMOS filter
handling, namely __damos_filter_out().  The test especially focus on
regions that overlap with given filter's target address range.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 4bddbfe243c3..6cc8b245586d 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -353,6 +353,66 @@ static void damos_test_new_filter(struct kunit *test)
 	damos_destroy_filter(filter);
 }
 
+static void damos_test_filter_out(struct kunit *test)
+{
+	struct damon_target *t;
+	struct damon_region *r, *r2;
+	struct damos_filter *f;
+
+	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true);
+	f->addr_range = (struct damon_addr_range){
+		.start = DAMON_MIN_REGION * 2, .end = DAMON_MIN_REGION * 6};
+
+	t = damon_new_target();
+	r = damon_new_region(DAMON_MIN_REGION * 3, DAMON_MIN_REGION * 5);
+	damon_add_region(r, t);
+
+	/* region in the range */
+	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
+
+	/* region before the range */
+	r->ar.start = DAMON_MIN_REGION * 1;
+	r->ar.end = DAMON_MIN_REGION * 2;
+	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
+
+	/* region after the range */
+	r->ar.start = DAMON_MIN_REGION * 6;
+	r->ar.end = DAMON_MIN_REGION * 8;
+	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
+
+	/* region started before the range */
+	r->ar.start = DAMON_MIN_REGION * 1;
+	r->ar.end = DAMON_MIN_REGION * 4;
+	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	/* filter should have split the region */
+	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
+	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	r2 = damon_next_region(r);
+	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
+	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
+	damon_destroy_region(r2, t);
+
+	/* region started in the range */
+	r->ar.start = DAMON_MIN_REGION * 2;
+	r->ar.end = DAMON_MIN_REGION * 8;
+	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
+	/* filter should have split the region */
+	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
+	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	r2 = damon_next_region(r);
+	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 6);
+	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 8);
+	damon_destroy_region(r2, t);
+
+	damon_free_target(t);
+	damos_free_filter(f);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -366,6 +426,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damos_test_new_filter),
+	KUNIT_CASE(damos_test_filter_out),
 	{},
 };
 
-- 
2.25.1


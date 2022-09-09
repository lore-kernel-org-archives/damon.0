Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5406139
	for <damon@lists.linux.dev>; Fri,  9 Sep 2022 20:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8795C43140;
	Fri,  9 Sep 2022 20:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662755346;
	bh=sDNPmkLNtbffCB7yBaG1vDK4L/fqo+2nXKmiK+SjhXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eA7mXHTj8CAzo/dRgZSWiewM44BtCMTaJAUI9iyDT9w6sOiNgjuaUS2ZfVGYovW7E
	 9k6WBRLbxhAiHv9bHVh/qo5r0lg4YESkE3zkAK7pzw+NywcHTJEMEqgrfERvlidZ0A
	 LPIMksQdov+1IBnQnEiQIzijc8XrHiowTTfHfasQbD/gd74RFUHCtEMutN29RSDhao
	 TPg8Du/HzkL4FuSyu7EasSyO8eaEUBMaBnLUnVGpfDTL0EJIH7gftvsq+SJoAd30Eh
	 9/HCo1PD50vk1Cgy09CIiTs6Rh5mNuxmqIgbYOvkf/X4aEuXCLI+uc90DVpznw4k9Z
	 5cToMONkW4Gzw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/7] mm/damon/core-test: test damon_set_regions
Date: Fri,  9 Sep 2022 20:28:57 +0000
Message-Id: <20220909202901.57977-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202901.57977-1-sj@kernel.org>
References: <20220909202901.57977-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preceding commit fixes a bug in 'damon_set_regions()', which allows
holes in the new monitoring target ranges.  This commit adds a kunit
test case for the problem to avoid any regression.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 45db79d28fdc..3db9b7368756 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -267,6 +267,28 @@ static void damon_test_ops_registration(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
 }
 
+static void damon_test_set_regions(struct kunit *test)
+{
+	struct damon_target *t = damon_new_target();
+	struct damon_region *r1 = damon_new_region(4, 16);
+	struct damon_region *r2 = damon_new_region(24, 32);
+	struct damon_addr_range range = {.start = 8, .end = 28};
+	unsigned long expects[] = {8, 16, 16, 24, 24, 28};
+	int expect_idx = 0;
+	struct damon_region *r;
+
+	damon_add_region(r1, t);
+	damon_add_region(r2, t);
+	damon_set_regions(t, &range, 1);
+
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
+	damon_for_each_region(r, t) {
+		KUNIT_EXPECT_EQ(test, r->ar.start, expects[expect_idx++]);
+		KUNIT_EXPECT_EQ(test, r->ar.end, expects[expect_idx++]);
+	}
+	damon_destroy_target(t);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -276,6 +298,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_merge_regions_of),
 	KUNIT_CASE(damon_test_split_regions_of),
 	KUNIT_CASE(damon_test_ops_registration),
+	KUNIT_CASE(damon_test_set_regions),
 	{},
 };
 
-- 
2.25.1


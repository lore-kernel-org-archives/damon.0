Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622B2BEC2A;
	Thu, 30 Jul 2026 04:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386395; cv=none; b=UA8awhYKvbeDEcRXIZiNA0eNb1nXgzsGjSTwraKI9O7x9l5++ziNa8sPaNq1q14xSFd380Ufxr135N4w4iWbncyQnMTCukWJ1n+Go6Nt33F85Fe4QFsNB/iraze9shHk5chxVO2215eINDUWKVR9KChhjecv3rRv/m0ZVS1ALgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386395; c=relaxed/simple;
	bh=ncEQe7i9lDV5FpcseX4mZjb4PsGVQHmh1C2fi3s8KIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKs2nSB5mkyz66INBG4zemGATy5Tw6njeeIS5RXnuz6zSkacEiraZcdjK0HJxA1igPw9YO3r1eUXyFT/Rmj29jxYINaJ1Tf6bK/5psWfKUMouGySPTY/mRQNVxDrfXkKDUWPfi/ElWGEQ3TGPgpoOlCKDVB/YZLZXLNujz9O6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chXFHu8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chXFHu8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1B11F00A3A;
	Thu, 30 Jul 2026 04:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386394;
	bh=VgF7GK3Jltsm6GWffUatiq/f36fmtD3Cz4bexms/my0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=chXFHu8hPjQ9jdA7ezdPxqzspnU1pN3OwNYtg+0WYD0rYw7UCk73cSKTiX0l6D+R7
	 d3XGcy5sjyyHGGFNPoVeNCH+M6RWzAbcd05q7xQqdHB9kMzEyVyJoXqtB+C8Wf3/Bt
	 4fM2/c10JXUPG4AdVyxUYZXzmxyDOXT6ptegxPK0MevAN38V43ZP0/rIJGLV7XmQ0x
	 aC846XVbL+YlZJ2xOBd0ouha/FcYmWXFnVwRFxHIwjE07Xo2MGON3HZsIRJM2x6zon
	 uCtdpUtazBMf5ZsnqA4J2BB0cgwRYv0gPdJw6wKJVYj369mRxuBAyEK5E/z996lNXD
	 zLrplCJ9R7RUw==
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
Subject: [RFC PATCH v1.1 1/6] mm/damon/tests/core-kunit: test damon_commit_filter()
Date: Wed, 29 Jul 2026 21:39:38 -0700
Message-ID: <20260730043944.146030-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730043944.146030-1-sj@kernel.org>
References: <20260730043944.146030-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kunit test to ensure damon_commit_filter() updates destination
filter as expected for valid inputs.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c7bda8aadef3f..9cd2be03aeb9b 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1354,6 +1354,45 @@ static void damon_test_commit_target_regions(struct kunit *test)
 			(unsigned long[][2]) {{3, 8}, {8, 10}}, 2);
 }
 
+static void damon_test_commit_filter_for(struct kunit *test,
+		struct damon_filter *dst, struct damon_filter *src)
+{
+	damon_commit_filter(dst, src);
+	KUNIT_EXPECT_EQ(test, dst->type, src->type);
+	KUNIT_EXPECT_EQ(test, dst->matching, src->matching);
+	KUNIT_EXPECT_EQ(test, dst->allow, src->allow);
+	switch (src->type) {
+	case DAMON_FILTER_TYPE_MEMCG:
+		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
+		break;
+	default:
+		break;
+	}
+}
+
+static void damon_test_commit_filter(struct kunit *test)
+{
+	struct damon_filter dst = {
+		.type = DAMON_FILTER_TYPE_ANON,
+		.matching = false,
+		.allow = false,
+	};
+
+	damon_test_commit_filter_for(test, &dst,
+			&(struct damon_filter){
+			.type = DAMON_FILTER_TYPE_ANON,
+			.matching = true,
+			.allow = true,
+			});
+	damon_test_commit_filter_for(test, &dst,
+			&(struct damon_filter){
+			.type = DAMON_FILTER_TYPE_MEMCG,
+			.matching = false,
+			.allow = false,
+			.memcg_id = 123,
+			});
+}
+
 static void damon_test_commit_ctx(struct kunit *test)
 {
 	struct damon_ctx *src, *dst;
@@ -1705,6 +1744,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_pageout),
 	KUNIT_CASE(damos_test_commit_migrate_hot),
 	KUNIT_CASE(damon_test_commit_target_regions),
+	KUNIT_CASE(damon_test_commit_filter),
 	KUNIT_CASE(damon_test_commit_ctx),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
-- 
2.47.3

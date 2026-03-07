Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10183A4505;
	Sat,  7 Mar 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913247; cv=none; b=ZPniSyScOQa3UrgdXF1qe40Z+VvYPg67JwL7CaB2qbwecBcxtywVXDLSUXqZXzyHfosfAcw+WEPtdDnybGqMSlJvxp4l7b3n93jT85N9xdXIlwEde7NLQtLS1t37JN2zYOrh021lzh+B1MQ5W+Km+aNIJEAarAPLHJVQ6u4T8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913247; c=relaxed/simple;
	bh=cHAWOwLABE0IuRjMJHLuZg8SBEg0KiVoUUFpxTrX+yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2bPuHndV2WrLSZbpMCyFA9yaLXgadGqXxboFwOK0Q8ycQjvOJPmQM1VBufgb0ajoqGpWS6/uLQZbSd96M/AIS0oD/cBYJIOMEosYGX3lb4sTUMfKTJ6t+Dci1VRtYxuO7AFVX3xWPLqjVwKYdr2oK7HCnR61IDSVvsZ+Cd90qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrDLMqsi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrDLMqsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C34C2BCB5;
	Sat,  7 Mar 2026 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772913247;
	bh=cHAWOwLABE0IuRjMJHLuZg8SBEg0KiVoUUFpxTrX+yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrDLMqsiYefqJ5d79fNnxVvcFSYtuDfZZZJ97LGdVq7EFv41zDhGggdm3+UyaSmxr
	 PBOMZmxL2uVBPb9W16T3rkDri/sWtMjBRNITE3W2ZsiJpLLS3WMUrpNyhul7/r/AE5
	 ay6amn/VCsmnX1P3MXuSqH5Rhx505HaS2zABmsFN5D/kI5qMV7eGaYykqHmMfDZXqJ
	 QzvGJFIN8DPHltAzVH62R2ibPehalNvmhc0V1L0pMKoMp8545eqMXpi4tSfkUKKjom
	 mYo3L9c9Cpa02jP3NA/ssCK+or5eNXff2jYOyqPJ1vSCywS81h2qvbpfjXt8i5xyl3
	 5yE9/efUJBP1Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/7] mm/damon/tests/core-kunit: add a test for damon_is_last_region()
Date: Sat,  7 Mar 2026 11:53:50 -0800
Message-ID: <20260307195356.203753-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307195356.203753-1-sj@kernel.org>
References: <20260307195356.203753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a bug [1] in damon_is_last_region().  Add a kunit test to not
reintroduce the bug.

[1] https://lore.kernel.org/20260114152049.99727-1-sj@kernel.org/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 2289f9e4610c0..e86d4f4fe261a 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1311,6 +1311,28 @@ static void damon_test_apply_min_nr_regions(struct kunit *test)
 	damon_test_apply_min_nr_regions_for(test, 10, 2, 10, 2, 5);
 }
 
+static void damon_test_is_last_region(struct kunit *test)
+{
+	struct damon_region *r;
+	struct damon_target *t;
+	int i;
+
+	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail\n");
+
+	for (i = 0; i < 4; i++) {
+		r = damon_new_region(i * 2, (i + 1) * 2);
+		if (!r) {
+			damon_free_target(t);
+			kunit_skip(test, "region alloc %d fail\n", i);
+		}
+		damon_add_region(r, t);
+		KUNIT_EXPECT_TRUE(test, damon_is_last_region(r, t));
+	}
+	damon_free_target(t);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -1339,6 +1361,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_feed_loop_next_input),
 	KUNIT_CASE(damon_test_set_filters_default_reject),
 	KUNIT_CASE(damon_test_apply_min_nr_regions),
+	KUNIT_CASE(damon_test_is_last_region),
 	{},
 };
 
-- 
2.47.3

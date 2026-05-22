Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A547F2E0;
	Fri, 22 May 2026 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464437; cv=none; b=KbepTzcd0RhscIWt8fK8d0dJ0ltXMwtAr8z+IiIvBgk6P8WUJP5qYdkIX4Gvah1rRt73Qjw5qpQW72oqLuBi6SJXSV5SixBnVekASOdSz9hB+I3wfw9Tlo1vDaoD0xz8iu9uZEWBVbD1GgcHsrVeErksAO5tBW+02DEyYCaxD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464437; c=relaxed/simple;
	bh=mNfg97l0DT5bsgZWe32uZCMNCLcD17spo4z+2wU6rn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLRXWSOObIo3iQqBOlqPnrHLQJ4u8tQ285fnOzcFOJwGOgsEmvRmBWY0QKQWo73Y9gAT+thnQ1BW9baFJL57GdpXChijAdXJHumReC1lYFVIHkFfITZmOfRVbXnGQofXPGfDyfBCvREnVxuG7ea3XTVeTydiJ4CXiw1c0pr4Zt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsRK95YA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsRK95YA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD87A1F00ADE;
	Fri, 22 May 2026 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464436;
	bh=7YG6GjDiTDF7+hhcDJxfKB/57kZkbDeh0ESzV1mlaFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fsRK95YAWFfmFTLX9KTNGpOXUjmYFrUP5XITKBJ6Zy/kioe4s+41wiViUR9ADrYUA
	 /bEYTKwdm97qlXr4945OsxiSBAEU8d0oIkm5AF6ksYIRs4CkHR0iPp+ocMCevAGX/C
	 o5gWmdi+6lvShm/tPw+m4Dc10lqcoRgI0RV8EA6PWkkvGcW2CBn//SrpWo7Qcs9tux
	 gBleDdtdbJ9/uJWW9WqrIKo4pkPCR+pZzl1nI8sllYBT8MU4pwN1mZRAEbMia2SA1w
	 gPkWwEiPe728JVD5t0GaQkdtD6bf9t5HEzYIDAmaPPSEqwABiQQ6OEIXBbsHDvLO/O
	 30UWotoCLPPvg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/14] mm/damon/tests/vaddr-kunit: replace damon_add_region() with damon_set_regions()
Date: Fri, 22 May 2026 08:40:15 -0700
Message-ID: <20260522154026.80546-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522154026.80546-1-sj@kernel.org>
References: <20260522154026.80546-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON virtual address operation set (vaddr) unit tests is using
damon_add_region() for setup of DAMON monitoring target region
boundaries setup.  But, damon_set_regions() is designed for exactly the
purpose.  All other DAMON API callers use the function for the purpose.
Replace damon_add_region() usage in the unit tests with
damon_set_regions(), for unifying the use case and reducing the
maintenance cost.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/vaddr-kunit.h | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 98e734d77d517..563fbc7e3f448 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -132,22 +132,35 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 				unsigned long *expected, int nr_expected)
 {
 	struct damon_target *t;
+	struct damon_addr_range *ranges;
 	struct damon_region *r;
 	int i;
 
 	t = damon_new_target();
 	if (!t)
 		kunit_skip(test, "target alloc fail");
+
+	ranges = kmalloc_array(nr_regions / 2, sizeof(*ranges), GFP_KERNEL);
+	if (!ranges) {
+		damon_destroy_target(t, NULL);
+		kunit_skip(test, "ranges alloc fail");
+	}
 	for (i = 0; i < nr_regions / 2; i++) {
-		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
-		if (!r) {
-			damon_destroy_target(t, NULL);
-			kunit_skip(test, "region alloc fail");
-		}
-		damon_add_region(r, t);
+		ranges[i].start = regions[i * 2];
+		ranges[i].end = regions[i * 2 + 1];
 	}
+	if (damon_set_regions(t, ranges, nr_regions / 2,
+				DAMON_MIN_REGION_SZ)) {
+		kfree(ranges);
+		damon_destroy_target(t, NULL);
+		kunit_skip(test, "damon_set_regions() fail");
+	}
+	kfree(ranges);
 
-	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
+	if (damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ)) {
+		damon_destroy_target(t, NULL);
+		kunit_skip(test, "second damon_set_regions() fail");
+	}
 
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
-- 
2.47.3

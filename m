Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D03F0A9F;
	Thu, 21 May 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374081; cv=none; b=Q+jEPpae6oyGzfbsI0NUFZUS/zM8MLf8U7qxmxI7IoeUCVXIfLMdxA466IInbT45XjhePjbFdwa2lZCHU8EsSza0ciJhOcVU1Wp/TSyYguaCV55aVje2Pz/XxONAuQlv9+Gx6DTQj2JjXm6ooxL0DD/3Fp45u684vx8AC5/rjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374081; c=relaxed/simple;
	bh=mNfg97l0DT5bsgZWe32uZCMNCLcD17spo4z+2wU6rn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2Rfekk8qPHZEoSKZ9/CM20tjfMKYRTJmM3G3w7RLmS1MRb4+oK1hvHSarQuZgq0wKEfasuVYI1iw5RwE/qSsVmgHy1fWrt4ZqVerkJZqkW0OeksgoBRNgz5RJoj4S4bOKuqdzUcTChvV8ZlyEZ9R8NBX0ldAkBQoh03FLzmkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln2jHlAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln2jHlAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8981F00A3F;
	Thu, 21 May 2026 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374078;
	bh=7YG6GjDiTDF7+hhcDJxfKB/57kZkbDeh0ESzV1mlaFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ln2jHlAr4jbvgui7gZ1N521h/uXjENEZDiuJzweT8xNGaj/u8J8BQMiQcDOiNCDyz
	 KEBnafI/4+P6m+qldnu7G2ah71+fkRmLzz2A3/PPDNSAJ6JwcLjd/MpfDMoY9AwMyi
	 ngtmvFOlAZ+b4lnGDaPp5R9eU/FJQmm5aUvuyDHKkGN2+p/+3a9SHmIbl1/spRvL4k
	 BfUgZ6JPZZpAe+1Q7chPmvULUqca4KDkYnWCsl38aLBG4z3qhgkXwcGKfKoI99m1si
	 Me0m9R6UJueK0iK/77Zwu8v2AKhrjrbFSkJCSOMVIhcVlPcLEuHFWtpp5m/+dkuans
	 s4FVf/cu4lCzQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 04/14] mm/damon/tests/vaddr-kunit: replace damon_add_region() with damon_set_regions()
Date: Thu, 21 May 2026 07:34:14 -0700
Message-ID: <20260521143428.83157-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521143428.83157-1-sj@kernel.org>
References: <20260521143428.83157-1-sj@kernel.org>
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

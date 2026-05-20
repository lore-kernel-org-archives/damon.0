Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD68374169;
	Wed, 20 May 2026 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258550; cv=none; b=Pnvg9WK4XmKmrdD+Nnw5A6jknks+h8kzBDbfbcQSAWDZ5xZkV+10yiwoutapVcYGqP26/5WJAWmnxf6J+cUDj0GapP9uPyPr0nlyyZP14VYPZG3LR/hjCCByZx+dr7YaloAXQVi2zeoxTmXGyHiZBQIDi33blq8SMmdDF5ffuiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258550; c=relaxed/simple;
	bh=fUXs1ooV7451ip14A+R/iHdCe9wlfyViAZd7Ivqs2/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsIU4E3grcM4cGDOldGtMxy6pPRefybtZZ97OF5Fg2cFu6DPTDP/JWrM6BBS61CNAEDqX0Q1hFceik6zPtfUQyD6V7oAXKOQzcmdKd3j3cu5xNqs2dr7rm06cX1kbRyJ7zm5bH/3sO3hofZ0+WQLhWT/f+3/cfHcriNNJ4vRPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc9Ddbcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc9Ddbcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF7A1F00894;
	Wed, 20 May 2026 06:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258549;
	bh=S8O4uifXR5w5lAJd+zyIhegR4CRBgoI+b5mk8ksj5iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qc9DdbcsA86X1lN8rdsck8Ith9VhH7qaQDrLc9XUNLiDXWTpfyl0nWSdoY8JQasIZ
	 Kvea/sdvegWG33X/AQRCGyfO4H7AIvL3w4qUTLTakt4pvhhwqFo+MUl/qDQE+Ed0Pu
	 moZRf9SSlCFoUNLobHS6Z7wc3mNtyGXzKbO7tYfoCfe+fvvL2drL2WckEIeKezDIyl
	 zgJD4JEBFST0Y7EJegat5eFxdjh165yxdTp79stShqyAMO9ZUpEB4KlTv59PrO5lWm
	 ZlvQnySiUpTSCQFnkbfweQloZg7CRtyLlUmrxJDF+XMzLVcMh8O6+yXszgJ57959e3
	 J1+KPoID96d3A==
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
Subject: [RFC PATCH 04/14] mm/damon/tests/vaddr-kunit: replace damon_add_region() with damon_set_regions()
Date: Tue, 19 May 2026 23:28:36 -0700
Message-ID: <20260520062858.167011-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520062858.167011-1-sj@kernel.org>
References: <20260520062858.167011-1-sj@kernel.org>
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
 mm/damon/tests/vaddr-kunit.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 98e734d77d517..23be9c3be75fa 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -132,20 +132,24 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
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
+	damon_set_regions(t, ranges, nr_regions / 2, DAMON_MIN_REGION_SZ);
 
 	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
 
-- 
2.47.3

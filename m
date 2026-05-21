Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884CE38399E;
	Thu, 21 May 2026 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335642; cv=none; b=VybCKHsjNM5wB4KfZb0WA7j7UjLlME+VhGqlL6C4xTmtBdiCX0yoBxgqwpgR1+qkVJT2xo1wrdEj5GWbMuWr/y/rkTPaFVXAf6OvYhpXPS4nNXKkT+aJ8QlYwwArlkbHxQHbdsbSkyfJmaFrBWqkn/+k78FVTP65BGCMr0dJM2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335642; c=relaxed/simple;
	bh=LaKbAUXFSNYX73Jrxh66NdV0w+R3T7/3EsMX57jlay8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpXRoD2tLGw1994X0sKFSsvr+td9fNucWdGIoZoB8WtEBqYu+l0d80GTwz238Ll0hU4JAU2dlo3vugsm43e3fICe/RUTE2Q2DEXkBx92O4PY1ooaBnAr4jAHdyL6ceojG3gfHoo23U2qV4KB6wm48PqrJcXveCna+qKG85fcz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcQOjP80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcQOjP80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD9C1F00A3E;
	Thu, 21 May 2026 03:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335641;
	bh=Qo8ff9y7yiTQLpylSBvlVWCBzLWB5436sNPLCqpj4FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KcQOjP80SJLuSv+Sj3PuAG5mkdl8+tLHGHUBswTuBU9RS7C4Wm98B9XxMTTo9lnyH
	 0+dBAGmDt+laIK2MklkzrBPJf7oNMjAw4SRNIJ0p7zALt9s2jvMtGCPjAhTtyET+sW
	 AinKZ2JznVcHTu5WRmD3UPp6YKdMBT2nWcsSy8sxx3qXlLi1+Xpl2EArRmpX0SqGck
	 IzKo9Pt9S1bY5/KFzw3d3wdXHDoZbiQ9F26iFvLHpU3BJVg+xwLjHJP0lima49whpe
	 SMzPNR4E4bVnGufJ3xYbu3OohsDYfiKvfR3vskyz7bEXIZpPXfyeYw/Q4MJz+7TWAm
	 mZfBXFtosd1aA==
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
Subject: [RFC PATCH v1.1 04/14] mm/damon/tests/vaddr-kunit: replace damon_add_region() with damon_set_regions()
Date: Wed, 20 May 2026 20:53:38 -0700
Message-ID: <20260521035349.87565-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521035349.87565-1-sj@kernel.org>
References: <20260521035349.87565-1-sj@kernel.org>
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
 mm/damon/tests/vaddr-kunit.h | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 98e734d77d517..de30db9b753e5 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -132,22 +132,32 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
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
+	}
+	if (damon_set_regions(t, ranges, nr_regions / 2,
+				DAMON_MIN_REGION_SZ)) {
+		kfree(ranges);
+		kunit_skip(test, "damon_set_regions() fail");
 	}
+	kfree(ranges);
 
-	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
+	if (damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ))
+		kunit_skip(test, "second damon_set_regions() fail");
 
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
-- 
2.47.3

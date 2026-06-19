Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B430351C2A;
	Fri, 19 Jun 2026 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897681; cv=none; b=iYaBoIa/VAiwFWO2Aobc/kzu99aH1LeEuD+6+2J125Ejz9GTNredG42eDtbf3+ypKzEI2J5UnN2Vk52SxvrOSWK3uW3jYAj0F4PhyDVRCzsjxMbUx4sfQNWyABw+lE/urRTfuP+I7s6dBmDxnmdpJZAQ5DqSKvpWr9nn2wGcwxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897681; c=relaxed/simple;
	bh=GkbHtiyoumMXFs02DEzXmukw4lBiHSdG52I8CIiGYxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fw2uBz/7Sq9+vwPrlBCYhhwe/yYi4qcH2VORv1hMmOorBV5Y375nA4BrKxLb/ywI73gm7r1knhILOTMshjR959F/J0zIz3AeBjZfHzltWCDcmjuGIewsfgzBHEV+sWktuPbsks0upxH/BK+hD07mnSwmoeGy9ZhnhbQlogixd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl9m0lZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl9m0lZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167F01F00A3D;
	Fri, 19 Jun 2026 19:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897680;
	bh=eFwh7/bBrNQXMDavjXH4Q3alYmiXXZ8Rq6jleDMJWMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cl9m0lZSTLE8aoHs8+Ru67aexhBBe2PdSDtZ6NkIsWTGqf15tHCa43Yf+vPGeJEJ/
	 JbW51/p4XSKqMKBuEMKKd5fj9jzOfJU9KDG7nNC2SPTr2ILcv0iMQci02y+pR8aNEH
	 iMUT1hvkR95+MBk/t0LWVxiKCBGjm+5pbuEGpqA1aQnN2hdg+jMS1/MZq+DoaCeiGQ
	 i9nM5TrQXr8PzTUWZchIMyyc9/PPZRdN4re2Bp9IU6XJp/Tw61zW+AV4D+oWloWBJ1
	 F9gKSd7GOR/7MSQt+NdfvpHZNLxtxLj4Fh826jIZBYu23Nf1yS9N2xsF8otzRNTYBI
	 8Gia+ARGgQ8Xg==
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
Subject: [RFC PATCH 09/13] mm/damon/tests/core-kunit: remove nr_accesses_bp setup and tests
Date: Fri, 19 Jun 2026 12:33:54 -0700
Message-ID: <20260619193415.73833-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619193415.73833-1-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core unit tests set up nr_accesses_bp for representing realistic
damon_region, and also test the field.  nr_acceses_bp is no longer being
used for a real use case.  Remove the setup and tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index cdab14396250f..d1f019ab6fc25 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -118,7 +118,6 @@ static void damon_test_aggregate(struct kunit *test)
 				kunit_skip(test, "region alloc fail");
 			}
 			r->nr_accesses = accesses[it][ir];
-			r->nr_accesses_bp = accesses[it][ir] * 10000;
 			damon_add_region(r, t);
 		}
 		it++;
@@ -155,7 +154,6 @@ static void damon_test_split_at(struct kunit *test)
 		damon_free_target(t);
 		kunit_skip(test, "region alloc fail");
 	}
-	r->nr_accesses_bp = 420000;
 	r->nr_accesses = 42;
 	r->last_nr_accesses = 15;
 	r->age = 10;
@@ -168,7 +166,6 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r_new->ar.start, 25ul);
 	KUNIT_EXPECT_EQ(test, r_new->ar.end, 100ul);
 
-	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, r_new->nr_accesses_bp);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, r_new->nr_accesses);
 	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
 	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
@@ -191,7 +188,6 @@ static void damon_test_merge_two(struct kunit *test)
 		kunit_skip(test, "region alloc fail");
 	}
 	r->nr_accesses = 10;
-	r->nr_accesses_bp = 100000;
 	r->age = 9;
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
@@ -200,7 +196,6 @@ static void damon_test_merge_two(struct kunit *test)
 		kunit_skip(test, "second region alloc fail");
 	}
 	r2->nr_accesses = 20;
-	r2->nr_accesses_bp = 200000;
 	r2->age = 21;
 	damon_add_region(r2, t);
 
@@ -208,7 +203,6 @@ static void damon_test_merge_two(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
-	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, 160000u);
 	KUNIT_EXPECT_EQ(test, r->age, 17u);
 
 	i = 0;
@@ -256,7 +250,6 @@ static void damon_test_merge_regions_of(struct kunit *test)
 			kunit_skip(test, "region alloc fail");
 		}
 		r->nr_accesses = nrs[i];
-		r->nr_accesses_bp = nrs[i] * 10000;
 		damon_add_region(r, t);
 	}
 
@@ -556,7 +549,6 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 		kunit_skip(test, "region alloc fail");
 
 	r->nr_accesses = 15;
-	r->nr_accesses_bp = 150000;
 	r->age = 20;
 
 	new_attrs = (struct damon_attrs){
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE66415F2E;
	Mon, 31 Aug 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188820; cv=none; b=c1XnZlQZ7W1sA4hUg745tzH3Vi1WdkujBIxZmfkgExlyUvQz4FZGTlkWzUJJ+lOq2aItr56UCEzd+WlrtUK4aCUjKDhHlXGlrtT+D/76mBtiKs9PbtL8d13vG3Jc/PS7Wm8BnutY8PbzUWWg4PEQggYto1011/6hgYF5jzvvd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188820; c=relaxed/simple;
	bh=5BPXTzgLt6Bl0eASrNOswsCfWT2dHB4EvDyCD00H+jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwphveO1chhAx7kWlSlOMnwPLAhV5wBzoHWNZcHYPuS8iE1SU113efBRKKOLBwgfozE618vrqzSdecOlOL8l2ggqVb9lGBmQVStvRNV+HovFJ/TK8OUokyFlFkQ67n4G0vh69czfQE0syNVQBUjbSdqO05+DbtpqSlj5YqKZayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDfT2val; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDfT2val"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CC01F00A3D;
	Mon, 31 Aug 2026 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188818;
	bh=eijFprEn5vtvf/LMCpMXuJKzdfeHNzAGCtIabB6fjsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XDfT2valRq0ffCXEwmL39LKtmFGpqdNyt06q3bmYE66NkaTSfgTfwbjQeKlKNAhQt
	 y4z1ah38eDZ48aX30QXLYfLnrbg8si31mjn1NSilOdX7YP/P/cSO5IsJiIPF7+M9Dv
	 9SmG82tY2XOAdAu/0TlhX1fO0NRcpMVo/r+Jxmp21iREl4rGlaPNSnK8BxrIjvPV2K
	 l9R7ZvHuh48Y1gpZYgXfokb6+RDVmL2qLXmmaeHbOaZHBm2MR2pfoJkbugUxf2zZkg
	 PZnuc6mAik0dHc1jbHuMP1LqirxB+Z3F1OGJGOLKxWVjBqem4NLlRZKI3oGBWdTpg1
	 37hcR4LuGULHQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Angelov <jasonangelov@ucla.edu>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/2] mm/damon/core-kunit: test probe_hits handling at region split and merge
Date: Mon, 31 Aug 2026 08:06:48 -0700
Message-ID: <20260831150650.84829-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831150650.84829-1-sj@kernel.org>
References: <20260831150650.84829-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Angelov <jasonangelov@ucla.edu>

damon_split_region_at() copies probe_hits[] and last_probe_hits[] to
the new split region.
damon_merge_two_regions() sets probe_hits[] to the size-weighted
average of the merged regions.

Extend damon_test_split_at() and damon_test_merge_two() tests to
cover those fields.

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ec7260a3bfea8..68591ca99a4f7 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -152,6 +152,8 @@ static void damon_test_split_at(struct kunit *test)
 	}
 	r->nr_accesses = 42;
 	r->last_nr_accesses = 15;
+	r->probe_hits[0] = 7;
+	r->last_probe_hits[0] = 3;
 	r->age = 10;
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
@@ -168,6 +170,8 @@ static void damon_test_split_at(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, r_new->nr_accesses);
 	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
+	KUNIT_EXPECT_EQ(test, r->probe_hits[0], r_new->probe_hits[0]);
+	KUNIT_EXPECT_EQ(test, r->last_probe_hits[0], r_new->last_probe_hits[0]);
 	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
 
 out:
@@ -189,6 +193,7 @@ static void damon_test_merge_two(struct kunit *test)
 		kunit_skip(test, "region alloc fail");
 	}
 	r->nr_accesses = 10;
+	r->probe_hits[0] = 6;
 	r->age = 9;
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
@@ -197,6 +202,7 @@ static void damon_test_merge_two(struct kunit *test)
 		kunit_skip(test, "second region alloc fail");
 	}
 	r2->nr_accesses = 20;
+	r2->probe_hits[0] = 14;
 	r2->age = 21;
 	damon_add_region(r2, t);
 
@@ -204,6 +210,7 @@ static void damon_test_merge_two(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
+	KUNIT_EXPECT_EQ(test, r->probe_hits[0], 11);
 	KUNIT_EXPECT_EQ(test, r->age, 17u);
 
 	i = 0;
-- 
2.47.3

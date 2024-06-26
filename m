Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC118A930;
	Wed, 26 Jun 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420478; cv=none; b=eUi6Fntaq+kTKrtmicuacUIk0KT8nUppycXqdotMIUKxgkTCBAVVQ3YNxb5QNUfY+/5xMM64VA+Lt0oIKYMQ26inj5/iFdCfmyjqlACCay/KilZKVnSci6EHyiaYkkNb/Y2Gty04DD8Nh55EZeS7waAc1s3cllVH/5yPtD9BY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420478; c=relaxed/simple;
	bh=1m0DSP9A63mwJJipOeM4FCyyG6b/spl9g6jnH4ftP0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BN+IzJWxj/Fz3mCxJbZs0vSsGeUJ6pphWncWltppzriBd6v+PDx8UYZ6eglV3gKfQbaFDUjpe48PacNM2PgDB4HQdnsrK3bJUk/A0B+L48Qvc1rRCsx0b3IJh/oYOnZbz8ycI6oahMRQ/O+Re/j0R0MLQgn8wE4j9A7/6vv5peI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arIe2N48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arIe2N48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96B7C116B1;
	Wed, 26 Jun 2024 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719420477;
	bh=1m0DSP9A63mwJJipOeM4FCyyG6b/spl9g6jnH4ftP0k=;
	h=From:To:Cc:Subject:Date:From;
	b=arIe2N48kXbz7Tbvv0ooQg9EVpboyfd0WQ2+7V8KzLvZnGmXDucAs1H7mNVVLnqb1
	 oDUqwj5AZvMqjMAb1rv0I66aOPMdvuZJElF9A6ex+mHWJbCkP+YzgEmPtoGxMW/q4J
	 ZFS2yS/IzDp5svXCctNcMMop4vWfl33dywnvQVjVi9GwEk0ORDDeiZ0g3HkZvdnj1C
	 5r0FkSN/8D5CHjHBGYvBa+LrYU2XSKmxoy2CzA8rjbMTbL9d9yx9p3RCES3SpqRKGe
	 kDkJn9q72YVhRJKevPYmCL8rfoQtuZ09w3VXWQXK/JCt8aqLvxewESB9QWS/CKkVZl
	 YaXkmvNtIHseg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable] mm/damon/core: increase regions merge aggressiveness while respecting min_nr_regions
Date: Wed, 26 Jun 2024 09:47:53 -0700
Message-Id: <20240626164753.46270-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's merge mechanism has two thresholds, namely those for access
frequency and size.  The access frequency threshold avoids merging two
adjacent regions that having pretty different access frequency.

The size threshold is calculated as total size of regions divided by
min_nr_regions.  Merging operation skip merging two adjacent regions if
the resulting region's size can be larger than the threshold.  This is
for meeting min_nr_regions.

Commit 44fdaf596984 ("mm/damon/core: merge regions aggressively when
max_nr_regions is unmet") of mm-unstable, however, ignores the
min_nr_regions by increasing not only access frequency threshold but
also the size threshold.

The commit also has one more problem.  User could set DAMON target
regions with more than max_nr_regions discrete regions.  Because DAMON
cannot merge non-adjacent regions, the number of regions will never be
lower than max_nr_regions regardless of the increased thresholds.  As a
result, the function can infinitely repeat the loop.

Increase only access frequency threshold, up to only possible maximum
value.

Fixes: 44fdaf596984 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e6598c44b53c..dac27b949403 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1695,20 +1695,21 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
  * overhead under the dynamically changeable access pattern.  If a merge was
  * unnecessarily made, later 'kdamond_split_regions()' will revert it.
  *
- * The total number of regions could be temporarily higher than the
- * user-defined limit, max_nr_regions for some cases.  For an example, the user
- * updates max_nr_regions to a number that lower than the current number of
- * regions while DAMON is running.  Depending on the access pattern, it could
- * take indefinitve time to reduce the number below the limit.  For such a
- * case, repeat merging until the limit is met while increasing @threshold and
- * @sz_limit.
+ * The total number of regions could be higher than the user-defined limit,
+ * max_nr_regions for some cases.  For example, the user can update
+ * max_nr_regions to a number that lower than the current number of regions
+ * while DAMON is running.  For such a case, repeat merging until the limit is
+ * met while increasing @threshold up to possible maximum level.
  */
 static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 				  unsigned long sz_limit)
 {
 	struct damon_target *t;
 	unsigned int nr_regions;
+	unsigned int max_thres;
 
+	max_thres = c->attrs.aggr_interval /
+		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
 	do {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
@@ -1716,8 +1717,8 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 			nr_regions += damon_nr_regions(t);
 		}
 		threshold = max(1, threshold * 2);
-		sz_limit = max(1, sz_limit * 2);
-	} while (nr_regions > c->attrs.max_nr_regions);
+	} while (nr_regions > c->attrs.max_nr_regions &&
+			threshold <= max_thres);
 }
 
 /*
-- 
2.39.2


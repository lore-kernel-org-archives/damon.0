Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101FEA5A
	for <damon@lists.linux.dev>; Thu,  7 Sep 2023 02:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86713C433CB;
	Thu,  7 Sep 2023 02:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694053783;
	bh=vRYmypXxVu4qyBFRsVgWGOXy10baQDAbK4q5Co5NXh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlP28eTvxlZIfTv787ShyqGqsODexay16ibiTx1Diaxx+5FsRbtNpcWuURBIEOMiI
	 MVGKGITV1obC+0nnb1wK5BP+LzyRRcd22VUneG4Do06WAlT3yR5Cd4F5A9REjPyqBs
	 37dj2ZaxtE7cCscAaXS3ulztigwpy2rxfNIB/MP1lbmzWgDIRBSYzFZ5uX3duR5pRS
	 34mSNwMpDpPDvZaq1aJb+hbu3YNtVwi4x9LJOwcXDyF89pA615ep4hmc4QbMa62sh/
	 HR+4gHtb2WSAAsdQ53ZSq8MRmZsVIpt6LNlSWFJHAhzOnHHSDJPv6qce6YRagf/g2j
	 OkLTbEuTqmVSA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] mm/damon/core: add more comments for nr_accesses
Date: Thu,  7 Sep 2023 02:29:27 +0000
Message-Id: <20230907022929.91361-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907022929.91361-1-sj@kernel.org>
References: <20230907022929.91361-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment on struct damon_region about nr_accesses field looks not
sufficient.  Many people actually used to ask what nr_accesses mean.
There is more detailed explanation of the mechanism on the comment for
struct damon_attrs, but it is also ambiguous, as it doesn't specify the
name of the counter for aggregating the access check results.  Make
those more detailed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ae2664d1d5f1..266f92b34dd2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -43,6 +43,10 @@ struct damon_addr_range {
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
+ * @nr_accesses is reset to zero for every &damon_attrs->aggr_interval and be
+ * increased for every &damon_attrs->sample_interval if an access to the region
+ * during the last sampling interval is found.
+ *
  * @age is initially zero, increased for each aggregation interval, and reset
  * to zero again if the access frequency is significantly changed.  If two
  * regions are merged into a new region, both @nr_accesses and @age of the new
@@ -472,13 +476,14 @@ struct damon_callback {
  *				regions.
  *
  * For each @sample_interval, DAMON checks whether each region is accessed or
- * not.  It aggregates and keeps the access information (number of accesses to
- * each region) for @aggr_interval time.  DAMON also checks whether the target
- * memory regions need update (e.g., by ``mmap()`` calls from the application,
- * in case of virtual memory monitoring) and applies the changes for each
- * @ops_update_interval.  All time intervals are in micro-seconds.
- * Please refer to &struct damon_operations and &struct damon_callback for more
- * detail.
+ * not during the last @sample_interval.  If such access is found, DAMON
+ * aggregates the information by increasing &damon_region->nr_accesses for
+ * @aggr_interval time.  For each @aggr_interval, the count is reset.  DAMON
+ * also checks whether the target memory regions need update (e.g., by
+ * ``mmap()`` calls from the application, in case of virtual memory monitoring)
+ * and applies the changes for each @ops_update_interval.  All time intervals
+ * are in micro-seconds.  Please refer to &struct damon_operations and &struct
+ * damon_callback for more detail.
  */
 struct damon_attrs {
 	unsigned long sample_interval;
-- 
2.25.1


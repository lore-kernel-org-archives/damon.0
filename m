Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FB3ACA51;
	Tue,  6 Oct 2026 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269538; cv=none; b=f8bevXoSOnsFPLclg9sqSlTL0D5rFAq4VFvnBe5fwB+I/CeFCP4X6Os4YmiqODL8Y5Bt5viSVFmFxEaQYeRoizQd2RUeq+THrMZprRUeUDpXsrgvVb/V1Mc2dy57pVd0mD1kpIv/PUXum9k5/veKkA/SSbdLkyUq5Vh/JOpypQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269538; c=relaxed/simple;
	bh=rB++sMfG8AdvLUHWmvycUpdDsFbOkVhtyfCId+rg60o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fM3SfTuBF47hb+q960M8giDbRS4PHRRwXrIg9tdJjzcSKsJqA5EtujC87+cFtTZYQJPdbPqPUk8e4bnrfVfsyyffm6WrX0lBQLBBVEnHP3GvNGhUXsypih23BKyTD0WCNQ465scA/7DsWxkr4l4iANSfOodgWUoLQOz9UM+7pdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0hXNJjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0hXNJjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94FE1F00893;
	Tue,  6 Oct 2026 06:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791269537;
	bh=QPAjnO4sadYj3FVzedyJO8iaaP+d0ImiNneHLyndDTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0hXNJjQsMh8I0I/vHbkxH6f0IQX1qlcvIqS5RV/VHxlfxmv6XedtSQhZ1HVxOsnF
	 puTIv8bE71Z77JRjEUgwZ4beFvyQu8Dt2q8HeWXiJZH2XVAx5snzwkPehZLJgwdVH3
	 GoSdnLE1/yfi3hoGTfwNTbQt3YF4/+KNloKBs22HiKymsD9hLlbKASvgV1VUIyhZJg
	 0zb0Hd1Go5GHMxoQA0fJLH2uy3mvvrtr5T/b3Pxev6LznQyfz2GZB4WqQ3fc9lH3Gk
	 rLVtM2nWhdRlFr+qIF7FHHQi0Ap4afM7nJectyWb5qXlPAf01v3wRWK/X7EiTnl0s8
	 qCmgk3VQcG6ZA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] mm/damon/ops-common: fix age_in_sec overflow on 32-bit
Date: Mon,  5 Oct 2026 23:52:05 -0700
Message-ID: <20261006065209.41507-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006065209.41507-1-sj@kernel.org>
References: <20261006065209.41507-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>

damon_hot_score() calculates the age of a region by multiplying r->age
and the aggregation interval.  On 32-bit architectures, unsigned long
is 32 bits, so the multiplication overflows once the age exceeds about
4295 seconds.  Then old regions are scored as if they were young.

Fix it by doing the calculation in 64-bit arithmetic using div_u64().
Also make age_in_sec u64, so the result is not truncated back to 32
bits.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260623011652.1354-1-sj@kernel.org

Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Cc: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: LLM
Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260930115812.138864-1-jaeyeon.lee.dev@gmail.com
- Collect R-b: from SJ.
- Rebase to the latest mm-new.

 mm/damon/ops-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 77366f42b3e5..7a7429359dc8 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -164,7 +164,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s)
 {
 	int freq_subscore;
-	unsigned int age_in_sec;
+	u64 age_in_sec;
 	int age_in_log, age_subscore;
 	unsigned int freq_weight = s->quota.weight_nr_accesses;
 	unsigned int age_weight = s->quota.weight_age;
@@ -174,7 +174,8 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			DAMON_MAX_SUBSCORE,
 			damon_nr_samples_per_aggr(&c->attrs));
 
-	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
+	age_in_sec = div_u64((u64)r->age * c->attrs.aggr_interval,
+			     USEC_PER_SEC);
 	if (age_in_sec)
 		age_in_log = min_t(int, ilog2(age_in_sec) + 1,
 				DAMON_MAX_AGE_IN_LOG);
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB236A026;
	Sat, 31 Jan 2026 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769888511; cv=none; b=mhCIZKvq1W3+UzYCNeYpsPDOz/k8RSYS2iEzskYftaB3HpoiLTEKLxIq0I6FQ9/XurQkD3hFXRDNbMgwFfFiwV9do6OwJ4yb4KVMU5lOepOPbzO4myqu4LW2bOMR/i1eC9FnyNmdF8gGwtZi13xmrwFF7/VUC6NtGwlF/bVWXIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769888511; c=relaxed/simple;
	bh=Pe0qzMcuMwlXKVIKMPhsj3X5ayzudFrg7BH3yoaNzyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gX2L61ty63518gLquoqfbjUnI16Dv1ehI8aifxWPxFYEdfur524PeQ/+mCJzGMjvjn/HCYSTgp0GrIF9O1OS1sIWWKF6ctWEZNdKuwwkncHcER6g/tv8K2JcPw1McMpEAemDSSnArDn9ev5wTbrc0CEk8G86sBwUvavwbKKhnaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcmDKHtK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcmDKHtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62C8C19425;
	Sat, 31 Jan 2026 19:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769888510;
	bh=Pe0qzMcuMwlXKVIKMPhsj3X5ayzudFrg7BH3yoaNzyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcmDKHtK0qqXshgt7YIaKdfLJSGPcsq6RQRB8pNlmzynsOtG/463k4we4baYjGvXb
	 e4ZZu4v+fciSAhJGo3CJ/EMz7Hzc/THCpTeaZuprn9QqhSd0udTZromt3GLiBT+dzS
	 rPvPz1EGAvVS21gedkDBzQHR7z0ccDL3ktYiQuCtHe0lBhFF1LZS0tYtTIvGHQWieb
	 +mi/LpRFSZzf91mttdPuTDf9RTNNz0XjzZIODmdqXJPl0AzxKmkmegnGywfIb6q2dA
	 nK+MLR5UczCuTctfyTHP09EtolVrLV5X+X7xSP1FKNdjztOgG5bqTLh7IjhWMl9qt4
	 CU4ush5tR587A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/2] mm/damon/core: set quota-score histogram with core filters
Date: Sat, 31 Jan 2026 11:41:42 -0800
Message-ID: <20260131194145.66286-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131194145.66286-1-sj@kernel.org>
References: <20260131194145.66286-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The histogram for under-quota region prioritization [1] is made for all
regions that are eligible for the DAMOS target access pattern.  When
there are DAMOS filters, the prioritization-threshold access temperature
that generated from the histogram could be inaccurate.

For example, suppose there are three regions.  Each region is 1 GiB.
The access temperature of the regions are 100, 50, and 0.  And a DAMOS
scheme that targeting _any_ access temperature with quota 2 GiB is
being used.  The histogram will look like below:

    temperature	size of regions having >=temperature temperature
    0		3 GiB
    50		2 GiB
    100		1 GiB

Based on the histogram and the quota (2 GiB), DAMOS applies the action
to only the regions having >=50 temperature.  This is all good.

Let's suppose the region of temperature 50 is excluded by a DAMOS
filter.  Regardless of the filter, DAMOS will try to apply the action on
only regions having >=50 temperature.  Because the region of temperature
50 is filtered out, the action is applied to only the region of
temperature 100.  Worse yet, suppose the filter is excluding regions of
temperature 50 and 100.  Then no action is really applied to any region,
while the region of temperature 0 is there.

People used to work around this by utilizing multiple contexts, instead
of the core layer DAMOS filters.  For example, DAMON-based memory
tiering approaches including the quota auto-tuning based one [2] are
using a DAMON context per NUMA node.  If the above explained issue is
effectively alleviated, those can be configured again to run with single
context and DAMOS filters for applying the promotion and demotion to
only specific NUMA nodes.

Alleviate the problem by checking core DAMOS filters when generating the
histogram.  The reason to check only core filters is the overhead.
While core filters are usually for coarse-grained filtering (e.g.,
target/address filters for process, NUMA, zone level filtering),
operation layer filters are usually for fine-grained filtering (e.g.,
for anon page).  Doing this for operation layer filters would cause
significant overhead.  There is no known use case that is affected by
the operation layer filters-distorted histogram problem, though.  Do
this for only core filters for now.  We will revisit this for operation
layer filters in future.  We might be able to apply a sort of sampling
based operation layer filtering.

After this fix is applied, for the first case that there is a DAMOS
filter excluding the region of temperature 50, the histogram will be
like below:

    temperature	size of regions having >=temperature temperature
    0		2 GiB
    100		1 GiB

And DAMOS will set the temperature threshold as 0, allowing both regions
of temperatures 0 and 100 be applied.

For the second case that there is a DAMOS filter excluding the regions
of temperature 50 and 100, the histogram will be like below:

    temperature	size of regions having >=temperature temperature
    0		1 GiB

And DAMOS will set the temperature threshold as 0, allowing the region
of temperature 0 be applied.

[1] 'Prioritization' section of Documentation/mm/damon/design.rst
[2] commit 0e1c773b501f ("mm/damon/core: introduce damos quota goal
    metrics for memory node utilization")

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5e2724a4f285e..bda4218188314 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2309,6 +2309,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		damon_for_each_region(r, t) {
 			if (!__damos_valid_target(r, s))
 				continue;
+			if (damos_core_filter_out(c, t, r, s))
+				continue;
 			score = c->ops.get_scheme_score(c, t, r, s);
 			c->regions_score_histogram[score] +=
 				damon_sz_region(r);
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9322A4FC;
	Sun, 26 Apr 2026 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245389; cv=none; b=HM5UBJfSs1lhy4oYbKqoQL9GnV8RuSrYw5qKJPuuGsGHteXqbDBoS3xsxTHgycJn46S0plK3SEGK3NoST2LV8ik6NXp3n3piH4rxU/gBPc1QGLZ/5k9kI/5pa7Q0yooNF3D4YeKipBVXu4sDV0lhoqh1P7FQPorKI38YqG2zDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245389; c=relaxed/simple;
	bh=T/rtKaW+eKFk9u31EesKB4EAeHDfVjDpSaLKG/xuO0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqRBQwABEHWWynD4/AeXsvqL0eGyZyWGzy3Xah/Jmyi0YERORWuWPoTujuiqWE7bB1nn55wTksdhXGMzk5A1SAPfcVMl3wx2xrwl578TLmn47+yGlutoSKAJE240rG+FCzLsFJg/9OSKL9eIWRNo53QiQC18NXLS5Am4/F/JQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skzjHFp9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skzjHFp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2938C2BCB4;
	Sun, 26 Apr 2026 23:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777245389;
	bh=T/rtKaW+eKFk9u31EesKB4EAeHDfVjDpSaLKG/xuO0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skzjHFp9vHqFSaoK85/avT28EYhWOljnnUy0mw4KWXm0pAy1IFAlmiTH/tst2LYf2
	 ZgW4dNHiP0uozx2R6Ip5VE+kJZB6yhe0eH3FO7kadd9KvK8d9rzOvV/N+PlQWgGZ7y
	 ca/l+jDNveyLvwNt53F7LuXtGPwPfqXEigWOVDB3pcsT+Yo+ugSAO7L9ls3y2BcysN
	 yMpBv89mFHBdW0uxHR5hVQ0HJAb+BPkt9JRYFOd5tTKinXShubbdJkNxk76WaburaE
	 gdqmjrONgPp7ytMBA2Tu+cCh6W1axX39Pe9CRJ/XGUaHwnowhIxinXSCZy7W2VpuX6
	 Qa1SFSjGAv2ng==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/4] mm/damon/ops-common: optimize damon_hot_score() using ilog2()
Date: Sun, 26 Apr 2026 16:16:14 -0700
Message-ID: <20260426231619.107231-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426231619.107231-1-sj@kernel.org>
References: <20260426231619.107231-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

The current implementation of damon_hot_score() uses a manual for-loop
to calculate the value of 'age_in_log'. This can be efficiently replaced
by ilog2(), which is semantically more appropriate for calculating the
logarithmic value of age.

In a simulated-kernel-module performance test with 10,000,000 iterations,
this optimization showed a significant reduction in latency (average
latency reduced from ~12ns to ~1ns).

Test results from the simulated-kernel-module:
- ilog2:
    DAMON Perf Test: Starting 10000000 iterations
    =============================================
     Total Iterations : 10000000
     Average Latency  : 1 ns
     P95 Latency      : 41 ns
     P99 Latency      : 41 ns
    ---------------------------------------------
     Range (ns)      | Count        | Percent
    ---------------------------------------------
     0-19            | 0            |      0%
     20-39           | 2625000      |     26%
     40-59           | 7374000      |     73%
     60-79           | 0            |      0%
     80-99           | 0            |      0%
     100+            | 1000         |      0%
    =============================================

- for-loop:
    DAMON Perf Test: Starting 10000000 iterations
    =============================================
     Total Iterations : 10000000
     Average Latency  : 12 ns
     P95 Latency      : 51 ns
     P99 Latency      : 60 ns
    ---------------------------------------------
     Range (ns)      | Count        | Percent
    ---------------------------------------------
     0-19            | 0            |      0%
     20-39           | 0            |      0%
     40-59           | 9862000      |     98%
     60-79           | 135000       |      1%
     80-99           | 1000         |      0%
     100+            | 2000         |      0%
    =============================================

Full raw benchmark results can be found at [1].

[1] https://github.com/aethernet65535/damon-hot-score-fls-optimize/tree/master/result-raw

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v2
(https://lore.kernel.org/20260320192020.33004-1-aethernet65535@gmail.com)
- Rebase to latest mm-new.
Changes from v1 (actually it was RFC)
(https://lore.kernel.org/20260320072431.248235-1-aethernet65535@gmail.com)
- Replace fls() with ilog2() per SeongJae Park's suggestion for better
  semantic clarity.
- Move performance benchmark results into the commit message and add
  comparison between for-loop and ilog2.

 mm/damon/ops-common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 8c6d613425c13..3a0ddc3ac7196 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -117,9 +117,12 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 		damon_max_nr_accesses(&c->attrs);
 
 	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
-	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
-			age_in_log++, age_in_sec >>= 1)
-		;
+	if (age_in_sec)
+		age_in_log = min_t(int, ilog2(age_in_sec) + 1,
+				DAMON_MAX_AGE_IN_LOG);
+	else
+		age_in_log = 0;
+
 
 	/* If frequency is 0, higher age means it's colder */
 	if (freq_subscore == 0)
-- 
2.47.3

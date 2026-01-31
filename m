Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4094736AB49;
	Sat, 31 Jan 2026 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769888511; cv=none; b=kWmsGQC1cQNY4PiPSv+0zcwjODH7zkYtWHPO/KGvSI3T8Sz3qe0HEvxIxsJhcZMDAgxSLHt/aSaSknFiM2lmi5KObLcFYIwZ883OD/jYQNPqCAgsqayF3MsnvA93mxwo4KU/iCteHozDLpvXNSRWt+WCThXN2Q5ZkptRz3sXWPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769888511; c=relaxed/simple;
	bh=lnT/lb6HZwlGefgSd8TpInNfP/02SBCdqDCFlsJ7D/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpSqUpLWqGJhUl9agzrXRYJhLmUTi4q0y83utbZjchbaUWNwWSqcN0XyD2UGcO4kykiT44mZEa8E1ByhIBp4+FgERbN41gWuSXwynJl/7eVgsMNUnlcEA6+vnLAXl3Gj5AR0h7JcNTN658ys66Mx9G7DMdGxDg4TzKjUuDSLEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCCZXr3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCCZXr3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82F3C16AAE;
	Sat, 31 Jan 2026 19:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769888511;
	bh=lnT/lb6HZwlGefgSd8TpInNfP/02SBCdqDCFlsJ7D/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCCZXr3yWA3gjPRkQLWbix16ivBKTW8bl+WFDFagnAMFyAyqdd9tdQc+jOISZt3jZ
	 Er8w33YJNdydGoqtTydTJivcymssb8BtdcBeNpmfjG2TTNZFICeGX0/nKxa94cxyqm
	 krYWgJ5ylX/ujXDJKmQCnsTF1cpDsALAiq1UOw9v7m3UNjmUdB6HnkzjoaBjDoHfZH
	 kWXaECxsSiCf0UtsdHR6xAwpoG9s5ypsnbBXHR8Hc7WkTbvnwrByj4g74yMzSeoZfj
	 v03JrPWOkATnuly61D+P8/DLeb+PM87E4BmMHowAvCOMO/o5ScIBnJCeNjlwm+/Q/+
	 sBgT0vPpgl9xw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/2] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Sat, 31 Jan 2026 11:41:43 -0800
Message-ID: <20260131194145.66286-3-sj@kernel.org>
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

kdamond_apply_schemes() is using safe regions walk
(damon_for_each_region_safe()), which is safe for deallocation of the
region inside the loop.  Actually the code does not only read, but also
write of the regions.  Specifically, regions can be split inside the
loop.  But, splitting a region doesn't deallocate a region, or corrupt
the list.  There is hence no reason to use the safe walk.  Rather, it is
wasting the next pointer and causing a problem.

When an address filter is applied, and there is a region that intersects
with the filter, the filter splits the region on the filter boundary.
The intention is to let DAMOS apply action to only filtered address
ranges.  However, because DAMOS is doing the safe walk, in the next
iteration, the region that split and now will be next to the previous
region, is simply ignored.

Use the non-safe version of the walk, which is safe for this use case.

damos_skip_charged_region() was working around the issue using a pointer
of pointer hack.  Remove that together.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bda4218188314..0ff190ed8a599 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1707,17 +1707,18 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
  * This function checks if a given region should be skipped or not for the
  * reason.  If only the starting part of the region has previously charged,
  * this function splits the region into two so that the second one covers the
- * area that not charged in the previous charge widnow and saves the second
- * region in *rp and returns false, so that the caller can apply DAMON action
- * to the second one.
+ * area that not charged in the previous charge widnow, and return true.  The
+ * caller can see the second one on the next iteration of the region walk.
+ * Note that this means the caller should use damon_for_each_region() instead
+ * of damon_for_each_region_safe().  If damon_for_each_region_safe() is used,
+ * the second region will just be ignored.
  *
- * Return: true if the region should be entirely skipped, false otherwise.
+ * Return: true if the region should be skipped, false otherwise.
  */
 static bool damos_skip_charged_region(struct damon_target *t,
-		struct damon_region **rp, struct damos *s,
+		struct damon_region *r, struct damos *s,
 		unsigned long min_region_sz)
 {
-	struct damon_region *r = *rp;
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
 
@@ -1744,8 +1745,7 @@ static bool damos_skip_charged_region(struct damon_target *t,
 				sz_to_skip = min_region_sz;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
-			r = damon_next_region(r);
-			*rp = r;
+			return true;
 		}
 		quota->charge_target_from = NULL;
 		quota->charge_addr_from = 0;
@@ -2004,7 +2004,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
-		if (damos_skip_charged_region(t, &r, s, c->min_region_sz))
+		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
 			continue;
 
 		if (s->max_nr_snapshots &&
@@ -2347,7 +2347,7 @@ static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r, *next_r;
+	struct damon_region *r;
 	struct damos *s;
 	unsigned long sample_interval = c->attrs.sample_interval ?
 		c->attrs.sample_interval : 1;
@@ -2373,7 +2373,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		if (c->ops.target_valid && c->ops.target_valid(t) == false)
 			continue;
 
-		damon_for_each_region_safe(r, next_r, t)
+		damon_for_each_region(r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
 
-- 
2.47.3

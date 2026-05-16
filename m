Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4546340286;
	Sat, 16 May 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956646; cv=none; b=mVDGpgH+nrVxN545nchZ03SoMom6UCxdYD+gIXL73b6e/fJ8uC9P2yQeT+stoygEoUpVSjlMcFEZ8nX0sYCf0wmwgVXGUfWeUJ/KE1JossGMLdixDZAzmx+MdJPw416VyYCSnOmhg1gsc69SEMzW4KV28XVaw+kkcafiaNPsqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956646; c=relaxed/simple;
	bh=BuHcQxBfKAGy6KrsKoN0hgRqvRDUguIDR5Ybq3/Wp0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvpJ8VhIIRasXWDqTVLbtlA4Z56yjIyakUUkRtYSN4dsyCnVSDheWsnHoDZYYNjFFtJxHayU/fFtojisdMJE7HPRuq0Dso5SSuHJLc4GS1sUmYIMV/ePz+1rfeftcGci4xwGIjY1a30y3MQ+WVP8e/CpEW7qVNuBnUbs6KG3BAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh8zUIRu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh8zUIRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641E4C2BCF5;
	Sat, 16 May 2026 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956646;
	bh=BuHcQxBfKAGy6KrsKoN0hgRqvRDUguIDR5Ybq3/Wp0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wh8zUIRuGhg8pd0sj3+VAfQpNbUn7HNJekNiHtL1lC54niNCCHjTurkMpp11z4/47
	 rgqjCfLFBSf9kTnnc/r6DRoCgRvkFl/1i1mkyS7CKvt7HUUbk8evl++70dmWRgjV5i
	 Vi+EYS38qe54lyI+kKbo+SJXKTAcBJbXGSxE1IjEGsG6NTvZ7Pfe13N46MZBgNeBgq
	 PigFlGoXhDgyNrzEvyuDOcGOUgLRkvF0TkVqWesIV8VYXSa80zWWW+0r4QeZYTNCFF
	 JDNUdeC7Rmx7NHDBHJU6cQtBzmUOiNC2JbGJQ9T8dGmF4MUUTU+SL4LE6Tho5FwaTV
	 TX/3LlC4ifWGw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 06/28] mm/damon/core: introduce damon_ops->apply_probes
Date: Sat, 16 May 2026 11:36:47 -0700
Message-ID: <20260516183712.81393-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend damon_operations struct with a new callback, namely apply_probes.
The callback will be invoked for data attributes monitoring.  More
specifically, the callback will apply damon_probe objects to each region
and update the per-region per-probe counters for the number of
encountered probe-positive samples.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9e70239e5305f..d3b6296700a08 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -621,6 +621,7 @@ enum damon_ops_id {
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
+ * @apply_probes:		Apply probes for each region.
  * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
@@ -647,6 +648,8 @@ enum damon_ops_id {
  * last preparation and update the number of observed accesses of each region.
  * It should also return max number of observed accesses that made as a result
  * of its update.  The value will be used for regions adjustment threshold.
+ * @apply_probes should apply the data attribute probes to each region and
+ * accordingly update the probe hits counter of the region.
  * @get_scheme_score should return the priority score of a region for a scheme
  * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
@@ -664,6 +667,7 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
+	void (*apply_probes)(struct damon_ctx *context);
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_region *r, struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
-- 
2.47.3

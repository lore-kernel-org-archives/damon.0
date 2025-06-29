Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60123B627;
	Sun, 29 Jun 2025 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751228088; cv=none; b=cLFZsIOLP2iS8MMTlvEZon3NRVbalJ4XWyqamOGSX66nNkOnqoIAB9H5nlCEyrxziXWs9F5P3bRyoGpfaHxZoCmXiGRAbMAj7sPtYWnmtqAYpBYsZdDB2KcY1vX+aaT7OZsFgd+2BcSPEwa4PCGvkfWDZOTbB3J+0alul4bRsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751228088; c=relaxed/simple;
	bh=WPdxO+e8ILol8xOVqVupBv8sHR3wPOu1sMz1xt3HWIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+pLdS3pEwRKs2FJ5cwBwX5IZqODKqDLR1eglFCgmoS/MW3NgQ+6BEAxNoTxAcEXAJBBoGCzrldITa+PJ6TTMCx7xis4dIhD7dIaGbYWLUUx4BV3Cs5nRu7grnOqLIlwl0NFxbeI85K9hfXVJaoJDgwZtMm/BemsyGmfpKXeeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th3ve3rG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th3ve3rG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BF5C4CEEB;
	Sun, 29 Jun 2025 20:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751228088;
	bh=WPdxO+e8ILol8xOVqVupBv8sHR3wPOu1sMz1xt3HWIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=th3ve3rGsg71OhvNGnagGF2Jf6YZzJOTamWxjviSTICoVOZ0I31Z02ityymlMSnbc
	 IqVYAHRn1PeWkuYx2S+WgZ6bwNfv9VAPcpLcWDgqu/lYGS5FYAtpPk9VtzDY80xEZX
	 USoM89llEEnEG4DcJtZVV03901ObkOcaAlg/tuMLrmJhmTyA5VI4H4f8WyPcn3P0ef
	 7F6pvuzotOUHqyLC8Q9GnbegMBSz0cmKlcuJ8WsLxKy6AgiM3wkR4vqTErDoea6Td6
	 OAMmgDQIr+fsg0hvykFrtvdr8TpP95lZSuBfc2VUyR9h2tl/u22aEY5r7SR2uIAcmt
	 alNXieidk3mgg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/6] mm/damon/core: add eliglble_report() ops callback
Date: Sun, 29 Jun 2025 13:14:39 -0700
Message-Id: <20250629201443.52569-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250629201443.52569-1-sj@kernel.org>
References: <20250629201443.52569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not every reported access information will be eligible for all DAMON ops
and target.  For example, virtual address access report will be not
eligible for 'padr' ops, or monitoring targets for a process that
different from the process for the repor.  If it is for monitoring
accesses from specific CPU or write, reports from other CPUs or reads
should be ignored.  Add operations set callback for this report
eligibility checking.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a2198909c903..9ec40ce7dde0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -592,6 +592,7 @@ enum damon_ops_id {
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
+ * @eligible_report:		Verify an access report for a target.
  * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
@@ -618,6 +619,8 @@ enum damon_ops_id {
  * last preparation and update the number of observed accesses of each region.
  * It should also return max number of observed accesses that made as a result
  * of its update.  The value will be used for regions adjustment threshold.
+ * @eligible_report should check if the given access report is eligible to be
+ * used by this operations set for the given target.
  * @get_scheme_score should return the priority score of a region for a scheme
  * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
@@ -635,6 +638,8 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
+	bool (*eligible_report)(struct damon_access_report *report,
+			struct damon_target *t);
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_target *t, struct damon_region *r,
 			struct damos *scheme);
-- 
2.39.5

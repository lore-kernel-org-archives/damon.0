Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331A230981;
	Sun, 27 Jul 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647501; cv=none; b=KOxkTxzuZjoEIdoBRvBjUOmKl9zUwjlPGLEKMHeNc7ORZz/lLKAqcuRYUQP9JW3ZXyair1aF95bR3BuCILazZkvOULhR88vSgFSsmaYpZUb3VCcNrCsXHtDJW5MWTZE8oZcFk1nNkuxBHD6Dr5/xXTKDeYPsSmY5u1WeorgKDok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647501; c=relaxed/simple;
	bh=tkPbh1vYlIwSvC/vF2tZ2YQvmhDcZ/BAu1gsu6yocrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CREV8UQvdXyL5wJEhdHmqHJQ0ni+UTmLRslce0IhHCAUwbcECq9eXuN5SzftDdmxmadzhmO6fEU40YsNJUocgYxwmcmVDo5XLY9J16VIruoCd/rAZ4iOBdZra9jxWnQOnhw7Pu063zmd8XdEw3VeHJG0zJCbSPiDiWoqr4sk2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdoXJDbI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdoXJDbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E560C4CEF8;
	Sun, 27 Jul 2025 20:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753647500;
	bh=tkPbh1vYlIwSvC/vF2tZ2YQvmhDcZ/BAu1gsu6yocrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TdoXJDbIX7Og9uiSKRdjVQhbxJm2D0VZc+QHNI4fHO9garcj1BMAA0j6RLls46a1D
	 /Zs78wbmn2dXP3gDf/ZM2syok3kNJ02+AwBzdtP/BqsOve9qrIdKrnpf5VK/yJLvYF
	 n8eA19tzgNoxBptNdEKBL+2xxjgXU7KhSQWkYpxm3xhFCTsIbStnDQMV40RxQQpK8D
	 POHIG4dJOn14pZmkFmfiVrKGjS5zqOZCNb3RIpJwBnsQAEkgIwGu5RI92b+DDbAjKy
	 Oh+PROfob69zYN+CD/INvzqHFaS6MEczh0mckk1TbVRgCfLk83zasSeicW0XQDGrIc
	 M9rX3/yfAFG2A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 2/7] mm/damon/core: add eligible_report() ops callback
Date: Sun, 27 Jul 2025 13:18:08 -0700
Message-Id: <20250727201813.53858-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727201813.53858-1-sj@kernel.org>
References: <20250727201813.53858-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not every reported access information will be eligible for all DAMON ops
and targets.  For example, virtual address access reports will not be
eligible for 'padr' ops, or monitoring targets for a process that is
different from the process for the report.  If it is for monitoring
accesses from specific CPUs or write, reports from other CPUs or reads
should be ignored.  Add operations set callback for this report
eligibility checking.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1f7592147d92..f3e5c585b5f1 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -590,6 +590,7 @@ enum damon_ops_id {
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
+ * @eligible_report:		Verify an access report for a target.
  * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
@@ -617,6 +618,8 @@ enum damon_ops_id {
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

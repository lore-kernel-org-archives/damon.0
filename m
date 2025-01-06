Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674831DFDBC;
	Mon,  6 Jan 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192049; cv=none; b=sbeOs2b1p4o7Qu/HNFDap1kWlfHAj2el69eMFgwiebIbbeFxy1wbrzTblQiO3wHBRwNzWerGSVZqkfUl5Sq+X44lm2NMgwwkySJTjF9GPCHLgWiCREYG+UADaAieLroKcMW73k8jOB+CsxKpgR6EbdBDsMlNQZPkHzmfY81y3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192049; c=relaxed/simple;
	bh=qj6QWyOD/vM16R3ECxClV3J3o7l3msnzxK4/LkXjXQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AN8ClgKx5REUvN7cgQhFOc2eJ9Sv7rajD96ZdzxEcLcWsryn+CBaoCt+A9ahgQk/4iPoSVw8Sc4Ct6F85AJBNHmair2nqfJCD17Dd9uLw5SWKW5IqBk27kFwuDd+uX9x02CvVzm7tm9G1sW/Gc2aNpPp8PifV2JpSwYZWBssgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8l0h8S4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8l0h8S4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E036C4CED2;
	Mon,  6 Jan 2025 19:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192048;
	bh=qj6QWyOD/vM16R3ECxClV3J3o7l3msnzxK4/LkXjXQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8l0h8S4TeRjSGATIMkb1PfMopf+UW8RezfO2VkwcGRrc/e2pYzf78MvnitsaAhYr
	 GA5J8txVBRUq3W+q4d7+bbJ1zpqvbJQ2s9pppFrwjsY3+pmo1PnJ0ltgaFcHk8UqL0
	 k+piP6rOQD3MyyDNKGJFQz62kQaKFzCEyq0AADV/e9IYtVhhlWmZtaxywVtrZfb4NL
	 iQuYo5B1H6PFEwJhUq/yI8EtL/Li9SxyuwRp5U2Q6tpStImOr3Gl1S3mjA24V0c/Gv
	 yQfcZtL+f9y7LHS0W5aMdrDB1X6hlBqNWbwhbHpgx4X2xEEeL/JOEOkQsS4CAz/Dy8
	 T8IvacplUVvVw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/16] mm/damon: clarify trying vs applying on damos_stat kernel-doc comment
Date: Mon,  6 Jan 2025 11:33:46 -0800
Message-Id: <20250106193401.109161-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS stat kernel-doc documentation is using terms that bit ambiguous.
Without reading the code, understanding it correctly is not that easy.
Add the clarification on the kernel-doc comment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2889de3526c3..b85eae388f5b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -287,6 +287,23 @@ struct damos_watermarks {
  * @nr_applied:	Total number of regions that the scheme is applied.
  * @sz_applied:	Total size of regions that the scheme is applied.
  * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
+ *
+ * "Tried an action to a region" in this context means the DAMOS core logic
+ * determined the region as eligible to apply the action.  The access pattern
+ * (&struct damos_access_pattern), quotas (&struct damos_quota), watermarks
+ * (&struct damos_watermarks) and filters (&struct damos_filter) that handled
+ * on core logic can affect this.  The core logic asks the operation set
+ * (&struct damon_operations) to apply the action to the region.
+ *
+ * "Applied an action to a region" in this context means the operation set
+ * (&struct damon_operations) successfully applied the action to the region, at
+ * least to a part of the region.  The filters (&struct damos_filter) that
+ * handled on operation set layer and type of the action and pages of the
+ * region can affect this.  For example, if a filter is set to exclude
+ * anonymous pages and the region has only anonymous pages, the region will be
+ * failed at applying the action.  If the action is &DAMOS_PAGEOUT and all
+ * pages of the region are already paged out, the region will be failed at
+ * applying the action.
  */
 struct damos_stat {
 	unsigned long nr_tried;
-- 
2.39.5

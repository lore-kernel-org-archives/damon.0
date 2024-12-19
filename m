Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AD155342;
	Thu, 19 Dec 2024 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581021; cv=none; b=uXzl68W8kra5O4u7Aec5Bm9LEcEd52KmAwCOCDX7TfwKn93spX4FjsejHKcf0ASvKKXDpRtZy972bH9tbqd4RWl/CubdrHQKl7KdN/+3btNWM8J0VM+SQ/beq2jcFXNz9dKyFp7YYy6CSAO6R9RRI1V94zu7qr3HBQRSB+XcemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581021; c=relaxed/simple;
	bh=6yAcbnM6J2idHIjWcNsWaXW+gfpMIfb6CiDEsPN4WLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aS7BuAZ6Ktpb+zeCM506MvmL5yMKpi6u97T7t3r5Y0EKe0Yv1AWyBhSb6I9fW5GxAOWZbxGN/LIHA2UkGZenAGSQcRyB7ujWgxBe+1ppINp1QgvAJ8XxwrwPSajOzFc6HuvN21JUazkNTeghRubtKd/sMLh0FGsqJ5S8RzSs4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2Zz6jKF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2Zz6jKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B80FC4CED4;
	Thu, 19 Dec 2024 04:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581020;
	bh=6yAcbnM6J2idHIjWcNsWaXW+gfpMIfb6CiDEsPN4WLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2Zz6jKFVEPW7u1pYxFRdlJrY348lqcmWUcfha2+coLLc1HpWoHnTIEUfYg2ziXlC
	 51ibgYnkuv8dFEKmc1FBcw14hA74jR5dTKVqsb9V8e5E51G4T2ZylTxk9znabTMit9
	 ohbI4MhC0Re8TXQRCyrAYXo89HrLTs88AjPe31a7yabDNYi/A29oO995ydVGxEvyFR
	 6A7mzFy59DR/oDcHw19Bc6MRFkMZiE7h5d/MMwZ9PZ1vJmPuDLtvTjdaNcArav1vWf
	 749M3/3bFJ+mh+1kpk9B/5HUGfV1HxjH6bXsEqPiAQ6M36FDqcrzKHQJUiQ7wMKdHZ
	 P2VR8NWEGYptg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/18] mm/damon: clarify trying vs applying on damos_stat kernel-doc comment
Date: Wed, 18 Dec 2024 20:03:10 -0800
Message-Id: <20241219040327.61902-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS stat kernel-doc documentation is using somewhat implicit terms.
Without reading the code, understanding it correctly is not that easy.
Add the clarification on the kernel-doc comment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b4165cc41d99..f66fa0ab9350 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -292,6 +292,23 @@ struct damos_watermarks {
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


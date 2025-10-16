Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CFC218ADD;
	Thu, 16 Oct 2025 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651262; cv=none; b=MO/hxOJXatYDtu27OlhLXF9ozSwf908BAkHCwk/Oq0Z0bxJshUC5qbgbZm2nSNgSsWuEW0S5B5y1NS2E2xncLp2Xu795rYstaKzSJ9K4pKKSxsSgAETiVxRUxaEiqRVegd3sUDHfQ7ditN1jDRclJbvaqe7R9A2dADQgn5iW6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651262; c=relaxed/simple;
	bh=UUnCkanvoPf80rfrjE5y8KYyMoRR90dpdf30uhflryc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLzTAGJ3gUVjvybwAZt+vDhCYRvaqbYHs6bIyFLLucdYv7G7azD01+miz5ceRgAUqFM2vrByd/4J0A79eww6Uixuyc8OXwEjhXjbZ59dpe9Qb6njv9X9E1gsKLIIXmDse3INdgVDj5v1tgoptLpq7mNAgHUY2VrZaG7Vo1QAjhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5RZ9Zd9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5RZ9Zd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFE6C116B1;
	Thu, 16 Oct 2025 21:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760651262;
	bh=UUnCkanvoPf80rfrjE5y8KYyMoRR90dpdf30uhflryc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5RZ9Zd9vlngL+iwpjUimBM6yuyRDpeqGgN3hWpLniLlmPJVypAaKX3AROSCCMpck
	 5u0FhXhO86Zusk/grZihXHecJ71vNGlsWNfjT/8D9v9J5KLJ3vHEPLe4ap0EQYIK4q
	 Pdw7KMbhrudeHwlhdg+1QbWa+aC09cQiX/ywv2bwUrkvrizFGsv6cD2tN0NxLOFYTD
	 R2IrJLDlG/wZrjhLPfLc4w9fsQby8mPBLMhMQgGuLJTbjWdeO1yPJHzWKhW/T0PLLL
	 TMgVXl3kSACRYTA8y8z3i5Cr8csflXLxQqHHELklyOAZMvSn5SucfA+dANi4ghXXiY
	 7JC3CFvPFrnDg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	bijan311@gmail.com,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/5] mm/damon/core: add damon_target->obsolete for pin-point removal
Date: Thu, 16 Oct 2025 14:47:28 -0700
Message-ID: <20251016214736.84286-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016214736.84286-1-sj@kernel.org>
References: <20251016214736.84286-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's monitoring targets parameters update function,
damon_commit_targets(), is not providing a way to remove a target in the
middle of existing targets list.  Extend the API by adding a field to
struct damon_target.  If the field of a damon_commit_targets() source
target is set, it indicates the matcing target on the existing targets
list is obsolete.  damon_commit_targets() understands that and remove
those from the list, while respecting the index based matching for other
non-obsolete targets.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  6 ++++++
 mm/damon/core.c       | 10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 524dea87cac7..8a7b45b9e40d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -92,17 +92,23 @@ struct damon_region {
  * @nr_regions:		Number of monitoring target regions of this target.
  * @regions_list:	Head of the monitoring target regions of this target.
  * @list:		List head for siblings.
+ * @obsolete:		Whether the commit destination target is obsolete.
  *
  * Each monitoring context could have multiple targets.  For example, a context
  * for virtual memory address spaces could have multiple target processes.  The
  * @pid should be set for appropriate &struct damon_operations including the
  * virtual address spaces monitoring operations.
+ *
+ * @obsolte is used only for damon_commit_targets() source targets, to specify
+ * the matching destination targets are obsolte.  Read damon_commit_targets()
+ * to see how it is handled.
  */
 struct damon_target {
 	struct pid *pid;
 	unsigned int nr_regions;
 	struct list_head regions_list;
 	struct list_head list;
+	bool obsolete;
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 70e66562a1b3..3242a9573db0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -492,6 +492,7 @@ struct damon_target *damon_new_target(void)
 	t->nr_regions = 0;
 	INIT_LIST_HEAD(&t->regions_list);
 	INIT_LIST_HEAD(&t->list);
+	t->obsolete = false;
 
 	return t;
 }
@@ -1213,7 +1214,11 @@ static int damon_commit_targets(
 
 	damon_for_each_target_safe(dst_target, next, dst) {
 		src_target = damon_nth_target(i++, src);
-		if (src_target) {
+		/*
+		 * If src target is obsolete, do not commit the parameters to
+		 * the dst target, and further remove the dst target.
+		 */
+		if (src_target && !src_target->obsolete) {
 			err = damon_commit_target(
 					dst_target, damon_target_has_pid(dst),
 					src_target, damon_target_has_pid(src),
@@ -1236,6 +1241,9 @@ static int damon_commit_targets(
 	damon_for_each_target_safe(src_target, next, src) {
 		if (j++ < i)
 			continue;
+		/* target to remove has no matching dst */
+		if (src_target->obsolete)
+			return -EINVAL;
 		new_target = damon_new_target();
 		if (!new_target)
 			return -ENOMEM;
-- 
2.47.3

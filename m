Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06260199230;
	Thu, 23 Oct 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182741; cv=none; b=qjzS8w1RmTfPcnJvtVzi5YtwLm7M6z4Eg6EFsKYSed9MUPARbCqoBHIBlIEtyvHGY/7xMhQHvoPQlosMvGaNujwRRFiDud6obo3/VHkc3Ouiyfro2t/moI/hNx6Mv3rn6f4lJqJ1vgkRdzckOOfv9JGemt4yyltrJeEHJyn/E9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182741; c=relaxed/simple;
	bh=v9vH7Jep/EeX2FXur/wyq53jucsgYHdF++0q2V0OArg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUbzSTEJHTzhtLL2ooZecTJoi4jbK93gMZHk0TzDXHrAQUuNe9IlQOx5lSZ+ozGlrJBOZQrGwHKcmgqar4FOgiiHOwjPJOkSzVUQum/WR40gB0vNiZYQ+t5WPXqtW5KXeo9Xohfc6ukRq1gR83x4+a945mC3U2KqNzXAa7CFUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egoIfw7I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egoIfw7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A71FC4CEFF;
	Thu, 23 Oct 2025 01:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182740;
	bh=v9vH7Jep/EeX2FXur/wyq53jucsgYHdF++0q2V0OArg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egoIfw7IZ8X9uk3E6nENP2Hxh1zKENq+lziGRTOzPFZbi3sbe9zR5TsESdtjvfcrM
	 d/8w8phWaEcF5VWGB3gEYPbpOKK0lf63OCfUL0fDToEzHF/t22Zy+fwyBCjd+XQsvI
	 ZFV2Y3SmLXer1AcW1/wCaeb+2YqnO73ULSCr2ot4Iw96ESygPYDrRcU3TzQUL2gDlw
	 uPH6h9AcWtUyyOAkN+RUa/bOU1aPkQN0R8WCuoxkpB4P9+lS2aKDMrr1YmG0Buf3Sy
	 AgnKgHP6xWOpLet86JU8wtwqUQytwHNZZ6e3A6HZvKIx53rq7GtIbLRPSaB+yv+VXM
	 sAUNpIPwVIi2A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/9] mm/damon/core: add damon_target->obsolete for pin-point removal
Date: Wed, 22 Oct 2025 18:25:25 -0700
Message-ID: <20251023012535.69625-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023012535.69625-1-sj@kernel.org>
References: <20251023012535.69625-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's monitoring targets parameters update function,
damon_commit_targets(), is not providing a way to remove a target in the
middle of the existing targets list.  Extend the API by adding a field
to struct damon_target.  If the field of a damon_commit_targets() source
target is set, it indicates the matching target on the existing targets
list is obsolete.  damon_commit_targets() understands that and removes
those from the list, while respecting the index based matching for other
non-obsolete targets.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Bijan Tabatabai <bijan311@gmail.com>
---
 include/linux/damon.h |  6 ++++++
 mm/damon/core.c       | 10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9ee026c2db53..f3566b978cdf 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -91,17 +91,23 @@ struct damon_region {
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
+ * @obsolete is used only for damon_commit_targets() source targets, to specify
+ * the matching destination targets are obsolete.  Read damon_commit_targets()
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
index 82546d138a5a..d78f4452e536 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -479,6 +479,7 @@ struct damon_target *damon_new_target(void)
 	t->nr_regions = 0;
 	INIT_LIST_HEAD(&t->regions_list);
 	INIT_LIST_HEAD(&t->list);
+	t->obsolete = false;
 
 	return t;
 }
@@ -1187,7 +1188,11 @@ static int damon_commit_targets(
 
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
@@ -1210,6 +1215,9 @@ static int damon_commit_targets(
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

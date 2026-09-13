Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01113812F0;
	Sun, 13 Sep 2026 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319837; cv=none; b=mN1BVk+V3Gi92WluWxbRP2h9Y18ryDOmxnJai7BPWNSvkmD4iNFZKiaDIJjdS3rXQ7D5ezwKh8PHCMl/19gJTXprBUC3Q+8itz+JUYe9InLcWIlOyA0ccDyiFUyRU4arZix3L5HeP0kssL8Y6gr0tCtJf/AOYg8zmMydfASWJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319837; c=relaxed/simple;
	bh=511pkTn6VnfeRoiABJeZKOSD3w5pR5NkGsXWAY1PVFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVpHynOtueeTm3fTgmto+C2QfsGDe0cMe9HmxPB07OALzdxc4dMFhhau9gYR4llMUEaXms6OPBzi213lNTx0C1k4tvH3q1fiF4WZzb2J1wkslZvjLiu0RbkTbIpsAG/y9EuiBCRC8ODs67hX8IK+tGwCJkf3YeXuHv4CSMA4Mg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZqCBSZU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZqCBSZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9061F0089A;
	Sun, 13 Sep 2026 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319835;
	bh=hPljEC41AE/9V3Eb7L+bcMCBYD4RAk8iJtQDR/e+uUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OZqCBSZUf/wQ/7MYqIfkvWxbZ4LmvLyMBfTw8zz3VNihGmgE3PHX+t8GljC//GAtv
	 IXTqNmPCVRLj/0+JPAfXmbAJh3vqi1T5btpqHhI0y8l+FIc3vXJ903nUnY2JXNB0hd
	 FUL/VGgP+3+M1fo0Utf/5Ep3AAwJULWe7mL8QiHYjMoThnKWhtjazHkPLKvQ3DfLON
	 IvivD4wTgidbdYci5d9MkpedjdF+oR4gXwLeAsDi/HpiMdmAPQQ0v8ZH11RLIVjDm/
	 8e3Y3e3HTlUsLdiAPPpN0fAnCty1kx3IzL6JKcCvmW2OKLD8S69I3vuww+ObjQwaaS
	 a0we1B1eAtS1w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 3/8] mm/damon/core: return an error from damos_commit_filter_arg()
Date: Sun, 13 Sep 2026 10:17:00 -0700
Message-ID: <20260913171706.103052-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171706.103052-1-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_filter_arg() is supposed to always succeed.  It may not in
future, for example, if the given filter is invalid.  Prepare the case
by modifying its signature to return an error when it failed.  Also pipe
the return value to its callers and let them handle the error.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3d7a973ea8b6f..ea7d8d5a4abf6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1317,7 +1317,7 @@ static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
 	return NULL;
 }
 
-static void damos_commit_filter_arg(
+static int damos_commit_filter_arg(
 		struct damos_filter *dst, struct damos_filter *src)
 {
 	switch (dst->type) {
@@ -1340,28 +1340,32 @@ static void damos_commit_filter_arg(
 	default:
 		break;
 	}
+	return 0;
 }
 
-static void damos_commit_filter(
+static int damos_commit_filter(
 		struct damos_filter *dst, struct damos_filter *src)
 {
 	dst->type = src->type;
 	dst->matching = src->matching;
 	dst->allow = src->allow;
-	damos_commit_filter_arg(dst, src);
+	return damos_commit_filter_arg(dst, src);
 }
 
 static int damos_commit_core_filters(struct damos *dst, struct damos *src)
 {
 	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
-	int i = 0, j = 0;
+	int i = 0, j = 0, err;
 
 	damos_for_each_core_filter_safe(dst_filter, next, dst) {
 		src_filter = damos_nth_core_filter(i++, src);
-		if (src_filter)
-			damos_commit_filter(dst_filter, src_filter);
-		else
+		if (src_filter) {
+			err = damos_commit_filter(dst_filter, src_filter);
+			if (err)
+				return err;
+		} else {
 			damos_destroy_filter(dst_filter);
+		}
 	}
 
 	damos_for_each_core_filter_safe(src_filter, next, src) {
@@ -1373,7 +1377,11 @@ static int damos_commit_core_filters(struct damos *dst, struct damos *src)
 				src_filter->allow);
 		if (!new_filter)
 			return -ENOMEM;
-		damos_commit_filter_arg(new_filter, src_filter);
+		err = damos_commit_filter_arg(new_filter, src_filter);
+		if (err) {
+			damos_destroy_filter(new_filter);
+			return err;
+		}
 		damos_add_filter(dst, new_filter);
 	}
 	return 0;
@@ -1382,14 +1390,17 @@ static int damos_commit_core_filters(struct damos *dst, struct damos *src)
 static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
 {
 	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
-	int i = 0, j = 0;
+	int i = 0, j = 0, err;
 
 	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
 		src_filter = damos_nth_ops_filter(i++, src);
-		if (src_filter)
-			damos_commit_filter(dst_filter, src_filter);
-		else
+		if (src_filter) {
+			err = damos_commit_filter(dst_filter, src_filter);
+			if (err)
+				return err;
+		} else {
 			damos_destroy_filter(dst_filter);
+		}
 	}
 
 	damos_for_each_ops_filter_safe(src_filter, next, src) {
@@ -1401,7 +1412,11 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
 				src_filter->allow);
 		if (!new_filter)
 			return -ENOMEM;
-		damos_commit_filter_arg(new_filter, src_filter);
+		err = damos_commit_filter_arg(new_filter, src_filter);
+		if (err) {
+			damos_destroy_filter(new_filter);
+			return err;
+		}
 		damos_add_filter(dst, new_filter);
 	}
 	return 0;
-- 
2.47.3

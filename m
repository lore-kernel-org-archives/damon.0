Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B847F2DD;
	Mon, 14 Sep 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395819; cv=none; b=LUwwB/AwvPFc7+zvTSEVh2nqdkLrHkadv3WpPuOMulj4UStEDKFb6CvZLZIji6jSx3YhOfj6LI/gGg+llW9yb4oEIXDDXagiOP+JfmOrZu1Wu6saT3dUoz+Sb7zHT136xrxo8iT6aS4OCO97hcpDo1ye/PSLyXos9BfIiMM9eBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395819; c=relaxed/simple;
	bh=rezLxJx/ysSC3j6vIQ0D2XPXYxSSlKKk/TpnK0F3TIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSgFbOWJs9XFNENUIotbcprgtglT/R59DZidC6KYVSn+FoebXihDRdKKbkahgERu29GXc4ZQ2uAi6jlAg6Aj05mYHE7QzsakQg3E/Uxa6/ynXTpAkN/dJLhopW3JDJjic8mvTYcDCL8ziM02HvE7/vi95P1SSO0y3VUf+Oa9qW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg1NrFwB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg1NrFwB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7681F00893;
	Mon, 14 Sep 2026 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395816;
	bh=IylFMzfsfQcR17Grot5+mj67UZj/L3bUEkgF2gj/ftI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xg1NrFwB1YiQuae9W8eyekK7DWN6FL90M2yHBgePYlP/g6HCOFtpH7ktN0pmbj9I+
	 u98a3NTVNeBJBmwXFvzqTiDx8AWb6rvl56oWwlaKNcOKwAGeH5gSCKNHVPrWWrEzg3
	 8kM/QzQj0fG50L8/etXomiCEc32jfGYUkT2isU5DClyo0FYkL1pPtgUvzkznHhQP8E
	 7EmD2UzTkGlstsJDm0SS1TsFv/GuVLwpqAsuVuuPHo8Vy7OcW+B1H+A90tHpSX6b7f
	 bzLPY2QQSpQDR3Y6motIVexQNMf75iW8nWQouD8Aqk9nzLqNAyVHBeu6kchiWEYyyw
	 oFt95gSnHdTVA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] mm/damon/core: return an error from damos_commit_filter_arg()
Date: Mon, 14 Sep 2026 07:23:20 -0700
Message-ID: <20260914142327.92510-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914142327.92510-1-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
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
index 0c98f7e267d07..94ea63084a24d 100644
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

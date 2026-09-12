Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A537F75E;
	Sat, 12 Sep 2026 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240697; cv=none; b=h6HBVVelMUn0Ma4uY7IZWrCAzDEBRRXEooIJV+RegCAIOL27mXufYjpSN4SytfLjPJkWUr06HzgUM0tYDiluKn8y/u2oYulMLDnsWHtODLQhrd41LXoxTJ0XA3nwsV080UVcClAmnGax5/SQ1Uz1YAPNNZcX3w1Q/cDfdwPCLp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240697; c=relaxed/simple;
	bh=90f9yZ7JrVqlLjVYd4BWbp5Wf93983JuyPp/tZs9Kz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdspVEp9192sM07U8rKf9Jjb7yvF0PMR13aE1UgUyy06OAjlv6p25+EF7EerDZ2g7Xq/HCSqlJQThiMARPBrOPn4jJHPKAOUt0cUtUjVnnzVTHPT2VSOzrRsFFWNKcfWs0yweMf0Kh1Ol6+h3444pzI7b0FOxDYLdoCT0+agb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToRA9W2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToRA9W2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BACE1F0089A;
	Sat, 12 Sep 2026 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789240696;
	bh=RCy1mpgnGFNfwJbYRh4cYXVMRxk5ZkvS/1Omzx6vs3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ToRA9W2SK4fhF4Qsb8Q/v0HI8l5gMOI8Rx9/MdPJY20eeTc/Vf3G+V5giJolzRLdi
	 nDAeXesvRJa0J1Y5D+HV+iqKc4Wm/UMi1bkinZTAkfS5cbdYbw5EHoyXPBfLkYLorb
	 Qd0u6kqCp7em6DBSJ/7ZmAorUZkAvj2eF6mLcgjSiZ31hHtxMAQN/45JthcbAMBf74
	 jyftB5XC8zvcSy8HUds3z2r6xnOBpQjRp/Amg3HRnGtwnN4E/+ZFNgeNS3FM1OLgVN
	 SoGuDnC+35BjXPhBhmGVLMvDr2NXAaD7z9yIfFbjaLU9mTpzHgOvEZWehyZlkqE+Xa
	 ZP/Xu/Zfw/JUA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/8] mm/damon/core: return an error from damos_commit_filter_arg()
Date: Sat, 12 Sep 2026 12:18:01 -0700
Message-ID: <20260912191807.138502-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912191807.138502-1-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
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
 mm/damon/core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0c98f7e267d07..3ad1fb2f21f3f 100644
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
-- 
2.47.3

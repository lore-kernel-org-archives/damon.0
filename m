Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FDF3246F8;
	Sat, 21 Feb 2026 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702597; cv=none; b=bAzmBccHVH+fiU2ndD0rKOmG9kaxtYqcnPvquOVXn+iscbRtj/5DhqT3c3zaf58sErtU+WlWwel3McFJNxQqfOM5fRFcvMhtnb93Kkn6DwFAwdxhBUBNK2aqdkpnO/1+MKTOxMt3MxfjI9WtzVN0vYGqfAZj4mtgiN1dt00Op9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702597; c=relaxed/simple;
	bh=yfRhExNso4AJw0G3Gu/sbFcwdK0et66BbTZ7++AzIBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaMkoXJa26LF8CjNV0P22SMkylzohsL+0V15H7l1kmuSpDaV9d7QyJZk9ZEYIT8M2HoUsx5X14PX2lM9wi4QM5bRvbjtgWUs/Q77Xg7EH33BTvf1IMTPYSIJ7RpPWZBmzji2WutRD9aWD4jRN2ClnnkovI3yObtp3Mkdbp3LH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB4ZFNP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB4ZFNP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C15AC4CEF7;
	Sat, 21 Feb 2026 19:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771702596;
	bh=yfRhExNso4AJw0G3Gu/sbFcwdK0et66BbTZ7++AzIBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GB4ZFNP86ucw+3iCZiFXKFSKc+7g7gQXYBizUVaM6G8Pj5spY5ST9Ekt2IMMeJPSv
	 ujn4pxCagJ8hVsjzpmdB5AZwSv+BwpeYomGyngaJVAhKPUhDJd8kO9Ki1uLpkUDxmU
	 jgl3T2QbmIMMnMw4xG63UgEC6QJojN5Yp4J9vzqz5oR2FZuTREgMJy+sa4+Lq1V81D
	 gBAQD03RWTC+cT/HNkoiWnHNWyY2vmsi+oSCpTobkdBgmdM+q3o3A8r/A4dYmrLOl0
	 rHTj1f43HloJtzgTWOzPQc/ryMrkIP9wNBcf1HzwTyMTO6Y2fbGo5LqWaGMOFuIlcJ
	 1ESR5NKOJQC5g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/10] mm/damon/core: add damon_split_region_at() debug_sanity check
Date: Sat, 21 Feb 2026 11:36:24 -0800
Message-ID: <20260221193629.19332-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-1-sj@kernel.org>
References: <20260221193629.19332-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_split_region_at() should be called with the correct address to
split on.  Add a sanity check for that under CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 94be598cafef1..16f7994903d6d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2629,6 +2629,23 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 			threshold / 2 < max_thres);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_split_region_at(struct damon_region *r,
+		unsigned long sz_r)
+{
+	if (sz_r > 0 && sz_r < damon_sz_region(r))
+		return;
+	pr_err("damon_split_region() call with r %lu-%lu (%lu), sz_r %lu\n",
+			r->ar.start, r->ar.end, damon_sz_region(r), sz_r);
+	WARN_ONCE();
+}
+#else
+static void damon_verify_split_region_at(struct damon_region *r,
+		unsigned long sz_r)
+{
+}
+#endif
+
 /*
  * Split a region in two
  *
@@ -2640,6 +2657,8 @@ static void damon_split_region_at(struct damon_target *t,
 {
 	struct damon_region *new;
 
+	damon_verify_split_region_at(r, sz_r);
+
 	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
 	if (!new)
 		return;
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDC38A29A;
	Mon, 27 Jul 2026 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163116; cv=none; b=CQK2tgUiY91vz88A6XE3GR0cst3SYxAPUnshN0OXMiibjzLAAbSIAbpxlxoF3Ho0JAvaAxkSEw1BYGxDDH6Q1J1pXVS87qQ5/C8icpgL7OO2tr6cHMtNG6yYbqmufuzRwuZyB0kceFVm4cEb0U94C87bZB71aKXCsSH+FLnGLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163116; c=relaxed/simple;
	bh=QROrfCzQixCQTszSavdn26Kts8/EkDr/hPWNC1d7GwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjmXoJPt+YHdarDnbTSMRCkc181rIuo1HDaLfmd7yDcB3wNtyYlgvE/7Mcxp55ykcNJKiwWbAJaJWQqH2SiNHGI21cp6B+sqNrOvTPIMbPMakuwx+8lZ+E85Eqh527F/FpdMwY8H5sAbaeWHc75hGn11tM1dEYePrwiDsVyCW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXeqXkkT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXeqXkkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9050C1F00A3D;
	Mon, 27 Jul 2026 14:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163114;
	bh=SdtqE3eR/Bua/rulOOI8NT/gdSWbQwN4dD7fIeQTAXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PXeqXkkThnDbMubQzL2QbuRli5gndk1PPtauBRBlBwa4NEBLeRA/hD23pXTiIu4xy
	 4P22t+uiOpUKYOLsY9b9hSnxJ3chgwAnpcoZKQG+1XVB+wmbXOiVPTgmsBtd5YLFst
	 XMdlizTzpV461DxxQk5ChkHB51lJBac1KFX/nepVeUnT3wWTYB+52pKKOoyGmFwXAN
	 R5LSXWxH1skTgsHUV2GCPjXkwgb1WkgRf8546lL9y+RMhQ3WLGgd2B8te90sPZUO5F
	 pN41zTfsCWF/tl6dGEnZQa8y1McpBGMWrz6E3OcnbwVq45AOkhLQTFMAqDazLVPkKn
	 +yiVcE3Cmo1/A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 06/17] mm/damon/core: commit preps
Date: Mon, 27 Jul 2026 07:38:15 -0700
Message-ID: <20260727143829.86236-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_commit_probes() is ignoring damon_prep.  Commit the prep actions,
too.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bda61f9ec0266..c74dee56efee8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -128,11 +128,34 @@ void damon_add_prep(struct damon_probe *p, struct damon_prep *prep)
 	list_add_tail(&prep->list, &p->preps);
 }
 
+static void damon_del_prep(struct damon_prep *p)
+{
+	list_del(&p->list);
+}
+
 static void damon_free_prep(struct damon_prep *p)
 {
 	kfree(p);
 }
 
+static void damon_destroy_prep(struct damon_prep *p)
+{
+	damon_del_prep(p);
+	damon_free_prep(p);
+}
+
+static struct damon_prep *damon_nth_prep(int n, struct damon_probe *p)
+{
+	struct damon_prep *prep;
+	int i = 0;
+
+	damon_for_each_prep(prep, p) {
+		if (i++ == n)
+			return prep;
+	}
+	return NULL;
+}
+
 struct damon_filter *damon_new_filter(enum damon_filter_type type,
 		bool matching, bool allow)
 {
@@ -1694,6 +1717,36 @@ static int damon_commit_targets(
 	return err;
 }
 
+static void damon_commit_prep(struct damon_prep *dst, struct damon_prep *src)
+{
+	dst->action = src->action;
+}
+
+static int damon_commit_preps(struct damon_probe *dst, struct damon_probe *src)
+{
+	struct damon_prep *dst_prep, *next, *src_prep, *new_prep;
+	int i = 0, j = 0;
+
+	damon_for_each_prep_safe(dst_prep, next, dst) {
+		src_prep = damon_nth_prep(i++, src);
+		if (src_prep)
+			damon_commit_prep(dst_prep, src_prep);
+		else
+			damon_destroy_prep(dst_prep);
+	}
+
+	damon_for_each_prep_safe(src_prep, next, src) {
+		if (j++ < i)
+			continue;
+
+		new_prep = damon_new_prep(src_prep->action);
+		if (!new_prep)
+			return -ENOMEM;
+		damon_add_prep(dst, new_prep);
+	}
+	return 0;
+}
+
 static void damon_commit_filter(struct damon_filter *dst,
 		struct damon_filter *src)
 {
@@ -1752,6 +1805,9 @@ static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
 		src_probe = damon_nth_probe(i++, src);
 		if (src_probe) {
 			dst_probe->weight = src_probe->weight;
+			err = damon_commit_preps(dst_probe, src_probe);
+			if (err)
+				return err;
 			err = damon_commit_filters(dst_probe, src_probe);
 			if (err)
 				return err;
@@ -1769,6 +1825,9 @@ static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
 			return -ENOMEM;
 		damon_add_probe(dst, new_probe);
 		new_probe->weight = src_probe->weight;
+		err = damon_commit_preps(new_probe, src_probe);
+		if (err)
+			return err;
 		err = damon_commit_filters(new_probe, src_probe);
 		if (err)
 			return err;
-- 
2.47.3

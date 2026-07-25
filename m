Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF636E467;
	Sat, 25 Jul 2026 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013358; cv=none; b=iLHA2D2JopqLY+40GvbIur5ct5InTiZezDkmPOV3/2O16Y9gKxnpubLBLQ83I7LAWNoGTYMiTQzrpFdPcF6SDvq38RKe5REbSVexYVqWWI7PPd4mxrYGdcMj1FAO6ZhwblIdQZaywi4sxabJbZx54FmdCJOI40bQSgga7n37tVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013358; c=relaxed/simple;
	bh=QROrfCzQixCQTszSavdn26Kts8/EkDr/hPWNC1d7GwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqLfCV11RhJ42QjQ2O/NhYrSHDx218f442MuKT5/qMQIvjbH1MtWvDjCizOyXj7e6DYHLdtVJR/ebeHEafJxtJrfL2hLooGu5BYlvjE+wJbplhUgvlw4X1rKetf/wovu4Q5G6v9QBFVWep6sA4/eGH3lclpinH5r98HsGN1oM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb5caqvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb5caqvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F27C1F00A3D;
	Sat, 25 Jul 2026 21:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013356;
	bh=SdtqE3eR/Bua/rulOOI8NT/gdSWbQwN4dD7fIeQTAXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bb5caqvbHTRWjD6+KqdsFkIoeWHz41IT88yOdjSWGzGZFaGmWnosSUw88TTQZhMN0
	 P0zlXq9/LnKrlpLbhfrcgYQs4pYxeBp9k4btPtP3G6t598XXJYF7YGW1BsExOA0/+v
	 dyD69RIUM/qtWHPSHLAGHSdvSU05YuK/cLwI4lCYUTtQ0CgNloZfISqr90T+8Oe6o0
	 ryDO9xwR1XHq/kFFCWGF9BbgAR1O7E1vCB0i3Jwpwn75BbLhURgTXqSQr/+9VqaoiE
	 L9oo1fEZhuyObTvAY3H9OF6/X8LYQJvtdTqLq0a5551o5QO+P2IE6Sz/opyaAhJQnh
	 /9GxvqoAHIN5A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/17] mm/damon/core: commit preps
Date: Sat, 25 Jul 2026 14:02:10 -0700
Message-ID: <20260725210225.129944-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
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

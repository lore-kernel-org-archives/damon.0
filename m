Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDBF38837F;
	Tue, 28 Jul 2026 04:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211978; cv=none; b=QIIQS8jZGEV9zIzYiVVDpJYfWp0XPfHayBK9Bj7A9DZ++jRhzanfqHj3VNet3l5yRqUs7dvzv2wZmkYHdZXgRjP3bHcsv7aJpgmktE7FyDSDqfFKQAEaso5nUW0816Mh2qXpTb2JZ9lStWTVuEkdclactEnA+liRsa9UFlIXweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211978; c=relaxed/simple;
	bh=zVXS2IKU7dhHdGpdaEBWEp54h+wsbCkrdeNESR9aOnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzVwPdk/Ci5TARtLkoMXD8vK8wgFOZ84gjlEV+t0DZBIc5uWwWhUBwgB4n24E0c3JMZ0hZ8BMcH9MpnTJ1BM4Qm8TL5gS9twEZKOPXmoPCeu1kMuzVET/Dui2nFdTDBL7Iev7lh+t66bBpgVsOM2ZK4ozwRODSjn/yTZoyq3xB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj/NT0VQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj/NT0VQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038261F00ACF;
	Tue, 28 Jul 2026 04:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211974;
	bh=34zeToEcXZjVDUJjZzX0H1OFs/41PDBV/Dxu9mrmuxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pj/NT0VQ9StLnnZ68P50TpeKNheICw1ZRF2QuEPytucxqIgGHaQOe7TzRRXEkIerM
	 15IRmV+UN7wf1/BOpkBofFhsSEodjjtK/RuLwfm6s+0KBaK3E8larGsBivRsZAfCx/
	 c+gky2rzM6GP/84E0CS+zoEILIjHKVR5xTzxAGZ2iLh0J1eFqocoWvnbBLBqDByRec
	 IznvRME+KQ9LLKGasIsIRIkxXsuB4mGBBZmvgmIn895JXTqca6Rmg/XfRdkZ6veY9N
	 4tLXzM90rsjWfYII5UJIc0iBdgp8U5B+05T7FDmrLM1WXqL2spMviaJUwsDycXkf1N
	 YH2nlvIVZUTQQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 06/17] mm/damon/core: commit preps
Date: Mon, 27 Jul 2026 21:12:27 -0700
Message-ID: <20260728041242.187380-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728041242.187380-1-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
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
index e8b5e6e43f9d4..01715648f6e0c 100644
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
@@ -1687,6 +1710,36 @@ static int damon_commit_targets(
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
@@ -1745,6 +1798,9 @@ static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
 		src_probe = damon_nth_probe(i++, src);
 		if (src_probe) {
 			dst_probe->weight = src_probe->weight;
+			err = damon_commit_preps(dst_probe, src_probe);
+			if (err)
+				return err;
 			err = damon_commit_filters(dst_probe, src_probe);
 			if (err)
 				return err;
@@ -1762,6 +1818,9 @@ static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
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

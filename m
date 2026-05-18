Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4033ADB0;
	Mon, 18 May 2026 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147685; cv=none; b=Iy0Sa+TmebknUaTw0kjLwbuvGyrfE4wFIlDe8KCvrw5El4uiUWn5GlTSI4VJoQJFn/mARUyjUEjkn65kuobXtTng3jxZQ8cU04U8Wt6e4ZpdFKazzWGM9hiAmF7yIYvlZ9CFX2ZvUPjeyRCio/qqlaeO2+wXCwgoINrAF6xHOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147685; c=relaxed/simple;
	bh=mIzkcH/5A3M6QuaehEH7P+cR7kb6K2TS5t1AbB4gd5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swJoDljmhkEVqEXR8jZfICwMmSX2CPwi9hYflWWG0zTfgow22dLnosIWmLZSZ5karfqfG3fb9wmzCN9uPJADJHNHRPu/i/0nUB0wulzcTLYiZZxHwPnZo9cV6JxK28nOfyppCCPPKd/MxAXQ9DQcmOd3rRI4wJcWohQik7Mjtk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os0gBHJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os0gBHJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2918BC2BCB7;
	Mon, 18 May 2026 23:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147685;
	bh=mIzkcH/5A3M6QuaehEH7P+cR7kb6K2TS5t1AbB4gd5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=os0gBHJHahHk/HMbnOsr8aOC6mf9fC0x+yISiRhTktEn1nluY6OaB82kZ2Y2HcTsp
	 VoXK6LvyKbN5P4ymo+BdJUI/FKpJGfrTXeX7jRTcpl5FGLN1AWEqsMjSMi7LoYjlmX
	 KaQRtevWPo0QgZPlK54LurK29YOMDPuSBxeqbH5iXLULy7CPK4Uh5W1wfca+16X1KP
	 Hu86EpXtFQNWk/WCNLLRopq25OIHTeRlDpldzP7hVtTdcsqJRk/CHbetIBO0ecRSmK
	 Cs32aLTLxmysA9hG+xbkX3/YCsYrBCd6Bejgyd6JAlLrgsgrFuvu3NVz1eDVMYQfPp
	 6s6S/rhp4LPhw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/28] mm/damon/core: commit probes
Date: Mon, 18 May 2026 16:40:52 -0700
Message-ID: <20260518234119.97569-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update damon_commit_ctx() to commit installed data probes, too.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 516368fbf1de3..075d60a4749a3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -133,11 +133,34 @@ void damon_add_filter(struct damon_probe *p, struct damon_filter *f)
 	list_add_tail(&f->list, &p->filters);
 }
 
+static void damon_del_filter(struct damon_filter *f)
+{
+	list_del(&f->list);
+}
+
 static void damon_free_filter(struct damon_filter *f)
 {
 	kfree(f);
 }
 
+static void damon_destroy_filter(struct damon_filter *f)
+{
+	damon_del_filter(f);
+	damon_free_filter(f);
+}
+
+static struct damon_filter *damon_nth_filter(int n, struct damon_probe *p)
+{
+	struct damon_filter *f;
+	int i = 0;
+
+	damon_for_each_filter(f, p) {
+		if (i++ == n)
+			return f;
+	}
+	return NULL;
+}
+
 struct damon_probe *damon_new_probe(void)
 {
 	struct damon_probe *p;
@@ -175,6 +198,18 @@ static void damon_destroy_probe(struct damon_probe *p)
 	damon_free_probe(p);
 }
 
+static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
+{
+	struct damon_probe *p;
+	int i = 0;
+
+	damon_for_each_probe(p, ctx) {
+		if (i++ == n)
+			return p;
+	}
+	return NULL;
+}
+
 #ifdef CONFIG_DAMON_DEBUG_SANITY
 static void damon_verify_new_region(unsigned long start, unsigned long end)
 {
@@ -1389,6 +1424,72 @@ static int damon_commit_targets(
 	return 0;
 }
 
+static void damon_commit_filter(struct damon_filter *dst,
+		struct damon_filter *src)
+{
+	dst->type = src->type;
+	dst->matching = src->matching;
+	dst->allow = src->allow;
+}
+
+static int damon_commit_filters(struct damon_probe *dst,
+		struct damon_probe *src)
+{
+	struct damon_filter *dst_filter, *next, *src_filter, *new_filter;
+	int i = 0, j = 0;
+
+	damon_for_each_filter_safe(dst_filter, next, dst) {
+		src_filter = damon_nth_filter(i++, src);
+		if (src_filter)
+			damon_commit_filter(dst_filter, src_filter);
+		else
+			damon_destroy_filter(dst_filter);
+	}
+
+	damon_for_each_filter_safe(src_filter, next, src) {
+		if (j++ < i)
+			continue;
+
+		new_filter = damon_new_filter(src_filter->type,
+				src_filter->matching, src_filter->allow);
+		if (!new_filter)
+			return -ENOMEM;
+		damon_add_filter(dst, new_filter);
+	}
+	return 0;
+}
+
+static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
+{
+	struct damon_probe *dst_probe, *next, *src_probe, *new_probe;
+	int i = 0, j = 0, err;
+
+	damon_for_each_probe_safe(dst_probe, next, dst) {
+		src_probe = damon_nth_probe(i++, src);
+		if (src_probe) {
+			err = damon_commit_filters(dst_probe, src_probe);
+			if (err)
+				return err;
+		} else {
+			damon_destroy_probe(dst_probe);
+		}
+	}
+
+	damon_for_each_probe_safe(src_probe, next, src) {
+		if (j++ < i)
+			continue;
+
+		new_probe = damon_new_probe();
+		if (!new_probe)
+			return -ENOMEM;
+		damon_add_probe(dst, new_probe);
+		err = damon_commit_filters(new_probe, src_probe);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /**
  * damon_commit_ctx() - Commit parameters of a DAMON context to another.
  * @dst:	The commit destination DAMON context.
@@ -1445,6 +1546,9 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	}
 	dst->pause = src->pause;
 	dst->ops = src->ops;
+	err = damon_commit_probes(dst, src);
+	if (err)
+		return err;
 	dst->addr_unit = src->addr_unit;
 	dst->min_region_sz = src->min_region_sz;
 
-- 
2.47.3

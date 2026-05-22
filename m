Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2148034A;
	Fri, 22 May 2026 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464438; cv=none; b=Xme9czhxlP/eASVkWPvzk3vXIGuR8+gIXJqlyxW407QmL4fm4Jbw7thomRZAAXmd/Rgw+uh4POyvij/3kICtaM2mEXloyGKf9h2X7olo1J+dh3zAP+FwHWPmRZjFUgeZ9K0NSj6VIo7jgZBLnBz7yiNvGDtdtgjjcb3JE4TIR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464438; c=relaxed/simple;
	bh=C0Qiz/68PoSKpJYdHo2J3oJvAucJHQFM7W7CTyDoh2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9Dno+AEYTZufGY5q2z7dwlgr5Zz9DHOa/57yGNJeXtNZaU1Y8pwgBeq1C0ztieqZsPbly04eLA2lWC9fle5lpHImD1A0EqT51HXlTueRKlodADThoCzQzkkUmxiBjeD4ZJe+IPZbDFUCQxbJ+2q5EjQVaABZD0EMyqpQH1X8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXmJ8xxE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXmJ8xxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394341F00ADF;
	Fri, 22 May 2026 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464437;
	bh=3LRLg3Pzb74v2r5bZtbtebH98gpHkUBcEoBkx4Qaj+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AXmJ8xxEVqJk8EwZs4vGzDSg1N5AXkYdEkpuEWmtsQp7DLw+TPHCX+YCjo0I33iWY
	 pq8Z2RcNU4qVdSnOLniVP/FwzKcj4QHyrkE6SNuzzfaOOpcrAj/fpn+1UTGEOaEq5R
	 5yJcY24guNKOe056G/Nftj4aoaKnzy4b/iCP8dgJJmRV7UC6o/TUttzOTiggHwqksU
	 uJ8abn6uskjg9VQTcyxRZUie7hcK/JHO0yp17dsbOiX72BI+1CJKiwmzBby3s2Qihw
	 HTxw0ogANEdaHkwi4cFAwq8fFwm/X7w1VntDpkdzCNHnfcbHFDaqPYA+mHwFRJGq8l
	 SjEbA8op0i8tQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/14] mm/damon/core: add kdamond_call() debug_sanity check
Date: Fri, 22 May 2026 08:40:19 -0700
Message-ID: <20260522154026.80546-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522154026.80546-1-sj@kernel.org>
References: <20260522154026.80546-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_call() is the place where DAMON API callers are allowed to
access the DAMON context's public internal state including the
monitoring results. Hence it is important to ensure it is called with
the expected DAMON context state.  Do the check under
DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8a9202937781c..9cde5b47b9585 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3331,6 +3331,37 @@ static void kdamond_usleep(unsigned long usecs)
 		usleep_range_idle(usecs, usecs + 1);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_ctx(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	damon_for_each_target(t, c) {
+		struct damon_region *prev_r = NULL;
+		unsigned int nr_regions = 0;
+
+		damon_for_each_region(r, t) {
+			WARN_ONCE(r->ar.start >= r->ar.end,
+					"region start (%lu) >= end (%lu)\n",
+					r->ar.start, r->ar.end);
+			WARN_ONCE(prev_r && prev_r->ar.end > r->ar.start,
+					"region overlap (%lu > %lu)\n",
+					prev_r->ar.end, r->ar.start);
+			prev_r = r;
+			nr_regions++;
+		}
+		WARN_ONCE(damon_nr_regions(t) != nr_regions,
+				"nr_regions mismatch: %u != %u\n",
+				damon_nr_regions(t), nr_regions);
+	}
+}
+#else
+static void damon_verify_ctx(struct damon_ctx *c)
+{
+}
+#endif
+
 /*
  * kdamond_call() - handle damon_call_control objects.
  * @ctx:	The &struct damon_ctx of the kdamond.
@@ -3346,6 +3377,8 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 	struct damon_call_control *control, *next;
 	LIST_HEAD(controls);
 
+	damon_verify_ctx(ctx);
+
 	mutex_lock(&ctx->call_controls_lock);
 	list_splice_tail_init(&ctx->call_controls, &controls);
 	mutex_unlock(&ctx->call_controls_lock);
-- 
2.47.3

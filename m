Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADE385D85;
	Thu, 21 May 2026 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335644; cv=none; b=U6hYq5C+4kMj5XV6KO5Zrt8RKnYaa5V78JtYVZIM7QxMgA3gXV9/QxqG9+4gAoge/og4GiuR9VY17Uxyaaiza8/+2/AfhEWwNK5zpt8H0R/FPX2pthlOO9feywA9zNFI8oT6apLCsT/IFTfdPUvziNgwt/V3Qq2wd7pJBvmknd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335644; c=relaxed/simple;
	bh=C0Qiz/68PoSKpJYdHo2J3oJvAucJHQFM7W7CTyDoh2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNmhlqlSB9mdRrKMhJgKh+CSAO2oPgCnF7I3SHEp42KWc6FZRDpVegTEZ42olibtwn8sf+h/b8OmaLBM8vlhxdSi35hbh4eCBaDp/v3hOCLnXiB45OSKmkIgvKuYjZ7/i3LHBdmDKOM/Z/l2npJXMcOE+A0Zq6rL6YewHaQiZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks9saREB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks9saREB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D0F1F00A3B;
	Thu, 21 May 2026 03:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335642;
	bh=3LRLg3Pzb74v2r5bZtbtebH98gpHkUBcEoBkx4Qaj+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ks9saREBtZOWlYAPafkbYozBvHE7crHWSGnyh8/GJsZINt/3zqYHh/B9nm1pDFLf7
	 RlfFGKegD4ZcvdN4oRUK/kDitm5IAELqD+t8Cr+p3o4k3S6Wy9gda5Ri89bn7rw/x8
	 DJkg5jR8VlbwJ6m74+vKZqcS02VgM3xNQ5rTTQcjU+pZtVXiKI1LB56DGnfm+GoC7o
	 nmOahC3p80pHsHOt1jHMAXT0qtUXtPNiflbBWCavuMUPLC/FZ4ByDXBKLAmpP25VGe
	 imHWJgTgMBN1U8ga6TZm3XoCTzjmgQW/hjmqjG1SdEJW5i/YM+zfR+GAzvNCh4gEES
	 n2VBk1rVl/IPA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 08/14] mm/damon/core: add kdamond_call() debug_sanity check
Date: Wed, 20 May 2026 20:53:42 -0700
Message-ID: <20260521035349.87565-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521035349.87565-1-sj@kernel.org>
References: <20260521035349.87565-1-sj@kernel.org>
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

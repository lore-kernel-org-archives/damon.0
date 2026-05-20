Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292C376467;
	Wed, 20 May 2026 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258552; cv=none; b=dDFs+Sk3xLoGQ5HYKTBq8gYIjgJ1/KhuI7yzTyIWVRWAqdMzqvTPfuttBW9fuV5xiSorrkD5cBQOIWZ0EITjNWxZ1uTIuWiyFecodMuc0O8xXaOoGhnTDFaWvW/YG888itNDH6j39Y/8Ajib5JNAJ4doJEJrVHTV6pxOqkVhEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258552; c=relaxed/simple;
	bh=vDoPI8lyHPrQfO8muAiHWGNu1mY1mz73wjqr9m+a9Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgX6EZIqDcQSgwL2j+wf+k+vOuTDrA7dMvYLr2SZcccIGAIClHqzgnNlb/Na40xggraIAiTNJwviEmEbcQd8BntkDDxgTPc2I5mgUambMo06yd1jOqE2TADrTBO6Mf5Nz70U7JkQ0zk25KuaGGPURFKhjDZcKGWzyiLnyVZm7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blhZA/UH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blhZA/UH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4217B1F00897;
	Wed, 20 May 2026 06:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258550;
	bh=aYW2M5njFjCEQHIQ96ZTAgTiOW4IgJkF16+H3Etztlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=blhZA/UHUql9L31Ecqg4e2HfnW817burhArAW9gQ71ugq/krO+fEoTqn+hLfMSfC5
	 3VPXnPY0eckIIvFijgoaAsf/x/UXQCQVoiPScrnD+v8k1Qa0sbb9S0g4JwprszQH6o
	 9u3vprjEskZlYJL03unY07qCGZLAjJf5rH2bohGhza3Wn2nzaXcp5HyheNP6ePyDUI
	 obw9DDDPbrlU/UpHF/T8wiN+FcyWWd5UOCjcuetjDB2Q2KS5RSdLZHhKwGLRGJoCNI
	 tTy+HAc/XZpdDyWBAXFtUlqHFoeb+NgJuRmTkUgMN2eVtZa3npQkwteUwzk+C36D60
	 WR16KRDZj+zbA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/14] mm/damon/core: add kdamond_call() debug_sanity check
Date: Tue, 19 May 2026 23:28:40 -0700
Message-ID: <20260520062858.167011-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520062858.167011-1-sj@kernel.org>
References: <20260520062858.167011-1-sj@kernel.org>
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
index 8a9202937781c..22327a23c7e57 100644
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
+			WARN_ONCE(r->ar.start <= r->ar.end,
+					"region start (%lu) <= end (%lu)\n",
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

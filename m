Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806619;
	b=O24vEcOBTsFy+lmzTHEZnUBD76V7jc95ZF4kjoi33zI+5ywZE0ejGspa5lhlv/7Aqb9p
	 aiPXcdkNOr1/crxQ8kEU2SsqBZlA9VhJibREV1C8yqPfeJwIdhlGYG1TzuJauwvFMcUbk
	 mP+VfMtIOm1tuWu1kwJjiARCyU2BEoCpxCHlanQua7VIWEmV5WS3TPkbPkOdoFzhm71NB
	 k6bD8zAuRU/ISKVBUPyVheTcSXbHbkY/hBsVs9d6zWBbG3Va38aTuCuslhTcTYvc8v8Wi
	 JPLSadlbQdc6NyX9WG0HgLzv7Keg+uAclN9IzBxBKePdBxEsrNBZ1tQQA7WjAQ1ca5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806619;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JeL+DmgE5YyYXsJkdebLi+O+vsds87IrC+NKWQ6kmew=;
	b=Uljs84ONY/S7KUJF3Mmd0j8ebz0cSVv7BEphP0xN46j5yhZ2KQ71I5HBLpUZ+/oQXxHO
	 Qivtbsy2KVEaFqW2o22Am6THYSGroVjZ/eINdp9fs3f49ldNRTchWWBIxiW3z6ehirKFo
	 Od0gqXd1BB/l1sCkEiX6BqnOUUeN61T9zQAaNh7L+7aVw8NCmsH1o1QlqC8PFhgMtHxWF
	 Fxc/0bpn/iQ2Hd0hjBvbBZnbP/jhZ22OSwUCZqNkBKlw0+Ww6vFbjag3KZOL9VVItEQTh
	 kiWLT/8a4gOEmeHReGUXyv1zgsbVcpC93aCx5cZPjlZND4Yjr2H1j/R2ApPnp7fRqGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaDnbB4Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29825606A334;
	Wed,  4 Nov 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaDnbB4Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00B01F00A16;
	Wed,  4 Nov 2026 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806618;
	bh=JeL+DmgE5YyYXsJkdebLi+O+vsds87IrC+NKWQ6kmew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MaDnbB4ZKPEpt6u0RSOjm+lgGWDW7uts+5vIC4xFaTDiY17cIhPmLHgDGLOSYa05Y
	 o+af8jUlzk74/vejpynM/TFOKwcQWaaJU0L1OlYysv40CDEti07OwiLv6w8ClWeAYj
	 78ckUFlYVDGf4PNpURvhfw8SEe/MYP7k5ThDBv0uC2CTCm8v5Gp/ICiFLtC7FIT2Nw
	 Yez7JAJ97l0Qrv5vLAFF8DkkzpPygd/XjXzzJtD+9bsidNJETijLCVkeVLaU2BtzSc
	 JPK54RQJwre2eUG1r7JmGkjXptxpFCSNB/VuWGRhGzIPx1rmRWWcKl3Uv5+wyEsBsp
	 LpGdBp2mkAHpQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/4] mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
Date: Wed,  4 Nov 2026 07:36:40 -0800
Message-ID: <20261104153645.82945-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104153645.82945-1-sj@kernel.org>
References: <20261104153645.82945-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no way to specify DAMOS target regions with a deterministic
time based age range.  Extend DAMOS core filter to specify target
regions with age in milliseconds.  Introduce new damos_filter_type,
DAMOS_FILTER_TYPE_AGE_MS in DAMON API, and implement support of the type
in the core layer.

Convert the age in aggregation intervals to milliseconds and use it when
the filter is evaluated.  Reuse damos_filter->range_{min,max} to save
the age range.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 16 ++++++++++------
 mm/damon/core.c       |  9 ++++++++-
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 380f9cf6ddd82..1302ffb6f0bcb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -394,13 +394,16 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
+ * @DAMOS_FILTER_TYPE_AGE_MS:	Region age range in milliseconds.
  *
- * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
- * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
- * damon_operations as a part of scheme action trying, and therefore accounted
- * as 'tried'.  In contrast, &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET
- * and &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filters are handled by the core layer
- * before trying of the action, and therefore not accounted as 'tried'.
+ * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET,
+ * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM and &DAMOS_FILTER_TYPE_AGE_MS are handled
+ * by the underlying &struct damon_operations as a part of scheme action
+ * trying, and therefore accounted as 'tried'.  In contrast,
+ * &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET,
+ * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM and &DAMOS_FILTER_TYPE_AGE_MS filters are
+ * handled by the core layer before trying of the action, and therefore not
+ * accounted as 'tried'.
  *
  * Support for the operations-handled filters depends on the running
  * &struct damon_operations.
@@ -415,6 +418,7 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
+	DAMOS_FILTER_TYPE_AGE_MS,
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d36823f4d0928..d631863b034db 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -659,6 +659,7 @@ bool damos_filter_for_ops(enum damos_filter_type type)
 	case DAMOS_FILTER_TYPE_ADDR:
 	case DAMOS_FILTER_TYPE_TARGET:
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+	case DAMOS_FILTER_TYPE_AGE_MS:
 		return false;
 	default:
 		break;
@@ -1336,6 +1337,7 @@ static int damos_commit_filter_arg(
 		dst->sz_range = src->sz_range;
 		break;
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+	case DAMOS_FILTER_TYPE_AGE_MS:
 		if (src->range_max < src->range_min)
 			return -EINVAL;
 		dst->range_min = src->range_min;
@@ -2552,7 +2554,7 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 	bool matched = false;
 	struct damon_target *ti;
 	int target_idx = 0;
-	unsigned long start, end, wsum;
+	unsigned long start, end, wsum, age_ms;
 
 	*err = 0;
 	switch (filter->type) {
@@ -2594,6 +2596,11 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		matched = filter->range_min <= wsum &&
 			wsum <= filter->range_max;
 		break;
+	case DAMOS_FILTER_TYPE_AGE_MS:
+		age_ms = r->age * ctx->attrs.aggr_interval / USEC_PER_MSEC;
+		matched = filter->range_min <= age_ms &&
+			age_ms <= filter->range_max;
+		break;
 	default:
 		return false;
 	}
-- 
2.47.3

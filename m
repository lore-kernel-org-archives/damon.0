Received: from mail-yx2-f9.google.com (mail-yx2-f9.google.com [74.125.224.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912139BFED
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791061713; cv=none; b=L/PGFfZo2bdH0+XPO2vg05fZlnDrTjNpm2pI7vP7envLbnAptxJOZgOSBqEarZ7167ZJRG1XbyUbdcVUyS1NmDJMkeGGcgcucIL1aqPdrMI5iFkFe5o/lVIIZ8419+NijA7FwCFcs0owqPYSD9y+DCnZUvcYxcExeXetbw0hyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791061713; c=relaxed/simple;
	bh=sWnaJ6XMERLifu7SIUWAbGgqmKm15NV7t/6Zh29vc9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z8bgKMPtgApJ3+UMMg8+oBJR//jDCanVjKZXve6EzF70tDW4tmGNB3W5K0ecmK6YB9b060g8lMzvWGjeyPKiC6IqP9vF2CTKo6tlOVA8QW60CWdZbxyLAlJRSGhdQMu36nS3A2NLgCm7wFHjklWLnlET1t2/e0Inrq4ewaHMnnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7WXETBs; arc=none smtp.client-ip=74.125.224.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7WXETBs"
Received: by mail-yx2-f9.google.com with SMTP id 00721157ae682-8a242f44e2eso973757b3.0
        for <damon@lists.linux.dev>; Sat, 03 Oct 2026 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791061711; x=1791666511; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2fqUlY6qim2cHCeufDeEuXDmVUcy77BBS09bM8HasmY=;
        b=A7WXETBsXviWGnNYXq4Z1D58WHItnu3kpVf9o1LxTklqMxc+9yWbwZr8b1z5JFGB96
         QWs2E3c2C3oA3Fs7f8FgpaTOL/TwyXWFXKs+TOSEHqcND8IkGDGcDggAYc4jYpjBB+st
         YI5D1nbvGz6HWfrcjefcvWDP+c0+XJ6k3AaxQJY90OCI5Jy64/ccIqmJ6FD9O2oVcprt
         HJtr0YPdLAD1/FIEYWyHgcNTuaOUZqtYNUOx7fS5eWFaEF+JHiUqXOELF3TIu+juh69d
         lvUbNjozHg0yLE0rjE0ZQ6d2gRo0RO1ralWQFkr06BwQs8p6eqCbViFV4ROW7091J7LO
         dOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791061711; x=1791666511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fqUlY6qim2cHCeufDeEuXDmVUcy77BBS09bM8HasmY=;
        b=QdGZwc501xAkkZpeSjAVmwwXyEcIaazlvOQJzLrx0wfF33XJJzgCB8Oo4jk33+oylv
         K4jHnugqidv888f21oa1AwzVfr2BMpj3Precj5lHTgrKo1gqlqR+XGG6IBOXbWTuaAG6
         +qGGsjChvwNcK1XBGKZrk5HfBZZPuDnmiYlBXcWvqsZttVPnFkmssKcHir5PHeHlF41K
         LbRHAgHIwW+RRP4LMUil+6QtLA2R/PlHLly+bONwvoeqtYr2M/zD/LZJdb+xwBVqJU7o
         tIHh6mR9ES7clp8ismDSbg9W5snba2BNOzPlzgnYlcNguF9XEEQEhHUjO7qyGUur/PRq
         iRuQ==
X-Gm-Message-State: AFq9FYJZoWxfk41UD/WYeLKbLB1ni2MCT1ZdxM9zNHFboc2Zih+HA2vp
	F5+bp9kh9Hy5SBf/bm0tnrtuY6a02JSDUZZ9UZ05GcK8U2iKP098Bk4=
X-Gm-Gg: AYBFou09HJqZLAwkYLoTrhbKq/gGQwQDGZN8n6KR+j/kQdHOx5VpePzeE8DYcybrv+T
	huylZIZ5vK/xStu2stvrLhzk3z3EPrt+qH+Xu+ajCEPFNJvRbBj6IflEORaDPIjs5Cswb27TLsl
	wVJtBbh6Z1zJEcfFdmkCGPh6GEWSGW/OqDHekBH3RbAZM2h3OllaG40Y3vlR7b8t3G+YBam0AYK
	Yl6b1Vl40lrRUBWZnVLvcra2WWCIhZ6f+N0fjkU77OffEfz+L5IKFtj8/XYiR+lXfiHKNL5L4ve
	mvBf3S+xQgf27SuAG0pE8e2J43fx1jv79dtrN0otG0LD8SXXGy6gs8TlQGjttzh5E/PYmy0g8y9
	ZhP1JAXNuESdAvLjpTuTKM7YKVhRZQ9lbJlJLM/Vd0Z3ZaP6yS/8p3KQkt4TY2hwIWzR0xbpTFZ
	SSsLXk06YbGUzYdH9pr1Kv+UvmLZ0mG9GrStuKvmFI520/6kGbEpnslj9mDVnUatmrdLjH2xNvs
	FCmR43msnDbLFrL+y17DWkBieOtCcr2vxEosaCUiWX0RAW7fcT4PwPILEGot8/F5I8xwK7e1heX
	EbhJ2S6g+FjSqQ0Vlt8Gc/n2SvIBUYsaaw==
X-Received: by 2002:a05:690c:e3ed:b0:873:17c9:afca with SMTP id 00721157ae682-8ae94c981a5mr12007377b3.29.1791061710890;
        Sat, 03 Oct 2026 14:08:30 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:550f:9551:5468:60f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8af0d179d3bsm743537b3.40.2026.10.03.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 14:08:30 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Sat, 03 Oct 2026 14:07:57 -0700
Subject: [RFC PATCH v3 4/9] mm/damon/ops-common: use probe-weighted score
 when probe weights are set
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-4-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gregory Price <gourry@gourry.net>, David Rientjes <rientjes@google.com>, 
 Wei Xu <weixugc@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
 Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
 Kunwu Chan <kunwu.chan@linux.dev>, 
 Ravi Jonnalagadda <ravis.opensrc@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0

When probe weights are configured (damon_has_probe_weights()), use
damon_probe_hits_wsum() for the frequency subscore in damon_hot_score()
instead of damon_nr_accesses_mvsum().  This routes hardware event counts
from a perf-event probe into the tiering decision.

When no probe weights are set the frequency subscore comes from
nr_accesses_mvsum, so page-table-only monitoring scores from the
page-table access rate.

Export damon_has_probe_weights() so ops-common.c can call it without a
static dependency on core.c internals.

Guard against integer overflow: clamp the probe-weighted subscore to
DAMON_MAX_SUBSCORE via min_t after the mult_frac scaling so a large
weighted-hit sum cannot overflow the subscore range.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       |  2 +-
 mm/damon/ops-common.c | 21 ++++++++++++++++++---
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 217299aa6c03..d7baa6a58d3d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1306,6 +1306,7 @@ unsigned int damon_probe_hits_mvsum(int probe_idx, struct damon_region *r,
 		struct damon_ctx *ctx);
 unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last, bool mv,
 		struct damon_ctx *ctx);
+bool damon_has_probe_weights(struct damon_ctx *c);
 
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4fd1db12bc49..6a90cf465d40 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -351,7 +351,7 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
 	return NULL;
 }
 
-static bool damon_has_probe_weights(struct damon_ctx *c)
+bool damon_has_probe_weights(struct damon_ctx *c)
 {
 	struct damon_probe *p;
 
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 2f3bf86a221b..8cc6bc440153 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -172,9 +172,24 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	unsigned int age_weight = s->quota.weight_age;
 	int hotness;
 
-	freq_subscore = mult_frac(damon_nr_accesses_mvsum(r, c),
-			DAMON_MAX_SUBSCORE,
-			damon_nr_samples_per_aggr(&c->attrs));
+	if (damon_has_probe_weights(c)) {
+		unsigned int wsum = damon_probe_hits_wsum(r, false, true, c);
+
+		/*
+		 * Route perf-event hardware event counts into the score.
+		 * Clamp to DAMON_MAX_SUBSCORE so a large weighted-hit sum
+		 * cannot overflow the subscore range.
+		 */
+		freq_subscore = min_t(int,
+				mult_frac(wsum, DAMON_MAX_SUBSCORE,
+					/* +1 guards divide-by-zero: samples-per-aggr can be 0 */
+					damon_nr_samples_per_aggr(&c->attrs) + 1),
+				DAMON_MAX_SUBSCORE);
+	} else {
+		freq_subscore = mult_frac(damon_nr_accesses_mvsum(r, c),
+				DAMON_MAX_SUBSCORE,
+				damon_nr_samples_per_aggr(&c->attrs));
+	}
 
 	age_in_sec = div_u64((u64)r->age * c->attrs.aggr_interval,
 			     USEC_PER_SEC);

-- 
Git-157)


Received: from mail-yx2-f0.google.com (mail-yx2-f0.google.com [74.125.224.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48F419FC9
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190025; cv=none; b=r3bVkznT1CO7X0pXof/FINpiTpXB1B9Hroify5OYranlKatc+159wVNyhDKxGyZ86SoaCNWRRN/xFhUnBErDwpYD9sBr+2FlcLPFKDhAfJe0PDLz+0V+Ce3gZi5nOR0cJwgZB5VXPmF+n8EJRY85wfkRhnGxD6vhGUbShHRyQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190025; c=relaxed/simple;
	bh=1EYjs7dr8001HZvpN6OGACF0FxNrGTYPiyEH6vsCQ+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VknMNeZbfAdODDLt7MoRTCwIWPzquLRz6giBDBU+/ryFEd5+9t7iIzXXKY+23SJBnAKlgQbOmWVMKPEj/INY0HmA6pkg5aFAVO0bMZVOZ6fYfJWK/OYpBZ9JBhz3dEJHvcI+nCQLeexKjQEDBXcmK7lpWvdEGs4QCfpgwN4/vuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtJu1KZd; arc=none smtp.client-ip=74.125.224.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtJu1KZd"
Received: by mail-yx2-f0.google.com with SMTP id 00721157ae682-8ae7b865b4bso4848387b3.0
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791190021; x=1791794821; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eK57rzngoR9p64gbd7b8c0TtXsJytTuhMQ1jUtQZOy8=;
        b=VtJu1KZdbKO6bPRwYg9zvI2/R94RwOnO2izsJKQDmRBYP0OW7VVyZp6E+3N3dSKUCk
         QGwkRxg3ZWlZE0teTcoIFVpDnCLv9enDQRIqq0yA9ysJmw7HyIhPd7WzXRKjtg1lBy5f
         tJ13Bm2i/leAVT0HHD4GRCreWoUc5UzZmnabZKrQAfQGf5jIhCn3Qwft7akdKyy5Kv8F
         Qmd43/s3K54DqHn81j31azvUz7bmSg6TjFn9/efieV8Ya5vnSTamkBcbSi45uJnMWtOA
         a1mCth0OgY57DDtHYB60Kz4GLYL39k/5APy3Pilz5z8Y8FWxyzM0hDaLYHtjVhPGtbzo
         5omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791190021; x=1791794821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eK57rzngoR9p64gbd7b8c0TtXsJytTuhMQ1jUtQZOy8=;
        b=RPsxJKujwCSry4JfcoGXBTz8C0ZrMDKYge9TUbN5Q2attu6nUPX+BPio8n6Muscm3g
         4TU0UluQjuZ0mqCZHp40eW+BcobpumyCjF880ib02ozwCarQoCnqjc/qjmnW/+NXRBwR
         6YDTiroIUtYJlmHNTkxO3g9p9HATMDXxOwxRYNsq1dE2Lk787W1N4Ak9HX6qfypzIWfW
         ym+qPTZqr28ZCmSe/bTUuYm7olDjwYr50b040DfYpPqo9PlUFiVTUa3nTY5ujzZzAwkI
         fMX0bdZBJCHPjhJY0uJd77PAbpLr5yeJeLf9rwDwXfa63mJuJw4h8+ndScq15T6QQbzb
         /ZXw==
X-Gm-Message-State: AFq9FYKa8pzp9yGyTDnOuZcvy2Auvgj+htHK31kERSLnO74EweynnT5c
	un+lzOGQZ4f0QumpZUnA7ffLIEk1QAv7fEOW06DmP8xTZyANNT+fCv0=
X-Gm-Gg: AYBFou1fZbvi+3ZYP8cdFpuAdGfMfzyn5yN1S3ee5N0ljz114WDrB7qt+aU8aP0d4oc
	MOfVaDmcYM2yEJ7G9Wwk6TeurrZiQwhoNR3DFXtIRU3ZTgXauKLTT2kZi7n+zWB1y0pwpMrnDt2
	gzOc49SbGl8WfjCmsxVWD4/QG9kVVuuROXKq898+nxmJjxN+IQevr5m6viG1zmrX5Ev3H/HUiqg
	ET+f0x91Cpl6X/gwNJmK/B6/NiGbmhobeoRwgXikRPpzuIM6tTHb+wNKU9+cJiC+LWtKE4wdgFN
	YCaI6iZyvhCo+NYwuj03CaAOT/ORIi5uUlSskGmHPPXnK1nTiwPm6iE47l+ufEH/D7b+F1pJ2+z
	F/E56Bj6hROEJSre6pjhAoPShZ7mYDHaw1jeMgSp1H5FYNLU2ROiKSN07fBATHRKv4mfnV5bWJU
	Eec67b4uyNzlmNC9TTWAJaoX7mQTuoeHwv2CQPiuaIZ/RaC1IspEaq0j8GK9O6cUGrInIffllzA
	mJDhvxRMsWuTldu3VAX6da2aSgtqHEI98uVFUvNujverMMo68eFKXWhSX7sZD292lxYRAfwrF+1
	FTTzCToczX3Qsx1sNQJbeny2YEa7q7Mhdi1ncvknkJP6Zw==
X-Received: by 2002:a05:690e:dc6:b0:677:d455:5198 with SMTP id 956f58d0204a3-677d4555829mr984847d50.40.1791190021565;
        Mon, 05 Oct 2026 01:47:01 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:1149:2fcd:c86b:8747])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b9c895sm2346306d50.13.2026.10.05.01.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:47:00 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Mon, 05 Oct 2026 01:46:48 -0700
Subject: [RFC PATCH v4 4/9] mm/damon/ops-common: use probe-weighted score
 when probe weights are set
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-4-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
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
instead of damon_nr_accesses_mvsum().  This routes the probe hits of a
perf-event probe into the DAMOS priority score.

Make damon_has_probe_weights() non-static and declare it in damon.h so
ops-common.c can call it.

Scale the weighted-hit sum in 64 bits and clamp the result to
DAMON_MAX_SUBSCORE, so a large sum cannot overflow the subscore range.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       |  2 +-
 mm/damon/ops-common.c | 19 ++++++++++++++++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7c5a416e1eff..b0895ef477ed 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1306,6 +1306,7 @@ unsigned char damon_probe_hits_mvsum(int probe_idx, struct damon_region *r,
 		struct damon_ctx *ctx);
 unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last, bool mv,
 		struct damon_ctx *ctx);
+bool damon_has_probe_weights(struct damon_ctx *c);
 
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a15dc7e9125a..9fc536238c2f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -331,7 +331,7 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
 	return NULL;
 }
 
-static bool damon_has_probe_weights(struct damon_ctx *c)
+bool damon_has_probe_weights(struct damon_ctx *c)
 {
 	struct damon_probe *p;
 
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 2f3bf86a221b..3c5cd745f4ba 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -172,9 +172,22 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	unsigned int age_weight = s->quota.weight_age;
 	int hotness;
 
-	freq_subscore = mult_frac(damon_nr_accesses_mvsum(r, c),
-			DAMON_MAX_SUBSCORE,
-			damon_nr_samples_per_aggr(&c->attrs));
+	if (damon_has_probe_weights(c)) {
+		unsigned int wsum = damon_probe_hits_wsum(r, false, true, c);
+		u64 subscore = div_u64((u64)wsum * DAMON_MAX_SUBSCORE,
+				       damon_nr_samples_per_aggr(&c->attrs));
+
+		/*
+		 * Score by the weighted probe hits.  Clamp to
+		 * DAMON_MAX_SUBSCORE so a large weighted-hit sum cannot
+		 * overflow the subscore range.
+		 */
+		freq_subscore = min_t(u64, subscore, DAMON_MAX_SUBSCORE);
+	} else {
+		freq_subscore = mult_frac(damon_nr_accesses_mvsum(r, c),
+				DAMON_MAX_SUBSCORE,
+				damon_nr_samples_per_aggr(&c->attrs));
+	}
 
 	age_in_sec = div_u64((u64)r->age * c->attrs.aggr_interval,
 			     USEC_PER_SEC);

-- 
Git-157)


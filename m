Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7B3D525B
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095342; cv=none; b=kQGu/bY4ebvXVjzF+/hGxNiaVZ0hzMZeu7Q9qiF7K9UeJc08IGugkThe5AlHads2Zi+nnPLMhymlxNgqsYVVwnMYUdyJ/6Ef/H0Ik1fiLm049O5u5/RI2bc1PAF1hcPeFUN8IxwO74JDrgkfVXhYUv+bw2aVa4HZnr8+WlvHRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095342; c=relaxed/simple;
	bh=KjOlarnqYLzu4XwtvEKCqscmE952xG7Ru+8qqnTDNZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FikKuOk8TXT1V5BBIeFx+RBeOZC3VDLtdNCCnuLoOhSFhI43zx2rdZyyjmx5zKyXlhDFSdJvxP5RqE0Z6nM7jy2ShTEPiQYKDo74TNphpdA7gy5LLGCrQzdNeCHjqnRoJ3HGbJz2g3gVkc4cMQ36TdLGPsijspkDOuCSnZneNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpoN+Umw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpoN+Umw"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2620445a91.0
        for <damon@lists.linux.dev>; Fri, 07 Aug 2026 02:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786095340; x=1786700140; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wpE9LlR4n7E+nsWeZA4Ufk20Oj2MKir8BCmBsXj1cZ0=;
        b=OpoN+UmwDPaVh8bCgEg60i21UD+nmiLW01FVXBfT4rGaCL9I4xgb8SEq8Ne2E18d4P
         HlDqYw/DzgOKUxgRrF5n5WQkg44xC9laO/9UjljM8nZhAG2//k0mImyRw01KUVyWwiPV
         Oz76arCeifu9uHx/DGi3RnUGQ6W97dpWrljjSUFyn+F/CpB1UuxuHhYZS7a1RY9wPF30
         6EuM6u8YjrEfKr83kKVQGm1A1XJMnhcaprO/37u6N3SriipZXYlkvOmVLBfbnRW7Ui/G
         /vHn48g6BxQmrk4pNa+MB6P4Ej079gTE49/RHLHaf6ARn72h5mnJv6JN/fohdbu8WbJx
         GVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786095340; x=1786700140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wpE9LlR4n7E+nsWeZA4Ufk20Oj2MKir8BCmBsXj1cZ0=;
        b=r/yi2SpLq1wOyRIb4BsB5SUoaohct0WsfnEIOBHal5tXf700vw/RfmdD+pUWIdjBti
         kUJcN1zUscLxRHpGKfuLg5a15uSWfjd9L2EUkZYhXKIjs9gTSpEoaTIktbUmp/hCfT7h
         qmOOdfgXqVQGN/CsBA0rD8lK+wPbt2xwd3HCyD5tXX/boW3C/MErHLdl6PW5pqtxODCa
         LisezBhFGOnXBm10jCT4zxoHR5crnBhiQEgnwlq8MPtUhl6vN8IHRvjFazbHa0v2QwRw
         ASGToP1wlxzIAnPVJO5YMeVboJAwuzAT4u0pHTwJurYvNsw6emeiWKgl6rNLrqVLmHlu
         DL0A==
X-Gm-Message-State: AOJu0YxqDBb/w7BffpmNDPtiBKJN/e+XB7Iw4l67qnCPi/CovksNxL22
	tFtLJ/wHkMxRBNDSVijbW4U7Ws+mdn6J6opoZOIFx6wZEDRvncyW9GiKaEeZAA==
X-Gm-Gg: AR+sD11M26Z/CLVs5fcJBZnkv3rO00565/Em8W0W5l64GJ1JJEqIcN0dXvyhkBzBfIR
	UHn/7D+n+W5kpUBFh0gJsgDvYTrTg6S1iaddF+9ktjrzdt7kGPkgy62QR5B6zojAtr5vS9+XAcX
	ONF2nfKzcZm1kkAbbXL7epm3+X1d9DfFn8gsaNSo/qRGMDd/cvJ4ClXvaPn2UkhuwbPrZ/Q53kN
	TDDnJCck+jXQlzcSpYWjqI0s16F2P6zRcH/nT5qGA/lnbTMlvSWrFJAKVsiUPf43f3SsfQ9EMaZ
	uGP3+pbtACjEUZT6wa/L/WIn6zxHTbTBFBfhSsyh5rYLKPV4bc2ZCHrLxHqi+qpnxTdmYr51EYA
	SksKC/V2kG0ZyUj1wPyVKbbHL54QqZ5A9LXoZDTzjfuOByeymlGpuYu8cTj87BGmc5PkRmdN5Ba
	wfzLDPlI41kXx9c5yOKYa7L/PMTWD43wl242usrCs3JPCWn8nr28Qgd0UqoyKYRnrnW89t32zmW
	QQ=
X-Received: by 2002:a17:90b:4c50:b0:381:5a08:6291 with SMTP id 98e67ed59e1d1-3909d917dddmr6862093a91.20.1786095340044;
        Fri, 07 Aug 2026 02:35:40 -0700 (PDT)
Received: from celestia ([2402:1980:935:f4a7:6f5c:e816:9aba:2090])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3926254ee45sm1604269a91.2.2026.08.07.02.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:35:39 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH 2/2] mm/damon: skip deactivated schemes in watermark checks and add fallback sleep
Date: Fri,  7 Aug 2026 17:35:26 +0800
Message-ID: <20260807093526.183009-3-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807093526.183009-1-aethernet65535@gmail.com>
References: <20260807093526.183009-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to DAMOS design documentation, a scheme is deactivated when
nr_snapshots reaches max_nr_snapshots. However, the previous
kdamond_wait_activation() still checked the schemes which nr_snapshots
reached max_nr_snapshots.

This caused an issue - when all schemes were deactivated due to
max_nr_snapshots, but their watermarks were still satisfied,
damos_wmark_wait_us() would return 0, causing kdamond_wait_activation()
to return 0 (activated). The main loop would then continue without
sleeping, leading to unnecessary overhead since all schemes would be
skipped in damon_do_apply_schemes().

To fix this:
- Add a damos_is_deactivated() helper that checks both wmarks.activated
  and max_nr_snapshots conditions.
- Replace the wmarks.activated-only checks with damos_is_deactivated()
  in both damon_do_apply_schemes() and kdamond_apply_schemes().
- In kdamond_wait_activation(), skip deactivated schemes when calculating
  the minimum wait time.
- When no active schemes remain, sleep for sample_interval as a fallback
  (consistent with pause behavior) instead of returning 0.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/core.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7230483e771f..57d1a21a8a0a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2633,6 +2633,17 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
 }
 
+static bool damos_is_deactivated(struct damos *s)
+{
+	if (!s->wmarks.activated)
+		return true;
+	if (s->max_nr_snapshots &&
+			s->max_nr_snapshots <= s->stat.nr_snapshots)
+		return true;
+
+	return false;
+}
+
 static void damon_do_apply_schemes(struct damon_ctx *c,
 				   struct damon_target *t,
 				   struct damon_region *r)
@@ -2645,7 +2656,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
-		if (!s->wmarks.activated)
+		if (damos_is_deactivated(s))
 			continue;
 
 		/* Check the quota */
@@ -2655,10 +2666,6 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
 			continue;
 
-		if (s->max_nr_snapshots &&
-				s->max_nr_snapshots <= s->stat.nr_snapshots)
-			continue;
-
 		if (damos_valid_target(c, r, s))
 			damos_apply_scheme(c, t, r, s);
 
@@ -3220,7 +3227,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
-		if (!s->wmarks.activated)
+		if (damos_is_deactivated(s))
 			continue;
 
 		has_schemes_to_apply = true;
@@ -3704,16 +3711,23 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 
 	while (!kdamond_need_stop(ctx)) {
 		damon_for_each_scheme(s, ctx) {
+			if (s->max_nr_snapshots &&
+				s->max_nr_snapshots <= s->stat.nr_snapshots)
+				continue;
+
 			wait_time = damos_wmark_wait_us(s);
 			if (!init_wait_time || wait_time < min_wait_time) {
 				init_wait_time = true;
 				min_wait_time = wait_time;
 			}
 		}
-		if (!min_wait_time)
+		if (!min_wait_time && init_wait_time)
 			return 0;
 
-		kdamond_usleep(min_wait_time);
+		if (min_wait_time)
+			kdamond_usleep(min_wait_time);
+		else
+			kdamond_usleep(ctx->attrs.sample_interval);
 
 		kdamond_call(ctx, false);
 		if (ctx->maybe_corrupted)
-- 
2.55.0


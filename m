Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0237DEAA
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778965448; cv=none; b=Xrx3xonbnQHEYI2upPcF+ou+v665uxsNoKXvOXRNmN01Z489mGlWtRzGOfofehqMWxpXWZbfUM626pW5NfgKKbPU2u+GXk+NsJkDiu3qOoK776JqAO/QpaUnwHRnwVnqduefSia0drAh3u1B0FCH8PLEaaK9wYM5+sEmQ8ST5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778965448; c=relaxed/simple;
	bh=KzYiajAK+nfFBai/4/fm3cADm7PKM27ScIiqlEri7s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Erx1tDCWcpe+hzjHROapuDiW2EwGSKRzkSHkdL1KoJwHjr+BxJYW0QxVYXtP5q8dBgG3aPHjoOnEpC1iq5/xPY8ESjd9LKubVkZuTvxE1LLYKIjJnAs5e1aQZFKJBcxUkcMr5yp4a7Ox2DJvXuFuDwpH13vIJK5D3vxmR512Vtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frmxGKbf; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frmxGKbf"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7bdec52f48dso4678327b3.0
        for <damon@lists.linux.dev>; Sat, 16 May 2026 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778965446; x=1779570246; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+8d6F/ecIm4OU9cM2uGG4hmEo0TfbVFCv/yoQTzhTg=;
        b=frmxGKbfLAYzRObZBobCNoZ4bYpXn7mhmJQ3ap6X+OrTurEV0Qk66OcWGi8F+6GEFx
         eYSeBKV5qSMLKiSs/Ie8TQTqcbtOr97a8DS9G+I5FaAqG+aa9497MsXp5AX8uOYFEnpK
         Nthe+FcJUQuYYkL5GOyaXnhlcBc17rESAcGxdQv0RO1YytgeVVlZSEscIwC3RyYqghrg
         R4eEdc+5yeb8sS0o/PPO4yON4+S7fkooiZgycvFyuFUdGkt8B1MCK79CC0h0QL/SyXaU
         T4w1JxTmvRw0sU2SEGysreMwDYUyPVoyYkupEecFFI2QkyxulLQri6PEPrE1keIVxJlr
         yp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778965446; x=1779570246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N+8d6F/ecIm4OU9cM2uGG4hmEo0TfbVFCv/yoQTzhTg=;
        b=A4QwVbEwTWITp0ugmaN6GqaYzczHhvipEwlWcvdR4XY0qmeVseaPjny/v+QtSRXgGh
         kzUFfucVZhKLU1W4wIlSoo/ba3Yb2nd6B3Ucl7WbxHSvxvkU9rcfjxpSv9uJks3dlGnR
         4Q4pFHoJaWeBUOp8DcIhmV1TcbYT24Lx2YKP+kwGa6BASgJn06CbRLW9JbODyENmUqqW
         Oa1bUGSvF2tTpI36lReLmp8OPDMIH2fuD7r5o8TRzau4YEaqe9eObGhtTECBwZn+v9aU
         h1VeekLuwrVU9lu8FyVvGFtk1K24niG7Q1dFKdZmrhHOxs7Lmc0WVxRFELRMqgjlBF9Q
         60Lg==
X-Forwarded-Encrypted: i=1; AFNElJ/6CGahop8Mu2AQvKS15DS6Bx2j4i+W8NEUz+K/FqeXNZBaynDmgoPlT1KWBHArgnkcjqdTqg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxy7RHVofz1GE6sc8NrdPCmIXA0AI5B4PjPTaHEW1UcOiCDsNgI
	3/LAPXbbQWHj75lqRHROeBmxK4O2RpBIW+Kyn6pEH1fbwqnPyBtfUEc=
X-Gm-Gg: Acq92OFRm2DtQieFNZbGD6WmxNgqNC0mAmwmycuU2q6+KrXOf8TMMrYSBGCJxR1izd/
	vT2KCRIGxevWAMHGCoZiEt43HnHOwKTfbE+YAuIumhRzRUkG8M+cdDRteaFCAWleZem6w4upuqW
	Ka4XYJ1LrrNCr7vgFd6ecw2NkbiYCmxuK2KBW4c2GSV0wToQhDH8+mnr2rzui1R8dSxlL84jsnn
	IMm/B9K1zNR1hkFVXy5rJ3aF4Qy+ABALisW/NPbxB917Vkcr5K1En0bUMJpVMjSmFTxouQ5/elA
	1Jb+xrdLwOTzMceAnEsmyxj8lCwq0GL0GZeuQJ/HwkxSg7SC1qt3flYQNiGLmvwrsf9JCcUrWJr
	nJIehHBhYXqfWC5MGpq8MJtx3nWYSF3wfkO9/ualmoNTddDjCw3QrChDsONzprGW5wgz09auS7B
	VJceq3pR3QpIcZe1LQRq2/t44jIsEc8206G+SqdEghyQ7cTrvFlJ6pm0m2Tmx3PYvRV9YwB8O+O
	Tua02sUnoqA
X-Received: by 2002:a05:690c:e28d:10b0:7bd:9a25:f39f with SMTP id 00721157ae682-7c7e5d8e253mr91991277b3.4.1778965446076;
        Sat, 16 May 2026 14:04:06 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f4ee8726sm48887337b3.27.2026.05.16.14.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:04:05 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com
Subject: [RFC PATCH 2/5] mm/damon/core: cap effective quota size to total monitored memory
Date: Sat, 16 May 2026 14:03:54 -0700
Message-ID: <20260516210357.2247-3-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516210357.2247-1-ravis.opensrc@gmail.com>
References: <20260516210357.2247-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAMOS quota goal tuner can compute an effective size (esz) larger
than the total monitored memory because it integrates over cumulative
deltas without bounding by the actual workload size.  Once esz exceeds
total monitored memory, the per-tick "remaining quota" arithmetic
stops being meaningful: any scheme can apply to the entire monitored
space and "remaining" stays positive indefinitely.

Cap esz to the total size of all currently monitored regions as a
final bound after all other quota calculations.  Add
damon_ctx_total_monitored_sz() helper that sums region sizes across
all targets.

The helper runs only inside damos_set_effective_quota(), which is
called at most once per quota reset_interval (default 1s) per scheme,
not per kdamond tick.  Walk cost is O(nr_regions) at that frequency
and is dominated by the enclosing tuner work.

This bound is tuner-shape and goal-metric agnostic: it constrains the
quota controller to physically realisable values regardless of which
tuner or goal metric drives it.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9975f3d9ebfe9..fd1db234ca304 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2614,6 +2614,19 @@ static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c,
 		quota->esz_bp = ULONG_MAX;
 }
 
+/* Sum of all monitored region sizes across all targets in @ctx. */
+static unsigned long damon_ctx_total_monitored_sz(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned long total = 0;
+
+	damon_for_each_target(t, ctx)
+		damon_for_each_region(r, t)
+			total += damon_sz_region(r);
+	return total;
+}
+
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
@@ -2621,6 +2634,7 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 {
 	struct damos_quota *quota = &s->quota;
 	unsigned long throughput;
+	unsigned long total_sz;
 	unsigned long esz = ULONG_MAX;
 
 	if (!quota->ms && list_empty(&quota->goals)) {
@@ -2649,6 +2663,11 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 	if (quota->sz && quota->sz < esz)
 		esz = quota->sz;
 
+	/* Safety cap: never migrate more than total monitored memory */
+	total_sz = damon_ctx_total_monitored_sz(ctx);
+	if (total_sz && esz > total_sz)
+		esz = total_sz;
+
 	quota->esz = esz;
 }
 
-- 
2.43.0


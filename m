Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA443FF8A5
	for <damon@lists.linux.dev>; Fri, 29 May 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073834; cv=none; b=gXArm7/2WEJE9ebzng9f7Pl8AeULJpVPdKd2mnKqfQU65Dy7VfHslDWDZpa/jEMgMKxHSN9kgn8yS2l2h0N6mGA7Ru3SvaHp3MTTIafSEY2wyCMbc6SjmYPVenoey/B2HtbJM/i7F/2VAfmpMm9Mejf6oHhGh47GHRnO0L5ZTCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073834; c=relaxed/simple;
	bh=mBWxNyD3dD7WZKndJ1kCqjFL7BsBzSS97QOevn010vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFPBXqe6W+4bhElyimGY4Hq7Bdmabwrh7tI3GbL3tAZDNTHZAidXrq9lw3EPikJdGFz+9DxRiSbI5Yw8tnwPAKZRWK2ga1OaLXrwVVAUcU0JVT1iePDU3oOOc/idNGosG7imr36Q54Z/zt6RT4H5aophGDuulgcSe1N6yuplosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7bSIv8+; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7bSIv8+"
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-43b69833d10so5895651fac.1
        for <damon@lists.linux.dev>; Fri, 29 May 2026 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073832; x=1780678632; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/62Lo7gqlbSGmK7of07r4Hjek/ejMB9r9tyx1CYLkQ=;
        b=i7bSIv8+AeoiFu5pat2wVsXVhuVVio5KC4fFfFKAZajYLeZQgRtulSjyW4cm5IqnGc
         HB6ULlw8C0qVwn726uP08PgcNtreZLadcMqQx6D8jGryIqwmpISEXyAXL2I1lJ7a5gq3
         hUPw8rMg5zBJu0lOlIEpEqV3P3HjBqpb+DtWCgDv8F02B8qOr+m7Bc+k2fX87mD4YUg7
         Mb7mCAI5Czob7Ca119Pm2DrGZkLYG0uW3dQeN8n8MwC8RqbZuxpwEHnfmFP1JkZz2xY+
         iQtqz+nBcegMNpJzxk+fWxqPtPFlh6NIlPlQRpf0bVbkDtuaYFsgc4aY55a9sARfsthz
         SCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073832; x=1780678632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o/62Lo7gqlbSGmK7of07r4Hjek/ejMB9r9tyx1CYLkQ=;
        b=il6IJNnK0UHkzTtTTfxZ32Lx2LiY/9VuqC5jQz2YPpWrZtmhzwvPLBUVOkHM1mkIns
         jWZy+mcu3BsuLDCj9e8dlc9ZvKFtnFPLUt7F7fTMJ2sWj3wXwFFHdlPJu7uDAV/ZJNVt
         Pi/w7JtEdk0DuOKbh6STi3B1eQ/ql1Ydzjudj+k8ElSzgodlNLVpQC3a41TwQ+0QMFfa
         zh1iSYm3m8pbWJ7qpOi40v2d7ecXcMVBSz0IfDmDTNj39GZIpJba8a9bG2Cj44oQAi0m
         mk0SWIY24rqgybW0hyQEqrv/LkS3rkn7ZuVJ20cEk0Lp2F8DJxC4F0qbXt4TEe+HLb7C
         KkJA==
X-Forwarded-Encrypted: i=1; AFNElJ+mJdv7fiyvpqmC30n1yz/DvEqbivKNKHRFYe5sWrOietLJBoloYaxUVNNsgIupL9NSBzfT8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNXEZrCeggg7082bJrU1z8Rwb5B8g0cem+wahqmfVa0i87cOqT
	aZc+QIPz7VKJOWzBGBlFONejrMujFWnxCbuxyIr8ustO+TyyB5eZtu0=
X-Gm-Gg: Acq92OEsc9CkylKpzT7lud/kCbx9aaLkgZ/y1gK+dHHnleN/1xcSv7bCAtE99ZQZEDP
	Unfe1KkCSqP3qeO0PeqAucwexuwrCDrdKZqPUq7u8Pdf81V21VLAR05An0YVzse2+0A4Do2k3XX
	Rzj/+5qy9+GFvt+qaE0k9ghKcKFecfVj2x1rtenarT7Nl3079d75jPFBLl52hYSBUOylp8nUsZB
	PkIyJkpqny/xg9U6q1PnP6GsDmtoXA2Av2V/rBqsmW49PwmtBpM2UCYhHcLxDtbWj6ikJ4/+Uvw
	GMtyG1rzEmWsXmTgbPdKvASU4xdPu/mRjycS46PL2CTr/d8hqXK9sjAz7Tbeekxqyg1xi4FZoZ8
	+S23WjU4wRFcOKA8so3vgr49ZyG4Bkr0cthxGqP+MGYVydXM+IElnNFUCiVmDEOR30MsLaQCp6L
	VVM32uyop1dW5GTYZrar1C8cR52jwVztRdCzT14yaEZ/y5F8U2bKT9k+01wKBa2E8rJ+57gTFT5
	4zIXCEHteF8
X-Received: by 2002:a05:6871:81e:b0:43b:9922:9ddd with SMTP id 586e51a60fabf-43ca425b65dmr369732fac.27.1780073831692;
        Fri, 29 May 2026 09:57:11 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93a2861fsm1392913fac.3.2026.05.29.09.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:57:11 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	akinobu.mita@gmail.com,
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
Subject: [RFC PATCH 6/6] mm/damon: add damos_node_eligible_mem_bp tracepoint
Date: Fri, 29 May 2026 09:56:40 -0700
Message-ID: <20260529165640.820-7-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529165640.820-1-ravis.opensrc@gmail.com>
References: <20260529165640.820-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fire a tracepoint at every DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal
evaluation, exposing (context, scheme, nid, target_value,
current_value).  This gives userspace observability into goal-tracking
without polling sysfs.

The trace_..._enabled() guard avoids the damon_for_each_scheme()
iteration cost when nothing is listening.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/trace/events/damon.h | 32 ++++++++++++++++++++++++++++++++
 mm/damon/core.c              | 20 ++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index e97e70579a8c8..877627c9a1a18 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -91,6 +91,38 @@ TRACE_EVENT(damon_perf_ring_overflow,
 	TP_printk("cpu=%d", __entry->cpu)
 );
 
+/* Per-tick DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal evaluation. */
+TRACE_EVENT(damos_node_eligible_mem_bp,
+
+	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
+		int nid,
+		unsigned long target_value, unsigned long current_value),
+
+	TP_ARGS(context_idx, scheme_idx, nid, target_value, current_value),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, context_idx)
+		__field(unsigned int, scheme_idx)
+		__field(int, nid)
+		__field(unsigned long, target_value)
+		__field(unsigned long, current_value)
+	),
+
+	TP_fast_assign(
+		__entry->context_idx = context_idx;
+		__entry->scheme_idx = scheme_idx;
+		__entry->nid = nid;
+		__entry->target_value = target_value;
+		__entry->current_value = current_value;
+	),
+
+	TP_printk("ctx_idx=%u scheme_idx=%u nid=%d "
+			"target_value=%lu current_value=%lu",
+			__entry->context_idx, __entry->scheme_idx,
+			__entry->nid,
+			__entry->target_value, __entry->current_value)
+);
+
 TRACE_EVENT_CONDITION(damos_before_apply,
 
 	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1e6966e45144f..609d627e2b33e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3203,6 +3203,26 @@ static unsigned long damos_quota_score(struct damon_ctx *c, struct damos *s)
 		highest_score = max(highest_score,
 				mult_frac(goal->current_value, 10000,
 					goal->target_value));
+
+		/*
+		 * Per-tick visibility of NODE_ELIGIBLE_MEM_BP goal evaluation
+		 * for userspace convergence-detection.
+		 */
+		if (goal->metric == DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP &&
+		    trace_damos_node_eligible_mem_bp_enabled()) {
+			unsigned int cidx = 0, sidx = 0;
+			struct damos *siter;
+
+			damon_for_each_scheme(siter, c) {
+				if (siter == s)
+					break;
+				sidx++;
+			}
+			trace_damos_node_eligible_mem_bp(cidx, sidx,
+					goal->nid,
+					goal->target_value,
+					goal->current_value);
+		}
 	}
 
 	return highest_score;
-- 
2.43.0


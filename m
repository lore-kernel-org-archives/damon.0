Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF808545D93
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060604; cv=none; b=EQQ2oDwAXUROzGvh/lOu0jv6SX7sed4kR1XB/5mCsTNDjfAu68o3lMyDpnRdT41NuqLFU66fCen9/9Le9NhffigmyKwKENuKXF4w0Cm4RLeIOlKT8fLpNHA/J48JpYQZpaXw6vN/vFoC3YS2pRmzcu+zC2pBl4oJQDS5TpAOKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060604; c=relaxed/simple;
	bh=dKBhc/qYjs60oa/k5fBVE/b8yc5t8ryc/K02fqOJhvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoCL45Yp7ylcI64oejmA7beEPAdGOkDaGRWeb+tj53aaVwLxQN9J4o5T2eOIOgb9gdM7MTlLpjYhj7Qxo5io0gjBfeYwmKDBD2tzwVPfgQmoob30gHMNFGcPBxDYCcwKqGXJCYhpcXhseLMAN7KLgfnu9Gz5nS/M1EUfhgllhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a35nuTFV; arc=none smtp.client-ip=74.125.224.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a35nuTFV"
Received: by mail-yx2-f3.google.com with SMTP id 956f58d0204a3-66fd0af9eb0so2123122d50.0
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060596; x=1789665396; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCG1VvuHQ6SCJdLVUga8vZowwN0KJmpgx8fDOpUOTA0=;
        b=a35nuTFV/wJGnPmAAounx4yswkOGP5ihQKmqC0UwkiQe6LpfcQlLw9+0mnnAEjUAkl
         jmht6/wVz6uWdxvRcm7rs5iTJt9DSRdh2nnsUJrqfUY7K+WS7n4gf9fM0bjdn2fZ3wHt
         1IVDV4IZO9yXa+BCicoUVlI0LFSrmd9krM+RSBS2wYFZunWUUGMTZeZ9H/06VZVNYpti
         6dQAVvtT4hEuhnQqUi2vlgPBjNnZjM88peN4co9Kwe5GybT8FlhnypzdCZnELjl+IOXB
         WyFepCcAxOU7XhUZatJItbadfSs+m0wv1pPnWvkcyALv3zLP94A9V2CV7Ns2bUIxLbCH
         uabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060596; x=1789665396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zCG1VvuHQ6SCJdLVUga8vZowwN0KJmpgx8fDOpUOTA0=;
        b=XVKNLDzMbBuJNm28qXR6U5a1nkpaQsWRKnSdyCuYKR2jvozWz3q2T9mx8yY+eveXK0
         ugzygm20EEIZ+yPC6n9RgVbM0m4RZn27ll3CkF57az6oUeSZxCyxHq+8wPI2DGbIV59M
         mdbUx+VlbC4hJ8eclwUE5/1uVm7ATQSKjm0UzTlNofxewJh3OCrRBUM/zp/LVWkeK2Ff
         N5TLxln2db1fU5gxLIS8sg3G4VRJSDTym8WAvvG2cbLfJctnCGCmvT5NMOn/wIOCC1Ux
         J8IFBJb+nC+07rallf2DlGBKMfH/z3Zty2UTcWDerSo4NlveKSZGk8dwvrz9EkEnsCEp
         wj3w==
X-Forwarded-Encrypted: i=1; AKwUvBwcITXRLAxtgLg81ZmDwbdhctxJTk+kwrAUdedB47LJP1WEdIGy2U7ZZrr0/O+FS0BKInxKfQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kva+7KNYIu2H0zAIFqSCnFPLjf4+uNBnKh31CDoB5+J7lIGHZs
	O5jbocsfr+P4YGqNEtdMkvDyRGb68yTj09+U9UHVGsEt9mDIddZC8e0=
X-Gm-Gg: AYBFou0JWnF7JtFP4mS+8B51LVJbUkrYxZXdlqgoBFOr/mQ/jVa7YUmNT1ezJYuMqjK
	PCAzF8QqFEa68AIaH18vQWcPte9ONcDiJ6ztY99SuE461pJqgV2Pd+VnhMFNiUG7KDvYWEJYdMp
	dnwrhV4W/UO/aNq0KpMa/VFY07WVKgKyHG1JmTGog0SUx+EepOfh/xOFTHQwXnqNXHmerd4totk
	PgQq6kJACzao20DP3S/4oa4lMTCNyTWuhD28OeAVtUjtJhiS/zEPiSEM9jF2ckSgdNmi2+GND/6
	CjLwfGEQ1a5EKG1c3bLycxJ4dAVM537pWGFKMSYQYoF5qtVb6ZLhGM1ca3k/OvJWaQgzV/Jsbru
	8fUWNfgCieW08sYLXDqTlHd1K3TfPUUx3BAr5bpbQaa6HQQhmG9Ra2pT+PC5S+e3cOXdtUOzOGt
	GXXIo6ElSRREEiq1lYQhvq2Oh/lpbhMFHUjXN6LYjC94rac89ZYW6sv71Feajjpql5Wr//zREwp
	UydZiq5ISeBqnYg9x3y7fZiqbdQbjoJ7HqhnF81Fu0A5oAVp/seUdoI9/kx
X-Received: by 2002:a05:690e:12c2:b0:66f:ca93:eae4 with SMTP id 956f58d0204a3-67124722b0dmr151051d50.92.1789060595769;
        Thu, 10 Sep 2026 10:16:35 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8b8fsm14316278d50.2.2026.09.10.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:16:35 -0700 (PDT)
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
	ravis.opensrc@gmail.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net
Subject: [RFC PATCH v2 4/9] mm/damon: add damos_node_eligible_mem_bp tracepoint
Date: Thu, 10 Sep 2026 10:16:18 -0700
Message-ID: <20260910171623.6638-5-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910171623.6638-1-ravis.opensrc@gmail.com>
References: <20260910171623.6638-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a per-tick tracepoint for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal
evaluation, exposing the goal target/current values for observability of
the node-eligible-memory bandwidth quota loop.  Bandwidth-feedback tiering
loops read this goal metric to detect convergence.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/trace/events/damon.h | 32 ++++++++++++++++++++++++++++++++
 mm/damon/core.c              | 28 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 4dfc9467ea4b5..b2a472eb45d95 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -74,6 +74,38 @@ TRACE_EVENT(damos_esz,
 			__entry->esz)
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
index 991ddb9a09414..6b56a3e961c4e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3461,6 +3461,34 @@ static unsigned long damos_quota_score(struct damon_ctx *c, struct damos *s)
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
+			/*
+			 * cidx is hardcoded 0 because DAMON sysfs currently
+			 * supports a single context per kdamond.  Other DAMOS
+			 * tracepoints (damos_before_apply, damos_esz,
+			 * damos_stat_after_apply_interval) follow the same
+			 * convention; once multi-ctx-per-kdamond lands the
+			 * field becomes meaningful.
+			 */
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492AD421F1B;
	Thu,  9 Jul 2026 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605968; cv=none; b=XSbTWtQcQgYI2ZP/SiDhwGXPgHGS7Ze5t3Dme/I5Tn4EEciAUVaXuDUGklN/9rKLuuLcV6lfcMz8U5suCWFrtTK5IDJByTunAF5z6J8obQMjNisQjXA8D1Ix5i6dVKrkdwpn6uF/5kZUnCVGU/fLqAGcvMiCPG3nWW6MYQeTXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605968; c=relaxed/simple;
	bh=EiM+cnbHgz6BZmohzfpAyodTwERu7UhzJH5/KvtkMbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eb2F43TS+WVCyB2C7/GYGLkM8t7WFB9BkSPYA0kmJkz9RwAeu9vDcHX0cQ2FxWq7fPppzA9mRNQDii2bnMeKCyiQv96BvEmMUmb9B3lMCJ9Omp0kjpRg6M4II+G+2uRmi7TFhNV3kSUV+lnvKdsjkNp4IKoV7pS2C5oKKsZY9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOTkeH/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOTkeH/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA5F1F000E9;
	Thu,  9 Jul 2026 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605967;
	bh=f7X699AHd2yvS5SlnZ9pQaDNVWM6Hfq6tYMt+CDq9Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cOTkeH/fz2U74GAMLYWPYTDTNtvX7NVYSU/t3paid/5xYNcgQTkUpTDSRHvmukEDF
	 wFzfOMW4sYRVKIWlXtqa9EnUe5wT0Du+zKjtz1ALCNhqwdZj/XCJnuuZaS/ZsWLG+/
	 w2qLgBQE3qt79Y6lmcqkTs5W1xfxawY841zKpf35e8x8ylzqILUTE/1Vai+3QAKJht
	 cOTlOp1PA0vgSvyV2TG8cX4Y7mQ28u6iESfSRsBuYMYTMf8dxjNATumrPZYoREbQn1
	 yMDcwlFYdm1Ge8c1LBTvbk+15aOFyjz9zeK9dgQ4JcKvmNdHtRtZ2rp1mHRtuFafP8
	 2sxT1dnn01Hxg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 10/19] mm/damon/core: validate params for probe hits weighted sum overflow
Date: Thu,  9 Jul 2026 07:05:48 -0700
Message-ID: <20260709140600.90950-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709140600.90950-1-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_probe_hits_wsum() could overflow in weird setups.  Users could set
the weight unreasonably high.  They could also set the aggregation
interval unreasonably high compared to the sampling interval.  Such user
setup is unlikely.  Even if such setup is used,
damon_has_probe_weights() always returns false, so the overflow cannot
happen.  The function may be completed in future, though.  Even if the
overflow happens, the consequence is degraded monitoring results for the
unreasonable setup. It is just a trivial user experience issue.

It is still better to be prevented unless the cost is expensive.  Avoid
the overflow by adding the parameter validation in the core layer
parameters validation function.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4f1425e56950b..b585e4bf035f1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1335,6 +1335,9 @@ static void damos_set_filters_default_reject(struct damos *s)
 static bool damon_valid_probe_params(struct damon_ctx *ctx)
 {
 	unsigned long sample_interval;
+	unsigned char max_probe_hits;
+	struct damon_probe *probe;
+	unsigned int wsum, wsum_to_add;
 
 	if (!damon_has_probe_weights(ctx))
 		return true;
@@ -1342,6 +1345,18 @@ static bool damon_valid_probe_params(struct damon_ctx *ctx)
 	sample_interval = ctx->attrs.sample_interval ? : 1;
 	if (ctx->attrs.aggr_interval / sample_interval > U8_MAX)
 		return false;
+
+	/* invlaid if probe hits weighted sum can overflow */
+	max_probe_hits = damon_nr_samples_per_aggr(&ctx->attrs);
+	wsum = 0;
+	damon_for_each_probe(probe, ctx) {
+		if (probe->weight > UINT_MAX / max_probe_hits)
+			return false;
+		wsum_to_add = probe->weight * max_probe_hits;
+		if (UINT_MAX - wsum < wsum_to_add)
+			return false;
+		wsum += wsum_to_add;
+	}
 	return true;
 }
 
-- 
2.47.3

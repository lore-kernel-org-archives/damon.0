Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E14C8FFE
	for <damon@lists.linux.dev>; Thu, 24 Sep 2026 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280999; cv=none; b=HXEsqn5pgQYYlDIqz240U2frcPFh0WlyiVWmlrC40mmVpsAtgrwItqzAA06xx8EMaoUvHDD+lydeBrchBdb4NzrSFNcU4yHDZkaI2Ud98N//s4o2cQISdUMrxEDeqXxl8c1+6vvGf8yvhGXGsrW8WD0sv1Qj0FR6zQGudRwvgVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280999; c=relaxed/simple;
	bh=2wH2gjfAFykx3AnQ4m3Mv/Cv23ewq1StEc/E/nViiDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p4ZKT4iATA0iVUvXIi8jVLkS47dKuW+SYdwdmRDpyDquh/miRDievtWtqLGuSlHbsnaGym5/qPJQ6odC+AYhY6ab4HEM2rx7FU+luvIUnK33NGLB23KHYic+Oo1U/c0T2T3N33NGCz/cnN+uHAHYmnyNblU+BIgm2Qo2UG/ppt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBWGpSb9; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBWGpSb9"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so1407955e9.1
        for <damon@lists.linux.dev>; Thu, 24 Sep 2026 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790280994; x=1790885794; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNbMPD2l6k45HjCSlVyW5ug/N5eQ+jTGtlCh88p1xFw=;
        b=RBWGpSb9OtPEtXYE8YuG5WjZNRVrhsUOfnTjFhFTbuvevMDf+IqZtZ3zEHOVf70jY2
         QVzFxQG2zRxI57fX1wsx0JMVJSDCwwP4SCpGh+OYkpE+7vaOvSTsyPIm48Vh2J3S2CKu
         qv56S9dpT5So6kDYWBNeybEExTmoubfRIZMTmEGnyvXG2FGzs9TTi/f+kl+OyyhFZI/X
         qE21D2y5USXO2MOiEe3/M1KolgoJIWHHTihDnfA495db/lOL0lFl6SZ4QEoNMRzpUjG3
         KXcmIP64mxBbkM8aKcOx/l9WzZV7vwwUd+Ia/TP7JAC1Kchc5LPzdAOAInVkjZdZ2+0Z
         Q14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280994; x=1790885794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wNbMPD2l6k45HjCSlVyW5ug/N5eQ+jTGtlCh88p1xFw=;
        b=p+6+/0O+R1xm2ouf+FeuwIleTugD85aDpgGZqveRwjt3deqBQl361Dtw7QN1ip1hj6
         Ueyu4RgJayCsS6fHzmuOOhJaMjagNaD02uE487yq6k+Ncqs3UdiAa42Up/dsa9YEAsLa
         FY0CrYHM0J3zrRORqam3LCI045fJxRD52soGIFXEvYGgz+FFaAECoLXyljGkF6/QkAwn
         nG5owtiaREQh6/W2kWdkMEOxfM8BUCn7AQs0DoeYUgXzLHcye5E14g0alWzPigYcMycC
         D0wGnYsMxjo2gpXcP0vwqv0/09TNaYwKRN74hIpPKyCx8oCRaiUuS7MowrxYYpfy8H7v
         UPfg==
X-Forwarded-Encrypted: i=1; AKwUvBwGVqd3vMKuwnfCVV10cD9Bsp9qk7ggEs7vhwbsq7Ll/tBVdgWZ2mVvNblKfpTfOHyMLXGN0g==@lists.linux.dev
X-Gm-Message-State: AFuF++mlnKt5Xn9DB2qQJHVXXl0DVjBVczLYeppaqY+zQtlqolgUqrYh
	HvatKmb6NnUJV/cuXFpHBzrzk5Yu+xTwxEKk3Cg8HY0dW0QAYoa2Cg23
X-Gm-Gg: AYBFou0Z/jPeiqSDCRt/wgdZsUXY+rEG+SH2ciPKtSHLIGWW7nVYVpdZiNVwPSZJ1P4
	Lh+NwPF8coZl1WdfaBs24+Jbx3bWem/6uP+8ziGSnSSpe3TzHgslmjkvk+5fP+AtdKmy2INJ48c
	2ZB5UTh0Gt1RIXLWs78nhLiazxrSpMco9cpDiKkhfe9kLt5zF3smyqi/aGV/0xtxXe5eEWEgCAK
	mNM0LXFu223V3/45ljMm0RZWW3zzTjFCUEjkVVj9DtxrYb95HwjnK+GVqzKytC8tlJhnPZ/QqK6
	kI7sOnHf5wI1xJNXdyRYjb+6LAs63w4PeEj4OQ3m5PLIJFzuEHNCCollWYokUluICPkdwAtVDAs
	a9as120Fel/Yx4BF3rAfBOKA+coMLQEzGo0a8WTm/tWUZKBlsy3y0evqRXUN9l1XCjSbKedxgYu
	nfMfQLnQ3JVIa6V9Czeby+xFCpywXA3ubpJSFvO3f7UHD5KPVhuoiKOvI7R33ys180ww9/mUzAG
	ecYwcOXn7jRcYDkWbXD5ycr7ZFDxzPIVRS/h6N2uQ/tjZlPsBSuipeTTkgXf6IYcKnGPG9qCei4
	vYHBPfurlfaGayKUf59ktfVK57zdTq/qcj2DPz9Od1FcTgX6MUjw1icBno4mtTi5ALLPhlt+wuT
	+K5FfZdD7clCRPhPVFjbALPY=
X-Received: by 2002:a05:600c:3e07:b0:49f:d6f0:6f24 with SMTP id 5b1f17b1804b1-49fe66cab70mr70945335e9.2.1790280993575;
        Thu, 24 Sep 2026 13:16:33 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-adbf-6901-3138-76b5-e9f7-b9cf.310.pool.telefonica.de. [2a02:3100:adbf:6901:3138:76b5:e9f7:b9cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm144818795e9.12.2026.09.24.13.16.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 13:16:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/damon/core: preserve the quota passed to damon_new_scheme()
Date: Thu, 24 Sep 2026 22:16:13 +0200
Message-Id: <20260924201615.4478-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260924201615.4478-1-kmehltretter@gmail.com>
References: <20260924201615.4478-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_commit_ctx() first commits the running context's parameters to a
temporary context for validating proposed updates. When
damon_commit_schemes() creates the temporary schemes, it passes the
running scheme's quota as the quota parameter of damon_new_scheme().

damon_new_scheme() calls damos_quota_init() on that quota before copying
it to the new scheme. This clears the running scheme's effective quota,
feedback input and charging state. Even an update rejected with -EINVAL
loses the running quota state.

For a size quota, this discards the bytes already charged and allows the
scheme to use a fresh quota before the reset interval has elapsed. For a
goal-driven quota, the consist tuner loses its accumulated input and
restarts from its minimum input. A time quota loses its throughput
estimate and falls back to the initial estimate.

Commit 60bd24f272d0 ("mm/damon/sysfs: test commit input against realistic
destination") introduced this problem in v6.19 when sysfs validation
began committing the running context's parameters to a temporary context.
Commit b90408ef1163 ("mm/damon/core: safely validate src on
damon_commit_ctx()") later moved that validation into the core API,
exposing other callers including DAMON_RECLAIM and DAMON_LRU_SORT.

Sashiko reported the same side effect [1] on the RFC of the core API
change.

Copy the quota to the new scheme first, then initialize that copy. Make
damos_quota_init() return void, since its return value is no longer needed.

Fixes: 60bd24f272d0 ("mm/damon/sysfs: test commit input against realistic destination")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20260702212143.0CB6D1F00A3D@smtp.kernel.org/ [1]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
 - Explain the running-context validation before the constructor side effect.
 - Clarify the quota parameter and use "commit" for the context operation.
 - Point Fixes to commit 60bd24f272d0 ("mm/damon/sysfs: test commit input
   against realistic destination") and drop the stable version comment.
 - Rebase onto mm-new. No changes to the fix logic.

 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4687b909d42c9..f76333f26de22 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -734,7 +734,7 @@ static bool damos_quota_goals_empty(struct damos_quota *q)
 }
 
 /* initialize fields of @quota that normally API users wouldn't set */
-static struct damos_quota *damos_quota_init(struct damos_quota *quota)
+static void damos_quota_init(struct damos_quota *quota)
 {
 	quota->esz = 0;
 	quota->total_charged_sz = 0;
@@ -744,7 +744,6 @@ static struct damos_quota *damos_quota_init(struct damos_quota *quota)
 	quota->charge_target_from = NULL;
 	quota->charge_addr_from = 0;
 	quota->esz_bp = 0;
-	return quota;
 }
 
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
@@ -776,7 +775,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->last_applied = NULL;
 	INIT_LIST_HEAD(&scheme->list);
 
-	scheme->quota = *(damos_quota_init(quota));
+	scheme->quota = *quota;
+	damos_quota_init(&scheme->quota);
 	/* quota.goals should be separately set by caller */
 	INIT_LIST_HEAD(&scheme->quota.goals);
 
-- 
2.53.0


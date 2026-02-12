Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C2288C3F;
	Thu, 12 Feb 2026 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877408; cv=none; b=RGmc5x6L7l1D2s+6+IuoNcTftkpUkRsODetjqyuN5EOvn00VGK/rhOSSHwTX4v1lY1lVruBTvzJVBVY+XOplVp8S0Qo3R0WGlouzxyab31izC2j1eAE5kflSK7Euw8uEsgR8c4pt7+fFMSbP+ekNrj3fdDgsVcgrgXZz4z2yIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877408; c=relaxed/simple;
	bh=xBnWOLA3jQha94wtKmplmtV31fbSm+0D4iTTXT4bhss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOLT8XqKSqRAxW6LrnxWRYOSaEaP9GgZQVlu9eIL60dQ13WheEo+Fk1MQsbQPpcCzG3zwBRAm2WsXmxUePXTpQCKCVHPW/CiDSf/xhXEmbBl83Vlhu4sfTmoiG9Tz518l/vukmbdAdEk9yQRzW44a9RGK5IJc85TigX3VZFRHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX2H8Edy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX2H8Edy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE967C19424;
	Thu, 12 Feb 2026 06:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770877408;
	bh=xBnWOLA3jQha94wtKmplmtV31fbSm+0D4iTTXT4bhss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uX2H8Edy988IOxMIf2SQzORS/zRaP3jk2oBvJ5/+z5Q0wCotlw/MJFcbDFIeyBFpm
	 6i8bnUQgHNg50YB2KCdUQi4ELfK18ixbsBsSOVtMhJ+FY936JdFK/w8XtLsYYue3uH
	 4//ekEpbJvOKwmSIK/1tPGqQQ1wV5z1LbMbMP0SAX/leLjTCqlCdYymI3T7aPkTVfJ
	 xJyQQw2pOLpdtyUmlTHFPYR3/EL99gJ+je0wVCDz7xV1sh3qXfCj0VeIjan03GNzQG
	 jGOXay6lmU+8t5bX7FOHhzF8SzEJ+yo31JRO7GPAECesPDfAJhHzyJvvT04MpgY3m/
	 /ydOGkCaYyltQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/5] mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
Date: Wed, 11 Feb 2026 22:23:09 -0800
Message-ID: <20260212062314.69961-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212062314.69961-1-sj@kernel.org>
References: <20260212062314.69961-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new goal-based DAMOS quota auto-tuning algorithm, namely
DAMOS_QUOTA_GOAL_TUNER_TEMPORAL (temporal in short).  The algorithm aims
to trigger the DAMOS action only for a temporal time, until the goal is
achieved.  For the temporal period, it uses as much quota as allowed.
Once the goal is achieved, it sets the quota zero, so effectively make
the scheme be deactivated.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 25345b5f821b9..0ab247fb06ca8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -216,9 +216,11 @@ struct damos_quota_goal {
 /**
  * enum damos_quota_goal_tuner - Goal-based quota tuning logic.
  * @DAMOS_QUOTA_GOAL_TUNER_CONSIST:	Aim long term consistent quota.
+ * @DAMOS_QUOTA_GOAL_TUNER_TEMPORAL:	Aim zero quota asap.
  */
 enum damos_quota_goal_tuner {
 	DAMOS_QUOTA_GOAL_TUNER_CONSIST,
+	DAMOS_QUOTA_GOAL_TUNER_TEMPORAL,
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1c126d910fe62..81e3ef737be77 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2217,6 +2217,26 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 	return highest_score;
 }
 
+static void damos_goal_tune_esz_bp_consist(struct damos_quota *quota)
+{
+	unsigned long score = damos_quota_score(quota);
+
+	quota->esz_bp = damon_feed_loop_next_input(
+			max(quota->esz_bp, 10000UL), score);
+}
+
+static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
+{
+	unsigned long score = damos_quota_score(quota);
+
+	if (score >= 10000)
+		quota->esz_bp = 0;
+	else if (quota->sz)
+		quota->esz_bp = quota->sz * 10000;
+	else
+		quota->esz_bp = ULONG_MAX;
+}
+
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
@@ -2231,11 +2251,10 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	}
 
 	if (!list_empty(&quota->goals)) {
-		unsigned long score = damos_quota_score(quota);
-
-		quota->esz_bp = damon_feed_loop_next_input(
-				max(quota->esz_bp, 10000UL),
-				score);
+		if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_CONSIST)
+			damos_goal_tune_esz_bp_consist(quota);
+		else if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_TEMPORAL)
+			damos_goal_tune_esz_bp_temporal(quota);
 		esz = quota->esz_bp / 10000;
 	}
 
-- 
2.47.3

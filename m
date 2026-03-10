Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77C309F08;
	Tue, 10 Mar 2026 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104739; cv=none; b=XeC96ZPk5gCeQciNkkLKBt27KFPkVHoI86V8sd1r/IKQrnI6zoODu4SIAVysvAjKrDdxetQBcrl8JEuKtlh9uVN6QqZisJirF8fuuEM1Dcq6qSMkGxJTMbWHhZAsqhfKH+9NCcIaCwP+42bwoqWdvuq0Qtl4e0/o6xqhVQA7Zpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104739; c=relaxed/simple;
	bh=/BXc7B9uaztn0WoEaxSSPUefWVgQvngZEj+kk1cUbBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAsH2QhLIPybsAxJGzgW64EW5fr3yIxmOMYg/osd50VpwU/Z512UpVxHx0w/jFc32Ph7yNt60MG9TvPNTtH2RhDC+25rAEhFAMNpEHoK1Fis3NxFMumEOA0fnLQ3+sHIMKwTRoCcDmshYUDYUaGdAo/4H5rrvxxbhnCCorLkWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbK4s+oK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbK4s+oK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417DCC2BCB0;
	Tue, 10 Mar 2026 01:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104739;
	bh=/BXc7B9uaztn0WoEaxSSPUefWVgQvngZEj+kk1cUbBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbK4s+oKLNIyPuQAWDZFRszKHp83zgpPaGRUIYSdF6Yjxaq+GyJS1uLyyU2pYTpvJ
	 wz0x6oiqUiAzYFtlNzwuIXQIM+3mb6DKuNw2T5d0PqPvPjTZqjBfaH86sft56Bh/29
	 QnWdSq8DEFAYop8n2nf+Zw8GzJCfZQ9UCuc/J6d5fn+XiCN4QAMW4d5E6vK4OkaHj+
	 jSwnr4r+ZUisnFx/JoaTdG9f9etLyb2prTa71xkhNzEGeg1guZf9wKW8X2pCg8Q7Fa
	 Sbm3vVcby6kJPuEwi+FDOXXdgR+mY3J8VsBCczLs4Dd9VnlMImFOAiMf4TgS8nL7i+
	 nqstMJjSWvhjg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/11] mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
Date: Mon,  9 Mar 2026 18:05:19 -0700
Message-ID: <20260310010529.91162-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310010529.91162-1-sj@kernel.org>
References: <20260310010529.91162-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new goal-based DAMOS quota auto-tuning algorithm, namely
DAMOS_QUOTA_GOAL_TUNER_TEMPORAL (temporal in short).  The algorithm aims
to trigger the DAMOS action only for a temporal time, to achieve the
goal as soon as possible.  For the temporal period, it uses as much
quota as allowed.  Once the goal is achieved, it sets the quota zero, so
effectively makes the scheme be deactivated.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0824b953492e8..1130c2f9a92f4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -218,9 +218,11 @@ struct damos_quota_goal {
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
index d351ef3bcf4e9..2e36024d99506 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2345,6 +2345,26 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
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
@@ -2359,11 +2379,10 @@ static void damos_set_effective_quota(struct damos_quota *quota)
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

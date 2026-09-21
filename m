Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F89C309F08
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956026; cv=none; b=NGdfez5yTqVUFF1fxYF2RNtE7mHiFg1J9970X8yv16g7hN6CfcQvFJVLYcsn8cz5jwhbEK3JXLJ+eVq4QbHUrv9HKkc1FhSohOEaRVtqYEPDg6eYnYQuwm3mzXymUke9VcWLYH+xsluDlRk0mEuuoPw4q3t/VL7PuYX8eTYfAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956026; c=relaxed/simple;
	bh=7bjL12I2GurMoSCdoMKek+j2S+kiktqKSgZfILbAInQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ON9lL1YL0w5CQuN3YPOoo8R2WX+xU+EXW0aouynoCU3iPO6mb4OOCnwEgWJj77LJWRD1GTHnSvl83rsZslysKZ/2fPfCn0kTsAC7RFW2vD54u1kSsEc2GjiELALR6smlSN3NB/wkCcxSwNfve6yUxMBL+moP+Qagbyz3mS5tC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfnG7LM2; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfnG7LM2"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso20020125e9.3
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 19:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789956021; x=1790560821; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7TZP8BNLRLnhNjBcWJuFbaWGwNCp5mqjDlxAcW8kmE=;
        b=OfnG7LM2IKN2lvZOS8truAFszs/keInvQHyP6B22eLcfWVLxkPRHTosg8ES61f7S0d
         qSli0iuxUXVCb62RRrVRnw6kSs2R+ocX2hWC40FbvMeGxnZ/VM77v/9dj/3eKhbxsQxT
         myLJFRioMaGIqq1DVYlC5SXo8GNBbADkLszaD8mYsxEX0UX4PIQodZ8kjL2shqq0lTmF
         JHE68qn0q/8sw2wo0TD2sgUFH0nY6kT+rHQJjtDqd/F9OsO5kCj6+Ct1OycTW3k3eexd
         IX7PH6tb+Q1E5CMi7h0VMhJt642yQI8pUsJfI9J1CIWvCJITcmQP144zZj89McFW4P4+
         ku0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789956021; x=1790560821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7TZP8BNLRLnhNjBcWJuFbaWGwNCp5mqjDlxAcW8kmE=;
        b=wKEc65Vzd9SF8mrxJYpngK0k7hiFUFMjZ/duWBJOjClU8Z5DsWAbRsNzlt6L5JtB4v
         lSv3tzeFIQNNyetxb3xPVhdsebSDE8svzVcBrrZPwW0WNnj+mBoEqRqRHY+J70pjwuU6
         FUsRJdTBVKcTv6awh/GvIzPXA1ZHZ8d0sYPY3A8mpnL2vI+LK46NaOnhzRydogq+DBbk
         RIPzu11xcSwW0aLHj4qbib1XjKP9MZPJSuk6ueOhJXBDZQTMjeJF1roPjQEuLPu70utR
         rtsaKEln1KTEwTtXSIum+O29ACQUecLkfNP0BXWbeVwSsVyBhtxeYM8H73agC8bwrrUb
         rSkw==
X-Forwarded-Encrypted: i=1; AKwUvBwRsIxNhfMO/Aydbeaw7vmeHM6ot8cSsXBJNnlwLot/asuyGV8X87wzoWKsllgd9PLCNHWPdQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mwPPs8hbJWRab/Vm16i1sHFp4fYdO/RdckfS4z+dB/+NoqYq4C
	fDdnzwZthE8ZRk5cuUunX50AtVsSU+eY6zcNudYdMf3DuahCZojAJOGp
X-Gm-Gg: AYBFou12F7MRxkMCi/5iCPqTfG2eiRfBO285haZPFcHCdgamuDLbKC+j16BnqcCG2nF
	2W58TTp/HdgZ1N3Z5hvv4W/0MgR7rdlQw1wTeg3ChZj7H7BPj55ETBInXkG/s31r4I5rSduBKsq
	Cu69liRiu0QGHduLBdeF7fjHkcvC+L2xYNeI0wCwp+1hqd2kcn9ItNr3mvs/mQFWG4YOtTgVcH1
	c3VbsaC9mp+vJewKQFcsdX3j5J0sSuK/fBPwh9+cgaj4KaQ4wN1tzXSLyX8wI8lQ7PYfHvD8drJ
	GRT9c4xufTu3A6eHoEJDVrH8G7CpTysgsY8nw1hip+eIBC2LeaRsduGpWG4klHUBuj6T1k8Xl4s
	uVcgaWBUa4SUQajSGC0MpoHk/g260agNAX7z44mbshzwP7suxBm6Ig9Buenu2PCGEd7eNjTU1u4
	nW4e2PTMYMCosP0b9QQU22pVJ+1l6IPLuJHSUWJ6/zVnU6FDLCu+k1AMProuKo1gk+wg3xoSNGp
	RZSc6Hs2FlWUGsLId8yzhxdhxLvWD9bdmLpp2BhtCn66OhMC+kSahHdrZ8UEJbeW7/hAsWQmLZx
	wEAluJuWuWN1dbEzeYtciug/3fAdznuFm+XKOqUBRrtoQV7lqI4fiHEVQ06SS/VfHz7aOCNuWz0
	2rd9TcbutrMXB
X-Received: by 2002:a05:600c:358a:b0:49c:fa20:cc08 with SMTP id 5b1f17b1804b1-49fc5741844mr142422905e9.31.1789956021522;
        Sun, 20 Sep 2026 19:00:21 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8e9-c501-2c36-515f-49b6-c492.310.pool.telefonica.de. [2a02:3100:a8e9:c501:2c36:515f:49b6:c492])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10273fsm193284995e9.7.2026.09.20.19.00.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 19:00:21 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/damon/core: keep the temporal tuner quota over an unmeasured PSI round
Date: Mon, 21 Sep 2026 04:00:12 +0200
Message-Id: <20260921020013.33105-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260921020013.33105-1-kmehltretter@gmail.com>
References: <20260921020013.33105-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b73198a47ffe ("mm/damon/core: handle uninitialized
damos_quota_goal->last_psi_total") scores a PSI quota goal without a
previous sample as achieved. This leaves the consist tuner's input
unchanged, but the temporal tuner sets its quota to zero for an achieved
goal. A running scheme with a nonzero temporal quota therefore loses a
charge window after a quota-goal commit.

Use the effective quota to preserve the temporal tuner's previous
goal-achievement state during an unmeasured round, as SJ suggested [1].
Score the goal as achieved when the effective quota is zero and as not
achieved otherwise. A new scheme's initially zero quota stays zero, and
the consist tuner's behavior is unchanged.

Move the PSI current-value calculation and last_psi_total update into a
helper that takes the current PSI total. This lets a unit test cover the
unmeasured and measured rounds without depending on system memory
pressure.

Fixes: b73198a47ffe ("mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total")
Cc: <stable@vger.kernel.org> # 7.1.x
Suggested-by: SJ Park <sj@kernel.org>
Link: https://lore.kernel.org/damon/20260916001311.101024-1-sj@kernel.org/ [1]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
The commit being fixed is still in mm-unstable, so its hash may change.

 mm/damon/core.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2258b72da7a78..add1b7afb957a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2955,6 +2955,28 @@ static inline u64 damos_get_some_mem_psi_total(void)
 
 #endif	/* CONFIG_PSI */
 
+static void damos_set_psi_current_val(u64 now_psi_total,
+		struct damos_quota_goal *goal, struct damos *s)
+{
+	u64 last_psi_total = goal->last_psi_total;
+
+	goal->last_psi_total = now_psi_total;
+	if (last_psi_total != U64_MAX) {
+		goal->current_value = now_psi_total - last_psi_total;
+		return;
+	}
+	/* uninitialized last_psi_total; make no effect this round */
+	if (s->quota.goal_tuner == DAMOS_QUOTA_GOAL_TUNER_CONSIST) {
+		goal->current_value = goal->target_value;
+		return;
+	}
+	/* let temporal tuner show the same achievement as in the last round */
+	if (!s->quota.esz)
+		goal->current_value = goal->target_value;
+	else
+		goal->current_value = 0;
+}
+
 #ifdef CONFIG_NUMA
 static bool invalid_mem_node(int nid)
 {
@@ -3207,13 +3229,7 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 		break;
 	case DAMOS_QUOTA_SOME_MEM_PSI_US:
 		now_psi_total = damos_get_some_mem_psi_total();
-		/* uninitialized last_psi_total; make no effect this round */
-		if (goal->last_psi_total == U64_MAX)
-			goal->current_value = goal->target_value;
-		else
-			goal->current_value = now_psi_total -
-				goal->last_psi_total;
-		goal->last_psi_total = now_psi_total;
+		damos_set_psi_current_val(now_psi_total, goal, s);
 		break;
 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
-- 
2.53.0


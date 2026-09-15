Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27D43E08A
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452590; cv=none; b=k52YNSIBBZIH0T+XJBD/IZdPk7vI8gPWAs5l7bZYrblBeljFfplfwvDwC11tWshKjwHXHHAtxGUJUjIL86yWuhNmkK8xyaHgpjU+hKTL/X5s2x19MzwFbDZK4xbAaK1CU2FjkBV/Psz0GIpuHnE+PH8UwFhhijD5t/EBtV1HjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452590; c=relaxed/simple;
	bh=dzCsYrwJVntmhJhcj+23XX0Hi5SaOYEE5WA2shbDc8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZUCSKS+dgezsK20zmF778PZN+SwZCQBDqhfKDYnbtjOllViihESpSQmSqs92d5eBRQPpCrXM6LzuFX+YTc3OfpB9IAsPiuk87l7v0ytPs5YWQHIrc7kgWM1rD0apM1LNb9QBPBTsogiAv0g1m4biRevyQTFE4+35B78ueSHnTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMEtxXCO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMEtxXCO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49e6deb520eso37744695e9.0
        for <damon@lists.linux.dev>; Mon, 14 Sep 2026 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789452587; x=1790057387; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eHs3rghcFG8c8Adwq/+j11WtqFeOvFLLNzQbYygfDg0=;
        b=LMEtxXCOFcRhl8CZW50133zSh9nnnO1zb2QoaI8yNLiPk3Uw1lZXC/03wrsEoDlrLm
         grqy4xmKbg7wcQIfF8CJYiPD5dBCcm98ss1vSvxFWwjXpnCN3jeDlvyHqsCEaz9pdxBc
         +BSgnBU9RDzX6qXP1p87iKizZ6p6oiuwEOD/S/lMfudBLB3vjpELqtSwORTgN4vXZdBG
         yHJkYXGcDEOwvds0TvgJJDXIsz/XXeRCXn9ZpclS6Gaai4BmAw4rpe33kzS4p4yI4Gsi
         E6s7njxJP5BDMjCiuF5EOV9pTdV1o82qhah5ov8xS2k1yRoLEIoFW9Z59Nomzgxigjim
         Y3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789452587; x=1790057387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eHs3rghcFG8c8Adwq/+j11WtqFeOvFLLNzQbYygfDg0=;
        b=ScddPEAu30jgB6a0UPujLPajHCSkQ5GP3a+ij3N0q2t9Mzvhaer5lvSSwH7/ELOAnD
         kr9RgpNYYCRM13XtnLCyyYgUnCEuu/fHO+t+IUy0Xe97wA9kZB5B7Ww67lMn16AFr4fO
         eaMZtR77WjUtPTdIg1hz1Rm3vA0TYJI7OsNSftQw5bXmEfeENphR/JFVa0EyxBW3AHbh
         6Ni6pX/3wIc90BHp8w7WCLDlDr5wKWLjNzE2YrwWvbR5H48CuZmNL9C6IdshUgb8yWyr
         j+IiDhstjjxq8ud+EPzNEhCOYTjAugB2FnuVn9soT+TBVr1FeUcUkq9NQSwggAuBuyhn
         T6uw==
X-Forwarded-Encrypted: i=1; AKwUvBwoYOHhS6cX+p3xHP47shO+6141WHs0BgG6R3ZKK5srznoxIjVPkXvzo2CeUaT3YiyM8I/Ybw==@lists.linux.dev
X-Gm-Message-State: AFuF++nSlNaQgB0C/ASVJjl1ii1jQztc1kqeFFHUh/9CEitC5Qw5Fi/q
	XbF3zpI+VhLa98G9SSBAZI6nzAEIT24hcUutfGtSiCB23Rx1Ougcxm2V
X-Gm-Gg: AYBFou2O9y7zq51BBii5FWt/aoLGERcA0EN+aYCaigHPBMnfVPjAPoBHlHMcBWkFluo
	DSHb/GqS+CwgQXJAcOp0WyBb0zYvM70epb6+vFvYFe2x6QVpgOTYM5EZDCYWuISrA38sz1R/WXB
	eMjfwW2i5SrZLxWdznUBmNUTs9SggCRRU1tzY6rrYL0ErqtYlfCkMOQhzOta8rZ33xYeNWRYxvZ
	DQXIn6ZNM6iSrgQEPZ+USDrhHy1jMnDoQwMUOag0tvNp3/4K6TW7Uf7f3ozsShYzKJQgi4vdDIC
	E+zXBkbYUVxPeGeQ5GxH1PZjj+TXzDH1z85XWfCKrJEWjEIr9qSHhaKhvnOfdjiRYROVgXLNwzy
	loCsi2mDte+h9+JgzxAKJov2mKiXQ22VVLq4HsOdRAA2QJ1McEJRiC6un1jN9m4yAN0LmE9RGTd
	xJ3MXbF9kTqmxc2hZhaezUUSMe77/1MhpekO4dvuHYnK5s7qhD1BgnenVxz/k5+mzgHlocZvgtM
	a7FGmY2qvZ3aHO+gz959LZR4w60uiEpUl6QM5gS12hgtFh3A2R5jTLQz/1U4IbXRWsTAfeiWNP9
	eSHw97eu/g0oigIPVXZA8TQrNVuYHOeu6u59LE/0uFhzD4YDSFGXbhKV+gK/nQgB+wbsxqE6Ms5
	CaHLJQYE4n3kcpoEc
X-Received: by 2002:a05:600c:3146:b0:49e:6ca5:8198 with SMTP id 5b1f17b1804b1-49e7a668f45mr66829135e9.14.1789452587021;
        Mon, 14 Sep 2026 23:09:47 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-afd5-c801-cc65-9ba1-765b-bff6.310.pool.telefonica.de. [2a02:3100:afd5:c801:cc65:9ba1:765b:bff6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d27c88fsm44282905e9.2.2026.09.14.23.09.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 23:09:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/core: score an unmeasured PSI goal as not achieved for the temporal tuner
Date: Tue, 15 Sep 2026 08:09:36 +0200
Message-Id: <20260915060937.3423-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260915060937.3423-1-kmehltretter@gmail.com>
References: <20260915060937.3423-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A newly created or committed PSI quota goal has no previous sample.
Commit a68878f83ae6 ("mm/damon/core: handle uninitialized
damos_quota_goal->last_psi_total") scores the first tuning round as
achieved to preserve the consist tuner's quota, since the feedback
loop returns its input unchanged at that score.

The temporal tuner sets the quota to zero for an achieved goal. This
skips the first charge window and the window after each goal commit.
Committing the PSI goal before every tuning round keeps the scheme
idle indefinitely.

Score an unmeasured PSI goal as not achieved for the temporal tuner,
so a new scheme can run in its first window. Keep the consist tuner's
behaviour unchanged.

Fixes: a68878f83ae6 ("mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total")
Cc: <stable@vger.kernel.org> # 7.1.x
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 mm/damon/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 06cf2ab7e97d..e6d87fd3992e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3161,12 +3161,18 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 		break;
 	case DAMOS_QUOTA_SOME_MEM_PSI_US:
 		now_psi_total = damos_get_some_mem_psi_total();
-		/* uninitialized last_psi_total; make no effect this round */
-		if (goal->last_psi_total == U64_MAX)
-			goal->current_value = goal->target_value;
-		else
+		if (goal->last_psi_total == U64_MAX) {
+			/* uninitialized last_psi_total; make no effect this round */
+			if (s->quota.goal_tuner ==
+					DAMOS_QUOTA_GOAL_TUNER_TEMPORAL)
+				/* an achieved score would zero the temporal quota */
+				goal->current_value = 0;
+			else
+				goal->current_value = goal->target_value;
+		} else {
 			goal->current_value = now_psi_total -
 				goal->last_psi_total;
+		}
 		goal->last_psi_total = now_psi_total;
 		break;
 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
-- 
2.53.0


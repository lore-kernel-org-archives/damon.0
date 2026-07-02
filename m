Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D84F7972
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985973; cv=none; b=o3viQ3811FbyYSsGfFg3+7od/3LbXFjhZE4hl9pxhcJAz1S7hcrFffbOYuJyG66OwG8vXhwhdv6Il6XP2oLIpU3KuFBZ4p0agIzRu2MXc32yYx+JF6ujpGoa3emVm2fhMNxpzzk5utWnL96OcR7GaR4WO+Dc5/Xx8nBfBmHP8ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985973; c=relaxed/simple;
	bh=ZvejY2fs5GOfN3d6DKEhJv9CnIiKvfl5iSa7zbgcbK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLpeHWO/YzZOwkpjwMnPRFKGbYws58kWKtSmTF9RZZRjFsgqD0VKSpZo/hcj3xKE4v10GF0eRw9gIKYsFuftRVMvIHv76DcHy2K6SO2IcurOea5OmCIu2kVO34hwApz2Hf3VWaCkYXPkG4H7xWeJXy37cRohEjiDpz6asT8h6ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lywIE3Bt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lywIE3Bt"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so288841a12.0
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985971; x=1783590771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=detx7g0IsRMCkRx6d4IwTcZjS7MggGrTdInwdCJAvjo=;
        b=lywIE3BtXgbnar6nHXO3vVSKY5ZFup13vs6JBb5UGBlf6jIu3Vpibs9b0LoI59o4PE
         1QS2AXSI3KCRYQe7bNQck7Bb5FmeitObgdZlRvvOFn+b/SWMyuXmpoRwfiX+5OMJ6eou
         ARq9l3VK+kCP/T1zNLGTlnG89wWqA0KAnzOkJbcSRCZ+bjsvgSoM6NkzSsQNMLTznKs3
         eOWQBbPTCVmuJj9yq7oT4Y1yWR8RP8Xu6dfhZLhGqSe+XQHETgGlm39fiWIXXBzkkN/r
         dTJz2VOMMuiBFS1iqI9rjxoQzqxoLubbIZFtXhm8s0ESXmqS0NlbAoaIflIfOF7v1FEx
         GmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985971; x=1783590771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=detx7g0IsRMCkRx6d4IwTcZjS7MggGrTdInwdCJAvjo=;
        b=JhQJaQdmLpWf/T+A5ZNixokQUE/rIkSlqAu2aCtXiGgjoS18ceUoyXj9pBVEYAlc/h
         MVEfpGbKlrny7Kongc0qWH9IkfhJ2etgder5LwFmEOaabZwKFn/I2T08xS6lo2Mj+F++
         hzjR6l/WaNuykBVTTTuBekSUJlGupUBs3W32c6OeExb6nQVNEt+SZZLMmGpP51XNNned
         x7psLfnU/6omA80jY46eF2QpLsdzH74UzEgMDK4aEOWIC1Wj8k/W8HO0l2QV2AUa2ySb
         cp0SUkwUI6p590Siljuxs7ukLFQ45bFBNAXilVRaEL445XrliCHpsr8/qlON+sIZZpZB
         p4gA==
X-Gm-Message-State: AOJu0Ywv/oxlEPkBKmZAbcI8Ai68LIrKOtfd6clqR7Ar1cqu6wMok7Wd
	fYaRVhMAKL29I6d9KEsdoBP14oRbH39NHntXKetvTGZahYn5AOSTsgi+46MWC8c1ZtE=
X-Gm-Gg: AfdE7cmTBPGEnFEj8CN4Yg3yLv1YswbpCVDTgZ2W08gUv7FupbOoqFuOxOCVqjiW/nv
	sq64JgOWNIUZmTv3oBTSz4twMv9CXdx3NQFgTXNRlPS7w3+oRfFoe6jfhbXJQNIvUQ7aSV5yqIf
	txfsoMX8qRN95Xyf1sakD4RYyT6d14DOaqkjSuz4XXeH2QdpeNo30SHmMFGhj0OQPBpEVnHbW/N
	2cOw512gXaqQHRIw696Xbs797hCWkD9Z5bcXF7R9XSAarzZtq/yKdXPV7xpYGPf1uPlfY9ilVSU
	C8ApwhyyO3hVs/bqXrhhcpmFfSTEnKk1rl206iv4/guo2E8cYO8M/R0uv9tB9LVyttWLE6vRYWH
	uKphAEIPygDLfFHNfICA4be5Q17vlxOeqU6wASWJRqBG3aFQrL838SguJi04grP+Gh21jnw03iY
	ROxw==
X-Received: by 2002:a05:6a21:6b04:b0:3bf:7c36:127c with SMTP id adf61e73a8af0-3bfd28491acmr8432747637.23.1782985970952;
        Thu, 02 Jul 2026 02:52:50 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b86ef6asm8348869eec.13.2026.07.02.02.52.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 02:52:50 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	sj@kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com
Subject: [RESEND RFC PATCH v2 4/5] mm/damon: introduce DAMOS_SPLIT action
Date: Thu,  2 Jul 2026 17:52:26 +0800
Message-ID: <20260702095227.75866-5-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702095227.75866-1-lianux.mm@gmail.com>
References: <20260702095227.75866-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DAMOS_SPLIT to the damos_action enum for splitting large folios
into smaller mTHP-order folios.  Add a target_order field to struct
damos to specify the desired split order.

Expose the action as "split" through the DAMON sysfs interface with
target_order validation (must be 2..HPAGE_PMD_ORDER-1).

Signed-off-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.wang@processmission.com>
---
 include/linux/damon.h    |  9 +++++++--
 mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5a0587556573..30cf4afb212c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -121,6 +121,7 @@ struct damon_target {
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_COLLAPSE:	Call ``madvise()`` for the region with MADV_COLLAPSE.
+ * @DAMOS_SPLIT:	Split large folios to the target mTHP order.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
  * @DAMOS_MIGRATE_HOT:  Migrate the regions prioritizing warmer regions.
@@ -141,6 +142,7 @@ enum damos_action {
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
 	DAMOS_COLLAPSE,
+	DAMOS_SPLIT,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
 	DAMOS_MIGRATE_HOT,
@@ -573,8 +575,11 @@ struct damos {
 	struct damos_access_pattern pattern;
 	enum damos_action action;
 	/*
-	 * @target_order: target order for mTHP actions (DAMOS_COLLAPSE).
-	 * 0 means system default (PMD order).  Valid: 0, 2..HPAGE_PMD_ORDER.
+	 * @target_order: target mTHP order for DAMOS_COLLAPSE and
+	 * DAMOS_SPLIT.  For COLLAPSE, 0 means PMD order default,
+	 * valid values: 0, 2..HPAGE_PMD_ORDER.  For SPLIT,
+	 * valid values: 2..HPAGE_PMD_ORDER-1; 0 and HPAGE_PMD_ORDER
+	 * are rejected at scheme creation time (defaulting to 2).
 	 */
 	unsigned int target_order;
 	unsigned long apply_interval_us;
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7dcd582ded86..84a4617ca3d3 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2293,6 +2293,10 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
 		.action = DAMOS_COLLAPSE,
 		.name = "collapse",
 	},
+	{
+		.action = DAMOS_SPLIT,
+		.name = "split",
+	},
 	{
 		.action = DAMOS_LRU_PRIO,
 		.name = "lru_prio",
@@ -3058,11 +3062,23 @@ static struct damos *damon_sysfs_mk_scheme(
 			HPAGE_PMD_ORDER, HPAGE_PMD_ORDER);
 		target_order = 0;
 	}
+	if (sysfs_scheme->action == DAMOS_SPLIT &&
+	    (target_order == 0 ||
+	     target_order >= HPAGE_PMD_ORDER)) {
+		pr_warn("DAMON split: target_order %u invalid, need 2..%u. Defaulting to 2.\n",
+			target_order,
+			HPAGE_PMD_ORDER - 1);
+		target_order = 2;
+	}
 #else
 	if (sysfs_scheme->action == DAMOS_COLLAPSE && target_order != 0) {
 		pr_warn("DAMON collapse: target_order not supported without THP. Use 0.\n");
 		target_order = 0;
 	}
+	if (sysfs_scheme->action == DAMOS_SPLIT) {
+		pr_warn("DAMON split: not supported without THP.\n");
+		target_order = 2;
+	}
 #endif
 	scheme->target_order = target_order;
 


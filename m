Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574E3368A2
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985611; cv=none; b=GV7F77BU3T90AmQBawE20nOVzoN+O701+gZ2oGPQyZYXP+Xczy9aemLg5RoIh0IM4qrtjSpnCivwX7Z915kfn7mHDOxYChFCWqkPDLTrkSCWSNc4ndF+27IYYomJ5W336xKlv8fP3D7sPPmWM0oiBzT0YNKy2hidO/jyINZTgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985611; c=relaxed/simple;
	bh=ZvejY2fs5GOfN3d6DKEhJv9CnIiKvfl5iSa7zbgcbK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNuxE4sNnmNu3cqzzjk4fhOMByDCQf6xU9wT+euB5gXAGo3mGvZ+/l5eJl1zGOknY9SLwrh4gySnxsXWGohHo4e0qHbFAOZ+tTdyFZH2IJkXlQFDnXLIkDg67zkVlSOnxunfmqbFrcwqgkTxEAnQy7ltDt6tMgO4qt2AuPwxro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHnaDEPA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHnaDEPA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37fcae0ecb3so1373608a91.3
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985609; x=1783590409; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=detx7g0IsRMCkRx6d4IwTcZjS7MggGrTdInwdCJAvjo=;
        b=BHnaDEPAeFDwAWZicMmLcMieugIK5fWdknTwYGqYqgTBJO0XxlBT9ed7w5Wt+ypQVg
         0A8mV1r+LDJPSVMLFv3K2x5PHXrNMOM667s5c7oXEb33vt5bC7FpPiVgj1B4EwqocI2c
         w1M+aN+YiR5zTXDG10l0548IzHBZHY7B8w5PmsJNGdTAH1R0lcdg6wFYmdNRr3uA0+tJ
         05pIOtzmuajBP3k0TO3aPwHGlRm+NHTrNMnLkkUgxjbdPTvsRAnm3YnSkQ3Bzjpd29PH
         2oNdezITns7s2Jkqtds2LHIPMvmRBEzfDDh2SMGAE2Ojh7sSCINBlRta73dT9yIS5SZH
         653A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985609; x=1783590409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=detx7g0IsRMCkRx6d4IwTcZjS7MggGrTdInwdCJAvjo=;
        b=JLJQ7gZIT8gFg1XWNv+ECrRzbWSyPyCmnjVQbsI1ecXTe7BbUCEHU4aFQp8qeKO4do
         4tb3POpJL+sS0JqwK8CstAuiCtJxF2IJqZrLGBEJTI2YO8/v2dvSe1NczYAt+qEVrG7q
         WwwXurb9QuNeyGQbEvR755lzpDBGhcHgKqnrkgOvhsPCYwNY1ipRcwlpLJZ2KLUPUsnC
         jOdtlzcEWnibdDsDHsmVkakGWcLAw63k17d3NmO1Xo2CA9Fl9Z6T77PEXPT22QLPwnwe
         B0HgsJB0KgDGBDYBrOm+GYwzllWzQK7YP1BLRSpzUBXSiJcmA8n3P4wS3mGxEIo79YDq
         nocw==
X-Gm-Message-State: AOJu0YytF1APX53PzlhR5QfqVDL67789CitRALo9oCP/dteM5yRtGHDD
	hoW8gxmXpSwFfwmMn6iQI1Rb1R4EhWvdx7bHnma7lkFxVwHwTRjRSJxj
X-Gm-Gg: AfdE7cliiDwEXobfBjioZn3icT8sF/FeFlLmIoUA0FcGto6CFXoKsbHZA4UEvUa0fR2
	eS1ne3RlmHJdvVoticmiu+eFi9qzafKk6V8xBRm3Ejy0gUBszdWCDikJL9oDE65XStuFwiqemIr
	mzM7+4X11zrqFW05f22hWRN6hz0Ckjw9/ryF3klSt9v2GxOwj9gWlR1qalPXRv86yqxpoCj2HuI
	QGQatlZys4FQqj4V6m6L6LipjKaDaJMwxl5o9A0puATHBPQ0orAh3DsKAEGzNca94KVCu2/40JI
	hrVB/MOYo0oylyuF1cvFo+om8Akvgv9qmAw0mo7LzGbtUIyYHQDevdc3InllrCcSazjDm7gJ5i6
	PhsXDlULFS3Px5Z7EIM/WxELJM8WE39uWb9s6167pQIHdLMBP7KhnuzAFQDHb4lR2ON4Bk4LUny
	uGdg==
X-Received: by 2002:a05:6a20:be8f:b0:3bf:76d5:cc2b with SMTP id adf61e73a8af0-3bfed2b5e8emr6706008637.22.1782985608996;
        Thu, 02 Jul 2026 02:46:48 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm5261121eec.11.2026.07.02.02.46.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 02:46:48 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com
Subject: [RESEND RFC PATCH v2 4/5] mm/damon: introduce DAMOS_SPLIT action
Date: Thu,  2 Jul 2026 17:46:32 +0800
Message-ID: <20260702094633.75658-5-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702094633.75658-1-lianux.mm@gmail.com>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
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
 


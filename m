Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD83428821
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906461; cv=none; b=MG80NXOPW9KW92C0UDp4w1J0LItaaIGCg6siS/FDaGElYk9atSA/utWDfJzhT7p1+Ubrycz0wT/MZ1Uc8U0At0dnPYNkxEGWvfDlfnJ4PNHXS4n4ZuZykVVaF2WZDuhkkvvv6JpdNsilrt6FaWKJWdqSZpO7InpLoDdqNdHmM+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906461; c=relaxed/simple;
	bh=IVClXsitF9ljfJP+leWwpI7xoMxJxxsu0RmCoSFtRM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prH0WYRR3aWNLRgKN0UT5e2vg+1d1F2xO7Q0KCW+Zh1k75zQ2nY1Hz5/CDIylya5Zd6JBHMUTFmvQa0Zu3lWI+ziAi07ZkdOnrg/1hCoEY4Y3DH5vvGlbwyOEUviQlvgyRUbxQXnwwrYutXswOTghKnnlF0Oh+UfwbVwGYxPDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaXpuuPw; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaXpuuPw"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30bc871ecdfso935690eec.1
        for <damon@lists.linux.dev>; Wed, 01 Jul 2026 04:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782906459; x=1783511259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z2S1A2WLG+DXJhb020TiDIFAisi2ilb5rl7oXhzW+7c=;
        b=eaXpuuPwFtT71xjdc1zS/QQAXiMYK7LKMAXi+Xf6TfNaOkKa5T4hpHVM32FDD0QaKU
         gySCClDG/51uH4L/Nz0xSYgKHu+4/SW39MYjhidAW2LeoLcw6RDvKiYLNAHiP61FqhBo
         K/Ld9ii+KD/P+eY41LM0LmpDkmSvPMCL3lRNI6DsYeLL+pjYN4hnsu4LlJyB7UyDSu4T
         vMhY8zOLBn0Spk3xaCVlazJ3UxK+LNL9pSBYOQ6DHlP7mmZxozCpDffW93m8G8xpVztC
         I4bjmYrxDwdGBQLeUH9QpfyPrFyQ/NAKKtPz7t5Bvd7fzrriSLv4fP8j3EKfJOKqQhTa
         aRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906459; x=1783511259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z2S1A2WLG+DXJhb020TiDIFAisi2ilb5rl7oXhzW+7c=;
        b=gl7LAyVMKuNC381GQ1z4HUXiEvcgZ0qnZxqNM7Dawpjqqhzdv+a3P4ELzkQGuYL6sa
         k3bof9dTiRBUhlMCfuFeiabrqPWpiEVRDzZCRSGMec8FLQLkqcTJjr5uVWM5EhQ5WoMa
         Bc948djSYWoIcGFJHaLJr8aLpyLepuHBQJX75ZAVywdAy6ZYb6VIOTDOzMKEcwlgF4uG
         CUxzwVq1Rzc9g4WuyCYnRbjbD4M4fRBRUv1NqvOXuyl5IdehOMfJcEYN2NMpAMoP6n9y
         GUFiSXD4dhPX9onSCHdpX0n4V651cdA2JsGFJTt0hB8F+HFgN4ih3M5G2xuVjWbCHKXt
         27vQ==
X-Gm-Message-State: AOJu0Ywxah5/J1zh1zyXBuyCjWBqdQR6+dlaAhvEfKC2NlsmUMmU+3nh
	3Q6MhDLsE7P7ibBTEKYC+O1m3O6sIlFT7e8Q5K0uZkireOIFdMDkhkv1tv04OO/b
X-Gm-Gg: AfdE7ck5a8MY+xZpmInhwMrMcNCvjvF0BqdFvUczJ4EQUCEgJXGiNR12zDcR5wVheSw
	hdLiz4wbZ2i1Hn94GLsEWiHN4eT5LUPTl1QKM/WZgzEGj+zyc5B4xhXy2J3XT2StzjoH9ER6moW
	HA0HQstHJdmN0QH3+i3inWWW+CJ2f3HBivWlLDiPeFDq4qvDV3RP+khDPgPPr3+n3TtGjNT/O9M
	HCFbpHMA+JsFC3DFnthyMmupnIjxkYwK0iWTLNOVQpOhCxcaUl6ahkgwlxs/tywZAUddmsYcRTU
	lauIFtbs43oPdpPw7fylI1Teyc4aN/KHn2+EZaenZrW7wE5GkJmE0Aa3xoH4xA5JhKC3A8LTlxI
	VYScXhZ3iFiJyJ79BXonfPccPkPj47aHgPss4S55Hi+JmnOIK+Wgt3Ri8IVJLm4q//hM0R+HLMQ
	8kgQ==
X-Received: by 2002:a05:7300:ec0c:b0:30e:cda8:e37 with SMTP id 5a478bee46e88-30f053c9521mr397911eec.20.1782906459147;
        Wed, 01 Jul 2026 04:47:39 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee327cea7sm22518169eec.31.2026.07.01.04.47.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 04:47:38 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	sj@kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com,
	Wang Lian <lianux.mm@gmail.com>
Subject: [PATCH v2 4/5] mm/damon: introduce DAMOS_SPLIT action
Date: Wed,  1 Jul 2026 19:47:15 +0800
Message-ID: <20260701114716.56503-5-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701114716.56503-1-lianux.mm@gmail.com>
References: <20260701114716.56503-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Lian <lianux.mm@gmail.com>

Add DAMOS_SPLIT to the damos_action enum for splitting large folios
into smaller mTHP-order folios.  Add a target_order field to struct
damos to specify the desired split order.

Expose the action as "split" through the DAMON sysfs interface with
target_order validation (must be 2..HPAGE_PMD_ORDER-1).

Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.wang@processmission.com>
---
 include/linux/damon.h    |  9 +++++++--
 mm/damon/sysfs-schemes.c | 12 ++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

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
index 735970717048..547252fc8a20 100644
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
@@ -3048,6 +3052,14 @@ static struct damos *damon_sysfs_mk_scheme(
 			HPAGE_PMD_ORDER, HPAGE_PMD_ORDER);
 		sysfs_scheme->target_order = 0;
 	}
+	if (sysfs_scheme->action == DAMOS_SPLIT &&
+	    (sysfs_scheme->target_order == 0 ||
+	     sysfs_scheme->target_order >= HPAGE_PMD_ORDER)) {
+		pr_warn("DAMON split: target_order %u invalid, need 2..%u. Defaulting to 2.\n",
+			sysfs_scheme->target_order,
+			HPAGE_PMD_ORDER - 1);
+		sysfs_scheme->target_order = 2;
+	}
 	scheme->target_order = sysfs_scheme->target_order;
 
 	err = damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota);
-- 
2.50.1 (Apple Git-155)


Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68114A82
	for <damon@lists.linux.dev>; Wed, 18 Jun 2025 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228808; cv=none; b=p9/4ygAEgXCcAIa9WPS2y1Z9wmou5cAKy1bg33L81VjTFarOFgPQB9s/vduiHNPd56Ehr1tr7Rw2neGHNay4ZBBHGWseoXcvkyMokPG8niEXTm39AbMa22RdwP5Cc8FdPo3Kf6gJmzd7gQv6pS4a67aK3dHFU56g7yZhYaLTfiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228808; c=relaxed/simple;
	bh=GO82xY98EtG2s+2c41pp151IrpBOAt2K24mdy/8uQwA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CAm19P3IXuR2P5Wrlg1tI0CqcYMf8up3qdAo3E8nE8ZPH/V8NhhfV/AodCx11my4R2gjiM82o4UIxBntCjVOwhixpCCLk7ANfVDJAac8gkP0LkXqmAlLPDFLZRuygO5OUHHOPiHQXJqRoFEN4djx2GZsdPXHCFWPzV0DGmIILIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=QAxUAjVm; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="QAxUAjVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750228807; x=1781764807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kgk0bf3swlK8SA7Y25K6lLZ223HadLfc8NRiYLRd6x4=;
  b=QAxUAjVmvU+MVMVPX3hagU7ZeVcMK/PSYGgNvD2zZbDwoXrNCdeq3zKx
   xkD2RQdf+rHsuE3n9SqAW/qchyGM4K/o/z6YuKWCczSnHajhyJCPII6eQ
   krVrpNEPuGC2veSpewH+bTZg5JsVDr9iHqAJgHGwiWJnVhTa+/X1sCYr9
   5EY5ID/c41CkzrKRAxAI2UKCtvy9Z1+zCxTgO25g6FDYMY6nBhvVxjoKh
   /+n8yitGDQG65WKG03BUkFvqUjymYzulqOCh/pX/w/aTyoBUh9It5Xm7v
   RLjaCMp/FMXxnvEwgOcd6AF3P74uznNrR89W9kk48H6v6HZJEsfsmOIUX
   g==;
X-IronPort-AV: E=Sophos;i="6.16,245,1744070400"; 
   d="scan'208";a="105844272"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:39:53 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:10980]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.217:2525] with esmtp (Farcaster)
 id 5867a9c5-64df-4c1c-9601-f4dd1a8b9f25; Wed, 18 Jun 2025 06:39:48 +0000 (UTC)
X-Farcaster-Flow-ID: 5867a9c5-64df-4c1c-9601-f4dd1a8b9f25
Received: from EX19D007UWB003.ant.amazon.com (10.13.138.28) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 18 Jun 2025 06:39:48 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.171.26) by
 EX19D007UWB003.ant.amazon.com (10.13.138.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 18 Jun 2025 06:39:47 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <sj@kernel.org>
CC: <damon@lists.linux.dev>, Nathan Gao <zcgao@amazon.com>
Subject: [PATCH] mm/damon: fix minor typos in damon header
Date: Tue, 17 Jun 2025 23:39:40 -0700
Message-ID: <20250618063940.43400-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D007UWB003.ant.amazon.com (10.13.138.28)

Fix typos in include/linux/damon.h

Signed-off-by: Nathan Gao <zcgao@amazon.com>
---
 include/linux/damon.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a4011726cb3b..bb58e36f019e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -450,7 +450,7 @@ struct damos_access_pattern {
 /**
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @pattern:		Access pattern of target regions.
- * @action:		&damo_action to be applied to the target regions.
+ * @action:		&damos_action to be applied to the target regions.
  * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
@@ -656,7 +656,7 @@ struct damon_call_control {
  * struct damon_intervals_goal - Monitoring intervals auto-tuning goal.
  *
  * @access_bp:		Access events observation ratio to achieve in bp.
- * @aggrs:		Number of aggregations to acheive @access_bp within.
+ * @aggrs:		Number of aggregations to achieve @access_bp within.
  * @min_sample_us:	Minimum resulting sampling interval in microseconds.
  * @max_sample_us:	Maximum resulting sampling interval in microseconds.
  *
-- 
2.39.5 (Apple Git-154)


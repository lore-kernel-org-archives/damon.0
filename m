Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2524C288530;
	Sat,  9 May 2026 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778302577; cv=none; b=RX2P3Y+l3uvxuVREN11ijB9mIyiiTKLhSz69efWEBgIEDDfY41fqEwVCi8nkr+7YV5pxu5BCebVFGBQmKrK/ALY87G/NQgVxCNc7gM/nOnuRT6Ww0JQ6+qZ9fZowEWdjS9rA7cflkhjlpPx4yQdJSNOneTqO04UGrNKxJYrDhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778302577; c=relaxed/simple;
	bh=umf/65ZGq9p4k+/ztvK7dR6Vu3zMojAH3aIPz/BKE5E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YP3H4ZSG37Aw4Zf5RLNdZinwjg8zN5FXJEqlifGixPqLcPymx3ZaiTkAWR+jcVl3FNysSN3R7T7LxkmPrChvkIoOwMJQavnmw5xS1yQEBgUFAw2Jarhaot1lkP7fahMUCdzqTANfF0/ldTrL6Yv0pIbgcgrHh+7EFliWFLGd6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; dkim=fail (0-bit key) header.d=h3c.com header.i=@h3c.com header.b=ZHD056fV reason="key not found in DNS"; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=h3c.com header.i=@h3c.com header.b="ZHD056fV"
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
	by h3cspam02-ex.h3c.com with ESMTP id 6493p3Ir032653;
	Sat, 9 May 2026 11:51:03 +0800 (+08)
	(envelope-from qin.yuA@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 6493oA5l029986;
	Sat, 9 May 2026 11:50:10 +0800 (+08)
	(envelope-from qin.yuA@h3c.com)
Received: from DAG6EX08-BJD.srv.huawei-3com.com (unknown [10.153.34.10])
	by mail.maildlp.com (Postfix) with ESMTP id D501A20045B6;
	Sat,  9 May 2026 12:02:06 +0800 (CST)
Received: from localhost.localdomain (10.142.164.51) by
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Sat, 9 May 2026 11:50:09 +0800
From: Yu Qin <qin.yuA@h3c.com>
To: <sj@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC: <damon@lists.linux.dev>, <linux-trace-kernel@vger.kernel.org>,
        Yu Qin
	<qin.yuA@h3c.com>
Subject: [PATCH] mm/damon: fix incorrect field name in damos_stat_after_apply_interval
Date: Sat, 9 May 2026 11:49:51 +0800
Message-ID: <20260509034951.3757618-1-qin.yuA@h3c.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 6493p3Ir032653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=h3c.com; s=default;
	t=1778298620; bh=9/Q+uPiuTRWOLurjJ6VTqNrKmlNKnyCD/DqPcys6GEs=;
	h=From:To:CC:Subject:Date;
	b=ZHD056fV04FT1Wahr2haPBw2SufSMJyMrypI1Un0z4jBATZrcJfugotNtk16VrK0X
	 8BiNuss91/09+z8JT2/mBkxjDYaFE5M7bUEY/liI2N+inW5QNLTbuPTJHnR7OQ2CAe
	 PBcglmvhOSitvaC3+OwP03KMgZxKRsWhQvuELNdGYnuBJQXMjmDobN57Rh1Hl7wbAQ
	 YCH12MAKpXtWAHjyljx90gpxnhCT/AFQMdQweSIEvD8pjUB6RHhx7MwO5PHVuEGeMT
	 I6B64n7XjVfMA+mwWNTqEjDBAB8umL0jsYw7P/Qah4fGG9gkJFPKTMVaajT438xizP
	 /FWXz0SD8ZjNA==

Fix the format string to use 'sz_applied' instead of 'sz_tried' to correctly
represent the applied size.

Signed-off-by: Yu Qin <qin.yuA@h3c.com>
---
 include/trace/events/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 24fc402ab..7e25f4469 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -41,7 +41,7 @@ TRACE_EVENT(damos_stat_after_apply_interval,
 	),
 
 	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu "
-			"nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu "
+			"nr_applied=%lu sz_applied=%lu sz_ops_filter_passed=%lu "
 			"qt_exceeds=%lu nr_snapshots=%lu",
 			__entry->context_idx, __entry->scheme_idx,
 			__entry->nr_tried, __entry->sz_tried,
-- 
2.33.0


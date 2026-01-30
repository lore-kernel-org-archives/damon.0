Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DA32DE71D
	for <damon@lists.linux.dev>; Fri, 30 Jan 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763399; cv=none; b=FybXSZJvTOQfvN1GZZBz4DSXk7C7uTBCYTRCetlb+uofKx1G8m/P7JxSXQgDmZBPBOxzUMcf8AFn0DaJkMGsHX3XrZQ+thUOCdxroR8KYusv10BfFRa/3p+VykoeyWD3n5USWPHdb83g2msV/QwFReKm2Jbyi5FRnU/cYVUIso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763399; c=relaxed/simple;
	bh=fZhU4NRWw871KX5aUACDSwJMpDszMHqcrSRNNDBgl/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CZwpQsNzragG2VZ1iAARIhh+HIxEs4CaCq3j3uzZ5DC0URgTU9ZTW9gHhJXgetn8pVZM1a+JN7jD2YXKyaWHY1K1P7+duz3bPCW+eGjATMZrDOSRVob4UMw5fpTal9YI3UY0qfnuOFL5+8brtru8vglFlTbWdFU1RgFnETYZgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <sj@kernel.org>, <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] mm/damon: remove __read_mostly from memory_idle_ms_percentiles
Date: Fri, 30 Jan 2026 03:56:03 -0500
Message-ID: <20260130085603.1814-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc11.internal.baidu.com (172.31.51.11) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The 'memory_idle_ms_percentiles' array in DAMON_STAT is updated
frequently by the kernel to reflect the latest idle time statistics.
Marking it as '__read_mostly' is inappropriate for data that is
regularly written to, as it can lead to cache pollution in the
read-mostly section.

Remove the '__read_mostly' annotation to accurately reflect the
variable's usage pattern.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 mm/damon/stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index ed8e362..5c4eec0 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -34,7 +34,7 @@ module_param(estimated_memory_bandwidth, ulong, 0400);
 MODULE_PARM_DESC(estimated_memory_bandwidth,
 		"Estimated memory bandwidth usage in bytes per second");
 
-static long memory_idle_ms_percentiles[101] __read_mostly = {0,};
+static long memory_idle_ms_percentiles[101] = {0,};
 module_param_array(memory_idle_ms_percentiles, long, NULL, 0400);
 MODULE_PARM_DESC(memory_idle_ms_percentiles,
 		"Memory idle time percentiles in milliseconds");
-- 
2.9.4


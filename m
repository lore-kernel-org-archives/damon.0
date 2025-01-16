Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413B2361E7
	for <damon@lists.linux.dev>; Thu, 16 Jan 2025 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060154; cv=none; b=FBXVzrKAL/L996pqAWOlnYObk3xEsc8lL6awtHnYj5gimn+WMu2yTVstoro6ZDZgoHvTKqOO6qOoRW28E/YDdvwuo2oAgx/ePAdNdm3STRBPyAj0YgYkOfbuTj/WwDHXaX4fNl0qO91AnSx8pmptyfcjkO1qYcNg/iPaNHq870o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060154; c=relaxed/simple;
	bh=S7UaYQKM0rEIBgQePvVmyhrpIsytOaueszjx8dFTERw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvxe6Llq3FUZDAXWu/INsjK7rsrtWuku3dG+JUW7aVrBbAYsbTJOIOufVy3u6IJ7Hmc5ETlGiuFj+5qvVSFzm2P8KZeRpp7WA0qiPTgLBfZm/k5qpONdLCIceXvYT0lEZwrXQORHWr8wI7AObzr5MF4rx0T3UuAuRww45AiuvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JMGWI+uf; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JMGWI+uf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737060145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ovyegd+SvQDVW3xzfKBYSdbeEeBaZAIftFZmgrwXI4k=;
	b=JMGWI+ufxbq+srbVP08mzl0Qzpsoc26wVhXrxnI5jZItLF7IJ8PuYUijnezdFe6nqLfMEW
	2c+6Nxu/0gUbJhsF8CvpwmHTUYBLqEAmaEbsHJS2A+jvGF7ZBFhyJjjCXXpcFAYnmtbjSl
	c1UXgCfJIJTkgGQoLiI7+hneDN73WME=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/core: Use str_high_low() helper in damos_wmark_wait_us()
Date: Thu, 16 Jan 2025 21:42:16 +0100
Message-ID: <20250116204216.106999-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_high_low() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0776452a1abb..ae1715a338d4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -14,6 +14,7 @@
 #include <linux/psi.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
@@ -1894,9 +1895,8 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
 		if (scheme->wmarks.activated)
 			pr_debug("deactivate a scheme (%d) for %s wmark\n",
-					scheme->action,
-					metric > scheme->wmarks.high ?
-					"high" : "low");
+				 scheme->action,
+				 str_high_low(metric > scheme->wmarks.high));
 		scheme->wmarks.activated = false;
 		return scheme->wmarks.interval;
 	}
-- 
2.48.0


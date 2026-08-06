Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FB483BF6
	for <damon@lists.linux.dev>; Thu,  6 Aug 2026 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036093; cv=none; b=dkNk10buUX/nQP42KV2MJAYTSzePWKg466nMHbo+WCdlWEvW07r2mxlOocCb7ZG9FsjpRT0FeHPP5+0OFXN9byEWkki/ukP5L/W21iDkarl3gVrhvkT7GTe18tcGyXORs+7/bFn+T2VeyEsFUnT6OcC3giNUFSQZe7UtzeFnzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036093; c=relaxed/simple;
	bh=2ruuupHzDg/pCnvQCr3QuP7Ea5v9hcuGtTAhco0qSZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYlzpL7Kn0Auythp25mB0IPYpB9OINAdwbBCbq6k5kiYmQv5wL/9RrhlacqE+UzX6xAe+OFLz2iONGOfX0gAUjjDqWMw9p7Z+DhbbwnqzHTugfs76Fr38VERPhOhTjdSsDsxN/paY9K+BysnF6WmITPHH5p0ElDI8BsuVJH6nPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g1XKw5FG; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g1XKw5FG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786036086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QdJIkDZt02KDXWyy13fgX++BhyE6OHznvvIz2+ccsgI=;
	b=g1XKw5FGsoe4d7qJVnWP0XzNu6svQmFhvh4SS8kB1WVNAeloEVM+1ypb8xM3D8IFroznmT
	DYgNXjUV8uumH6y1YCaCYz0K/iaiHCOGSC0nXkZjcepPWlhRNi2FTGH2F+yB56/kHR63oO
	eOf8zp6LL/dDcrc6iIR34+Db37ozCuE=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: [PATCH] mm/damon/core: remove declaration of __damon_commit_ctx()
Date: Fri,  7 Aug 2026 01:07:01 +0800
Message-ID: <20260806170701.79266-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

It was added by commit b1471afe4d10 ("mm/damon/core: do parameter testing
commit on damon_start()") but is actually not needed.  Remove it.

Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
---
 mm/damon/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e03df0a61060..fb884b2b1c92 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1954,8 +1954,6 @@ static int __damon_start(struct damon_ctx *ctx)
 	return err;
 }
 
-static int __damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src);
-
 /**
  * damon_start() - Starts the monitorings for a given group of contexts.
  * @ctxs:	an array of the pointers for contexts to start monitoring
-- 
2.53.0


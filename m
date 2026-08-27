Received: from mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655948D868
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848826; cv=none; b=T5AaLsBKskh0QLVu7OBPV36K+84/RLhCvjfq+ZTydpVtEHCXVPffMy2LQoFoLNRO053rzLlc1nBIj2NrIPzq2WRRcgiJ6EmtrAETApKAQuBhcswEu9T/MyDzM6/2gDDE4XLufiNcb4vSMr9m/+8CXqUsR9PkZLBLU5Aebj3qV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848826; c=relaxed/simple;
	bh=dAqjXOjzhNh5omqUcK6UrCGKxTg0RuYnBXOWEvx4Koo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFVW1r+fdZqjcq14WouPQTO3q/Y5zNbMFZXUBB12x/Zhuk7QR7I7CiqOfT4gacfH/9afr0MaSn7JT36dOgxsFzgmgxi934sJcU+Y6NUMZMuEgvuiqfVRMPYM7Jj/wKBVmKwQ1LfnDHjnStUREukNG+VY6QYuYu0+nYv90u6sQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PGwZhunW; arc=none smtp.client-ip=91.218.175.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PGwZhunW"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=dAqjXOjzhNh5omqUcK6UrCGKxTg0RuYnBXOWEvx4Koo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787848820; v=1; x=1788453620;
 b=PGwZhunWCUm5GRrSQK3Ph6tbaqGG37PSIIJ7iEMqtGLeSee4pUdty91UfcSRJkOU2XpbKJJZ
 1ltFsXnRQ8lL2Ryx5drARpi8KIS9hK03ZLEBapfg6Zs6S3ebMMx+U416VQws8RHjkG70Yl5fWCs
 fGvo35Qr34OXTlRbzK3nOd88=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id b5233e2837e3b3f5;
	Thu, 27 Aug 2026 16:40:09 +0000
X-Mizu-Trace-ID: b5233e2837e3b3f5
X-Migadu-Flow: FLOW_OUT
From: Zenghui Yu <zenghui.yu@linux.dev>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: [PATCH] mm/damon/core: remove declaration of kdamond_fn()
Date: Fri, 28 Aug 2026 00:39:53 +0800
Message-ID: <20260827163953.83520-1-zenghui.yu@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

It was added by commit 2224d8485492 ("mm: introduce Data Access MONitor
(DAMON)") but is actually not needed.  Remove it.

Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
---
 mm/damon/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 37d661e2bbc1..183080556404 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1922,8 +1922,6 @@ static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
 	return max_region_sz;
 }
 
-static int kdamond_fn(void *data);
-
 /*
  * __damon_start() - Starts monitoring with given context.
  * @ctx:	monitoring context
-- 
2.53.0


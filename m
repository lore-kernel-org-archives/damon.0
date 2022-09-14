Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982707F
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 09:37:19 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1663148231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hHiFxLoQl7nFkGX8kgtVUXbRSPMp0KpED73uMSjHu+w=;
	b=VoSrXwXuRHkuMJqgFeh5tLtjh1NB+Ha72/uvICQk9QNQ0pkQ03EOA93YfkOxxjmDqWxgrR
	8MYTYS34zwlstEhfu5gl+oJ43Iu4OeA6gADuRa1He9hy+nycYoP5A6zpOG5V9cmFBsW2yk
	h4tFSd/Q9+2rr/XMyyF4obkf2M4yTOk=
From: Yajun Deng <yajun.deng@linux.dev>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: sieberf@amazon.com,
	shakeelb@google.com,
	foersleo@amazon.de,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/damon: fix missing damon_del_region()
Date: Wed, 14 Sep 2022 17:36:36 +0800
Message-Id: <20220914093636.1184590-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev

It should be called damon_del_region() before free each region, so use
damon_destroy_region() instead of damon_free_region().

Fixes: f23b8eee1871 (mm/damon/core: implement region-based sampling)
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0b1eb945c68a..e62e7ebf4b12 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -361,7 +361,7 @@ void damon_free_target(struct damon_target *t)
 	struct damon_region *r, *next;
 
 	damon_for_each_region_safe(r, next, t)
-		damon_free_region(r);
+		damon_destroy_region(r, t);
 	kfree(t);
 }
 
-- 
2.25.1


Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A086D17EC
	for <damon@lists.linux.dev>; Thu, 14 Jul 2022 06:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ae2SQ
	EjyqEAy4llX3y9SCpo1YGcLcUs45qJqZjS/Fig=; b=N0SmdXZQh7th8Ak0L0HlF
	sHvbr6PHlrOpG4jUKjIJXEeOe/PSyANcLGhKl24MVIrVW+IqaNlFW8Y6NoffQ1Vf
	1iCyOkMCeW6g4fLK7UQkogIv2J9CPZ9/eqQ9XvmcKhOhEl0mumoXDT1pFr7Xm75u
	NoRtO+B/ivsldJJLj7aXI4=
Received: from localhost.localdomain (unknown [123.112.69.106])
	by smtp2 (Coremail) with SMTP id GtxpCgCnJeS8uc9i1XzxOw--.21856S4;
	Thu, 14 Jul 2022 14:37:56 +0800 (CST)
From: Jianglei Nie <niejianglei2021@163.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] mm/damon/reclaim: fix potential memory leak in damon_reclaim_init()
Date: Thu, 14 Jul 2022 14:37:46 +0800
Message-Id: <20220714063746.2343549-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GtxpCgCnJeS8uc9i1XzxOw--.21856S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyfKr13WF1fXF1fXF1fWFg_yoWDGwcEyF
	42qryUua1DXa9ay3ZFkw1fCw1xZrWkGrykXFWxt347AFyrGrn3Xry8Xrs3XF17u3yUJry2
	vFs7Zas8Zr129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRibAwPUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiFQU+jF5mLxy4NQAAsk

damon_reclaim_init() allocates a memory chunk for ctx with
damon_new_ctx(). When damon_select_ops() fails, ctx is not released, which
will lead to a memory leak.

We should release the ctx with damon_destroy_ctx() when damon_select_ops()
fails to fix the memory leak.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 mm/damon/reclaim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 4b07c29effe9..0b3c7396cb90 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -441,8 +441,10 @@ static int __init damon_reclaim_init(void)
 	if (!ctx)
 		return -ENOMEM;
 
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
+	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
+		damon_destroy_ctx(ctx);
 		return -EINVAL;
+	}
 
 	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
-- 
2.25.1


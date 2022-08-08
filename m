Received: from mx5.cs.washington.edu (mx5.cs.washington.edu [128.208.2.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713627A
	for <damon@lists.linux.dev>; Mon,  8 Aug 2022 22:05:07 +0000 (UTC)
Received: from mx5.cs.washington.edu (localhost [IPv6:0:0:0:0:0:0:0:1])
	by mx5.cs.washington.edu (8.17.1/8.17.1/1.26) with ESMTP id 278M0mGN108074;
	Mon, 8 Aug 2022 15:00:48 -0700
Received: from attu7.cs.washington.edu (attu7.cs.washington.edu [IPv6:2607:4000:200:10:0:0:0:86])
	(authenticated bits=128)
	by mx5.cs.washington.edu (8.17.1/8.17.1/1.26) with ESMTPSA id 278M0lK7108070
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 8 Aug 2022 15:00:47 -0700
Received: from attu7.cs.washington.edu (localhost [127.0.0.1])
	by attu7.cs.washington.edu (8.15.2/8.15.2/1.23) with ESMTP id 278M0lHO1680562;
	Mon, 8 Aug 2022 15:00:47 -0700
Received: (from klee33@localhost)
	by attu7.cs.washington.edu (8.15.2/8.15.2/Submit/1.2) id 278M0kQC1680561;
	Mon, 8 Aug 2022 15:00:46 -0700
From: Kenneth Lee <klee33@uw.edu>
To: akpm@linux-foundation.org
Cc: damon@lists.linux.dev, Kenneth Lee <klee33@uw.edu>
Subject: [PATCH] mm/damon/dbgfs: Use kmalloc for allocating only one element
Date: Mon,  8 Aug 2022 15:00:19 -0700
Message-Id: <20220808220019.1680469-1-klee33@uw.edu>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kmalloc(...) rather than kmalloc_array(1, ...) because the number of
elements we are specifying in this case is 1, kmalloc would accomplish the
same thing and we can simplify.

Signed-off-by: Kenneth Lee <klee33@uw.edu>
---
 mm/damon/dbgfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index cb8a7e9926a4..51d67c8050dd 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -1041,7 +1041,7 @@ static int __init __damon_dbgfs_init(void)
 				fops[i]);
 	dbgfs_fill_ctx_dir(dbgfs_root, dbgfs_ctxs[0]);
 
-	dbgfs_dirs = kmalloc_array(1, sizeof(dbgfs_root), GFP_KERNEL);
+	dbgfs_dirs = kmalloc(sizeof(dbgfs_root), GFP_KERNEL);
 	if (!dbgfs_dirs) {
 		debugfs_remove(dbgfs_root);
 		return -ENOMEM;
-- 
2.31.1


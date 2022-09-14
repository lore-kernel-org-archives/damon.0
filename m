Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED03D61
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 11:57:35 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPnFGbQ_1663156646;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPnFGbQ_1663156646)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 19:57:27 +0800
From: Xin Hao <xhao@linux.alibaba.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: [PATCH] mm/hugetlbfs: use macro SZ_1K to replace 1024
Date: Wed, 14 Sep 2022 19:57:23 +0800
Message-Id: <20220914115723.38271-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using macro SZ_1K in hugetlbfs_show_options() has no any functional
changes, just makes code more readable.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 fs/hugetlbfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f7a5b5124d8a..9b9784ffe8de 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1023,10 +1023,10 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
 	if (sbinfo->max_inodes != -1)
 		seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);

-	hpage_size /= 1024;
+	hpage_size /= SZ_1K;
 	mod = 'K';
-	if (hpage_size >= 1024) {
-		hpage_size /= 1024;
+	if (hpage_size >= SZ_1K) {
+		hpage_size /= SZ_1K;
 		mod = 'M';
 	}
 	seq_printf(m, ",pagesize=%lu%c", hpage_size, mod);
--
2.31.0

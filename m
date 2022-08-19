Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBE4697
	for <damon@lists.linux.dev>; Fri, 19 Aug 2022 17:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85184C433C1;
	Fri, 19 Aug 2022 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660929576;
	bh=3Sdln9qJKHLzw3ch7twkCCMwF2dg/LGZE0fJeB2Pqds=;
	h=From:To:Cc:Subject:Date:From;
	b=WDXGks4O7BdiqUE7X0ObnfF1Zyc1+QRtTDQWZKrcu/dYHW20fJbBaY5zTopwpzRcr
	 iT1CheRg5d9nG1nbiK+07tKfvbRrMPPAzYs5xdQS9G94QOx6JiQ+CZqnjz5bLfoTQM
	 8GizFsATxnYxbVf0njAQVdq4u3/+gJxXl8HMgOFRfzNYQuZFqeZm2bQA2iehreJcJr
	 MsgssHY7b9NDzkvL3zvPSqZdzev4Zl7VTNxdSDSPb4x7IYajtOS5mXMkGX9sEwD/g5
	 YzO+4CjEDdZnIOJknjJdGpijVe7LNFh8j3wLUZmLKeBi2YCJXcIkfdlNSLufGy6I/p
	 rjfnuFJRi3Ofg==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: sj@kernel.org,
	badari.pulavarty@intel.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/dbgfs: avoid duplicate context directory creation
Date: Fri, 19 Aug 2022 17:19:30 +0000
Message-Id: <20220819171930.16166-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Badari Pulavarty <badari.pulavarty@intel.com>

When user tries to create a DAMON context via the DAMON debugfs
interface with a name of an already existing context, the context
directory creation silently fails but the context is added in the
internal data structure.  As a result, memory could leak and DAMON
cannot be turned on.  An example test case is as below:

    # cd /sys/kernel/debug/damon/
    # echo "off" >  monitor_on
    # echo paddr > target_ids
    # echo "abc" > mk_context
    # echo "abc" > mk_context
    # echo $$ > abc/target_ids
    # echo "on" > monitor_on  <<< fails

This commit fixes the issue by checking if the name already exist and
immediately returning '-EEXIST' in the case.

Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Badari Pulavarty <badari.pulavarty@intel.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lore.kernel.org/damon/DM6PR11MB3978994F75A4104D714437379C679@DM6PR11MB3978.namprd11.prod.outlook.com/)
- Manually check duplicate entry instead of checking
  'debugfs_create_dir()' return value
- Reword commit message and the test case

Seems Badari have some email client issue, so I (SJ) am making this
second version of the patch based on Badari's final proposal and repost
on behalf of Badari.

 mm/damon/dbgfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 51d67c8050dd..364b44063c2f 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -795,7 +795,7 @@ static void dbgfs_destroy_ctx(struct damon_ctx *ctx)
  */
 static int dbgfs_mk_context(char *name)
 {
-	struct dentry *root, **new_dirs, *new_dir;
+	struct dentry *root, **new_dirs, *new_dir, *dir;
 	struct damon_ctx **new_ctxs, *new_ctx;
 
 	if (damon_nr_running_ctxs())
@@ -817,6 +817,12 @@ static int dbgfs_mk_context(char *name)
 	if (!root)
 		return -ENOENT;
 
+	dir = debugfs_lookup(name, root);
+	if (dir) {
+		dput(dir);
+		return -EEXIST;
+	}
+
 	new_dir = debugfs_create_dir(name, root);
 	dbgfs_dirs[dbgfs_nr_ctxs] = new_dir;
 
-- 
2.25.1


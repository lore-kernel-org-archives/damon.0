Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB07FA
	for <damon@lists.linux.dev>; Fri, 10 Feb 2023 04:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786BEC433A1;
	Fri, 10 Feb 2023 04:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676004527;
	bh=GHjXtEXAs/907P6A+4MUMIxpIxGv/uFwCu4RPtNwvv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osoBk/p5fti365hKvBevvfZpAfFjjBuRvv90yf+hbzGZGnr44zGzfMzevZBF1G5W+
	 0cZp6p4OTOl29Rq8NHb+4yhgbo8Dduwr/YXYSUYSaJfAIuLSRgmDs6O0hUYP3PvxqA
	 lnnI3TiTC1gQpj6NnQM4FpQwlGgEiexU4MJHePwMijo+PLyb1i04CdpxtINd6AHV+t
	 iDshdB/9WNtDhnYuAiB7CBh1adRpmRDEgHAOFRS5ChWfCZGD0kOJAV2osSEbuacspk
	 /OtFQ0ujR1NeVbbBb8i0JhTrOBz2jn7zCDH/hnK7mivL/KBsapzZBsQf3lecRBPt1G
	 cR/odiYu7eU/g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 3/3] mm/damon/dbgfs: print DAMON debugfs interface deprecation message
Date: Fri, 10 Feb 2023 04:48:38 +0000
Message-Id: <20230210044838.63723-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210044838.63723-1-sj@kernel.org>
References: <20230210044838.63723-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON debugfs interface has announced to be deprecated after >v5.15 LTS
kernel is released.  And, v6.1.y has announced to be an LTS[1].

Though the announcement was there for a while, some people might not
noticed that so far.  Also, some users could depend on it and have
problems at  movng to the alternative (DAMON sysfs interface).

For such cases, warn DAMON debugfs interface deprecation with contacts
to ask helps when any DAMON debugfs interface file is opened.

[1] https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=332e9121320bc7461b2d3a79665caf153e51732c

Link: https://lkml.kernel.org/r/20230209192009.7885-4-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/dbgfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index b3f454a5c682..124f0f8c97b7 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -20,6 +20,14 @@ static int dbgfs_nr_ctxs;
 static struct dentry **dbgfs_dirs;
 static DEFINE_MUTEX(damon_dbgfs_lock);
 
+static void damon_dbgfs_warn_deprecation(void)
+{
+	pr_warn_once("DAMON debugfs interface is deprecated, "
+		     "so users should move to DAMON_SYSFS. If you cannot, "
+		     "please report your usecase to damon@lists.linux.dev and "
+		     "linux-mm@kvack.org.\n");
+}
+
 /*
  * Returns non-empty string on success, negative error code otherwise.
  */
@@ -711,6 +719,8 @@ static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 
 static int damon_dbgfs_open(struct inode *inode, struct file *file)
 {
+	damon_dbgfs_warn_deprecation();
+
 	file->private_data = inode->i_private;
 
 	return nonseekable_open(inode, file);
@@ -1039,15 +1049,24 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 	return ret;
 }
 
+static int damon_dbgfs_static_file_open(struct inode *inode, struct file *file)
+{
+	damon_dbgfs_warn_deprecation();
+	return nonseekable_open(inode, file);
+}
+
 static const struct file_operations mk_contexts_fops = {
+	.open = damon_dbgfs_static_file_open,
 	.write = dbgfs_mk_context_write,
 };
 
 static const struct file_operations rm_contexts_fops = {
+	.open = damon_dbgfs_static_file_open,
 	.write = dbgfs_rm_context_write,
 };
 
 static const struct file_operations monitor_on_fops = {
+	.open = damon_dbgfs_static_file_open,
 	.read = dbgfs_monitor_on_read,
 	.write = dbgfs_monitor_on_write,
 };
-- 
2.25.1


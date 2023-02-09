Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C770A931
	for <damon@lists.linux.dev>; Thu,  9 Feb 2023 19:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C11FC433A1;
	Thu,  9 Feb 2023 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675970416;
	bh=YKnuEvRI6qfPAJO2dUUkfnH+bQPuZPD2yzEq+Lx0+z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNwNncaxqJtNLK1jiU8L7oyV++uilfm1Jne4U3kLLB385NSqtdiYkJ9f+YuB4rOdK
	 r8irMblAq+as8w9prFXzUhRqT+sN+Q8MUOX4T2Cct1ET47M1Wj8YGIxL9yvdIt+GQX
	 tJrmah8kxg9jC8ep0z3I06JWRIl1Y652uHmKIWsjWEVZ6cbkf3A7U5L3N//AQDz4Xf
	 FbHuAgyGYxo05IvYJnqmOh72HjluzjCiL/YsfqTdGsa9yqVhZU0WXMzbM5FtgWLRj/
	 7SfnQPPzftZC0eIW4SR3pZgk8QhRJV6q5mTmj6nX2NU2shlUhkKAdA36QETg86+6oi
	 wWowqMT+cl1zw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm/damon/dbgfs: print DAMON debugfs interface deprecation message
Date: Thu,  9 Feb 2023 19:20:09 +0000
Message-Id: <20230209192009.7885-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209192009.7885-1-sj@kernel.org>
References: <20230209192009.7885-1-sj@kernel.org>
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

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index b3f454a5c682..e551a20b35e3 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -20,6 +20,11 @@ static int dbgfs_nr_ctxs;
 static struct dentry **dbgfs_dirs;
 static DEFINE_MUTEX(damon_dbgfs_lock);
 
+static void damon_dbgfs_warn_deprecation(void)
+{
+	pr_warn_once("DAMON debugfs interface is deprecated, so users should move to the sysfs interface (DAMON_SYSFS).  If you depend on this and cannot move, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.\n");
+}
+
 /*
  * Returns non-empty string on success, negative error code otherwise.
  */
@@ -711,6 +716,8 @@ static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 
 static int damon_dbgfs_open(struct inode *inode, struct file *file)
 {
+	damon_dbgfs_warn_deprecation();
+
 	file->private_data = inode->i_private;
 
 	return nonseekable_open(inode, file);
@@ -1039,15 +1046,24 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
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


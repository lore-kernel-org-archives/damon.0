Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080621771C;
	Fri, 12 Sep 2025 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644794; cv=none; b=H9yrRg814pAPppKKVxO0Ivs642qwDuvGIwMQxr+IIgkyfbrwpbM4oOytQ6PUJobZzck23hFnaFXv6QSbNXou4nCMO41zzknqOadm0JP2oxL+nhQJcHpRZS4HJAoukjd7Z7B+wrIXXvTqDi3IDvzWNTXpcYRN3lUP78r3JKYJuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644794; c=relaxed/simple;
	bh=R6gFcrBZzKhA783iYWMpRMpyvk2yh72AuYFVIUrkO4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9RQslIWOv3m8HJMIBi31ABr3ZKsVnrduaoZalOYKL0SYwLRDWS7B0Htt52hbYKA5aQVA4515VdWP/VKx0a79ouWMFVySTHhQOUHPbyRDTXXfa/OibfP+b3M/ApJX7FsJWW0XE3B2B23qM6IqY6IwE7XSP2n6bwAlGr8rqdiWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnqoLcU1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnqoLcU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F47C4CEFA;
	Fri, 12 Sep 2025 02:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757644793;
	bh=R6gFcrBZzKhA783iYWMpRMpyvk2yh72AuYFVIUrkO4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnqoLcU1HwAB3uvX7ReqKrUa2MOea8r/MNoj6WTGGW8PpUYZ5uTjJuKOhBBbMJHxJ
	 /JpGCWYr2X29FYDZhFC/FgHZPEC23na/YaL3P1qHSvAB4vH4dAaBbxk1f6/ixa2shg
	 hFh+a5tFt7YKuLwZ+b6QnTO8Ad04AzaGw6rMQSsABuBeVSgBEEeswPgzpscVI/XJg2
	 TJNr7DJiLa6cc0ghDf5y3skZGm9pndE+gLeh0Cfnjn6QHIhbT13MGVbr+pFk6btTkc
	 6xA0vI70JTxkX8ut4Q7cBzANJaO2O3WXpjgXaOP/JFEfjcXFz6wdAE+3NqvP/lxyo6
	 9XJJF49U7/mHg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/7] mm/damon/stat: use damon_initialized()
Date: Thu, 11 Sep 2025 19:39:41 -0700
Message-Id: <20250912023946.62337-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912023946.62337-1-sj@kernel.org>
References: <20250912023946.62337-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT is assuming DAMON is ready to use in module_init time, and
uses its own hack to see if it is the time.  Use damon_initialized(),
which is a way for seeing if DAMON is ready to be used that is more
reliable and better to maintain instead of the hack.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index c33df0ade183..d8010968bbed 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -220,8 +220,6 @@ static void damon_stat_stop(void)
 	damon_destroy_ctx(damon_stat_context);
 }
 
-static bool damon_stat_init_called;
-
 static int damon_stat_enabled_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -235,7 +233,7 @@ static int damon_stat_enabled_store(
 	if (is_enabled == enabled)
 		return 0;
 
-	if (!damon_stat_init_called)
+	if (!damon_initialized())
 		/*
 		 * probably called from command line parsing (parse_args()).
 		 * Cannot call damon_new_ctx().  Let damon_stat_init() handle.
@@ -256,12 +254,16 @@ static int __init damon_stat_init(void)
 {
 	int err = 0;
 
-	damon_stat_init_called = true;
+	if (!damon_initialized()) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	/* probably set via command line */
 	if (enabled)
 		err = damon_stat_start();
 
+out:
 	if (err && enabled)
 		enabled = false;
 	return err;
-- 
2.39.5

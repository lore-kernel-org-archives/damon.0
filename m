Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115637DE92;
	Thu, 16 Apr 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350349; cv=none; b=P54nzyTS11i4P7eirnW9gzBfCLqGIGO9cdDIEjdzDdK22kGJ4769O7eGLWGka8bJh9M+SqlNH7g2lIHN/uwCWf0cJS1CiS/royxYjHZ4xpizBwrqTJQr2HnYrqEnOat11O8jDa15c04MaeVNDEBt6Hk8OUeCea5J9JJSlRUIxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350349; c=relaxed/simple;
	bh=ISIO6kAu45FSQY075H+uIGwTqhCGHuJ5pC1ocL3AuWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eeB3vv7bzN7Gl6Cdx4oIw3/gZmKD38sJioTlDnwMU+EIEOZdQ2MxDgAbrQHgwy4oQ8x9j/erbUO/tGeD2/KagYFIigXJGkhI7l6tFhwqMl6LEZu01++2mwwYnybwYrSi/auPHxva/ncLVdIdVNQWWi1cIB1VeJuHuwfrFfjXHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/nNbhC2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/nNbhC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5860EC2BCAF;
	Thu, 16 Apr 2026 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776350348;
	bh=ISIO6kAu45FSQY075H+uIGwTqhCGHuJ5pC1ocL3AuWs=;
	h=From:To:Cc:Subject:Date:From;
	b=X/nNbhC2pauFxgiFhETPbQlHRyiGdJzADwxmhq8c2pr/CCkvFtHICNfHc3lv6Th1J
	 4amfaFMuG+1ku42xVSvSjeQA/tKSCspS8C1ufIgzTKH5shodUpzpCh+C9WYwCdgza3
	 wFGF7NAHcVKBQRi4yMnQ72oN+UvEv6yC9kx/mCEhbS0xGinuxi60hAQXKr4dvLz9GP
	 Xeivm9TDGQjEUzYdZ1Q7LWTMllJgOYzoc84oZ1fXppqFV2jhkY5dWfNESSN9NnnNY7
	 a+j+t1rbkjiTYcIN8XhlFy2MryfsojSSzjRCv/erZ/zlhJYcGz9UcrGE5VrdUfT1zR
	 FXQzChbmuyGxA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/stat: detect and use fresh enabled status
Date: Thu, 16 Apr 2026 07:38:55 -0700
Message-ID: <20260416143857.76146-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT assumes the kdamond will keep running once damon_stat_start()
succeeds, until it calls damon_stop() to stop it.  If the
regions_score_histogram allocation in kdamond_fn() is tried after
damon_stat_start() returns, however, and if the allocation fails, the
kdamond can stop before DAMON_STAT calls damon_stop().  In this case,
users will show the 'enabled' parameter value as 'true', while it is not
working.  This could make users confused.

The user impact should be mild, though.  First of all, the issue may
happen only quite rarely.  The allocation failure is arguably too small
to fail (100 unsigned long objects) in common setups.  The time window
for the race is also quite small.  Even if the race and the allocation
failure happen, users could find the fact that the kdamond is stopped
using 'ps' like commands.  By writing 'N' and 'Y' to the 'enabled'
parameter sequentially, the user can also easily restart DAMON_STAT.

That said, the bug is a bug that needs to be fixed.  Instead of managing
the complicated state in the variable, detect and use the real kdamond
running status when the user reads the parameter, via the parameter read
callback.  This will allow users to always read the correct 'enabled'
value.

Note that the 'enabled' variable is no longer the argument for the
'enabled' parameter.  But it is still used for two use case.  For
keeping the config/boot time user-set parameter value.  And for keeping
the user request to compare against the current state, to see if the
damon_start() or damon_stop() call are really needed.

Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 99ba346f9e325..3951b762cbddf 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -19,14 +19,17 @@
 static int damon_stat_enabled_store(
 		const char *val, const struct kernel_param *kp);
 
+static int damon_stat_enabled_load(char *buffer,
+		const struct kernel_param *kp);
+
 static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_stat_enabled_store,
-	.get = param_get_bool,
+	.get = damon_stat_enabled_load,
 };
 
 static bool enabled __read_mostly = IS_ENABLED(
 	CONFIG_DAMON_STAT_ENABLED_DEFAULT);
-module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+module_param_cb(enabled, &enabled_param_ops, NULL, 0600);
 MODULE_PARM_DESC(enabled, "Enable of disable DAMON_STAT");
 
 static unsigned long estimated_memory_bandwidth __read_mostly;
@@ -273,17 +276,23 @@ static void damon_stat_stop(void)
 	damon_stat_context = NULL;
 }
 
+static bool damon_stat_enabled(void)
+{
+	if (!damon_stat_context)
+		return false;
+	return damon_is_running(damon_stat_context);
+}
+
 static int damon_stat_enabled_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool is_enabled = enabled;
 	int err;
 
 	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (is_enabled == enabled)
+	if (damon_stat_enabled() == enabled)
 		return 0;
 
 	if (!damon_initialized())
@@ -293,16 +302,17 @@ static int damon_stat_enabled_store(
 		 */
 		return 0;
 
-	if (enabled) {
-		err = damon_stat_start();
-		if (err)
-			enabled = false;
-		return err;
-	}
+	if (enabled)
+		return damon_stat_start();
 	damon_stat_stop();
 	return 0;
 }
 
+static int damon_stat_enabled_load(char *buffer, const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n", damon_stat_enabled() ? 'Y' : 'N');
+}
+
 static int __init damon_stat_init(void)
 {
 	int err = 0;

base-commit: d8bf71b1ab52974349a5d58e40749f04daa339dc
-- 
2.47.3

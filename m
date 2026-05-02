Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355E1DC9B5;
	Sat,  2 May 2026 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777687515; cv=none; b=lJnb30g4UBvC3cM1F1tvuKEFtY2swlLAl2YjIl6CvQIh2kdDNkeS5t5JDe8ZJCvq7k56UNynyS1iq6og7ZnqHGtQe4zqvuetWWuJsmwa4mFNKCnZkqoadCtrLsYzfLQrTmV86rRF8GeumEU020O49sQqGzcuk//WoF3EaWce9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777687515; c=relaxed/simple;
	bh=zmdkpdSWqP8doKAHn9uOBEj3q+JEz8NGiE/WXdGr6Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4kcu4eD71Mms2DLylq1DKBSc1Ry+ZIAGkj3qihybtTVXeb/BbzlJ5P3L4x6Ohl3/IGpAPN00+pkEB6X2luCaf0GErzDhr+8i3QT9Bm3Q9rbPNtIBYoveFVUQG1CRTULAEOOtSaveUSxlbGOmIqr20foUkVt2SRqmy+1yN2uaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ejtoxq0d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ejtoxq0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259E3C2BCC7;
	Sat,  2 May 2026 02:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777687515;
	bh=zmdkpdSWqP8doKAHn9uOBEj3q+JEz8NGiE/WXdGr6Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ejtoxq0dEbQHrdgOUI/B+UpvvG9khRixX7Cbk2C/wzsQtGIgcfY77JjchiMCcZ+JR
	 Z5vBHkO+A/+OrB/QKrnR35mwCYVFC2rxPnU92Z8zruW46MF3l3kuHrdKgdJUQ1tzg6
	 BKHo5uh9hhkeQzLFy9ZDGY7C1XAdo1PV493MyhridiF/FMTqI2GaCiwM+hDkHvj1bQ
	 +Nl6NHm8msrlLH2HK/VBUx6fWIdP2kt66YgpNPf4LPF8bwClnaDKuxsWththf23oVk
	 kkdmz/abV5l5laXUpWuoxjRqGQWe2mHOwRL5jrtUBnprRcy43U92+bx39zGJ3DSn1J
	 IAVtz4+6VTTfQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Fri,  1 May 2026 19:05:03 -0700
Message-ID: <20260502020505.80822-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260502020505.80822-1-sj@kernel.org>
References: <20260502020505.80822-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Knowing the pid of the kdamonds can help user-space management including
monitoring of DAMON's system resource consumption.  To make it easier,
DAMON_SYSFS, DAMON_RECLAIM and DAMON_LRU_SORT provide the pid
information.  DAMON_STAT is not providing it, though.  Expose the pid of
DAMON_STAT kdamond via a new read-only module parameter, namely
kdamond_pid.  This also makes DAMON modules usage more standardized,
because DAMON_RECLAIM and DAMON_LRU_SORT also provide the information
via their read-only parameters of the same name.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index f4d3203e92639..0e14f5bb8f75d 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -266,6 +266,45 @@ static int damon_stat_enabled_load(char *buffer, const struct kernel_param *kp)
 	return sprintf(buffer, "%c\n", damon_stat_enabled() ? 'Y' : 'N');
 }
 
+static int damon_stat_kdamond_pid_store(
+		const char *val, const struct kernel_param *kp)
+{
+	/*
+	 * kdamond_pid is read-only, but kernel command line could write it.
+	 * Do nothing here.
+	 */
+	return 0;
+}
+
+static int damon_stat_kdamond_pid_load(
+		char *buffer, const struct kernel_param *kp)
+{
+	int pid;
+
+	if (!damon_stat_context) {
+		pid = -1;
+	} else {
+		pid = damon_kdamond_pid(damon_stat_context);
+		if (pid < 1)
+			pid = -1;
+	}
+	return sprintf(buffer, "%d\n", pid);
+}
+
+static const struct kernel_param_ops kdamond_pid_param_ops = {
+	.set = damon_stat_kdamond_pid_store,
+	.get = damon_stat_kdamond_pid_load,
+};
+
+/*
+ * PID of the DAMON thread
+ *
+ * If DAMON_STAT is enabled, this becomes the PID of the worker thread.
+ * Else, -1.
+ */
+module_param_cb(kdamond_pid, &kdamond_pid_param_ops, NULL, 0400);
+MODULE_PARM_DESC(kdamond_pid, "pid of the kdamond");
+
 static int __init damon_stat_init(void)
 {
 	int err = 0;
-- 
2.47.3

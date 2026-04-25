Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1CD2D876B;
	Sat, 25 Apr 2026 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777149198; cv=none; b=EWZqUBhkgY5JVkfTpYO891HCbUrmNKKvpHWdcaZqqTMrBggkTI2ue1eueFmJvt6HHsy3o2dxeFnfNhMWFB2J+6fAWbMbEhgfj/OuVx+2gOyReYmcyMRch0nOx3+onyGNMURYGNjeBIWZZaRVaKTdVfoWX6bckPaO8ScntRkTmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777149198; c=relaxed/simple;
	bh=Ru1qRcWk4w4e46Ipw1oHgndub0LRIDQasZkRB/XPXiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uko2TmCqMbKLpfIZrKVk486crF/6sBcsS5D/QUPkGYuQwi3vlmQVHUdR3WZ54X/8hP+AD7dhlOu35Vk1msXI+y9FKZaP3ek10wtkkL0F+6xU1wmC/coFgqIe5qnb+cOJD708uLRfBLppZbupmYgcI53uwVDeBqC7WJs2op4KsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSqUC9gi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSqUC9gi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985BCC2BCB7;
	Sat, 25 Apr 2026 20:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777149198;
	bh=Ru1qRcWk4w4e46Ipw1oHgndub0LRIDQasZkRB/XPXiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSqUC9gi0v1ghuB0dKd16JF1JuCth0ib8nKBB28OGzN3G8aSh8lHl+tfT53OrtBJr
	 35FPofwxvIug4+ttP/B+1FjDbUu4jn3hwxd1Cy7aQzRzwmLzSdserTB+sWniV0T7AQ
	 9S4kGhSCaV0JhbAFbIlB7q5toGQWnCy1aiFpflMR0OTm+sLByZvbzQIc6L7rPEQ4WO
	 eD/VZ6ZwFz2h/dAHIpcudJMbw0643r5Z6S6P9acXcs7aJcduFCY6O5S0Q/SXPBv37K
	 NDIco7tJvtPYs97xMFcxUk3Th6mYV0XyNrvO7OT+EEv0FYJtllyFLP9QKXHUc0b1Bw
	 NTSjsyzJx3CNA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Sat, 25 Apr 2026 13:33:06 -0700
Message-ID: <20260425203309.108879-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425203309.108879-1-sj@kernel.org>
References: <20260425203309.108879-1-sj@kernel.org>
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
 mm/damon/stat.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index f4d3203e92639..37964683839d0 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -266,6 +266,44 @@ static int damon_stat_enabled_load(char *buffer, const struct kernel_param *kp)
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
+
 static int __init damon_stat_init(void)
 {
 	int err = 0;
-- 
2.47.3

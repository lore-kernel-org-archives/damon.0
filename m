Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410D73F0759;
	Thu, 30 Apr 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558824; cv=none; b=CLK570ElFx+sklP1a7pn1xX+ikM+jL4JQ7+OKi02YV+NwEgHyobElBQtlbsLmcJpymETqBL/IJyMH+Wz5l8+o04dJYOkgfM9QamCZqFEYpEW9IUkvV2tJpFsvuIURJ6CCZaO8Zau9rflZsrqQwUSGZ2tzT4u3HHdrsOvItoBCj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558824; c=relaxed/simple;
	bh=Ru1qRcWk4w4e46Ipw1oHgndub0LRIDQasZkRB/XPXiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNtZUwIxpZazIdShebsCDOUshrCsOoHvI9tQMzwgIfqgksx77aIf7qTafPf6ZTkA6xTzy1VfX6kEnezVgQ96DU2IFjmA6eV2o3BJxaW27w9QiSE9WccNe7Q0UZbDaK30vMMojKlW12Aqq9H40B2X/V5gyaJUAIQcQx3Le4sosQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKqYLUQ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKqYLUQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D63C2BCB8;
	Thu, 30 Apr 2026 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777558824;
	bh=Ru1qRcWk4w4e46Ipw1oHgndub0LRIDQasZkRB/XPXiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKqYLUQ/2B+XygqyB+m1N2X5McbAhh+Xb9n1h5sVjlovsA6Tq9Eqv411ck53zDMAq
	 lkOUX3/km1VfYrZPQWd2y7kU0v8bh1CLUNBFaUHxzCmp+u8lTjuzeFK3yWsmNI8Um9
	 Ah+7q39huMiGgUmZHiMSdXB7d1CsEAiozKM6LhPd6kd+kaQIGMlp+bqHK7kIbK/oVl
	 puM7lORos6+xfOugj8fmbHkYUZdnO1OaGuCuzFuy098fMu/OsTq+15giAGCcMdQCkM
	 2K7WKBEwcKQaqh8XYlmy6rFDx2GkLiIAWWv3BkX4aRlMkXvKRBap+yd9yJmeuVQ91M
	 dAIdSPIOTlY/g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Thu, 30 Apr 2026 07:20:09 -0700
Message-ID: <20260430142013.80993-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430142013.80993-1-sj@kernel.org>
References: <20260430142013.80993-1-sj@kernel.org>
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

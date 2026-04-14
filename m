Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7703E929E;
	Tue, 14 Apr 2026 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211163; cv=none; b=WK6P4VMiGUEAQT5sPRLMZXR7WMCu6hF56Q+3k3/ROaFaTmNEbQq0YHh1i8kCoPIaCC6V9RkCrqR0PpDFJjY7vU1tRTAjcgHXSBI7IHSGhzrHIxmaXZ89Sja/I2RCMIQWEIP5jD7xcSLuiQcAJt7dcVxgH9WJJUWcDO3WJBdRsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211163; c=relaxed/simple;
	bh=89KMBZu/gh+eCPCY4tm5mE3w5HQv3CWTICCzSSCwLjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rze0HJsXTAPorVHZoy6klTSqoa01kFxnP0InwYHQaEOaZQEWyM1s9HVrmo0Mo1Jkanil05CdS8GxbX/DnO7O6lZo0GLHpliNa7cagm2fZO73PedXiZfhvtwjwS4kikYd8b9fgjL6ZtpnsoP6JO/+zFDsYsq3hhWnQo1O4/cdZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqCuFpEJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqCuFpEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A69C2BCB7;
	Tue, 14 Apr 2026 23:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776211163;
	bh=89KMBZu/gh+eCPCY4tm5mE3w5HQv3CWTICCzSSCwLjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BqCuFpEJzlNl+RkLq7nmIRer8zwazZy31XdNlcdw+vRBT7cIO4caxhMKpQDa0UbqL
	 OEeuuwNCrQWDr/JOjjCYlaXtmmdWmaGS0mbRxEXFEaffIRGcDzn+sbWqoO16D+69Bi
	 RIvF/xcRqEhAAdH4AMtUUg4uiRlcqNCVbGHoUKeEaIkV8hA4UDaEhw7oyUX64k5xq3
	 DNpEqoNhW1ck7FhWhyPpYFG0z//8ilRNUGCclUJxUtkWCnoAw5Ut8WH/SMcIMi9CDS
	 d0aBGkx+Ji4ZpOBmlQmbFcC3wkLGYDurs1xVhj6D1TSLgeQ17iCvsBh+NTC05xBCQ/
	 xhUB0Qf0LsvNg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Tue, 14 Apr 2026 16:59:10 -0700
Message-ID: <20260414235912.98174-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414235912.98174-1-sj@kernel.org>
References: <20260414235912.98174-1-sj@kernel.org>
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
 mm/damon/stat.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 99ba346f9e325..510c593a313b8 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -44,6 +44,15 @@ module_param(aggr_interval_us, ulong, 0400);
 MODULE_PARM_DESC(aggr_interval_us,
 		"Current tuned aggregation interval in microseconds");
 
+/*
+ * PID of the DAMON thread
+ *
+ * If DAMON_STAT is enabled, this becomes the PID of the worker thread.
+ * Else, -1.
+ */
+static int kdamond_pid __read_mostly = -1;
+module_param(kdamond_pid, int, 0400);
+
 static struct damon_ctx *damon_stat_context;
 
 static unsigned long damon_stat_last_refresh_jiffies;
@@ -260,6 +269,13 @@ static int damon_stat_start(void)
 		damon_stat_context = NULL;
 		return err;
 	}
+	kdamond_pid = damon_kdamond_pid(damon_stat_context);
+	if (kdamond_pid < 0) {
+		err = kdamond_pid;
+		kdamond_pid = -1;
+		damon_destroy_ctx(damon_stat_context);
+		damon_stat_context = NULL;
+		return err;
 
 	damon_stat_last_refresh_jiffies = jiffies;
 	call_control.data = damon_stat_context;
@@ -269,6 +285,7 @@ static int damon_stat_start(void)
 static void damon_stat_stop(void)
 {
 	damon_stop(&damon_stat_context, 1);
+	kdamond_pid = -1;
 	damon_destroy_ctx(damon_stat_context);
 	damon_stat_context = NULL;
 }
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A62C08DC;
	Tue, 14 Apr 2026 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142213; cv=none; b=DAEWeIxg4h505r/v/pPiDLDypqrzk0s8ZAuBgM4SbpGnUhu65rC7ij+r10+V26T1/Icd0Dg/IxhxbjJ5p9hbbWWY4lmuEz/3UancOveGkXj/AHaFTVxfBMOxnB9+FJHXZjEyHssOGWq32HCQZQFh5OVxsFkRYUSfPkTkg4nwyKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142213; c=relaxed/simple;
	bh=tEc5S1Hg5SD+ndgy55KmKghFX44j7oOw2xQAGI0H8z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVyKMFaFbaLg4TgGVwWuuwRHoB5lZftEYsX8Frov171nNNXMcFKWkRBMQ5dkthgkQvy+Yd9MqGvh29ptA8WvD8fl2wiWw6yPFcZt1ILZSST6fCvgKn9gkETOo9YmHqWRwywXNl6gbpKJfUC6Qbw6xEJNNU9InRyqMqsFdOUGI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue0OyZPg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue0OyZPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EB3C2BCB6;
	Tue, 14 Apr 2026 04:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776142213;
	bh=tEc5S1Hg5SD+ndgy55KmKghFX44j7oOw2xQAGI0H8z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ue0OyZPgAKphMQmfgufZ2O980EarRHbBfjq+clKfoxTrPNS/sRMGwvKWPR+k2nI6V
	 WbaeMSQbSvFgXYglf9GY0PmVsD4bDWriarNDgdciO4K8MMIn81q9svdQtQ3XwQMLBJ
	 ezf7jCkUo1KLEVrxgWjTfPC+taBkQBnQ8ugAd+i05ppnCM3ejkHXCO7TsdB6nzlHwR
	 sZyUAaF/35qC/gIDoOZVo+WvIQA1vsoUwirXaZDIbj1UVfxC9IxyVmxo3cHDT60tkP
	 XRdUqjKLPIsfS16Hy1PlbGnp/ffQbaYoGITIJ9fcDaVMfHP0BM7q/MmLsffDjmvmBE
	 Q7BlFiOVf8e3w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Mon, 13 Apr 2026 21:49:59 -0700
Message-ID: <20260414045002.88110-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414045002.88110-1-sj@kernel.org>
References: <20260414045002.88110-1-sj@kernel.org>
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
 mm/damon/stat.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 99ba346f9e325..21fa04d95eeac 100644
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
@@ -260,6 +269,9 @@ static int damon_stat_start(void)
 		damon_stat_context = NULL;
 		return err;
 	}
+	kdamond_pid = damon_kdamond_pid(damon_stat_context);
+	if (kdamond_pid < 0)
+		return kdamond_pid;
 
 	damon_stat_last_refresh_jiffies = jiffies;
 	call_control.data = damon_stat_context;
@@ -269,6 +281,7 @@ static int damon_stat_start(void)
 static void damon_stat_stop(void)
 {
 	damon_stop(&damon_stat_context, 1);
+	kdamond_pid = -1;
 	damon_destroy_ctx(damon_stat_context);
 	damon_stat_context = NULL;
 }
-- 
2.47.3

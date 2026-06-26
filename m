Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F363A9639
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782461435; cv=none; b=XQ/wXhRwXktklwDnn59hjXmA+a1FF/HCqfjyz+DDOn9iVAL4j718o49NCMTW9H/Nh2TgVZczNq/0XC7o1UUi+clfyONE3hNOoRY8oXNI6/ROA0T34AiwEBi+nuiLEG+dMNm+JLvxpasATO+krBSOG5JTyjxEBFYzGtDCjZLtQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782461435; c=relaxed/simple;
	bh=ylVJPo4xI4IQ5MMsxnyeXfMOa3DRhh9YA0pi+ctJbVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pt71IWDC9czsQPW7UUcvurQABl9hv0jL9eqVsGvmxDJKMVyQ21mPt9j+yAaIZmymgx55YXtffe0dlUWeWu43heT+/I5+G/QRzwIqt1w7HynfRrVSw8dmzCmaWvXSa/Po1gBGASAdtgQ+p+mEc//rsjgV3P0e7DOC6e/ziUsrG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpeQGR4h; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpeQGR4h"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c80879c36eso3100775ad.1
        for <damon@lists.linux.dev>; Fri, 26 Jun 2026 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782461434; x=1783066234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48i67nzh9pxu8NTOl7eRiJOeiFO+TayVZ9b4xMQJyfc=;
        b=WpeQGR4hznBdqVvEh2lZS0smqG9ZZK8Oq+3rGOrK91XgZVc1gqaKGVvXLFTkj0tyR9
         7W3LWJXn4J2fJ7j2nJBkeI3GJXvc7RvbzsBscNZmiB+zIziYk2F8uytBLCQjyXv+7KW7
         Z+yhLnGQXAd18PB7wTbuWKY3dHNR7vkcKmGmHPvTlypfbs/nzo9kbkyX1nqV2QLiCsxd
         OqbmwkhcV2jnBLKIUQlb40ofLC5PKZ0RH/QWfOtjZYrCbJ7HHWDpkcEKq+VcXAcOVyxK
         LnHwlcASklKqcjXalmYXPo3Hnafhzqhc+OBf0qjQXuw2GhghXad8Y2IdY/VU82FV63zr
         F+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782461434; x=1783066234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48i67nzh9pxu8NTOl7eRiJOeiFO+TayVZ9b4xMQJyfc=;
        b=ixojGXXg2DnDBGwWo3qbpkszM4lLlQVVQ4Q7MFA4lffGfTdJvTn3oUNp0FyLRuC0Fh
         uCoZONdxZ6OndGFU1/5F3GNi5RXAHh5E/F++NMLA/SfDUSUvPUVKlDKr8Bx1AuL2bscO
         Q6eknGvRQsKCKbWz6clKoZncQI04dQXERgpSQTf4mDqe1KU/WtqJVt5rLh6FlfjThPwH
         E9HdRV9XS5aD330io7sr/VsBomzOgm4y6o0IZlVwS1/UpE5BIpZjNOdezoWbgMPw3/Uv
         hjyTqGSF2l4AHb3MBL8EMJ7WI9fwBNBuQeYobWP9X9nBM+MXMAzaCRWgJ22GDxQAdYS8
         EhFg==
X-Gm-Message-State: AOJu0YyllM/tBjED2vnYKlfRzknKBvluDrlPWIq0kqj5ZVF99H5VzTAP
	r7xNH6RPJXXpII/a6TfzoQLEVjTBTS5DCXqdt6uYc0uA6tK49nJ9kwNp
X-Gm-Gg: AfdE7ck1U/d6MPmLRhPxI06ILoemwTMbzXZDbdaj96vfBfHWe4HwPPaYBzB6YXUVutx
	5/leO585PHN5c+vHQisbq0MHp4Ts0H5nYN4ZhrJ5JoKjyNnyhpK4aR7X6qAXZyesL6t1+z6CwYA
	VLWAEfotV+DycnwsaTEcGutWMUIWLB55MhwSD2aSjsYTsNFs3F3I37ZbPH6NDeosgxx47V252ah
	enA9Kes2Mnt+xZ/rXlssiyHnRMerf3xTtvLa4HKPUt3cgjdtwavwUqa6zy/G4IduqrcuhhM5bdY
	45s2fTEFVFZxD8oTWOZKmURbZ2M23u/2YHAW2Ecq7CDqkM+4hAXJWfxvLrruWQXHw7GtfjLR2l7
	2GRA5B8ZtzwY7DgZBiBXjCaAHzZyxgqnNIWJHY9jqM0gKpouQv1C3QdWuZ40c7nFjTLM+EE9B6h
	kQlrnNNzxaUKjQthz33wGRovzUQqvQ9Ha6W1N/thuPxYHQ5G5Wmys=
X-Received: by 2002:a17:902:ebc6:b0:2c6:af4b:99a1 with SMTP id d9443c01a7336-2c7c3d2a805mr134249435ad.3.1782461433641;
        Fri, 26 Jun 2026 01:10:33 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9a5:e298:5467:317e:e807:794b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63cfe81sm34154045ad.55.2026.06.26.01.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:10:33 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC PATCH] mm/damon/reclaim: add 'available' memory as an optional watermarks metric
Date: Fri, 26 Jun 2026 16:10:38 +0800
Message-ID: <20260626081038.46569-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======

Currently, DAMON's watermarks metric is calculated based on the
proportion of the system's free memory.

However, on devices like Android, the system typically maintains a very
low amount of free memory, even when the available memory is abundant.
This causes DAMON_RECLAIM to prematurely or aggressive trigger memory
reclamation, thereby increasing the risk of page refaults.

Solution
========

Introduce a new sysfs parameter 'memrate_type' to DAMON_RECLAIM. Users
can switch DAMON's watermark metric evaluation to be based on available
memory by writing 'available' to this parameter and commit the change.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 include/linux/damon.h    |  9 ++++---
 mm/damon/core.c          |  6 +++++
 mm/damon/reclaim.c       | 56 ++++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs-schemes.c |  4 +++
 4 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6f7edb3590ef..0006e3a25317 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -314,13 +314,16 @@ struct damos_quota {
 /**
  * enum damos_wmark_metric - Represents the watermark metric.
  *
- * @DAMOS_WMARK_NONE:		Ignore the watermarks of the given scheme.
- * @DAMOS_WMARK_FREE_MEM_RATE:	Free memory rate of the system in [0,1000].
- * @NR_DAMOS_WMARK_METRICS:	Total number of DAMOS watermark metrics
+ * @DAMOS_WMARK_NONE:		    Ignore the watermarks of the given scheme.
+ * @DAMOS_WMARK_FREE_MEM_RATE:	    Free memory rate of the system in [0,1000].
+ * @DAMOS_WMARK_AVAILABLE_MEM_RATE: Available memory rate of the system in
+ *				    [0,1000].
+ * @NR_DAMOS_WMARK_METRICS:	    Total number of DAMOS watermark metrics
  */
 enum damos_wmark_metric {
 	DAMOS_WMARK_NONE,
 	DAMOS_WMARK_FREE_MEM_RATE,
+	DAMOS_WMARK_AVAILABLE_MEM_RATE,
 	NR_DAMOS_WMARK_METRICS,
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7e4b9affc5b0..f12d06081d70 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3300,11 +3300,17 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 static int damos_get_wmark_metric_value(enum damos_wmark_metric metric,
 					unsigned long *metric_value)
 {
+	long available_pages;
+
 	switch (metric) {
 	case DAMOS_WMARK_FREE_MEM_RATE:
 		*metric_value = global_zone_page_state(NR_FREE_PAGES) * 1000 /
 		       totalram_pages();
 		return 0;
+	case DAMOS_WMARK_AVAILABLE_MEM_RATE:
+		available_pages = si_mem_available();
+		*metric_value = available_pages * 1000 / totalram_pages();
+		return 0;
 	default:
 		break;
 	}
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index ce4499cf4b8b..229bc68bb1ad 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -159,6 +159,17 @@ static unsigned long addr_unit __read_mostly = 1;
 static bool skip_anon __read_mostly;
 module_param(skip_anon, bool, 0600);
 
+/*
+ * Watermarks metric options.
+ *
+ * If this parameter is set as ``free``, DAMON_RECLAIM calculates the watermark
+ * metric based on the system's free memory rate. If set as ``available``, it
+ * calculates the metric based on the system's available memory rate.
+ *
+ * Default is ``free``.
+ */
+static enum damos_wmark_metric memrate_type = DAMOS_WMARK_FREE_MEM_RATE;
+
 static struct damos_stat damon_reclaim_stat;
 DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_reclaim_stat,
 		reclaim_tried_regions, reclaimed_regions, quota_exceeds);
@@ -220,6 +231,8 @@ static int damon_reclaim_apply_parameters(void)
 		goto out;
 	}
 
+	damon_reclaim_wmarks.metric = memrate_type;
+
 	attrs = damon_reclaim_mon_attrs;
 	if (autotune_monitoring_intervals) {
 		attrs.sample_interval = 5000;
@@ -376,6 +389,49 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
 MODULE_PARM_DESC(addr_unit,
 	"Scale factor for DAMON_RECLAIM to ops address conversion (default: 1)");
 
+static int damon_reclaim_memrate_type_store(const char *val,
+					    const struct kernel_param *kp)
+{
+	if (sysfs_streq(val, "free"))
+		memrate_type = DAMOS_WMARK_FREE_MEM_RATE;
+	else if (sysfs_streq(val, "available"))
+		memrate_type = DAMOS_WMARK_AVAILABLE_MEM_RATE;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int damon_reclaim_memrate_type_load(char *buffer,
+					   const struct kernel_param *kp)
+{
+	int type = READ_ONCE(memrate_type);
+	int len = 0;
+
+	if (type == DAMOS_WMARK_FREE_MEM_RATE)
+		len += sysfs_emit_at(buffer, len, "[free] ");
+	else
+		len += sysfs_emit_at(buffer, len, "free ");
+
+	if (type == DAMOS_WMARK_AVAILABLE_MEM_RATE)
+		len += sysfs_emit_at(buffer, len, "[available] ");
+	else
+		len += sysfs_emit_at(buffer, len, "available ");
+
+	len += sysfs_emit_at(buffer, len, "\n");
+
+	return len;
+}
+
+static const struct kernel_param_ops memrate_type_param_ops = {
+	.set = damon_reclaim_memrate_type_store,
+	.get = damon_reclaim_memrate_type_load,
+};
+module_param_cb(memrate_type, &memrate_type_param_ops, &memrate_type, 0600);
+MODULE_PARM_DESC(memrate_type,
+		 "Memory rate type for watermarks metric "
+		 "(free or available, default: free)");
+
 static bool damon_reclaim_enabled(void)
 {
 	if (!ctx)
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 329cfd0bbe9f..5d6636433bd6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1056,6 +1056,10 @@ damos_sysfs_wmark_metric_names[] = {
 		.metric = DAMOS_WMARK_FREE_MEM_RATE,
 		.name = "free_mem_rate",
 	},
+	{
+		.metric = DAMOS_WMARK_AVAILABLE_MEM_RATE,
+		.name = "available_mem_rate",
+	},
 };
 
 static ssize_t metric_show(struct kobject *kobj, struct kobj_attribute *attr,
-- 
2.54.0


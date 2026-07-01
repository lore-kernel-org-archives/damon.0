Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787533F23DF
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906450; cv=none; b=NzawrsX3XbHoBNNBxXSYnWShNUdu4TcXfRbzyRH5cTobBc+h61sVuesxLvaiosDvw7er+0vTvP+JpBC5XRij3Au/5jL7Il7sXYqgvPU/danjvqXGXGh8cvooBKHdLvzZEr5EhJd8Um9/hiOGVpLhm3w2dI23z3SGSQdWnBK0Q1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906450; c=relaxed/simple;
	bh=t2aDhVhWtQ0bk9kZleiffFmC3e0+L1rE8J64jnC1LGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAB2TbFBtFRemR/nrU0pL2BFwSTYouojZ8Yhr7v6Mx9dA8W/xz6oq3hTm+Sm9JVhJpIf+LkEUlz+7djifv5Y4Kwg6rerVssqpcXCVRxy+Ar6umbjUIU3BJrYeErsGIn0PLPoGlmREQYqu0lOZQGF4nEBbfPZgdrPfOZVzHLk6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdKF+Cvi; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdKF+Cvi"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30ec3dfbcd1so933555eec.0
        for <damon@lists.linux.dev>; Wed, 01 Jul 2026 04:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782906448; x=1783511248; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bzJQz5GnN2ox5PLzrp2Ge3nxM0G2/PXl7LwNvmx7vnM=;
        b=LdKF+Cvicm862g4mhul8qk5PkhOS62Zwo7pm+MrY/5gePMLQwWVt0PAqbuzHLn3lJm
         vQDgWsI63UJZBzSCy3j5MQXIoKQftvaVO5OYEV+NJ8DBhAjMph4XgHWqdtEORIaxlzZA
         dlH6rGyH5x8Te1jWBXjCN1g3ZzAO9TjiNR86mJQOyywOOQBGg7H+I6ci6DDrg79LU4Pe
         vO6L/SFTQQbwZn8p9vfeaU1Z3VtaURXd6ZUhANSkpIPahTFZVcGaAc3ErfGM24JbdMGU
         lYwrYdQPFyc6BX8he/1tnTjvlYqriqxcvI7EGhDcJ/c4Hu5NjB1NfdEMv4QqXm++ooc6
         TmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906449; x=1783511249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bzJQz5GnN2ox5PLzrp2Ge3nxM0G2/PXl7LwNvmx7vnM=;
        b=rG7LMTTV61nLYHexO3HB2zF3Lft8hPuac6SUQS3Z+5Jwb3jUp2At/YdoEZ6Art0LUV
         7UWetJPEYx2Wk/zZo/M6CunRWPEKKM3C4x1+1yhRqvUtx9sahBtsSEL28/YuekjxVEjw
         BlOFjYQ8fsY9lJEcLiip4JycfMsx7LomZj/MlD1NJF79+vrSrvfREaGmiD59AW1t6QEW
         Zy6AECU8sfT/ykofNcUQUxUGCbxetueL2FWVB4amNTMX0mBeMNLd5CFxgp9xbttWIuQh
         3HYEX95/UsxhbSkxwrvfzX0dVFP5HAduuDXUDNZkX1LEzEA6iyDVVi573OSG395JmAMv
         C/Ww==
X-Gm-Message-State: AOJu0Yz3xB1mLPT9jlo0o79waRiqU+ca9nBji0o3DYERFeswL3W7CbA7
	OQa6NhySF2KLUOURMCVWNIgRExMM0RzclJezq24lgapnAH8NXLir1MRHTFJnIreF
X-Gm-Gg: AfdE7ckaAs2ckvV6kd4Qbjlghwy/5XwFylzXNdYKTgtsWiFlKohxHZunkzeCZWK+AhF
	cquZc+garroQmisp5EDV+5mq1HTWXgsVY9OzVLHxlWbALjeafApKAKivRPF5FZHt6ZcjqFomOrv
	IOyZT0HzKWYczGo+ntyUZrQWB4VsZPV5Z1ultKKQXLQjptawKxYkQvany7Tq676J4vFonRXeHLk
	b98iP2fJYRgI9BuUwmreZpSdoFlxeo1uifpKqFbXK+fNetkE/qVXm6m9adRm+F0KiKEVJY5ACWS
	wa4VHpRozj5c7gD0wV4N+VD6Y3xjDKlZPsGAOnEWnz2FIEUtAnlznFuFkdyu0bxwou76W4k3MFE
	UE5RriYtvAxOBGqWZpYWZkAwM1Xzb04CxiFoVsZ0PBQc6h0FSpCZczLSbwJW3U/ZtsrOpL03ox3
	Nn0A==
X-Received: by 2002:a05:7301:2e85:b0:30c:efc:c399 with SMTP id 5a478bee46e88-30f05434252mr367328eec.35.1782906448364;
        Wed, 01 Jul 2026 04:47:28 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee327cea7sm22518169eec.31.2026.07.01.04.47.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 04:47:28 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	sj@kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2 1/5] mm/damon: add target_order field for DAMOS_COLLAPSE
Date: Wed,  1 Jul 2026 19:47:12 +0800
Message-ID: <20260701114716.56503-2-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701114716.56503-1-lianux.mm@gmail.com>
References: <20260701114716.56503-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Lian <lianux.mm@gmail.com>

DAMOS_COLLAPSE currently collapses into PMD-size THP only.  Add a
target_order field to express per-order mTHP collapse intent.  Zero
means system default (PMD order, same as current behavior).  Valid
values are 0 and 2..HPAGE_PMD_ORDER.

Wire up the sysfs interface: a per-scheme rw file "target_order".
Validate at store time that the value is in range, and warn at scheme
creation time if DAMOS_COLLAPSE is used with an unsupported non-PMD
order, resetting to 0.

The actual mTHP application via the khugepaged wrapper will be added
in subsequent patches.

Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.wang@processmission.com>
---
 include/linux/damon.h    |  5 +++++
 mm/damon/sysfs-schemes.c | 45 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6f7edb3590ef..5a0587556573 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -572,6 +572,11 @@ struct damos_migrate_dests {
 struct damos {
 	struct damos_access_pattern pattern;
 	enum damos_action action;
+	/*
+	 * @target_order: target order for mTHP actions (DAMOS_COLLAPSE).
+	 * 0 means system default (PMD order).  Valid: 0, 2..HPAGE_PMD_ORDER.
+	 */
+	unsigned int target_order;
 	unsigned long apply_interval_us;
 /* private: internal use only */
 	/*
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 329cfd0bbe9f..735970717048 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -6,7 +6,9 @@
  */
 
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/numa.h>
+#include <linux/huge_mm.h>
 
 #include "sysfs-common.h"
 
@@ -2257,6 +2259,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_stats *stats;
 	struct damon_sysfs_scheme_regions *tried_regions;
 	int target_nid;
+	unsigned int target_order;
 	struct damos_sysfs_dests *dests;
 };
 
@@ -2642,6 +2645,34 @@ static ssize_t target_nid_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t target_order_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+
+	return sysfs_emit(buf, "%u\n", scheme->target_order);
+}
+
+static ssize_t target_order_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	unsigned int val;
+	int err;
+
+	err = kstrtouint(buf, 0, &val);
+	if (err)
+		return err;
+
+	if (val != 0 && (val < 2 || val > HPAGE_PMD_ORDER))
+		return -EINVAL;
+
+	scheme->target_order = val;
+	return count;
+}
+
 static void damon_sysfs_scheme_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
@@ -2656,10 +2687,14 @@ static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
 static struct kobj_attribute damon_sysfs_scheme_target_nid_attr =
 		__ATTR_RW_MODE(target_nid, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_target_order_attr =
+		__ATTR_RW_MODE(target_order, 0600);
+
 static struct attribute *damon_sysfs_scheme_attrs[] = {
 	&damon_sysfs_scheme_action_attr.attr,
 	&damon_sysfs_scheme_apply_interval_us_attr.attr,
 	&damon_sysfs_scheme_target_nid_attr.attr,
+	&damon_sysfs_scheme_target_order_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme);
@@ -3005,6 +3040,16 @@ static struct damos *damon_sysfs_mk_scheme(
 	if (!scheme)
 		return NULL;
 
+	if (sysfs_scheme->action == DAMOS_COLLAPSE &&
+	    sysfs_scheme->target_order != 0 &&
+	    sysfs_scheme->target_order != HPAGE_PMD_ORDER) {
+		pr_warn("DAMON collapse: target_order %u not supported, only PMD order (%u) is available. Use 0 or %u.\n",
+			sysfs_scheme->target_order,
+			HPAGE_PMD_ORDER, HPAGE_PMD_ORDER);
+		sysfs_scheme->target_order = 0;
+	}
+	scheme->target_order = sysfs_scheme->target_order;
+
 	err = damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota);
 	if (err) {
 		damon_destroy_scheme(scheme);
-- 
2.50.1 (Apple Git-155)


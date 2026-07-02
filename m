Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3747DD47
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985962; cv=none; b=ADcIPyF8qXgOdi5XT2WR4KjlYPDTfmhDxbil+ddMfy8xcDsu/klkhgrb24x3Ia+b4id1D7UTLdzCWbidqQQ6kNToYZRijfrty3sZf9eUF3GG6p31tGE+eW27gxM6V5M4ljEpMGBcWlPT+BRAf0z1FhhKxVFRHi1GHIiwKytKr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985962; c=relaxed/simple;
	bh=Ydn0e55zkv5c4nUveVDaFWmz9V83VU4CaxFtaaheZhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+4aGUX7kxDrRHZylEYlkwy0lLUnvEmvvaMS34yylORn1c5KYY1oHm/BJ/7PWdw6DQ3bE7kmFaB4MkcqvN3QHQnt4zILR6HVn+blqo7wS8N4SMPC12CRBPnx5vr0KvnuEd6AU2Y4zplIwyPUjewJqguegxemQXQcxYMUr1k4gK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfJGHaB5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfJGHaB5"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37e11438c66so905566a91.3
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985960; x=1783590760; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpS96uEtjcbqmOVeroPMUCkO+BmAfanRLzlSYz1EmYQ=;
        b=nfJGHaB5CVW/eJW2yx2xuz0KbBz51KbsyWFYXLNx3kTcY07F0W8CLitjeyMIU81BdP
         tvTR6raAId72IO+9ECdk6In3TzHOpIYyQQydFVzBI4ESSD1e9MT5ODvD2y7yUXFNZgSV
         3DSg7Y2LlmpKqGW/QPzJjvtudhsVOHOkhn7I5dXfRtv4J1aqkT99/tKJTHa34LsiQzqw
         3uqQ2TLcKUk56HiTCfMES+ep8YJVllB6rzz6WVdoZvTGXJT+swDNDT7HgDyo+d0qy7Va
         SwqqOvVPtRdoAJl2+6P860XRx5Rc6pEBqcG+vqRXWmPZ1ZZCQMSQxtLczsTL/sFJcvCT
         lJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985960; x=1783590760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpS96uEtjcbqmOVeroPMUCkO+BmAfanRLzlSYz1EmYQ=;
        b=lFKEZtbNmIu1l69sFTOs37gfnRcRS9KJ1N9SKIN6mW5SUzm+zSZgBJ+p39lY1nGu0Y
         u40kRwLbf7/+KjalXY8iEEJmQIniXJwjY7FqvyegUEmHv1pjqYdUVTwycQUpwOY6+Ebx
         +LIJcD5m3m8UdI81lduUSC4N6ZS1dOwChqsMDRFpYgZr7Dtwd0EoQHmPt/0aZaWxtKP5
         YGFLTytfUlWstdQDGUnTJEWwspwmUTzlrIjY98J+cT3YAbGQR0xH6FDKo2ey8cv9As2/
         dj73970ClV9XKHe8eNl9MyP3i2vkbYPI/W7zepkMPeneGpn9iByCGqeQXQscCKCRjT+j
         /q9g==
X-Gm-Message-State: AOJu0YxOROV+cwYEvkKPoWxwAVoaFaAZpDIR3GQD3N9lhd4ctZBZNOZl
	FhNp7bKF0IV9+0t+KLWugEhQuksASK22DEwBhCUqNHDRZ1K1z5/5KZSeOS14MflpTo0=
X-Gm-Gg: AfdE7cm7wyruu9b7Dxm7y6s024611oLSaQT7iuXy1UJ2Q9bBAgrMy9RQaf76/p/4CO0
	EK5OQeVW/odHCegEK4dG/3KhUljw3uNMi8XqSXUiUTeszVczxnQu66hRrpzHXbReBXJgEMcm0iz
	Jyy79frfX3WY53I9act4m1/EyCQZpiK7KSZL5AKmL30newZBFdO7SjyVJq+HcSdCcXXsxcN+p1U
	2BFeYEP3oB9tN1cfULQdpktgJPEqJXpKrhTjniU+AODchD0vo3a4lXh8rrtZPzfubLZj+ONgl7O
	k3bIDCFr6Vb4d4pvZBR5pY4xDJjLlm2UgPVCNTvlCHFIDOS8oDWKvXNvEjf+YSLg41Lj0i4qQ/8
	7aWT74l9UGvoBR1Y0gRG04NxdCkwSja1c6tAP29FapGwKt5+HoOsQkPJmDBa+JX3nrgxki99rXO
	qY+ZNHckxBYrLU
X-Received: by 2002:a05:6a21:e0a6:b0:3b2:86cb:929e with SMTP id adf61e73a8af0-3bfed41d914mr6063142637.46.1782985960220;
        Thu, 02 Jul 2026 02:52:40 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b86ef6asm8348869eec.13.2026.07.02.02.52.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 02:52:39 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	sj@kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com
Subject: [RESEND RFC PATCH v2 1/5] mm/damon: add target_order field for DAMOS_COLLAPSE
Date: Thu,  2 Jul 2026 17:52:23 +0800
Message-ID: <20260702095227.75866-2-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702095227.75866-1-lianux.mm@gmail.com>
References: <20260702095227.75866-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.wang@processmission.com>
---
 include/linux/damon.h    |  5 ++++
 mm/damon/core.c          |  2 ++
 mm/damon/sysfs-schemes.c | 61 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

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
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 265d51ade25b..be54defd4646 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -579,6 +579,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 
 	scheme->migrate_dests = (struct damos_migrate_dests){};
 	scheme->target_nid = target_nid;
+	scheme->target_order = 0;
 
 	return scheme;
 }
@@ -1278,6 +1279,7 @@ static int damos_commit(struct damos *dst, struct damos *src)
 
 	dst->wmarks = src->wmarks;
 	dst->target_nid = src->target_nid;
+	dst->target_order = src->target_order;
 
 	err = damos_commit_dests(&dst->migrate_dests, &src->migrate_dests);
 	if (err)
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 329cfd0bbe9f..7dcd582ded86 100644
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
 
@@ -2323,6 +2326,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
 	scheme->action = action;
 	scheme->apply_interval_us = apply_interval_us;
 	scheme->target_nid = NUMA_NO_NODE;
+	scheme->target_order = 0;
 	return scheme;
 }
 
@@ -2642,6 +2646,39 @@ static ssize_t target_nid_store(struct kobject *kobj,
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
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (val != 0 && (val < 2 || val > HPAGE_PMD_ORDER))
+		return -EINVAL;
+#else
+	if (val != 0)
+		return -EINVAL;
+#endif
+
+	scheme->target_order = val;
+	return count;
+}
+
 static void damon_sysfs_scheme_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
@@ -2656,10 +2693,14 @@ static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
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
@@ -2970,6 +3011,7 @@ static struct damos *damon_sysfs_mk_scheme(
 	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
 	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
 	struct damos *scheme;
+	unsigned int target_order;
 	int err;
 
 	struct damos_access_pattern pattern = {
@@ -3005,6 +3047,25 @@ static struct damos *damon_sysfs_mk_scheme(
 	if (!scheme)
 		return NULL;
 
+	target_order = sysfs_scheme->target_order;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (sysfs_scheme->action == DAMOS_COLLAPSE &&
+	    target_order != 0 &&
+	    target_order != HPAGE_PMD_ORDER) {
+		pr_warn("DAMON collapse: target_order %u not supported, only PMD order (%u) is available. Use 0 or %u.\n",
+			target_order,
+			HPAGE_PMD_ORDER, HPAGE_PMD_ORDER);
+		target_order = 0;
+	}
+#else
+	if (sysfs_scheme->action == DAMOS_COLLAPSE && target_order != 0) {
+		pr_warn("DAMON collapse: target_order not supported without THP. Use 0.\n");
+		target_order = 0;
+	}
+#endif
+	scheme->target_order = target_order;
+
 	err = damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota);
 	if (err) {
 		damon_destroy_scheme(scheme);


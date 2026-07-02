Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0D399365
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985604; cv=none; b=jS2NuYNtR8GbexSJYisul52m+2SM5hmqEiSpgR10vhuuZRzKkBPZB2Cvgz0EK3pbhvOB1i6Np84v6r2n89sa4VpfEieV5IbcwidRM3R84pCPh4OFDlr4QBKOjekg1PvyqWTHb2VxAcH6h28Nt9R+6W7mvkoa+xTZAnmBKHzKu8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985604; c=relaxed/simple;
	bh=Ydn0e55zkv5c4nUveVDaFWmz9V83VU4CaxFtaaheZhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd58LaqsXUBgCmzdQ1loChfvl0VI8+sPhj+KzyYwYUI3dw8eq1is5izI1BzsAKKvzFU4TgjI8qdxAcnO7r5tJkmQ1g+9dH0oGbu9pl1d3yZENnR0b9uS4JMyT4ZzU9wMMA0xrRBL0c2xsB4THQ5fT4kYHXkqN2+jjyM1lvPZzXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8rkAkwk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8rkAkwk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c88cc025f54so993943a12.1
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985602; x=1783590402; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpS96uEtjcbqmOVeroPMUCkO+BmAfanRLzlSYz1EmYQ=;
        b=i8rkAkwkDy3S9qmBAiDSswkQ9TK6ax/ATHg7RrkpSvD0SoN1KUaa5mkjdU7nkyiLpO
         Ob6C+DfD2RHXqWko/BsqQnPct4CilH5PmjpCcgcuqmsQpXeKzgKQemZ3bxYXnJsfzm1O
         wbfjFHWJExVKMF6YCvsjAC9dQfAxCz/GvhfwRJd/HuPDbFYvx/PFG2XOHfXxr0jmsWfZ
         bgSJZGoCrlZPU+oZMPxk45JR5/G/Ycxyjk2DbY1wmy7fkAc/m1svkZwkPRLURvQubpDa
         9WqkL0SYZEvMgWcG21/FCfsZTImrp8H1GVNDxbEZCUtTubr9Ego+QiRTuunBUOzSUQ96
         fNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985602; x=1783590402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpS96uEtjcbqmOVeroPMUCkO+BmAfanRLzlSYz1EmYQ=;
        b=SyRyMXSpi9PRfvTQsWimFHhqnjEIk7a5KE0xOQEsWDmdjqnlaBWFEemntLGkriaUyu
         d2sPIeSidUquIMADsZg+SXO09t51K0EylJ77QntTjWP0/Nffc5yJvKYsZQkdsDQebvcb
         1y+tyXJOxKPEDMEx8ljsMeqVNxpLtyRNk09h5P63du8GPN5+RotyIgwWpC97A1KbVRlj
         gH6zoAzk0yyRHQTy20aDE9jwHBTDFuTPzOwUptnTcmNgX6BqFGGRhtq24m9bE8vmWvsZ
         z32TWYBeJCJiNbLuATPvt4m01UYSKBfQfDOg2j/ZbdWyxopXdzMudowa+faUXj2VJgrt
         6EQg==
X-Gm-Message-State: AOJu0Yy/G1TEbkUOtg6UlTkc9DQqq/VPN4jRPV50Fx+fX3AsnHrm6yXi
	Cr7EB2goBYlK+Ka8NDrCKYBzqVcKj1CNtP9ThhioXJVxSLvWn5aF8Pqg
X-Gm-Gg: AfdE7cmUS4GKfQPbTgOmLpbh8U5wrFOmayGx+m6HJLtB94UTQ3s8EJSTkSgpSee4irv
	6wlhCI4nq4X06LhoRx2ngHDcGRfOGixFKI/xMxPyANuEic+I7fkkTVlRNAK3Mtdn5h944f929qc
	lrtOu6eqZnj3X98NThbSZB1p4bBYSutEkdyHHOpRg8zKM2hJe2hxBkB2pqil4UigqbnFKTZx2DF
	OLAjb84qzyqm/l3/MKv2vs4Gaf0tWB+DRXXyD7PGdUhSAryx4OagJKGtwNqP2O7BBp5xhLhki1I
	wTC23mClhy+2Wg5zfGkU2AVDNZv6EeQpsv3uoN4eH1mDWr4cM3lhmzGU+5UAmLPfzm+IqFmBh4c
	X5CrdfD8+1L/lJvfPUVslXsC97ixUjWcG/AwwTYsFXbg4Eq+nysGjmXMPRClCuBDcilnlnXRuzn
	pT4Q==
X-Received: by 2002:a05:6a21:b93:b0:3a2:ccb5:abc7 with SMTP id adf61e73a8af0-3bfed237b5emr6487223637.13.1782985601858;
        Thu, 02 Jul 2026 02:46:41 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm5261121eec.11.2026.07.02.02.46.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 02:46:41 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com
Subject: [RESEND RFC PATCH v2 1/5] mm/damon: add target_order field for DAMOS_COLLAPSE
Date: Thu,  2 Jul 2026 17:46:29 +0800
Message-ID: <20260702094633.75658-2-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702094633.75658-1-lianux.mm@gmail.com>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
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


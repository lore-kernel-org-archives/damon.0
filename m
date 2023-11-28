Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88771134D7
	for <damon@lists.linux.dev>; Tue, 28 Nov 2023 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMN45zkg"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5cc5988f85eso52187577b3.2
        for <damon@lists.linux.dev>; Mon, 27 Nov 2023 23:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701156906; x=1701761706; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkYXobmQORad3/hpJazSzxaZjqFiG7V4HM30XOOtlqU=;
        b=hMN45zkg5PCCAM3vdgnqWp3iTXamug8kKJ5BIiOejWGB3mIzRtVwkpUbKP9nlfikCZ
         MwvxsOVU2FKKZazaHw9MXfUi8gu8COym/B6VYhuffBFBi9bKgIQwB5tbU09+Hrbfi8NK
         0qc7MgEZiWPzWB4CPuUCF3DCVOUbjYJHVRG/0Nk/OdeYpJwL65ou0Mor0EvRRiiG0pAo
         Lf3M8I5ajhyvlEDy1fV/d8yD5qtP2nol+r0XfNY7UrN+pTLUfdOH/h/pylc1gzZSHQPW
         Pu0j92a3CaWyL3xvXzLDkQESHDG9Sv0et0S0Ds5O6aNjQjFXyCTkVfvpbO5yFlKNw5Cf
         7PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156906; x=1701761706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkYXobmQORad3/hpJazSzxaZjqFiG7V4HM30XOOtlqU=;
        b=oiycaEYhN02sdxohk60w4Byc9RiFpWcWiuQ1KUqIbeb4Jco5LDgEyUUwG2lLmSreR+
         5e3ARlza3vWDDl2fdnmO5ToQxEL4pFk0Gv5G1A/O8BxRlpEcdm3NDJdJJ0j8x6Rwf/uL
         gd0/ew2Uf1p+I8+dhTuag4KKTj0izL9BIWxIDZR+GU2wrnFR71EevSz1fEhRon82yGk5
         9mjIrEMC9kl6smkB4vIMkZP2eWrv9HltnkLzK0/O/SQfj0oIpNM3lGNmhKSVX0BMEACa
         34jzb0yyPUwMFbD8yk682X05m5FfisJHruLvW5vqNRXcUMJhktg9JFyIFZXuasPVozUe
         TaHA==
X-Gm-Message-State: AOJu0YyAHFkWQb0WO3f+N8HTCizWSSE3A6F17whShpU9Ti3nhIrWX4Y3
	e7ObB7/qTTOYncsh7rDC6ecN+Fj6990RGQ==
X-Google-Smtp-Source: AGHT+IHY5XDAgMbNEpLvOxM9X1wUTOqLGATih0InMi8U33BF1AbXSRtWRTq3pq3Q+sVjwW2W4Qaz6w==
X-Received: by 2002:a81:af10:0:b0:5cd:f783:df03 with SMTP id n16-20020a81af10000000b005cdf783df03mr10556684ywh.23.1701156906369;
        Mon, 27 Nov 2023 23:35:06 -0800 (PST)
Received: from cuiyangpei.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cb4fa1174dsm8331333pfn.124.2023.11.27.23.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:35:06 -0800 (PST)
From: cuiyangpei <cuiyangpei@gmail.com>
X-Google-Original-From: cuiyangpei <cuiyangpei@xiaomi.com>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: cuiyangpei <cuiyangpei@xiaomi.com>
Subject: [PATCH 2/2] mm/damon/core: add sysfs nodes to set last_nr_accesses weight
Date: Tue, 28 Nov 2023 15:34:40 +0800
Message-ID: <20231128073440.11894-2-cuiyangpei@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
References: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The date access frequency is cleared every time the aggregation
interval is reached. In order to refer to the past time access
frequency, the current access frequency can be calculated by
setting the weight of the last access frequency.

Signed-off-by: cuiyangpei <cuiyangpei@xiaomi.com>
---
 .../ABI/testing/sysfs-kernel-mm-damon         |  6 ++++
 include/linux/damon.h                         |  3 ++
 mm/damon/core.c                               | 29 +++++++++++++++++
 mm/damon/sysfs.c                              | 31 +++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 819534dcfb6c..8367e26bf4da 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -74,6 +74,12 @@ Description:	Writing a keyword for a monitoring operations set ('vaddr' for
 		Note that only the operations sets that listed in
 		'avail_operations' file are valid inputs.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/last_nr_accesses_weight
+Date:		Nov 2023
+Contact:	Ping Xiong <xiongping1@xiaomi.com>
+Description:	Writing a value to this file sets last_nr_accesses weight
+		of the DAMON context. Reading this file returns the value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6495513cc6de..71e67a9d0996 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -18,6 +18,8 @@
 #define DAMON_MIN_REGION	PAGE_SIZE
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
+/* set last_nr_accesses weight */
+#define LAST_NR_ACCESSES_WEIGHT	0
 
 #define MIN_RECORD_BUFFER_LEN	1024
 #define MAX_RECORD_BUFFER_LEN	(4 * 1024 * 1024)
@@ -522,6 +524,7 @@ struct damon_attrs {
 	unsigned long ops_update_interval;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
+	unsigned int last_nr_accesses_weight;
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 630077d95dc6..230afcceea22 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1142,6 +1142,34 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 }
 
+static unsigned int __calculate_nr_accesses(struct damon_ctx *c, struct damon_region *r)
+{
+	unsigned int rem_old, rem_new;
+	unsigned int res;
+	unsigned int weight = c->attrs.last_nr_accesses_weight;
+
+	res = div_u64_rem(r->nr_accesses, 100, &rem_new) * (100 - weight)
+		+ div_u64_rem(r->last_nr_accesses, 100, &rem_old) * weight;
+
+	if (rem_new)
+		res += rem_new * (100 - weight) / 100;
+	if (rem_old)
+		res += rem_old * weight / 100;
+
+	return res;
+}
+
+static void kdamon_update_nr_accesses(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t)
+			r->nr_accesses = __calculate_nr_accesses(c, r);
+	}
+}
+
 /*
  * Merge two adjacent regions into one region
  */
@@ -1469,6 +1497,7 @@ static int kdamond_fn(void *data)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
 		if (ctx->passed_sample_intervals == next_aggregation_sis) {
+			kdamon_update_nr_accesses(ctx);
 			kdamond_merge_regions(ctx,
 					max_nr_accesses / 10,
 					sz_limit);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7a7d41e609e3..2946b0e91ad8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -544,6 +544,7 @@ struct damon_sysfs_attrs {
 	struct kobject kobj;
 	struct damon_sysfs_intervals *intervals;
 	struct damon_sysfs_ul_range *nr_regions_range;
+	unsigned int last_nr_accesses_weight;
 };
 
 static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
@@ -553,6 +554,7 @@ static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
 	if (!attrs)
 		return NULL;
 	attrs->kobj = (struct kobject){};
+	attrs->last_nr_accesses_weight = LAST_NR_ACCESSES_WEIGHT;
 	return attrs;
 }
 
@@ -602,12 +604,40 @@ static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
 	kobject_put(&attrs->intervals->kobj);
 }
 
+static ssize_t last_nr_accesses_weight_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_attrs *attrs = container_of(kobj,
+			struct damon_sysfs_attrs, kobj);
+
+	return sysfs_emit(buf, "%u\n", attrs->last_nr_accesses_weight);
+}
+
+static ssize_t last_nr_accesses_weight_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_attrs *attrs = container_of(kobj,
+			struct damon_sysfs_attrs, kobj);
+	int err = kstrtoint(buf, 0, &attrs->last_nr_accesses_weight);
+
+	if (err)
+		return -EINVAL;
+	if (attrs->last_nr_accesses_weight > 100)
+		return -EINVAL;
+
+	return count;
+}
+
 static void damon_sysfs_attrs_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_attrs, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_attrs_last_nr_accesses_weight_attr =
+		__ATTR_RW_MODE(last_nr_accesses_weight, 0600);
+
 static struct attribute *damon_sysfs_attrs_attrs[] = {
+	&damon_sysfs_attrs_last_nr_accesses_weight_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_attrs);
@@ -1083,6 +1113,7 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 		.ops_update_interval = sys_intervals->update_us,
 		.min_nr_regions = sys_nr_regions->min,
 		.max_nr_regions = sys_nr_regions->max,
+		.last_nr_accesses_weight = sys_attrs->last_nr_accesses_weight,
 	};
 	return damon_set_attrs(ctx, &attrs);
 }
-- 
2.43.0


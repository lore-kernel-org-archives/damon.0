Received: from mail-yx2-f4.google.com (mail-yx2-f4.google.com [74.125.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8539B947
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791061720; cv=none; b=XLh9HTS8oMCteK38x9F1jXzavNQuFL6iZO726UXLz1Gn87X8E9yvGg05Ye67+xDN9YRLKlOsB2GaEo74mafBTYFiP9F4NXKxhy6+FyqmuJDTDQMVC/sx1KnZi9pU98XTCp7d5b9mVS2s6zSlTgcULg48rWQKgW8YSmM95Bko3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791061720; c=relaxed/simple;
	bh=4GeTaFkpmSrxrhcBbpEnnLyVrlmly5cEs+VvUB+vYAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J8MDRZcVFDP0GQWhm5U8m6lTIhbq6jYadfnkGvpd1TNThRwc6on54yiCpXCPUcyUbkfsERt+Bem0xXDhIOYl6vHFpv8B8/4NTV+CnU34uEzetl+MIBYXOvzCbHQ+6dkzDu17sEyvrKLT/HXAumtaATfQyt6R4AqltFkHk1dNtl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFDDoF+5; arc=none smtp.client-ip=74.125.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFDDoF+5"
Received: by mail-yx2-f4.google.com with SMTP id 00721157ae682-8af042c666dso67077b3.1
        for <damon@lists.linux.dev>; Sat, 03 Oct 2026 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791061717; x=1791666517; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oz95vRs5vqLfyYxEe+xBnRvqmwtB91PGg+pYDCLuw98=;
        b=MFDDoF+5tuIUrJ5U0gt8P1U8p3G53BFPvU7gU212AzVo1Q8XpGwIYFkWgerxs4Gc9i
         kR7mHii1Q7s6HtF/CGD+5g/Ab1Rri1dLEpMvqdVq3qRGofXaXa5/oGgYVG/WPIo0oFNj
         uq8cbA7rJhOvI/mgPrr+db7dRL53oD8FP02ASlk1Bnfg35LZJ43RCdfTNE71ykFlBY1M
         zVZLP30EdDfL9Qc/k3dKk/9iI4YgYcNU6lWch4/h/fjaWAJz2dU0WkRBmrUCapOPI/jC
         ut/+QePmmCTU6GJwjGMpCrXQ3kNusE7+xGo7nHdHIYSLHBhQQ4nILVjcqPB5f7ilxusT
         yL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791061717; x=1791666517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oz95vRs5vqLfyYxEe+xBnRvqmwtB91PGg+pYDCLuw98=;
        b=MoYgroJ+fgKv6bhxwsENTcUH0og4NVlpilrRdyD7qOQlWmtvJsk36ZwIbQIliCD0Po
         Iftr2+v38TJJZH4zkgjXKQNVPlDOJ9xKu+7Txd0DGKnyJbjF/C0Ji4q7cdqBFf/2jEvH
         aV0PsysrwOt+TWMhLyl1IYnI/jy1Gu4oqvs27GiipyTisqZfawrNJTon/jkHnKW+HBUb
         1R3yAuYi8kEJyjxuKaMFE4vIPs6oLs0wSJITyz7CNfpS8JnEmj8D8W3TbbaK4GN6Rx7x
         u9v6A5rsvZSpbhPM++vfNB8KiMyYzPluQVBUITdKg8pg2jss+EKJmaTh9b7qsJG79kB6
         LEnQ==
X-Gm-Message-State: AFq9FYLAlOrgHjxcpNctKNv/u4rg1XuQvFKUHrNcnSKcWnY9ZEXxoLR+
	kxporauX5pzV040QgBu242BRufOw7oi93LXwFv56Yy3/dPkkw1zBoIQ=
X-Gm-Gg: AYBFou39WBBFCuSVEywzhc0t+TfF6IMTvHnyenTcuZU1KQMJUcWU8TnvbEnA6cyliU7
	DaEo+lq2jqBN0ajWPkPYvqfw98UJiTSF/ngQS2XljuA35FuHMfv92pV6syP236V6wmagDY+rs52
	OsMjDolJwi7cQ9rWhkvk7QMDLBFKrWrJKPVeFKvd4WQ2yq7AO+fX7F5iKiqV/0CG21pc/+DmVcO
	qIYnhq+7an9gF5W4u+RUbjbgBES5f5oLNj6MjDSEOxue4is5232JVx3AATYq2fAs/Xsvt/0sOEN
	npcWc1TpaG2BRY3P4YPXPU77OFdKUOVMGJyIGK5FbPZ29DHPSdiqvl+bcGhPY9ysTFtKWBN6OX3
	m2+DEbT3EnBPJLr0ixLB6jgTURW0SrKxDGNYzuDM9vsEt3r5H7fjhfeHsxD/BPVCEIij2deivhQ
	gFScl7+i+hkcnHsQSbpSgQO+b9vNL91UCpG/jDbcNM9eHHSFqoDdcvaORAdeLQ2Ot9QtG4zZ/P9
	m8FMvA033PGjdn4cNXWPhh8ukKKN9ZRVQ6JpI8J3VlXgaS4CQ2eQBSYrIA0cje3L+hSrhvFIOrx
	6ZMSOmpbD25gqNqjfnzKdHMoqAXsBouaRw==
X-Received: by 2002:a05:690c:e68e:b0:8a9:693a:324 with SMTP id 00721157ae682-8ae95ad6211mr7290727b3.109.1791061716860;
        Sat, 03 Oct 2026 14:08:36 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:550f:9551:5468:60f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8af0d179d3bsm743537b3.40.2026.10.03.14.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 14:08:36 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Sat, 03 Oct 2026 14:07:59 -0700
Subject: [RFC PATCH v3 6/9] mm/damon/sysfs: expose perf_event prep
 attributes
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-6-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gregory Price <gourry@gourry.net>, David Rientjes <rientjes@google.com>, 
 Wei Xu <weixugc@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
 Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
 Kunwu Chan <kunwu.chan@linux.dev>, 
 Ravi Jonnalagadda <ravis.opensrc@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0

Wire the DAMON_PREP_PERF_EVENT prep type added to core.c and
perf_source.h into sysfs, so user space can configure a PMU hotness
probe entirely through the preps/N/ directory: type, config, config1,
config2, sample_period, sample_freq, wakeup_events, precise_ip,
sample_phys_addr, sample_weight_struct, exclude_kernel, exclude_hv.

For example:

  echo perf_event > .../probes/0/preps/0/prep_action
  echo 8          > .../probes/0/preps/0/type
  echo 0x100      > .../probes/0/preps/0/sample_period
  echo 1          > .../probes/0/preps/0/sample_phys_addr

damon_sysfs_set_perf_probe() builds the damon_perf_probe_event from the
prep's stored attributes and, when arming, calls
damon_perf_probe_setup() to open the PMU counter(s) immediately;
deferred (non-arming) builds carry the attributes for a later commit to
arm, per the commit_live distinction in the previous commit.

damon_sysfs_set_preps() validates a DAMON_PREP_PERF_EVENT prep before it
can reach the PMU: sample_period and sample_freq are mutually exclusive
sampling modes, so setting both or setting neither is rejected;
precise_ip is a 2-bit bitfield in perf_event_attr, so a value above 3 is
rejected; and a second DAMON_PREP_PERF_EVENT prep on the same probe is
rejected outright rather than silently ignored, since a probe can only
ever be backed by one PMU counter.

Co-developed-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/sysfs.c | 283 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 269 insertions(+), 14 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 80e6fc8004e5..36bccf948025 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 
 #include "sysfs-common.h"
+#include "perf_source.h"
 
 /*
  * init region directory
@@ -756,6 +757,21 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 struct damon_sysfs_prep {
 	struct kobject kobj;
 	enum damon_prep_action action;
+	/* perf_event_attr subset; valid when action == DAMON_PREP_PERF_EVENT */
+	u32 perf_type;
+	u64 config;
+	u64 config1;
+	u64 config2;
+	u64 sample_period;
+	u64 sample_freq;
+	u32 wakeup_events;
+	u32 precise_ip;
+	bool sample_phys_addr;
+	bool sample_weight_struct;
+	bool exclude_kernel;
+	bool exclude_hv;
+	bool freq;
+	bool single_instance;
 };
 
 static struct damon_sysfs_prep *damon_sysfs_prep_alloc(void)
@@ -780,6 +796,10 @@ damon_sysfs_prep_action_names[] = {
 		.action = DAMON_PREP_SET_PGIDLE,
 		.name = "set_pgidle",
 	},
+	{
+		.action = DAMON_PREP_PERF_EVENT,
+		.name = "perf_event",
+	},
 };
 
 static ssize_t prep_action_show(struct kobject *kobj,
@@ -834,8 +854,122 @@ static void damon_sysfs_prep_release(struct kobject *kobj)
 static struct kobj_attribute damon_sysfs_prep_prep_action_attr =
 		__ATTR_RW_MODE(prep_action, 0600);
 
+/*
+ * perf_event configuration attributes.  These mirror a subset of
+ * perf_event_attr and are only meaningful when prep_action is "perf_event".
+ * They select the PMU (via type/config) and its sampling parameters, and are
+ * copied into the perf-event probe when the kdamond is turned on.
+ *
+ * The sysfs file names stay bare (type, config, ...) while the backing C
+ * symbols are prefixed to avoid clashing with identically named attributes
+ * elsewhere in this file.
+ */
+#define DAMON_SYSFS_PREP_PERF_U32(name, field)				\
+static ssize_t damon_sysfs_prep_##name##_show(struct kobject *kobj,	\
+		struct kobj_attribute *attr, char *buf)			\
+{									\
+	struct damon_sysfs_prep *prep = container_of(kobj,		\
+			struct damon_sysfs_prep, kobj);			\
+	return sysfs_emit(buf, "%u\n", prep->field);			\
+}									\
+static ssize_t damon_sysfs_prep_##name##_store(struct kobject *kobj,	\
+		struct kobj_attribute *attr, const char *buf,		\
+		size_t count)						\
+{									\
+	struct damon_sysfs_prep *prep = container_of(kobj,		\
+			struct damon_sysfs_prep, kobj);			\
+	u32 v;								\
+	int err = kstrtou32(buf, 0, &v);				\
+	if (err)							\
+		return err;						\
+	prep->field = v;						\
+	return count;							\
+}									\
+static struct kobj_attribute damon_sysfs_prep_##name##_attr = __ATTR(name, \
+		0600, damon_sysfs_prep_##name##_show,			\
+		damon_sysfs_prep_##name##_store)
+
+#define DAMON_SYSFS_PREP_PERF_U64(name, field)				\
+static ssize_t damon_sysfs_prep_##name##_show(struct kobject *kobj,	\
+		struct kobj_attribute *attr, char *buf)			\
+{									\
+	struct damon_sysfs_prep *prep = container_of(kobj,		\
+			struct damon_sysfs_prep, kobj);			\
+	return sysfs_emit(buf, "%llu\n", prep->field);			\
+}									\
+static ssize_t damon_sysfs_prep_##name##_store(struct kobject *kobj,	\
+		struct kobj_attribute *attr, const char *buf,		\
+		size_t count)						\
+{									\
+	struct damon_sysfs_prep *prep = container_of(kobj,		\
+			struct damon_sysfs_prep, kobj);			\
+	u64 v;								\
+	int err = kstrtou64(buf, 0, &v);				\
+	if (err)							\
+		return err;						\
+	prep->field = v;						\
+	return count;							\
+}									\
+static struct kobj_attribute damon_sysfs_prep_##name##_attr = __ATTR(name, \
+		0600, damon_sysfs_prep_##name##_show,			\
+		damon_sysfs_prep_##name##_store)
+
+#define DAMON_SYSFS_PREP_PERF_BOOL(name, field)				\
+static ssize_t damon_sysfs_prep_##name##_show(struct kobject *kobj,	\
+		struct kobj_attribute *attr, char *buf)			\
+{									\
+	struct damon_sysfs_prep *prep = container_of(kobj,		\
+			struct damon_sysfs_prep, kobj);			\
+	return sysfs_emit(buf, "%u\n", prep->field);			\
+}									\
+static ssize_t damon_sysfs_prep_##name##_store(struct kobject *kobj,	\
+		struct kobj_attribute *attr, const char *buf,		\
+		size_t count)						\
+{									\
+	struct damon_sysfs_prep *prep = container_of(kobj,		\
+			struct damon_sysfs_prep, kobj);			\
+	bool v;								\
+	int err = kstrtobool(buf, &v);					\
+	if (err)							\
+		return err;						\
+	prep->field = v;						\
+	return count;							\
+}									\
+static struct kobj_attribute damon_sysfs_prep_##name##_attr = __ATTR(name, \
+		0600, damon_sysfs_prep_##name##_show,			\
+		damon_sysfs_prep_##name##_store)
+
+DAMON_SYSFS_PREP_PERF_U32(type, perf_type);
+DAMON_SYSFS_PREP_PERF_U64(config, config);
+DAMON_SYSFS_PREP_PERF_U64(config1, config1);
+DAMON_SYSFS_PREP_PERF_U64(config2, config2);
+DAMON_SYSFS_PREP_PERF_U64(sample_period, sample_period);
+DAMON_SYSFS_PREP_PERF_U64(sample_freq, sample_freq);
+DAMON_SYSFS_PREP_PERF_U32(wakeup_events, wakeup_events);
+DAMON_SYSFS_PREP_PERF_U32(precise_ip, precise_ip);
+DAMON_SYSFS_PREP_PERF_BOOL(sample_phys_addr, sample_phys_addr);
+DAMON_SYSFS_PREP_PERF_BOOL(sample_weight_struct, sample_weight_struct);
+DAMON_SYSFS_PREP_PERF_BOOL(exclude_kernel, exclude_kernel);
+DAMON_SYSFS_PREP_PERF_BOOL(exclude_hv, exclude_hv);
+DAMON_SYSFS_PREP_PERF_BOOL(freq, freq);
+DAMON_SYSFS_PREP_PERF_BOOL(single_instance, single_instance);
+
 static struct attribute *damon_sysfs_prep_attrs[] = {
 	&damon_sysfs_prep_prep_action_attr.attr,
+	&damon_sysfs_prep_type_attr.attr,
+	&damon_sysfs_prep_config_attr.attr,
+	&damon_sysfs_prep_config1_attr.attr,
+	&damon_sysfs_prep_config2_attr.attr,
+	&damon_sysfs_prep_sample_period_attr.attr,
+	&damon_sysfs_prep_sample_freq_attr.attr,
+	&damon_sysfs_prep_wakeup_events_attr.attr,
+	&damon_sysfs_prep_precise_ip_attr.attr,
+	&damon_sysfs_prep_sample_phys_addr_attr.attr,
+	&damon_sysfs_prep_sample_weight_struct_attr.attr,
+	&damon_sysfs_prep_exclude_kernel_attr.attr,
+	&damon_sysfs_prep_exclude_hv_attr.attr,
+	&damon_sysfs_prep_freq_attr.attr,
+	&damon_sysfs_prep_single_instance_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_prep);
@@ -2261,14 +2395,62 @@ static int damon_sysfs_set_preps(struct damon_probe *probe,
 		struct damon_sysfs_preps *sys_preps)
 {
 	int i;
+	bool seen_perf_prep = false;
 
 	for (i = 0; i < sys_preps->nr; i++) {
 		struct damon_sysfs_prep *sys_prep = sys_preps->preps_arr[i];
 		struct damon_prep *prep;
 
+		/*
+		 * period and freq are mutually exclusive perf sampling modes;
+		 * reject a config that sets both before it can arm a counter.
+		 */
+		if (sys_prep->action == DAMON_PREP_PERF_EVENT &&
+		    sys_prep->sample_period && sys_prep->sample_freq)
+			return -EINVAL;
+		/*
+		 * ...and setting neither leaves the counter with no sampling
+		 * mode at all; reject that too rather than arming garbage.
+		 */
+		if (sys_prep->action == DAMON_PREP_PERF_EVENT &&
+		    !sys_prep->sample_period && !sys_prep->sample_freq)
+			return -EINVAL;
+		/* precise_ip is a 2-bit bitfield in perf_event_attr */
+		if (sys_prep->action == DAMON_PREP_PERF_EVENT &&
+		    sys_prep->precise_ip > 3)
+			return -EINVAL;
+		/* At most one perf-event prep per probe. */
+		if (sys_prep->action == DAMON_PREP_PERF_EVENT && seen_perf_prep)
+			return -EINVAL;
+		if (sys_prep->action == DAMON_PREP_PERF_EVENT)
+			seen_perf_prep = true;
+
 		prep = damon_new_prep(sys_prep->action);
 		if (!prep)
 			return -ENOMEM;
+		if (sys_prep->action == DAMON_PREP_PERF_EVENT) {
+			/*
+			 * damon_new_prep() does not zero prep->perf; clear it
+			 * so any field not assigned below starts from a known
+			 * zero rather than kmalloc garbage.
+			 */
+			memset(&prep->perf, 0, sizeof(prep->perf));
+			prep->perf.type = sys_prep->perf_type;
+			prep->perf.config = sys_prep->config;
+			prep->perf.config1 = sys_prep->config1;
+			prep->perf.config2 = sys_prep->config2;
+			prep->perf.sample_period = sys_prep->sample_period;
+			prep->perf.sample_freq = sys_prep->sample_freq;
+			prep->perf.wakeup_events = sys_prep->wakeup_events;
+			prep->perf.precise_ip = sys_prep->precise_ip;
+			prep->perf.sample_phys_addr = sys_prep->sample_phys_addr;
+			prep->perf.sample_weight_struct =
+				sys_prep->sample_weight_struct;
+			prep->perf.exclude_kernel = sys_prep->exclude_kernel;
+			prep->perf.exclude_hv = sys_prep->exclude_hv;
+			prep->perf.freq = sys_prep->freq;
+			prep->perf.single_instance = sys_prep->single_instance;
+		}
 		damon_add_prep(probe, prep);
 	}
 	return 0;
@@ -2308,8 +2490,71 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
 	return 0;
 }
 
-static int damon_sysfs_set_probe(struct damon_probe *probe,
-		struct damon_sysfs_probe *sys_probe)
+#ifdef CONFIG_DAMON_PERF_SOURCE
+/*
+ * Build a perf-event probe descriptor from the probe's DAMON_PREP_PERF_EVENT
+ * prep and attach it to @probe.  The descriptor is always carried (so the ring
+ * drain and the commit hand-off recognise the probe as event-driven), but the
+ * PMU counters are only armed when @arm is set.
+ *
+ * @arm is true when building the context that will actually run (turn-on
+ * path); it is false when building a param_ctx for a commit, which is
+ * discarded after validation.  Arming a param_ctx would collide with the
+ * running context's perf-probe ownership and return -EBUSY, so the commit path
+ * defers arming to damon_commit_perf_probe().
+ */
+static int damon_sysfs_set_perf_probe(struct damon_ctx *ctx,
+		struct damon_probe *probe, bool arm)
+{
+	struct damon_prep *prep;
+
+	damon_for_each_prep(prep, probe) {
+		struct damon_perf_probe_event *event;
+		int err;
+
+		if (prep->action != DAMON_PREP_PERF_EVENT)
+			continue;
+
+		event = kzalloc_obj(*event, GFP_KERNEL);
+		if (!event)
+			return -ENOMEM;
+		event->attr.type = prep->perf.type;
+		event->attr.config = prep->perf.config;
+		event->attr.config1 = prep->perf.config1;
+		event->attr.config2 = prep->perf.config2;
+		event->attr.sample_period = prep->perf.sample_period;
+		event->attr.sample_freq = prep->perf.sample_freq;
+		event->attr.wakeup_events = prep->perf.wakeup_events;
+		event->attr.precise_ip = prep->perf.precise_ip;
+		event->attr.sample_phys_addr = prep->perf.sample_phys_addr;
+		event->attr.sample_weight_struct =
+			prep->perf.sample_weight_struct;
+		event->attr.exclude_kernel = prep->perf.exclude_kernel;
+		event->attr.exclude_hv = prep->perf.exclude_hv;
+		event->attr.freq = prep->perf.freq;
+		event->attr.single_instance = prep->perf.single_instance;
+
+		probe->perf_priv = event;
+		probe->event_driven = true;
+		if (arm) {
+			err = damon_perf_probe_setup(ctx, probe, event);
+			if (err) {
+				probe->perf_priv = NULL;
+				probe->event_driven = false;
+				kfree(event);
+				return err;
+			}
+		}
+		/* At most one perf-event prep per probe. */
+		break;
+	}
+	return 0;
+}
+#endif /* CONFIG_DAMON_PERF_SOURCE */
+
+static int damon_sysfs_set_probe(struct damon_ctx *ctx,
+		struct damon_probe *probe,
+		struct damon_sysfs_probe *sys_probe, bool arm)
 {
 	struct damon_sysfs_filters *sys_filters;
 	struct damon_sysfs_preps *sys_preps;
@@ -2322,13 +2567,21 @@ static int damon_sysfs_set_probe(struct damon_probe *probe,
 			return err;
 	}
 	sys_filters = sys_probe->filters;
-	if (!sys_filters)
-		return 0;
-	return damon_sysfs_set_filters(probe, sys_filters);
+	if (sys_filters) {
+		err = damon_sysfs_set_filters(probe, sys_filters);
+		if (err)
+			return err;
+	}
+#ifdef CONFIG_DAMON_PERF_SOURCE
+	err = damon_sysfs_set_perf_probe(ctx, probe, arm);
+	if (err)
+		return err;
+#endif
+	return 0;
 }
 
 static int damon_sysfs_set_probes(struct damon_ctx *ctx,
-		struct damon_sysfs_probes *sys_probes)
+		struct damon_sysfs_probes *sys_probes, bool arm)
 {
 	int i, err;
 
@@ -2342,9 +2595,10 @@ static int damon_sysfs_set_probes(struct damon_ctx *ctx,
 		damon_add_probe(ctx, p);
 		sys_probe = sys_probes->probes_arr[i];
 		p->weight = sys_probe->weight;
-		err = damon_sysfs_set_probe(p, sys_probe);
+		err = damon_sysfs_set_probe(ctx, p, sys_probe, arm);
 		if (err)
 			return err;
+
 	}
 	return 0;
 }
@@ -2443,7 +2697,7 @@ static inline bool damon_sysfs_kdamond_running(
 }
 
 static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
-		struct damon_sysfs_context *sys_ctx)
+		struct damon_sysfs_context *sys_ctx, bool arm)
 {
 	enum damon_ops_id ops_id;
 	int err;
@@ -2461,7 +2715,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
-	err = damon_sysfs_set_probes(ctx, sys_ctx->attrs->probes);
+	err = damon_sysfs_set_probes(ctx, sys_ctx->attrs->probes, arm);
 	if (err)
 		return err;
 	err = damon_sysfs_set_sample_control(&ctx->sample_control,
@@ -2475,7 +2729,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 }
 
 static struct damon_ctx *damon_sysfs_build_ctx(
-		struct damon_sysfs_context *sys_ctx);
+		struct damon_sysfs_context *sys_ctx, bool arm);
 
 /*
  * damon_sysfs_commit_input() - Commit user inputs to a running kdamond.
@@ -2495,7 +2749,8 @@ static int damon_sysfs_commit_input(void *data)
 	if (kdamond->contexts->nr != 1)
 		return -EINVAL;
 
-	param_ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
+	param_ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0],
+			false);
 	if (IS_ERR(param_ctx))
 		return PTR_ERR(param_ctx);
 	err = damon_commit_ctx(kdamond->damon_ctx, param_ctx);
@@ -2553,7 +2808,7 @@ static int damon_sysfs_upd_tuned_intervals(void *data)
 }
 
 static struct damon_ctx *damon_sysfs_build_ctx(
-		struct damon_sysfs_context *sys_ctx)
+		struct damon_sysfs_context *sys_ctx, bool arm)
 {
 	struct damon_ctx *ctx = damon_new_ctx();
 	int err;
@@ -2561,7 +2816,7 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	err = damon_sysfs_apply_inputs(ctx, sys_ctx);
+	err = damon_sysfs_apply_inputs(ctx, sys_ctx, arm);
 	if (err) {
 		damon_destroy_ctx(ctx);
 		return ERR_PTR(err);
@@ -2613,7 +2868,7 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	if (!repeat_call_control)
 		return -ENOMEM;
 
-	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
+	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0], true);
 	if (IS_ERR(ctx)) {
 		kfree(repeat_call_control);
 		return PTR_ERR(ctx);

-- 
Git-157)


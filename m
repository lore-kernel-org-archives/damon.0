Received: from mail-yx2-f5.google.com (mail-yx2-f5.google.com [74.125.224.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B553C2BB4
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190030; cv=none; b=n58fd4E8g1XFlShKUCGn0UBc6fxJ/rpJopeSJhJkj2e2M0NEPLP9sFzYzkiRVICyfoXaWqBSZAGSGjX75e7FmvwUlU7DSnTwtLA+6K7qPViV9xpUc5b7TmIug+4nqK/eSY2+bLyog2mw1aSf+6OJFqYS3yKbWn1X0Qx111Feb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190030; c=relaxed/simple;
	bh=0wK+iFqR7n7KN3Eohxo5QzOMoXgdZkDM90CVvHQwqKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n93WAYcq7xcEuwNyPmpSCXxPcZRRMf6RyYU2Neu35pzT0Zd+9fwsT2+oFV02zaJWvhNQDtirNytOup/tfOqr94QHTAuhOy/P6hw1iRptoypwkdotqge+jjdF+wFMutpkusCc5lW0SwIFgdTJNJziImDIah1Eg/78UjN9inNC8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iyk21b2I; arc=none smtp.client-ip=74.125.224.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iyk21b2I"
Received: by mail-yx2-f5.google.com with SMTP id 956f58d0204a3-677bd24a602so634129d50.1
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791190027; x=1791794827; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrGqhEg5+akRtI8lWrL7MA1TBYd/NNwJbocEpeXp/gM=;
        b=Iyk21b2Ioyf42uk2ul4ZSk57t78BHCaEfEq8p+KwI+ci5PxWp9bwNxbWOoWgvjzOyn
         lZY7ldo4BQVZvNAMapdKqIoH3rzDMLsVm4F9dHTXEClB/2CrY23Qw+gDy+jcJ8vWFpgk
         s5Oy9XjnaYthuheG5zZQUOwCcqQhOftuYyRnT80mERWjjs9Mz2a7npG2Mi5IT/JZqy03
         V5LmlltIM2lAR/iDqsdpm5Fl/82IFktJvamdXnf7SYM/x3p3f4A8ORGeo8peUFDQ2J7f
         +ToZuX57KMLAIqygpWx1BnsnoNP0dczlQDPFAnlEBMOQ8QcWQzCkfjtskv3uBEYj/ev0
         +X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791190027; x=1791794827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PrGqhEg5+akRtI8lWrL7MA1TBYd/NNwJbocEpeXp/gM=;
        b=Ndbtac1KW/G9Vs8kfaHvEloShbSWG7Lyb/N2W+ovCXX06cYw5UI7rQKaOSOrANbKbc
         4hSbjQALxlr4ky7G4Zp9etOzXWxio6If8Tj4KM4wPymn5JCJkXOUnFnmuNlOUhDQc55x
         OyhkNHfTAa8/Zbv9PyEK2mOBf5hCGL9coH0OrGtvBSXilwTn180qwn458ZstNOgY3rMG
         an3pRH3iu+RgPVvuIVwHoIPISPvfVa6ibbbhK+ZxefzXkywlCUter8GZojXUK7AScpGH
         GOHS54eJK5SY8OSr9iPiC5ZOoU15/tQFOejxLgzEu1N0zFmNvrSfPsec/KDNF8fovQB+
         +MZQ==
X-Gm-Message-State: AFq9FYJY3lQl4HYO3ydAlucg4fu1x4OfkjuW0mQIPqqvz9Vl4qXYe8Su
	ALJSxCLNYDdgQpOXMWbPVptceRboFiVMVFzHH6ncd6Y7COuu+JQYNoI=
X-Gm-Gg: AYBFou3R+ZvNI2jYVTQgu6eeWd26u5UwPFnKrGWjopKAJLQsvtOzSbS1rG24HMcIxra
	RKeFexEy6Ys1euQh7QLe0w8W2a1C3d+JuVYYPnwguPto36NGTaAsfgOkwNpeD2Hu379xpL8hynE
	UetsH1nv4L+ucnTXXhKz5Sw85ZxbpQ6u5iF7lWzdGefC1ZAJbJnSS7tpTbe988B9mMoNV9I3Kv2
	CGrs8JkjOsfp8RMPDk6rA8hYA7mvXTh2mxjfHgRkNAC7HfhYtzoUUDwC9f/sDHeD7ssUxZgFG0d
	jEiI7XsiWM2Y6iwrMqN+x/brF1hhDAUQ0H+cE9xxu7RjbzPRo4FazDPf6r8lhoO4YMyw4maviyy
	Nzyd+bN28Ix0dfW0S8D3xkDXyALMaHLsowQ/CeOdPt26vD4V2NyziGEvI5GRNYuKqG+a7UC7zp1
	23HSqz1kEsQ+B+egWWUodSH3d4tRW3mty5uOMXwJ/iOkw8vXal+f7Q+vhV7OpcQf6IIps4HDS0H
	rzegoN8NYGr03ZKfEVZxO7abOhIuUPu+XMfGDzsRhJd5ovfBVpnsBA36FE5pjpA+LNaQmUKdBKX
	/0NRK+5Rlsu3qNOjb/5XAqkSrj5ad29eaA==
X-Received: by 2002:a05:690e:bc3:b0:677:d719:7bb5 with SMTP id 956f58d0204a3-677d7197ff2mr989931d50.61.1791190027260;
        Mon, 05 Oct 2026 01:47:07 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:1149:2fcd:c86b:8747])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b9c895sm2346306d50.13.2026.10.05.01.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:47:06 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Mon, 05 Oct 2026 01:46:50 -0700
Subject: [RFC PATCH v4 6/9] mm/damon/sysfs: expose perf_event prep
 attributes
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-6-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
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
perf_source.h into sysfs, so user space can configure a PMU-backed
probe entirely through the preps/N/ directory: type, config, config1,
config2, freq, sample_period, sample_freq, wakeup_events, precise_ip,
sample_phys_addr, sample_weight_struct, exclude_kernel, exclude_hv and
single_instance.

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
can reach the PMU.  freq selects which one of sample_freq and
sample_period carries the sampling rate, so the selected one must be set
and the other zero, since the counter would otherwise be armed with a
zero period and take no samples.  precise_ip is a 2-bit bitfield in
perf_event_attr, so a value above 3 is rejected.  A second
DAMON_PREP_PERF_EVENT prep on the same probe is rejected, since a probe
is backed by one PMU counter.

A probe with a perf_event prep cannot have probe filters, since the
drain does not apply them to its samples.  With CONFIG_DAMON_PERF_SOURCE
disabled, a perf_event prep is rejected with -EOPNOTSUPP.  The prep
attribute stores take damon_sysfs_lock with mutex_trylock(), as the
other DAMON sysfs stores do, and return -EBUSY while it is held, so a
commit reads a consistent set of values.

Co-developed-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/sysfs.c | 304 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 290 insertions(+), 14 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 80e6fc8004e5..3fc40dd540a0 100644
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
@@ -834,8 +854,132 @@ static void damon_sysfs_prep_release(struct kobject *kobj)
 static struct kobj_attribute damon_sysfs_prep_prep_action_attr =
 		__ATTR_RW_MODE(prep_action, 0600);
 
+/*
+ * perf_event configuration attributes.  These mirror a subset of
+ * perf_event_attr and are only meaningful when prep_action is "perf_event".
+ * They select the PMU (via type/config) and its sampling parameters, and are
+ * copied into the perf-event probe when DAMON is turned on or the inputs are
+ * committed.
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
+	if (!mutex_trylock(&damon_sysfs_lock))				\
+		return -EBUSY;						\
+	prep->field = v;						\
+	mutex_unlock(&damon_sysfs_lock);				\
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
+	if (!mutex_trylock(&damon_sysfs_lock))				\
+		return -EBUSY;						\
+	prep->field = v;						\
+	mutex_unlock(&damon_sysfs_lock);				\
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
+	if (!mutex_trylock(&damon_sysfs_lock))				\
+		return -EBUSY;						\
+	prep->field = v;						\
+	mutex_unlock(&damon_sysfs_lock);				\
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
@@ -2261,14 +2405,60 @@ static int damon_sysfs_set_preps(struct damon_probe *probe,
 		struct damon_sysfs_preps *sys_preps)
 {
 	int i;
+	bool seen_perf_prep = false;
 
 	for (i = 0; i < sys_preps->nr; i++) {
 		struct damon_sysfs_prep *sys_prep = sys_preps->preps_arr[i];
 		struct damon_prep *prep;
 
+#ifndef CONFIG_DAMON_PERF_SOURCE
+		if (sys_prep->action == DAMON_PREP_PERF_EVENT)
+			return -EOPNOTSUPP;
+#endif
+
+		/* freq selects which of sample_freq and sample_period is set */
+		if (sys_prep->action == DAMON_PREP_PERF_EVENT &&
+		    (sys_prep->freq ?
+		     !sys_prep->sample_freq || sys_prep->sample_period :
+		     !sys_prep->sample_period || sys_prep->sample_freq))
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
+			prep->perf.sample_phys_addr =
+				sys_prep->sample_phys_addr;
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
@@ -2308,8 +2498,81 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
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
+static bool damon_sysfs_probe_has_perf_prep(struct damon_probe *probe)
+{
+	struct damon_prep *prep;
+
+	damon_for_each_prep(prep, probe) {
+		if (prep->action == DAMON_PREP_PERF_EVENT)
+			return true;
+	}
+	return false;
+}
+
+static int damon_sysfs_set_probe(struct damon_ctx *ctx,
+		struct damon_probe *probe,
+		struct damon_sysfs_probe *sys_probe, bool arm)
 {
 	struct damon_sysfs_filters *sys_filters;
 	struct damon_sysfs_preps *sys_preps;
@@ -2322,13 +2585,25 @@ static int damon_sysfs_set_probe(struct damon_probe *probe,
 			return err;
 	}
 	sys_filters = sys_probe->filters;
-	if (!sys_filters)
-		return 0;
-	return damon_sysfs_set_filters(probe, sys_filters);
+	/* the drain does not apply probe filters to perf_event samples */
+	if (sys_filters && sys_filters->nr &&
+	    damon_sysfs_probe_has_perf_prep(probe))
+		return -EINVAL;
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
 
@@ -2342,7 +2617,7 @@ static int damon_sysfs_set_probes(struct damon_ctx *ctx,
 		damon_add_probe(ctx, p);
 		sys_probe = sys_probes->probes_arr[i];
 		p->weight = sys_probe->weight;
-		err = damon_sysfs_set_probe(p, sys_probe);
+		err = damon_sysfs_set_probe(ctx, p, sys_probe, arm);
 		if (err)
 			return err;
 	}
@@ -2443,7 +2718,7 @@ static inline bool damon_sysfs_kdamond_running(
 }
 
 static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
-		struct damon_sysfs_context *sys_ctx)
+		struct damon_sysfs_context *sys_ctx, bool arm)
 {
 	enum damon_ops_id ops_id;
 	int err;
@@ -2461,7 +2736,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
-	err = damon_sysfs_set_probes(ctx, sys_ctx->attrs->probes);
+	err = damon_sysfs_set_probes(ctx, sys_ctx->attrs->probes, arm);
 	if (err)
 		return err;
 	err = damon_sysfs_set_sample_control(&ctx->sample_control,
@@ -2475,7 +2750,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 }
 
 static struct damon_ctx *damon_sysfs_build_ctx(
-		struct damon_sysfs_context *sys_ctx);
+		struct damon_sysfs_context *sys_ctx, bool arm);
 
 /*
  * damon_sysfs_commit_input() - Commit user inputs to a running kdamond.
@@ -2495,7 +2770,8 @@ static int damon_sysfs_commit_input(void *data)
 	if (kdamond->contexts->nr != 1)
 		return -EINVAL;
 
-	param_ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
+	param_ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0],
+			false);
 	if (IS_ERR(param_ctx))
 		return PTR_ERR(param_ctx);
 	err = damon_commit_ctx(kdamond->damon_ctx, param_ctx);
@@ -2553,7 +2829,7 @@ static int damon_sysfs_upd_tuned_intervals(void *data)
 }
 
 static struct damon_ctx *damon_sysfs_build_ctx(
-		struct damon_sysfs_context *sys_ctx)
+		struct damon_sysfs_context *sys_ctx, bool arm)
 {
 	struct damon_ctx *ctx = damon_new_ctx();
 	int err;
@@ -2561,7 +2837,7 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	err = damon_sysfs_apply_inputs(ctx, sys_ctx);
+	err = damon_sysfs_apply_inputs(ctx, sys_ctx, arm);
 	if (err) {
 		damon_destroy_ctx(ctx);
 		return ERR_PTR(err);
@@ -2613,7 +2889,7 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	if (!repeat_call_control)
 		return -ENOMEM;
 
-	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
+	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0], true);
 	if (IS_ERR(ctx)) {
 		kfree(repeat_call_control);
 		return PTR_ERR(ctx);

-- 
Git-157)


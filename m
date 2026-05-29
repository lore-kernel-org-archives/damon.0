Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA2B3F99E5
	for <damon@lists.linux.dev>; Fri, 29 May 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073826; cv=none; b=Qpg0Zbvp16P1AT3leJH+WQyyZxVob4n/ARBIbIviHqCb/ot13Xm8NhBQxfHG+ixwHV2iPZby6g7HhLJmRpwCUyEgM0RUhTUIPxhyvwyalPoEUJ6dSv4AnJyA0pgJ7fuPT7Uh7kN2gtYfejTUcRnA7IoDRknLb5yJf/J/sp+L/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073826; c=relaxed/simple;
	bh=F/QiQ0zSPrm/6oDcRCoTElEWdSJvT5j07i2HruZ+ebE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/ToZBz15jbRZejGsnXc8IVSbJmGRYFRWfvhvgabMBvhD9KyKkVuvTquSC1Tf70bQFhphirSpHropCUI4m0TPgRL5HniQ1pqWM0P3xe6+qI9F/UQH347E5F4Z4aJo+yH7n/GoPaRLCt/cpRJ1Jqq11U5t4PfysyvqOE8pqszwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBmdB6wO; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBmdB6wO"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7e615efd7d7so5853692a34.2
        for <damon@lists.linux.dev>; Fri, 29 May 2026 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073823; x=1780678623; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rls65X3DOzAoQMMdNR2JhXNJkdCouUDjyK2mqUrqz1s=;
        b=KBmdB6wOdMTxdLWQqeJAcPOryLM5x7mM0rc+jNrZI8L2eN/kca6jes4Xoh1lRQqlPO
         gnFBKw9GEMz0y0cPnQnsbyGlZ0eCRM+jnb/9Bt2yjTAPyDCiSe1T2EWxiUc5smxmFyf6
         C3cUbWnvd9VAydtSU+an/TuROBdqdMjYP2SSEh5PDOV5eCEPf1x+AsXYc1TmGRV3RZNy
         t7q6VPV3WfyFjz5uJRfdv0q2uj1CXoTz1yY88Q4IhborF8y6DXIbJPFWn76W0f9GmkON
         tel0ruxXiboYbaW8XpIzJRslVNYYNQShoTL4eV64xOg4tW6B33MPHLrhF87baiP1tnT1
         JlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073823; x=1780678623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rls65X3DOzAoQMMdNR2JhXNJkdCouUDjyK2mqUrqz1s=;
        b=WCg79FdVQQX6/En2lsoKsUYqn9gIV0oAkNBN+6/A9l/nzILiySyMwdM4xaJR2Dj3bU
         u+PjbhQ8oCPeL8/VtU6Zf2farHkLPpNSDfMaaLMgXUPCSbP9wOaNorPixVkWhRc/kygo
         vQXWytuynmMPNoLdleMi6sQAhElO3e+OVdT3g/KJX9r67NN8olE78gZZ+fWB93h72q+v
         MkFTIrm2Z/B0fg46DQSq+CeWBC0btt1OdI+o9PdVzDHyoYp6+ZO0B+n/4ovRXU8bgoGD
         9izLWxzRpR5xs/QUi64kT1dlzS8pY1c3UjAxs6LU/DK2wAT9A9/X4C8OD278nlCOcS/h
         FU3g==
X-Forwarded-Encrypted: i=1; AFNElJ9l9KQMCqzXNU6xX5aQicZru26Rjbg61gZNJ8eIk0FovHLXm6rsxxU+tyTcibON2gPCyyT7QA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOvvH4wOD0Qo9M2mDM8B395vwN/xZYgdCvkOZh/+VWN3025JMm
	UqHf93QcffILoJ3PA1MRraiUkJxTzF40S76cJqXDTwBJEyeb/Z8jqW8=
X-Gm-Gg: Acq92OHO874nvhmdufBwWvVrwcnaxp0iG5ii7DhxBUqpQ0uutTrakWxV+apLVOsqHAt
	coHkm+u+QDlv9PkjXJzRID5WRQ+qxJK6rnn+W6Bjpiz9Lgdpq5u66Yuga6VV2wM3eJMdfKemr9D
	2WZ307nr+ntMQmdLRu8qpSmmRF3IvNPTOxrchQLYR4CO3LVfjFtFYePe8S1XgsNfH4U80doqzBW
	roBYG2jWbFQe0yta28WD0hyOdaBLbRDuRwONCREaBwUJ6xEMNUKfWFUcU2S4mbxvz+9I9fLvSH9
	dHO4xtP0oTHVHlV2FwX5eNZnWeA2Dne5Eqx1yR9p6dELPYWfgT1lO3RofhcN/rNWNmYU6TjeUF1
	3Oe9eKzdjUPijPAkXtJsPYGz0xIGfX9TdvOzOKe6oh+hHi+ODh8edhhDjV6VM+c6WinSWXTtzb7
	3KtUWdFsVydtKc3UC21t9FgYyWZ36eJcJ/gVOIwzX86premC0Tki0glNJYuv2q1EhK3N2ppXver
	PvQfLGBSKxR
X-Received: by 2002:a05:6830:258d:b0:7d7:ccc7:c546 with SMTP id 46e09a7af769-7e6a1e3ad8amr396513a34.23.1780073822973;
        Fri, 29 May 2026 09:57:02 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695b8f662sm1862616a34.4.2026.05.29.09.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:57:02 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com
Subject: [RFC PATCH 2/6] mm/damon/sysfs-sample: expose perf_events configuration via sysfs
Date: Fri, 29 May 2026 09:56:36 -0700
Message-ID: <20260529165640.820-3-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529165640.820-1-ravis.opensrc@gmail.com>
References: <20260529165640.820-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a perf_events/ subdirectory under each context's sample/ directory.
Each numbered entry maps to one damon_perf_event and exposes its raw
PMU attr, addressing flags, and period/delivery knobs.

Defaults match Intel PEBS L3-miss; userspace overrides them for other
PMUs.  sample_weight_struct defaults off because PMUs that do not
advertise PERF_SAMPLE_WEIGHT_STRUCT (e.g. AMD IBS Op) reject events
that request it with -EOPNOTSUPP.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/sysfs-sample.c | 579 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 579 insertions(+)

diff --git a/mm/damon/sysfs-sample.c b/mm/damon/sysfs-sample.c
index ffc9c85455474..0570d27a47b1c 100644
--- a/mm/damon/sysfs-sample.c
+++ b/mm/damon/sysfs-sample.c
@@ -452,6 +452,520 @@ static const struct kobj_type damon_sysfs_primitives_ktype = {
 	.default_groups = damon_sysfs_primitives_groups,
 };
 
+/*
+ * perf_event_attr directory
+ */
+
+struct damon_sysfs_perf_event_attr {
+	struct kobject kobj;
+	u32 type;
+	u64 config;
+	u64 config1;
+	u64 config2;
+	bool sample_phys_addr;
+	bool sample_weight_struct;
+	bool exclude_kernel;
+	bool exclude_hv;
+	bool freq;
+	u64 sample_freq;
+	u64 sample_period;
+	u32 wakeup_events;
+	u32 precise_ip;
+};
+
+static struct damon_sysfs_perf_event_attr *
+damon_sysfs_perf_event_attr_alloc(void)
+{
+	struct damon_sysfs_perf_event_attr *attr =
+		kzalloc(sizeof(*attr), GFP_KERNEL);
+
+	if (!attr)
+		return NULL;
+	attr->wakeup_events = 1;
+	attr->precise_ip = 2;
+	attr->freq = true;
+	attr->exclude_kernel = true;
+	attr->exclude_hv = true;
+	return attr;
+}
+
+static ssize_t attr_type_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "0x%x\n", perf_event_attr->type);
+}
+
+static ssize_t attr_type_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou32(buf, 0, &perf_event_attr->type);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t config_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "0x%llx\n", perf_event_attr->config);
+}
+
+static ssize_t config_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou64(buf, 0, &perf_event_attr->config);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t config1_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "0x%llx\n", perf_event_attr->config1);
+}
+
+static ssize_t config1_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou64(buf, 0, &perf_event_attr->config1);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t config2_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "0x%llx\n", perf_event_attr->config2);
+}
+
+static ssize_t config2_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou64(buf, 0, &perf_event_attr->config2);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t sample_phys_addr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "%d\n", perf_event_attr->sample_phys_addr);
+}
+
+static ssize_t sample_phys_addr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	bool sample_phys_addr;
+	int err = kstrtobool(buf, &sample_phys_addr);
+
+	if (err)
+		return -EINVAL;
+
+	perf_event_attr->sample_phys_addr = sample_phys_addr;
+	return count;
+}
+
+static ssize_t sample_weight_struct_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "%d\n", perf_event_attr->sample_weight_struct);
+}
+
+static ssize_t sample_weight_struct_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	bool sample_weight_struct;
+	int err = kstrtobool(buf, &sample_weight_struct);
+
+	if (err)
+		return -EINVAL;
+
+	perf_event_attr->sample_weight_struct = sample_weight_struct;
+	return count;
+}
+
+static ssize_t sample_freq_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "%llu\n", perf_event_attr->sample_freq);
+}
+
+static ssize_t sample_freq_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou64(buf, 0, &perf_event_attr->sample_freq);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t wakeup_events_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "%u\n", perf_event_attr->wakeup_events);
+}
+
+static ssize_t wakeup_events_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou32(buf, 0, &perf_event_attr->wakeup_events);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t precise_ip_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "%u\n", perf_event_attr->precise_ip);
+}
+
+static ssize_t precise_ip_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou32(buf, 0, &perf_event_attr->precise_ip);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t freq_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "%d\n", perf_event_attr->freq);
+}
+
+static ssize_t freq_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	bool freq;
+	int err = kstrtobool(buf, &freq);
+
+	if (err)
+		return -EINVAL;
+	perf_event_attr->freq = freq;
+	return count;
+}
+
+static ssize_t sample_period_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "%llu\n", perf_event_attr->sample_period);
+}
+
+static ssize_t sample_period_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	int err = kstrtou64(buf, 0, &perf_event_attr->sample_period);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t exclude_kernel_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "%d\n", perf_event_attr->exclude_kernel);
+}
+
+static ssize_t exclude_kernel_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	bool v;
+	int err = kstrtobool(buf, &v);
+
+	if (err)
+		return -EINVAL;
+	perf_event_attr->exclude_kernel = v;
+	return count;
+}
+
+static ssize_t exclude_hv_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+
+	return sysfs_emit(buf, "%d\n", perf_event_attr->exclude_hv);
+}
+
+static ssize_t exclude_hv_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_event_attr *perf_event_attr = container_of(kobj,
+			struct damon_sysfs_perf_event_attr, kobj);
+	bool v;
+	int err = kstrtobool(buf, &v);
+
+	if (err)
+		return -EINVAL;
+	perf_event_attr->exclude_hv = v;
+	return count;
+}
+
+static void damon_sysfs_perf_event_attr_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_perf_event_attr, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_type_attr =
+		__ATTR(type, 0600, attr_type_show, attr_type_store);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_config_attr =
+		__ATTR_RW_MODE(config, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_config1_attr =
+		__ATTR_RW_MODE(config1, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_config2_attr =
+		__ATTR_RW_MODE(config2, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_sample_phys_addr_attr =
+		__ATTR_RW_MODE(sample_phys_addr, 0600);
+
+static struct kobj_attribute
+		damon_sysfs_perf_event_attr_sample_weight_struct_attr =
+		__ATTR_RW_MODE(sample_weight_struct, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_sample_freq_attr =
+		__ATTR_RW_MODE(sample_freq, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_wakeup_events_attr =
+		__ATTR_RW_MODE(wakeup_events, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_precise_ip_attr =
+		__ATTR_RW_MODE(precise_ip, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_freq_attr =
+		__ATTR_RW_MODE(freq, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_sample_period_attr =
+		__ATTR_RW_MODE(sample_period, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_exclude_kernel_attr =
+		__ATTR_RW_MODE(exclude_kernel, 0600);
+
+static struct kobj_attribute damon_sysfs_perf_event_attr_exclude_hv_attr =
+		__ATTR_RW_MODE(exclude_hv, 0600);
+
+static struct attribute *damon_sysfs_perf_event_attr_attrs[] = {
+	&damon_sysfs_perf_event_attr_type_attr.attr,
+	&damon_sysfs_perf_event_attr_config_attr.attr,
+	&damon_sysfs_perf_event_attr_config1_attr.attr,
+	&damon_sysfs_perf_event_attr_config2_attr.attr,
+	&damon_sysfs_perf_event_attr_sample_phys_addr_attr.attr,
+	&damon_sysfs_perf_event_attr_sample_weight_struct_attr.attr,
+	&damon_sysfs_perf_event_attr_freq_attr.attr,
+	&damon_sysfs_perf_event_attr_sample_freq_attr.attr,
+	&damon_sysfs_perf_event_attr_sample_period_attr.attr,
+	&damon_sysfs_perf_event_attr_wakeup_events_attr.attr,
+	&damon_sysfs_perf_event_attr_precise_ip_attr.attr,
+	&damon_sysfs_perf_event_attr_exclude_kernel_attr.attr,
+	&damon_sysfs_perf_event_attr_exclude_hv_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_perf_event_attr);
+
+static const struct kobj_type damon_sysfs_perf_event_attr_ktype = {
+	.release = damon_sysfs_perf_event_attr_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_perf_event_attr_groups,
+};
+
+/*
+ * perf_events directory
+ */
+
+/*
+ * Cap on the number of perf events per damon_ctx, to bound the sysfs
+ * kobject footprint and prevent unbounded allocations from a careless
+ * write to nr_perf_events.
+ */
+#define DAMON_SYSFS_PERF_EVENTS_MAX	64
+
+struct damon_sysfs_perf_events {
+	struct kobject kobj;
+	struct damon_sysfs_perf_event_attr **attrs_arr;
+	int nr;
+};
+
+static struct damon_sysfs_perf_events *damon_sysfs_perf_events_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_perf_events), GFP_KERNEL);
+}
+
+static void damon_sysfs_perf_events_rm_dirs(
+		struct damon_sysfs_perf_events *events)
+{
+	struct damon_sysfs_perf_event_attr **attrs_arr = events->attrs_arr;
+	int i;
+
+	for (i = 0; i < events->nr; i++)
+		kobject_put(&attrs_arr[i]->kobj);
+	events->nr = 0;
+	kfree(attrs_arr);
+	events->attrs_arr = NULL;
+}
+
+static int damon_sysfs_perf_events_add_dirs(
+		struct damon_sysfs_perf_events *events, int nr_events)
+{
+	struct damon_sysfs_perf_event_attr **attrs_arr, *attr;
+	int err, i;
+
+	damon_sysfs_perf_events_rm_dirs(events);
+	if (!nr_events)
+		return 0;
+
+	attrs_arr = kmalloc_array(nr_events, sizeof(*attrs_arr), GFP_KERNEL);
+	if (!attrs_arr)
+		return -ENOMEM;
+	events->attrs_arr = attrs_arr;
+
+	for (i = 0; i < nr_events; i++) {
+		attr = damon_sysfs_perf_event_attr_alloc();
+		if (!attr) {
+			damon_sysfs_perf_events_rm_dirs(events);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&attr->kobj,
+				&damon_sysfs_perf_event_attr_ktype, &events->kobj,
+				"%d", i);
+		if (err) {
+			kobject_put(&attr->kobj);
+			damon_sysfs_perf_events_rm_dirs(events);
+			return err;
+		}
+		attrs_arr[i] = attr;
+		events->nr++;
+	}
+	return 0;
+}
+
+static ssize_t nr_perf_events_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_perf_events *events = container_of(kobj,
+			struct damon_sysfs_perf_events, kobj);
+
+	return sysfs_emit(buf, "%d\n", events->nr);
+}
+
+static ssize_t nr_perf_events_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_perf_events *events;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0 || nr > DAMON_SYSFS_PERF_EVENTS_MAX)
+		return -EINVAL;
+
+	events = container_of(kobj, struct damon_sysfs_perf_events, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_perf_events_add_dirs(events, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damon_sysfs_perf_events_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_perf_events, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_perf_events_nr_attr =
+		__ATTR_RW_MODE(nr_perf_events, 0600);
+
+static struct attribute *damon_sysfs_perf_events_attrs[] = {
+	&damon_sysfs_perf_events_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_perf_events);
+
+static const struct kobj_type damon_sysfs_perf_events_ktype = {
+	.release = damon_sysfs_perf_events_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_perf_events_groups,
+};
+
 /*
  * sample directory
  */
@@ -471,6 +985,7 @@ int damon_sysfs_sample_add_dirs(struct damon_sysfs_sample *sample)
 {
 	struct damon_sysfs_primitives *primitives;
 	struct damon_sysfs_sample_filters *filters;
+	struct damon_sysfs_perf_events *perf_events;
 	int err;
 
 	primitives = damon_sysfs_primitives_alloc(true, false);
@@ -494,7 +1009,23 @@ int damon_sysfs_sample_add_dirs(struct damon_sysfs_sample *sample)
 	if (err)
 		goto put_filters_out;
 	sample->filters = filters;
+
+	perf_events = damon_sysfs_perf_events_alloc();
+	if (!perf_events) {
+		err = -ENOMEM;
+		goto put_filters_out;
+	}
+	err = kobject_init_and_add(&perf_events->kobj,
+			&damon_sysfs_perf_events_ktype, &sample->kobj,
+			"perf_events");
+	if (err)
+		goto put_perf_events_out;
+	sample->perf_events = perf_events;
+
 	return 0;
+put_perf_events_out:
+	kobject_put(&perf_events->kobj);
+	sample->perf_events = NULL;
 put_filters_out:
 	kobject_put(&filters->kobj);
 	sample->filters = NULL;
@@ -512,6 +1043,10 @@ void damon_sysfs_sample_rm_dirs(struct damon_sysfs_sample *sample)
 		damon_sysfs_sample_filters_rm_dirs(sample->filters);
 		kobject_put(&sample->filters->kobj);
 	}
+	if (sample->perf_events) {
+		damon_sysfs_perf_events_rm_dirs(sample->perf_events);
+		kobject_put(&sample->perf_events->kobj);
+	}
 }
 
 void damon_sysfs_sample_release(struct kobject *kobj)
@@ -596,3 +1131,47 @@ int damon_sysfs_set_sample_control(
 	return damon_sysfs_set_sample_filters(control,
 			sysfs_sample->filters);
 }
+
+static int damon_sysfs_add_perf_event(
+		struct damon_sysfs_perf_event_attr *sys_attr,
+		struct damon_ctx *ctx)
+{
+	struct damon_perf_event *event = kzalloc(sizeof(*event), GFP_KERNEL);
+
+	if (!event)
+		return -ENOMEM;
+
+	event->attr.type = sys_attr->type;
+	event->attr.config = sys_attr->config;
+	event->attr.config1 = sys_attr->config1;
+	event->attr.config2 = sys_attr->config2;
+	event->attr.sample_phys_addr = sys_attr->sample_phys_addr;
+	event->attr.sample_weight_struct = sys_attr->sample_weight_struct;
+	event->attr.freq = sys_attr->freq;
+	event->attr.sample_freq = sys_attr->sample_freq;
+	event->attr.sample_period = sys_attr->sample_period;
+	event->attr.wakeup_events = sys_attr->wakeup_events;
+	event->attr.precise_ip = sys_attr->precise_ip;
+	event->attr.exclude_kernel = sys_attr->exclude_kernel;
+	event->attr.exclude_hv = sys_attr->exclude_hv;
+
+	list_add_tail(&event->list, &ctx->perf_events);
+	return 0;
+}
+
+int damon_sysfs_add_perf_events(struct damon_ctx *ctx,
+		struct damon_sysfs_sample *sysfs_sample)
+{
+	struct damon_sysfs_perf_events *events = sysfs_sample->perf_events;
+	int i, err;
+
+	if (!events)
+		return 0;
+
+	for (i = 0; i < events->nr; i++) {
+		err = damon_sysfs_add_perf_event(events->attrs_arr[i], ctx);
+		if (err)
+			return err;
+	}
+	return 0;
+}
-- 
2.43.0


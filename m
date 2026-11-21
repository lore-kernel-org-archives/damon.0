Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294828;
	b=P8qEbbwXDpkJ182EQBg5T5A8B+cwDxj39ZgtfznHhmKtxCfOkii9VHHmm8knFPgjkIT3
	 Aka2o9eGCfX2tASZl8XTIn8AqRqaskmQKvCDRlCIy571jTIOuKJMx9g+CV1Kvj+RCnuJP
	 Kjcs2O8gxpsjISguaSIhRH+AZfQUeXeTIeKylll3DiVKnkJdXHqWT919RGJCiNj/kPBi8
	 bR6wajMyCPGezzaMQxlEXyXsztkRZnV9h5LlWtWTaXvXyBHZKhSfrHYCgjD8p/yrKdCwG
	 59qELD1IVr7/Wm8bek4Pa+my4oKTRxcYbqRqzzr1Rf7Py08cM55JOkSuoijP2Z5ltWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YDurKzhLIi0mIdGpL4ZrXZs3NcRPuPDRtfbfQ8ZOhNQ=;
	b=ORKKkEzVKfpu3vI2OFGgjPyIcGQNzZmzqfQyWQ5D9YAZGEddy2Xr8CWMs2Ll19CS5P4f
	 RpU5A8GNlmnnIXLgpHn+pvJ9jsBOxDHt9FGJhjq93Zi6lJjiSnQiMOhyQDluZKAHsLsxi
	 6x8MnSvjHac0ZlRZBYNqqqHnRdS9KCmJlAReU54PAZ8agqw4YHexmoqY5Kc4iUb+masRx
	 XQbKax7b7/sNio965ux4guXD8UYouMqOaWkC1NjG+BxQP9WuWjPpkla6p6qW3ia9mw8Ul
	 HxAPrVygvsn8+J0m8UKWDGxhE/E5LqzomcryMmqZuqLc8lNjAmlwB/teAV6GP3I2Mmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjIu6X6t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E56606A337
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjIu6X6t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923881F000C4;
	Sat, 21 Nov 2026 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294828;
	bh=YDurKzhLIi0mIdGpL4ZrXZs3NcRPuPDRtfbfQ8ZOhNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DjIu6X6tFNdglQB+DuO58AM+e4OKZcZnkzRxSiBlta8fwg5EwcheTW6LQrK5FrBIL
	 JORooxV/dPj5pJLYz4VxpnxMirmM3JRRwtrbRjTmRPQXt3t8iiLFpq0OAkjcTh1VHG
	 9OnNTcet9x93aWCwboNfXxUjOElylzvpfB6WEo7MKtYMw3NjSMb0igHiHwzCZAVlQP
	 3PIaV0vTf1josb/TVh+XG87wuEyjweLYlaHP5IyJRc9KvxZb7xYw+NPEC+oLB2I0XE
	 xVmRLFiDk1HKNN3hk0RG+UxaFup5xQbbzokxbsFZSPFZDu3htFaXf7S5HMKKj7wZQY
	 pk6SXynPeuisw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 22/27] mm/damon/sysfs: implement report producer addr_{start,end} files
Date: Sat, 21 Nov 2026 13:00:06 -0800
Message-ID: <20261121210013.130397-23-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement addr_start and addr_end sysfs files under report producer
directory.  Those set and get the address range of the user_report type
data attribute reports.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b4d898ec0c9f7..5f9bb1955dfd5 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -3047,6 +3047,7 @@ struct damon_sysfs_producer {
 	struct kobject kobj;
 	enum damon_report_type report_type;
 	bool enabled;
+	struct damon_addr_range addr_range;
 };
 
 static struct damon_sysfs_producer *damon_sysfs_producer_alloc(void)
@@ -3116,6 +3117,44 @@ static ssize_t producer_state_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t addr_start_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+
+	return sysfs_emit(buf, "%lu\n", producer->addr_range.start);
+}
+
+static ssize_t addr_start_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+	int err = kstrtoul(buf, 0, &producer->addr_range.start);
+
+	return err ? err : count;
+}
+
+static ssize_t addr_end_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+
+	return sysfs_emit(buf, "%lu\n", producer->addr_range.end);
+}
+
+static ssize_t addr_end_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+	int err = kstrtoul(buf, 0, &producer->addr_range.end);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_producer_release(struct kobject *kobj)
 {
 	struct damon_sysfs_producer *producer = container_of(kobj,
@@ -3127,10 +3166,16 @@ static struct kobj_attribute damon_sysfs_producer_report_type_attr =
 		__ATTR_RW_MODE(report_type, 0600);
 static struct kobj_attribute damon_sysfs_producer_producer_state_type_attr =
 		__ATTR_RW_MODE(producer_state, 0600);
+static struct kobj_attribute damon_sysfs_producer_addr_start_type_attr =
+		__ATTR_RW_MODE(addr_start, 0600);
+static struct kobj_attribute damon_sysfs_producer_addr_end_type_attr =
+		__ATTR_RW_MODE(addr_end, 0600);
 
 static struct attribute *damon_sysfs_producer_attrs[] = {
 	&damon_sysfs_producer_report_type_attr.attr,
 	&damon_sysfs_producer_producer_state_type_attr.attr,
+	&damon_sysfs_producer_addr_start_type_attr.attr,
+	&damon_sysfs_producer_addr_end_type_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_producer);
-- 
2.47.3

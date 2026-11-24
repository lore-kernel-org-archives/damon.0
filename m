Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534610;
	b=CTxPQPmjJY0ndSgJnJxwvRaOPPyKD/E6Fq/3jqjPpsmR9ffbmtf0QGQrVHhD3zZw5hnv
	 6s4PdkYWMUK0GgvPspjumuVs4EOaYHps8HvZqMgcBtgq0CkiOzWcelMQj6mablLzDkRd/
	 aJ3t5wS/wMTbDa9WQJ+XwN0nRT2c/gknig345OrraaMq7Yn3rhJUGGG6TLMXK0gGH2sY6
	 M20S1PkEHfQA3dPVcBXgT6Cs8k9BXIdog78Tuw1ZgDpykjmBdsespiBQ/6257qvmQslN6
	 G3dXVM6LGeKyxDfA5Q/nMwaQd/wDUMMVjvHB9dGxjtHztOmVhqSctiqPuNML45LBxNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/Zxj2eMwaIXgQbhu9dalRInbQK+/1v4vmTweukww8fE=;
	b=h5JnRie5TvNSJTQmc/BmZi1xPxgTQqybCwNfnkstGZpyM8yYy8HBgzTS2Fgf8WrkKqYi
	 nfgr/naFn9eJ8wG0e1sa5gbbYHPYqyEUMhl3cCDpJy/GrHaVeMhpc+rhvrza9hxyK3oJJ
	 zyl8TnhYTACL1le5QPfTQIi8sSw8wvaBPaxMCbdtqC5phTbA97iRzWwgMz2oyp8+LvK7X
	 hAjbuKhBPmzhl38M0mKFia7lAoOWGEaf0m1iJuwbDq4GebPIhWupNVuV4yqXcla4BG8w5
	 zml+UMgpOFtzIsyFNKZslJLQ5Bp65cbGbrw5iOEki4WoUrAmTRAa7mu89dPxJRDhJcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rc8WWwT5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00B606A335
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rc8WWwT5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A78A1F000EB;
	Tue, 24 Nov 2026 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534609;
	bh=/Zxj2eMwaIXgQbhu9dalRInbQK+/1v4vmTweukww8fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rc8WWwT5/u9XB1zyZGcWpMkhXSxCnSEgtTmaos7+Ro8G/XWbNTzl+E8xXnhpS4nGB
	 pvzNzn/eou0+vhvSJoQ8PhftHLzDIVS41qhB71YKV77l5D7JLSZ4Vnn7VjDrpsM1RT
	 ADm8+KIAjoQlx9CgHp1AnZC7IFEvluRWtBCGn98dVCDGwPZirg9M1JipAX/s5FrhyP
	 cI9FXbLo/kdBIKvpvaL+Ytd+dv3g5N468H7aciNUShOp11554MmSotFuDhnfHvSZu8
	 +Df1+PNb+HKSaizQGAFplOfEy18JxeorgW718NbnX3/i1BqOmMjzTWS+KDAQbQ9WHF
	 uinAvMa9GRlbA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 08/27] mm/damon/sysfs: implement report producer type and state files
Date: Tue, 24 Nov 2026 07:36:14 -0800
Message-ID: <20261124153636.91854-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
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

Implement report_type and producer_state files under the report producer
directory.  The type file receives the type of the reports that the
producer will generate and submit to DAMON.  The producer_state file
enables and disables the producer.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7c6bc30c12125..7cdbe2fedf7d8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2983,6 +2983,8 @@ static const struct kobj_type damon_sysfs_kdamonds_ktype = {
 
 struct damon_sysfs_producer {
 	struct kobject kobj;
+	enum damon_report_type report_type;
+	bool enabled;
 };
 
 static struct damon_sysfs_producer *damon_sysfs_producer_alloc(void)
@@ -2990,6 +2992,77 @@ static struct damon_sysfs_producer *damon_sysfs_producer_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_producer);
 }
 
+struct damon_sysfs_report_type_name {
+	enum damon_report_type type;
+	char *name;
+};
+
+static const struct damon_sysfs_report_type_name
+damon_sysfs_report_type_names[] = {
+};
+
+static ssize_t report_type_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_report_type_names); i++) {
+		const struct damon_sysfs_report_type_name *type_name;
+
+		type_name = &damon_sysfs_report_type_names[i];
+		if (type_name->type == producer->report_type)
+			return sysfs_emit(buf, "%s\n", type_name->name);
+	}
+	return -EINVAL;
+}
+
+static ssize_t report_type_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+	ssize_t ret = -EINVAL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_report_type_names); i++) {
+		const struct damon_sysfs_report_type_name *type_name;
+
+		type_name = &damon_sysfs_report_type_names[i];
+		if (sysfs_streq(buf, type_name->name)) {
+			producer->report_type = type_name->type;
+			ret = count;
+			break;
+		}
+	}
+	return ret;
+}
+
+static ssize_t producer_state_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+
+	return sysfs_emit(buf, "%s\n", producer->enabled ? "on" : "off");
+}
+
+static ssize_t producer_state_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+
+	if (sysfs_streq(buf, "on"))
+		producer->enabled = true;
+	else if (sysfs_streq(buf, "off"))
+		producer->enabled = false;
+	else
+		return -EINVAL;
+	return count;
+}
+
 static void damon_sysfs_producer_release(struct kobject *kobj)
 {
 	struct damon_sysfs_producer *producer = container_of(kobj,
@@ -2997,7 +3070,14 @@ static void damon_sysfs_producer_release(struct kobject *kobj)
 	kfree(producer);
 }
 
+static struct kobj_attribute damon_sysfs_producer_report_type_attr =
+		__ATTR_RW_MODE(report_type, 0600);
+static struct kobj_attribute damon_sysfs_producer_producer_state_type_attr =
+		__ATTR_RW_MODE(producer_state, 0600);
+
 static struct attribute *damon_sysfs_producer_attrs[] = {
+	&damon_sysfs_producer_report_type_attr.attr,
+	&damon_sysfs_producer_producer_state_type_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_producer);
-- 
2.47.3

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774545;
	b=nApIS1wbuDrAh4R1dWjWEeoAWwgqSBsgdI+4wgvSykZ3SfOnDCJRCnHwuZHaU0Nn4aT+
	 q6wFhNps2eTpEO/V44XCEW4T9PMO2z549RrhPvSTBPXeZOypsWL1H57048iO6soZ2jzHo
	 CS7xviFBl4UpOmmnZJlkZD2Db7Axw89RrnaopKEvDHGgB645bHFKc2i3Qv2S8Twr4RaOq
	 zKfbSmkG1Wwl35ruL5v22QaUcXgHNONGWolEOa+NKF3i5jHqVflzhgdz1WP9jX+wnNXXe
	 D8VX7QT+VAhXXIPPn9bt6awtSa67xu2+PsJlUOsgvpl5ADkYfquSgmDHvGTpGgOWMjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774545;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kHhnYqoQe1EhM4f5cyc2l4mme4lRuHhy4MnQ2nEOlUo=;
	b=C7OSVlJBIHr0wu27AtkVFiDZtt50bsLlSBscTYtDIU2O0kj+3nmuy1NV6z5bM4qgvsiL
	 IyadW0hsJLRPKEOfxItAgm2wWf1v7zR7Zjiq8W7OVikA1d+TOKAVVvbO9SVh073976/0X
	 v+IrDAvJofvLyc6RfHXPQhQd2G2yxAEdQwAvdI6WdR2yzgrs0USbzhdckJnPxf6g0IX6e
	 cC0/0rNOpJOxeMX46yw17cu+SE557Hdf9Kz7L6hoRIwq9zRPLfeVH2U+Et0DpUJLCxdvo
	 v6HnyR7b8Tm/OsYHQ3S9CXUzQuyYYgTEzJ7Lbq6smy6yeXQJIMfmGYNjmOvBcuniMvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F15rwd+e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD24606A33E;
	Sun, 15 Nov 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F15rwd+e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64D91F000C5;
	Sun, 15 Nov 2026 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774545;
	bh=kHhnYqoQe1EhM4f5cyc2l4mme4lRuHhy4MnQ2nEOlUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F15rwd+eNBmEdxKDvcq79WoITIDzqtjdcCDeOwCKWxl2vA+qUQRLN2PyoBkxx2Ew/
	 kxUdqtSObKxnO2ciG89vsMy4ZqqUDl4fEET9UBKjUHmwBKnCQXrsqtoqYuloliNqtf
	 lFqKOqRGOgvktbb1nxnyg6mypGimnQZ44268AzS7tweaGlifbWVWxh9a2a51VgxoCX
	 QHbB9rydPYKIulC388SnyrTBwC9lRqEbCxnIRBq8vhPAG+qnT0zjbrRmsBfnwUaYtH
	 +b4jSYU60s1yp0XY+SVhr/GIrESqU8HGBryAdZKVz7nGQFvYqtRkz70l3jqDN+TMzm
	 NrmqOJbo8VdWA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/27] mm/damon/sysfs: implement report producer type and state files
Date: Sun, 15 Nov 2026 12:28:26 -0800
Message-ID: <20261115202849.99134-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
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

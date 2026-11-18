Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968557;
	b=qGPWwnav8p9WWDe3w7OAarmzaHoh34WGyDwjQ5rmch+84p0tGq6tWLlFrb2r47MIcy+h
	 zzEpLyPJWMEIh+VYgoi/9yOMvsC7qxqXdwovXtd3SHFx7uA4p7E2e3mNYzmVcv4blFXnV
	 FINlqxCOxWHbLatBKhWQ8QCTuoEcPleivfLEHZIPfKEJ/Y1w5km6IRVhu9sUDOw5ClhmT
	 0O3ea5SzRkUOlAqIuy36SLJNH6bVKk+K3AMatcP7aPCbHFfKzFOSEpuToeCe+NKKVMh88
	 vQIzjcPnItm0r4Tcv6C3fYAh/6Fo32Qp14AxWNTeciSiZAowCLVBeinJwKq2dHGuVMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5kDNeq0YIzH6aqgKl3Y8N9odneRfo3uo0UcuJ/hi1Pw=;
	b=1747reQ3meUDmUBGmnC2SSEO5LGT9m70aEBO0uD03xDXAaR7VRgn2VActvnfCmJWd1Gy
	 qdVGziaLwSXsEntqheAvFyvK/sU/6IhTWl1KzF8ybwvINj5LGhh6GcwvZXlL+oUX8lZNi
	 dnBxP2n4XCBazjOo8xyhZfg9WGfJEtCVtVMbyBSG1667+PEqXenN+aoj6DZ9+zzbA68N+
	 2VxVW24OyaXgff3FpctuqYWdkoElTGyJX3AawLdtUo9eGqiH9YPKG6o7v8rYzb5YWq4O0
	 pEy0f7UYCo63GGa982zoEDFbFMgUDg2aB22My/QL5otp+PCRtjTdu/+uP/8na/V5mJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GKzVTB/o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4560A3819;
	Wed, 18 Nov 2026 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKzVTB/o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB711F0092F;
	Wed, 18 Nov 2026 02:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968557;
	bh=5kDNeq0YIzH6aqgKl3Y8N9odneRfo3uo0UcuJ/hi1Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKzVTB/o+PIPUhNOflmOqevlWf/jhiGt+NaWTYUqm8KoS/a3yt1+jZSmr5ukVrs0K
	 TZaju7cU8ONa3qgGAIVLWAHPkh6M6LWSJ/iZxf8EhvwZi+ZDBD9g3uU5KpHI7h0hyI
	 gzkG88+lKN343th7uhHUR4St31cGUGs5odx7f2ywkWVf8AeieH+8orJHoKBWiA6spI
	 Tskvra6eGx4aCbXA3vYRXX9XgS42nMNFEmb/FbTQxriErwNsSEsNlKs0EC2/WPoquz
	 iKBkVId/VfAWF1wyZTLQJxwOFwLV0MvPLpCRc9waiyfrhb1aXJLEY8qQSN8VJhuCOH
	 zcd2mZJqBk2KQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 15/27] mm/damon/sysfs: add filter_report_type file under probe filter directory
Date: Tue, 17 Nov 2026 18:22:10 -0800
Message-ID: <20261118022225.100659-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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

Add a sysfs file, filter_report_type, under probe filter directory.  It
receives damon_report_type from the user.  Reuse
damon_sysfs_report_type_name struct for user keyword matching.  Move the
definition instead of forward declaration, as the code change is small
enough at this stage.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 61 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7cdbe2fedf7d8..ca971cf1dcf6d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -977,6 +977,7 @@ struct damon_sysfs_filter {
 	char *path;
 	unsigned long range_min;
 	unsigned long range_max;
+	enum damon_report_type report_type;
 };
 
 static struct damon_sysfs_filter *damon_sysfs_filter_alloc(void)
@@ -1175,6 +1176,53 @@ static ssize_t max_store(struct kobject *kobj,
 	return err ? err : count;
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
+static ssize_t filter_report_type_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_report_type_names); i++) {
+		const struct damon_sysfs_report_type_name *type_name;
+
+		type_name = &damon_sysfs_report_type_names[i];
+		if (type_name->type == filter->report_type)
+			return sysfs_emit(buf, "%s\n", type_name->name);
+	}
+	return -EINVAL;
+}
+
+static ssize_t filter_report_type_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_filter *filter = container_of(kobj,
+			struct damon_sysfs_filter, kobj);
+	ssize_t ret = -EINVAL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_report_type_names); i++) {
+		const struct damon_sysfs_report_type_name *type_name;
+
+		type_name = &damon_sysfs_report_type_names[i];
+		if (sysfs_streq(buf, type_name->name)) {
+			filter->report_type = type_name->type;
+			ret = count;
+			break;
+		}
+	}
+	return ret;
+}
+
 static void damon_sysfs_filter_release(struct kobject *kobj)
 {
 	struct damon_sysfs_filter *filter = container_of(kobj,
@@ -1202,6 +1250,9 @@ static struct kobj_attribute damon_sysfs_filter_min_attr =
 static struct kobj_attribute damon_sysfs_filter_max_attr =
 		__ATTR_RW_MODE(max, 0600);
 
+static struct kobj_attribute damon_sysfs_filter_filter_report_type_attr =
+		__ATTR_RW_MODE(filter_report_type, 0600);
+
 static struct attribute *damon_sysfs_filter_attrs[] = {
 	&damon_sysfs_filter_type_attr.attr,
 	&damon_sysfs_filter_matching_attr.attr,
@@ -1209,6 +1260,7 @@ static struct attribute *damon_sysfs_filter_attrs[] = {
 	&damon_sysfs_filter_path_attr.attr,
 	&damon_sysfs_filter_min_attr.attr,
 	&damon_sysfs_filter_max_attr.attr,
+	&damon_sysfs_filter_filter_report_type_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_filter);
@@ -2992,15 +3044,6 @@ static struct damon_sysfs_producer *damon_sysfs_producer_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_producer);
 }
 
-struct damon_sysfs_report_type_name {
-	enum damon_report_type type;
-	char *name;
-};
-
-static const struct damon_sysfs_report_type_name
-damon_sysfs_report_type_names[] = {
-};
-
 static ssize_t report_type_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-- 
2.47.3

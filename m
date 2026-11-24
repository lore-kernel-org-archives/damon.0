Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534616;
	b=cGvuJAgJ2GK1Mh6H/aTpgA5EC2cj13PPAfM/A8VOXA7CHdmKobamyv8grxvRVo4vIaXz
	 EpDZnL31w20Lp04fjZxcMp6+JZoHZWB9BzjIjj2/q7HxodiXfgUIO98a6CvOZ9t6wy2Xc
	 3zFTfFclXTpY4hYEa9V26zIHjNoslFJgmu4zK5g9H9MCNm5fGwscUisgC1RzTwKuJGPPF
	 8TIp1c1giZwEY6SPbl5lIRKeBn6JRzSM4BBaeTXNlYTba0bf8W4PgmkAYGhnOoCoVmlGM
	 PmMU9ttVI6Hg0w1a/U0nr9QCV6xfbQgB5UlzamGrDgNtXcGwcO682u4MSx40yAqapuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534616;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ev01uXrsK+5BPeS58A2Wm9kvysKqjK5H8CmDZBBMICs=;
	b=ydoIZu6wvf0orGIcsrlHEJz1x/4d3giCHQiQsPVWVBuZ1XFp9iufUHkHrrE3VQZsuLLz
	 hAYpbWMwlU4bA7koHLwAVBQB+VO5znjr/Hu83Nw8Ge+/dzTykNbKrNUI08VfBELk2sV4L
	 QCFcNEu4pT/kCfilzfxE7OUvATxv7ZO0BnrT5irNH7ZNlPCg4+HrnQ/qboJLwiEHwRsiI
	 +x8PcojIiM1GbB82EqZ18Jj5ohbCALpBrFdyyIbhxFKCg8U2cv2aOyru+faE8VB20dCoy
	 yS7g1TnS8jEW1vgge7G0dsIAJV8/XB6cN4wjtfkp+HiZ+F4WI1vBgyn0ueIDRjM5WSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXKLwLOT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF7606A31E
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXKLwLOT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4520C1F000C0;
	Tue, 24 Nov 2026 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534615;
	bh=ev01uXrsK+5BPeS58A2Wm9kvysKqjK5H8CmDZBBMICs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CXKLwLOTnkbtXvzsB/W9j2qzLQC2WWtBFDvNnVZXkcpnzWbgSFQvj53IwkApTm8as
	 ylSfb1OSjpdK8y3daUrvKrmjWBLZBWVF/QNXjtd7R9wiX360sUhNbGe0+1xksyvHUD
	 tnhlcXm6b6LVQE1VQajibUFYOOV2kl/3mcWJEHLzVqfrHOD+rrpG36itQPDjiVd0Eo
	 xHwx1OJgIun5UAukHk1XWJQ8hW71aHFOr4racF93+ZrO8hYGhpLRwAY65ijBzyW+KD
	 h5Jdyqdhl7/XNzVPuNIfL7+PRzFzY74xTNHlPuIoQWSujRoQfyNL66Fu/siKVDOnIa
	 Rw+J7LI3mOW6g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 15/27] mm/damon/sysfs: add filter_report_type file under probe filter directory
Date: Tue, 24 Nov 2026 07:36:21 -0800
Message-ID: <20261124153636.91854-16-sj@kernel.org>
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

Add a sysfs file, filter_report_type, under probe filter directory.  It
receives damon_report_type from the user.  Reuse
damon_sysfs_report_type_name struct for user keyword matching.  Move the
definition instead of forward declaration, as the code change is small
enough at this stage.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
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

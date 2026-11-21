Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294826;
	b=tO3iq6jM/0M9eoS0MV2St0S/9qmCk6QXlrTS4dkVXItCDR+U1fp1AqyRFrENwTOad/O4
	 yz8syVN2jRfVi6iGCtZY86y9mfXCJpAcxHoGjzf8LsRqP66EUX6AUtm8ze/+JwJK+dcUs
	 buBv44I0/yVULGV7bGe0hwwKdG822YO3BoB//p6ng8uY1hhJFooIfaA+w5QqOAEBFN3V0
	 fWAAfHrPPmdq4Pf+FYyee0jr7FWUr6sr0/BaYP6jeghDmP4k6iM3gp4COiWhZtpQfIq12
	 JhO7Z5c18bperHOvQ+c372DJgdpPrJ+2Hu7MC3Zelbt7HpIL7vILj7E476NG/wFMGVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5kDNeq0YIzH6aqgKl3Y8N9odneRfo3uo0UcuJ/hi1Pw=;
	b=3Pv6nhlrMfnzX1S5Sxc0fP0eHC8ZqgLMaycqH44RXCHj36b7LoP8UXtuPikfQIYZB0lV
	 4ziNAb0gDxqehwmqPeWfrJ2cNZ1DHqBSq2eYp/PEWEsy1v6czcYHN7uE14eVnysCL76jK
	 dzClAAi98Rtm2UGZ3ygSLDtFGEl+s8/tMGIfYHZaga/nYkDlBLX7fLjgRDnYOV8g+DpN/
	 5CMcjleNaSi4cRymdxKh3Ve8flY68AEF2SgdYP6JfckWdBWIhGV8zKavLgz/YjkVzxJwe
	 HKk8lIGKl99YKIpU7MQFPvalqh4ljx/0dcX181hcHZgPJ9T676XAPGeOTcDfKxto96Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieWaSR+K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3A606A320
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieWaSR+K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1605C1F000CA;
	Sat, 21 Nov 2026 21:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294826;
	bh=5kDNeq0YIzH6aqgKl3Y8N9odneRfo3uo0UcuJ/hi1Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ieWaSR+KB+cLfLHY/BAz1IhrxOa3wh+QTKWe6Wc2SkpNv1dQLGT2DMwSniw3NFpg5
	 W5Qn5ejsIWIn9psGhsoTSylG7tOKJOk8CDiyyXUxUAuUDcFwDgaUp4Mpw1i3whUigV
	 HWmnL4O4wDE7WaucZxVRkq7Tgb2Emw7Aza1rdfRnk0j6vvhoH7mmWE6pNWs0z2vCpO
	 90EPeOjMXlteJZI2gDpQkWrfrr81TCiEjXpqzpCvGZB5tR+KOva1NIpuyfLO0SKfcu
	 vFy108Yl5eXgykWOSq6jqeNr5O6iBgBwLAEIds+45vY/xT59+5NU9iH/Yc6W1+M8XV
	 6F4oVCw2Azg3g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 15/27] mm/damon/sysfs: add filter_report_type file under probe filter directory
Date: Sat, 21 Nov 2026 12:59:59 -0800
Message-ID: <20261121210013.130397-16-sj@kernel.org>
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

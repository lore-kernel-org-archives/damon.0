Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602B310652;
	Sun, 26 Apr 2026 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236760; cv=none; b=pmQQq/6FPy9i0G6WRI0RTroP9XjhoE/AyGt6lW+mQPqFxkYk6fiY+0JMy8A4VpdkCG3j83lnBOu0yaJNa1v7DGvquu+ssOsIvEy/+9J9oK+5AfuXcJZlvDv36KueOQGsBUGPrdpodVW8iel8prwP57X19rzvwesq3lCTFoUS8bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236760; c=relaxed/simple;
	bh=n8NHvN0HAPPSe4MQZU6Swveu54v2WkmDhfNoQjsKaCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0OaIN/idcWWipoFCVERv7AgCEF4Oloh1N7/Zpizje4Gp/oteGwwWHGcPWaPF7MlK0pW4zkqdUfSfSz2NpQXMYP5+wnj8U2oVZUz4MLYvRerRfLMoV6gUdlXjWC7uThtHA329QaXMSxDUDUQsvB/IrBrqN717Tscs3FiE5ehb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH9APUYW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH9APUYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970B4C2BCF4;
	Sun, 26 Apr 2026 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236759;
	bh=n8NHvN0HAPPSe4MQZU6Swveu54v2WkmDhfNoQjsKaCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NH9APUYWZFrbBawnXc54h5wO3jk22Ljsb8FDaKjTPE4XtsmgvJsPZWYjK7R+cE1oC
	 9E4cSDT7r3TU0S8msSsBt0coiwCm78j4lonit803zJjWXwVgLf45ncS0frVteVeilU
	 3WllJgUzE9vksddpywRtfMEM77ScUhUc47u7VmPm3zEfNx2QbIEUqb3Q9CPvxuVwzX
	 H1hGcCSB63BG32JEsucHLoiInOAUEn25GLjBFF8Tz7a+67ib7WNeuxBTIEnmPiyjZn
	 16wEiGIygzm+g9iwxzJ5M89VcwKnk0j0qEGYqAKxQt/MYgMYJVMKqB1tFNg+Ievn5A
	 bFup5naqx51XQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 15/19] mm/damon/sysfs-schemes: implement tried_region/probe_hits file
Date: Sun, 26 Apr 2026 13:52:16 -0700
Message-ID: <20260426205222.93895-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426205222.93895-1-sj@kernel.org>
References: <20260426205222.93895-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a file for letting users read the per-region per-probe
positive samples count.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index c3c1ff6108863..48a949484a052 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -20,6 +20,7 @@ struct damon_sysfs_scheme_region {
 	unsigned int nr_accesses;
 	unsigned int age;
 	unsigned long sz_filter_passed;
+	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
 };
 
@@ -34,6 +35,9 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
 	sysfs_region->ar = region->ar;
 	sysfs_region->nr_accesses = region->nr_accesses_bp / 10000;
 	sysfs_region->age = region->age;
+	memcpy(sysfs_region->probe_hits, region->probe_hits,
+			sizeof(*sysfs_region->probe_hits) *
+			ARRAY_SIZE(sysfs_region->probe_hits));
 	INIT_LIST_HEAD(&sysfs_region->list);
 	return sysfs_region;
 }
@@ -83,6 +87,28 @@ static ssize_t sz_filter_passed_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%lu\n", region->sz_filter_passed);
 }
 
+static ssize_t probe_hits_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_region *region = container_of(kobj,
+			struct damon_sysfs_scheme_region, kobj);
+	char *str;
+	int ret, i;
+
+	str = kcalloc(2048, sizeof(*str), GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+	for (i = 0; i < DAMON_MAX_PROBES; i++) {
+		snprintf(&str[strlen(str)], 2048 - strlen(str), "%hhu",
+				region->probe_hits[i]);
+		if (i < DAMON_MAX_PROBES - 1)
+			snprintf(&str[strlen(str)], 2048 - strlen(str), ",");
+	}
+	ret = sysfs_emit(buf, "%s\n", str);
+	kfree(str);
+	return ret;
+}
+
 static void damon_sysfs_scheme_region_release(struct kobject *kobj)
 {
 	struct damon_sysfs_scheme_region *region = container_of(kobj,
@@ -107,12 +133,16 @@ static struct kobj_attribute damon_sysfs_scheme_region_age_attr =
 static struct kobj_attribute damon_sysfs_scheme_region_sz_filter_passed_attr =
 		__ATTR_RO_MODE(sz_filter_passed, 0400);
 
+static struct kobj_attribute damon_sysfs_scheme_region_probe_hits_attr =
+		__ATTR_RO_MODE(probe_hits, 0400);
+
 static struct attribute *damon_sysfs_scheme_region_attrs[] = {
 	&damon_sysfs_scheme_region_start_attr.attr,
 	&damon_sysfs_scheme_region_end_attr.attr,
 	&damon_sysfs_scheme_region_nr_accesses_attr.attr,
 	&damon_sysfs_scheme_region_age_attr.attr,
 	&damon_sysfs_scheme_region_sz_filter_passed_attr.attr,
+	&damon_sysfs_scheme_region_probe_hits_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_region);
-- 
2.47.3

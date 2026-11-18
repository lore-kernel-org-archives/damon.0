Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968554;
	b=PyiNxQ7OhIIRFfMTI/2WaxSnIaxZg48PObdwIMb1dyV2yRaDiOpKfF5t6hoOV8bm7+Ke
	 6oGctiBUj2u9tuJjOrglaS1H6ccC946P8brARmFxbB1npSRSvLRTvpwrcy2b0HhkPl3DJ
	 yZalxjSBMYbIplMVWzMSBg5MfrxkVsYs16ahM1oOBDfkMHn71N+Nem2p+RHB/ImjDJI3q
	 eouccbYw/UXeHwE4LDXg+Aj5zC7KuDWH9FdY4L0M0Yu5roZQEzqspZAyXSb4FWB5qMqNs
	 7F4kEy8sHi0aZn/I4yy29F2rVnDU/uVu7vVAyI/eD1J8Q5LWtwROixxj+LA/moz1LMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968554;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZoY4hnFbJ5g7c+Vl7aZxcV0uXn6NxmdIonYYm4S4XhY=;
	b=WaL3OweEy9L8Az8/Ykpnlm8LTJB+hUtMYkWqfoYy5ejTAHl+ZiPVDUgUjHUTC6PfMFGy
	 uJBXGJU5MwpIIMjMtmwp+7d+I/QfY0vJM/6SsiLVf6IhkQ+Vv519iLLQvs80yu1AFqWC0
	 PUPnotTqvCuWdicm7+Iogo74qpLvc792MDujRWpiFuGbbl5iI2bp8i1QuTqpomKayqISv
	 Bf0J7vWXKZ/teHk1wYhtuqP+gqD0MaRuHKncqwe4MhJDrHoL8VBzzzQGUg813oCl0QdL5
	 +J1zonVElD1Wwg5lTdtUz2FAfi8MdXBW0wFlMD80Blp311s1XyVEL5SkYltLcINnh7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDJGyrGl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE650606A8A4;
	Wed, 18 Nov 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDJGyrGl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7629C1F000CF;
	Wed, 18 Nov 2026 02:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968554;
	bh=ZoY4hnFbJ5g7c+Vl7aZxcV0uXn6NxmdIonYYm4S4XhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDJGyrGlsnnCrzFaIATHzHA0Z7QPT+Q64Nl76ExxPjh+o5nloi1fFAQcweOqz0g5Z
	 SVvprU2m4+hjJbdPqLkI3HGdqyBo402LtyfRsGwBhqOi8hXbceS/XGXR2GOJ7UAsOE
	 WUDqG+At3xylwtcVfFKv2rPQ+fe/jfxELLSdNhXwFyK0FkLBqi1bzhDwAjbo0ZcfiF
	 VuJ0KlSB42mGgfJlX/y0E90hgNeicUvF5Hzodm5syQ3SwdD+FtThrYVbLqUSroPBii
	 weK3ncRvyvvPzvI+GWKCfd2S5aps++kqFep5fimbRxJ96Q46Sn4APic5hng3reB7NP
	 C+PbXkmv9iBbg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 06/27] mm/damon/sysfs: add producers/nr_producers file
Date: Tue, 17 Nov 2026 18:22:01 -0800
Message-ID: <20261118022225.100659-7-sj@kernel.org>
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

Implement a new sysfs file, nr_producers, under the producers/
directory.  The file will be used for generating directories for each
report producer, in a manner that is similar to the nr_kdamonds file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 75701ed662222..d3a7cb170975a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2983,6 +2983,7 @@ static const struct kobj_type damon_sysfs_kdamonds_ktype = {
 
 struct damon_sysfs_producers {
 	struct kobject kobj;
+	int nr;
 };
 
 static struct damon_sysfs_producers *damon_sysfs_producers_alloc(void)
@@ -2990,12 +2991,62 @@ static struct damon_sysfs_producers *damon_sysfs_producers_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_producers);
 }
 
+static void damon_sysfs_producers_rm_dirs(
+		struct damon_sysfs_producers *producers)
+{
+	producers->nr = 0;
+}
+
+static int damon_sysfs_producers_add_dirs(
+		struct damon_sysfs_producers *producers, int nr_producers)
+{
+	damon_sysfs_producers_rm_dirs(producers);
+	producers->nr = nr_producers;
+	return 0;
+}
+
+static ssize_t nr_producers_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_producers *producers = container_of(kobj,
+			struct damon_sysfs_producers, kobj);
+
+	return sysfs_emit(buf, "%d\n", producers->nr);
+}
+
+static ssize_t nr_producers_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_producers *producers;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	producers = container_of(kobj, struct damon_sysfs_producers, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_producers_add_dirs(producers, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
 static void damon_sysfs_producers_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_producers, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_producers_nr_attr =
+__ATTR_RW_MODE(nr_producers, 0600);
+
 static struct attribute *damon_sysfs_producers_attrs[] = {
+	&damon_sysfs_producers_nr_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_producers);
-- 
2.47.3

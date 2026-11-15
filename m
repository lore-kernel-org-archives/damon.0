Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774544;
	b=1AUEha/GQZN/r3eTrx24gOx/eCB6xx0yk639m9vjim3luEykFTWtw1lvAQrYW6ZEsj5V
	 raPLbIp4EvRvCT1G+5+wusZvCGDv4cIH47lSiCPj85/m2iNkfumVN6z16A6aGczAyG92U
	 dSm4DjqTAzHP65izgc2FYku6gUOKhLDba+pSUWmFnJXDj8AZdTw/zNuXJZoHEQ/HzI3M8
	 aZYyx6vDxsgTKpiHgXOhvcHJFwL++YKsSL4+yPyzus+wIlDA9FyJf5Z05Ez3L0WrVOZM6
	 6oaVmbmqduw+AvbfhsDmQH7rrmond3ADLGT+iDqcqigq95YSbsooDiccCLNl/UJD5MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZoY4hnFbJ5g7c+Vl7aZxcV0uXn6NxmdIonYYm4S4XhY=;
	b=2T13AN3w+aOzJ9G2JaCUZBeNRfWbaEYX82WdbxcrkKG43oZZpDlAhYSSUHkkM2wbbI8F
	 4jEZunr/75oJVpQsVZ1h2V95UhYaU+nOENq8VFJHqjq7YzwSgbpU7jYIpBkwmlAbxjlca
	 J3hUsHyIp9PSsZbNWrACDEyO+5T/qtUEbPH50lJAiFyTnSmqFe2kLGVvYw5aUWwaJmW40
	 Nqh/HGzQPm7q+AdIBdA6/x6FbihB3kkMBSmWxa5C2st2g8z4NDnpeZxk6wLaCZikpT+EZ
	 dhH+Nq9sQpiTkJyFhY522k5BgxhdyR9HMT+kToEXWrnB2zwfkoqpGb4GhF3nESNSUpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ID7qKCGG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97883606A880;
	Sun, 15 Nov 2026 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ID7qKCGG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A2C1F000CE;
	Sun, 15 Nov 2026 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774544;
	bh=ZoY4hnFbJ5g7c+Vl7aZxcV0uXn6NxmdIonYYm4S4XhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ID7qKCGG0jU87u+XHV8aN1YanclyRV6UBKKMWWFc1i2tX+AUbVyZCHg7TrXjekIp7
	 Md5Puh/1ufVf6260SbS3E9hJfUOQaOSeaZrXRPx1g2nooN82FSGJPi87vdookoA4WR
	 0dKMK8ZonhTNBf8ucbMPCsFx5rTbFWoV/ud9JFhN78pYYcB4hBxvFwC1pZ1fmnyciU
	 G/l/dsgWHSIBWxZTaPoufsfhssljAYwjqrvWZ5lWuF8x3TwbAXMC1tr/isngaWUkJe
	 y6itdsxU9ox6oMKqbu5rIIhWKQiUyZF0qXg+YqUWFYPygGSDZNdpi9pATLfz0mS820
	 QASKWo+l9EsPw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/27] mm/damon/sysfs: add producers/nr_producers file
Date: Sun, 15 Nov 2026 12:28:24 -0800
Message-ID: <20261115202849.99134-7-sj@kernel.org>
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

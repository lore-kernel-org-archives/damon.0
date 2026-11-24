Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534609;
	b=tb7w4Cw/hNPR/q2gtupWaVo6mbyvDCcaBoS/QL11y5FrWI/t2ZtJIfWjzCt95syMwWwR
	 ExaX8ZyIgchrBxdp0iSDfukbwUyfRfyEwHX4/C7wo0X5pAGEMus7yWkH9Ez58XjgP3kIs
	 JY6/4W/O5Fb7J4wTMpHb2ahJlvhBcEeF0ru2mRogoU67ZdiJByECM5F3GnVkvn9LgA9aW
	 3OQDf/72ycmlCu/TBrU2yTh0baZJasdz6oroyUvDWfJJYNHpyP+r38KHyTfx0arrdE/2q
	 Ap9Mr9ggwLzSVKqa+bcZU3klCGUrshO6ra/7/u02C+9YPjZBp7YHcxcfcHGI/OBNJvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534609;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Esn01hvGsm300THww7Bwi6euyaSw8hSdi0zfeBrrMo8=;
	b=kYjs2ga051cIL4IG4yiFGI1Kp0Kh2dJUMJLzgj2fc/wYBm2CmvgxiD1s0rfTZsDKqh56
	 qgNwIjpPwLJmDoIgOKTFHuvidVOqhFmaiVfyXR8ykUIl8ZUWzFZO7dpFqJ1Uc7TwHWoCO
	 8kl5umsS3+AYHQIc23Lju4OaHZMshWgsoeMmKu4iqYe4s0vFFF/h4XhkJzhawuELaJUmx
	 +FEg7299crrqZeoPGTxmXuWl67M3BVtxp4yRQvg5EwYGieI12CAR6eWQ+KdBILpjZrBqA
	 9LPNMQBnGM27357Tytq9CbFozEHBhqLqfr+TcFLqzUFhv0o8CC6gsEHDcTwpOhJU5xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqexezKr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82382606A338
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqexezKr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E97D1F000D8;
	Tue, 24 Nov 2026 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534609;
	bh=Esn01hvGsm300THww7Bwi6euyaSw8hSdi0zfeBrrMo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VqexezKry5v9RKTJdbErdeFMxRZsYbu6SutiAqud4X9hU+HWOeAN3o7FWq+2uZbK/
	 ALxTeDWlk8pB1SAm9fKFGyfIaVi7Yc2jFA7EzQM/ESVBQatzq1BcZ7lIlLdke/h+ee
	 jJd1MjLT4eKWcUlDwDcKkT3ilJ1o0WCC/BPj7QGFPQyO/ribYE2JAJxRwN7idORPfr
	 998+WDF9nUPqs0QvTqHizX3bIlzhh11opWTIuYfLSfkbRS1Yr2cXz0GNXQ47QGy2cm
	 A48xQxmTeMFLMciiNpUVFcqK9ltBPSQbCXjAUGyEowmVdJJOxRV6G6ZP/3SPhwcYdn
	 ILvi4dh06VXOA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 07/27] mm/damon/sysfs: implement report producer directory
Date: Tue, 24 Nov 2026 07:36:13 -0800
Message-ID: <20261124153636.91854-8-sj@kernel.org>
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

Implement a sysfs directory for each report producer.  Create and remove
the directories for reports/producers/nr_producers file writes.  It is a
placeholder for sysfs files that will be used for controlling each
report producer.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index d3a7cb170975a..7c6bc30c12125 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2979,10 +2979,40 @@ static const struct kobj_type damon_sysfs_kdamonds_ktype = {
 	.default_groups = damon_sysfs_kdamonds_groups,
 };
 
+/* producer dir */
+
+struct damon_sysfs_producer {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_producer *damon_sysfs_producer_alloc(void)
+{
+	return kzalloc_obj(struct damon_sysfs_producer);
+}
+
+static void damon_sysfs_producer_release(struct kobject *kobj)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+	kfree(producer);
+}
+
+static struct attribute *damon_sysfs_producer_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_producer);
+
+static const struct kobj_type damon_sysfs_producer_ktype = {
+	.release = damon_sysfs_producer_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_producer_groups,
+};
+
 /* producers dir */
 
 struct damon_sysfs_producers {
 	struct kobject kobj;
+	struct damon_sysfs_producer **producers_arr;
 	int nr;
 };
 
@@ -2994,14 +3024,53 @@ static struct damon_sysfs_producers *damon_sysfs_producers_alloc(void)
 static void damon_sysfs_producers_rm_dirs(
 		struct damon_sysfs_producers *producers)
 {
+	struct damon_sysfs_producer **producers_arr = producers->producers_arr;
+	int i;
+
+	for (i = 0; i < producers->nr; i++) {
+		kobject_del(&producers_arr[i]->kobj);
+		kobject_put(&producers_arr[i]->kobj);
+	}
 	producers->nr = 0;
+	kfree(producers_arr);
+	producers->producers_arr = NULL;
 }
 
 static int damon_sysfs_producers_add_dirs(
 		struct damon_sysfs_producers *producers, int nr_producers)
 {
+	struct damon_sysfs_producer **producers_arr, *producer;
+	int err, i;
+
 	damon_sysfs_producers_rm_dirs(producers);
-	producers->nr = nr_producers;
+	if (!nr_producers)
+		return 0;
+
+	producers_arr = kmalloc_objs(*producers_arr, nr_producers,
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!producers_arr)
+		return -ENOMEM;
+	producers->producers_arr = producers_arr;
+
+	for (i = 0; i < nr_producers; i++) {
+		producer = damon_sysfs_producer_alloc();
+		if (!producer) {
+			damon_sysfs_producers_rm_dirs(producers);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&producer->kobj,
+				&damon_sysfs_producer_ktype, &producers->kobj,
+				"%d", i);
+		if (err) {
+			kobject_put(&producer->kobj);
+			damon_sysfs_producers_rm_dirs(producers);
+			return err;
+		}
+
+		producers_arr[i] = producer;
+		producers->nr++;
+	}
 	return 0;
 }
 
-- 
2.47.3
